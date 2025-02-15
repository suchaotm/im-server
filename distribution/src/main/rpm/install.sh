set -e

cd /opt/im-server
tar -xzvf distribution*.tar.gz

sed -i 's/h2db.path .\/h2db\/wfchat/h2db.path \/var\/lib\/im-server\/h2db\/imdb/' /opt/im-server/config/wildfirechat.conf
sed -i 's/local.media.storage.root .\/media/local.media.storage.root \/var\/lib\/im-server\/media/' /opt/im-server/config/wildfirechat.conf
sed -i 's/<Property name="MSG_LOG_HOME">.\/logs<\/Property>/<Property name="MSG_LOG_HOME">\/var\/log\/im-server<\/Property>/' /opt/im-server/config/log4j2.xml
sed -i 's/WILDFIRECHAT_CONFIG_PATH=$WILDFIRECHAT_HOME/WILDFIRECHAT_CONFIG_PATH=\/etc\/im-server/' /opt/im-server/bin/wildfirechat.sh

if [ ! -d /etc/im-server ]; then
mkdir /etc/im-server
fi

mv -f  /opt/im-server/config /etc/im-server
systemctl daemon-reload

echo "IM server folders:"
echo "/etc/im-server/config     config"
echo "/opt/im-server            binary files"
echo "/var/log/im-server        logs"
echo "/var/lib/im-server/h2db   embed db"
echo "/var/lib/im-server/media  embed media files"
