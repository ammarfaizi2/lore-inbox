Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVCIUPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVCIUPJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVCIUMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:12:17 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:15251 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S262298AbVCIUHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:07:51 -0500
From: Kimmo Sundqvist <kimmo.sundqvist@mbnet.fi>
Organization: Unorganized
To: linux-kernel@vger.kernel.org
Subject: Log full of "ing_filter:  fixed  ippp2 out ippp2"
Date: Wed, 9 Mar 2005 22:07:41 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503092207.41963.kimmo.sundqvist@mbnet.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Please cc all replies to me.

After upgrading my little NATting firewall/router from 2.6.7-ck4 to 
2.6.10-gentoo-r6 my /var/log/messages is 15MB in size and most of it looks 
like the text below.  All traffic to the Internet seems to cause this.  

"cat /var/log/messages | uniq | uniqmessages" results in a 3MB file.  I use 
syslog-ng.

Iptables setup script further down.

Mar  9 21:58:15 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:15 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:15 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:15 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:15 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:16 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:16 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:16 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:16 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:16 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:16 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:16 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:17 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:17 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:17 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:17 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:17 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:17 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:17 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:17 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:17 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:17 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:17 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:17 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:17 shadowgate ing_filter:  fixed  ippp2 out ippp2
Mar  9 21:58:17 shadowgate ing_filter:  fixed  ippp2 out ippp2

My firewall setup looks like:

IPTABLES=/sbin/iptables
MODPROBE=/sbin/modprobe
DEPMOD=/sbin/depmod

EXTIF="ippp2"
INTIF="eth0"
KAKKOSIF="eth1"

$DEPMOD -a

$MODPROBE ip_tables

#$MODPROBE ip_conntrack
#In the kernel

$MODPROBE ip_conntrack_ftp
$MODPROBE iptable_nat
$MODPROBE ip_nat_ftp

echo "1" > /proc/sys/net/ipv4/ip_forward
echo "1" > /proc/sys/net/ipv4/ip_dynaddr
#echo "1" > /proc/sys/net/ipv4/conf/all/proxy_arp

$IPTABLES -P INPUT ACCEPT
$IPTABLES -F INPUT
$IPTABLES -P OUTPUT ACCEPT
$IPTABLES -F OUTPUT
$IPTABLES -P FORWARD DROP
$IPTABLES -F FORWARD

$IPTABLES -t nat -F

/sbin/iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
/sbin/iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT

$IPTABLES -A FORWARD -i $EXTIF -o $KAKKOSIF -m state --state \
ESTABLISHED,RELATED -j ACCEPT   # RJ-45

$IPTABLES -A FORWARD -i $EXTIF -o $INTIF -m state --state \
ESTABLISHED,RELATED  -j ACCEPT # BNC segment

$IPTABLES -A FORWARD -i $KAKKOSIF -o $EXTIF -j ACCEPT   # RJ-45
$IPTABLES -A FORWARD -i $INTIF -o $EXTIF -j ACCEPT        # BNC segment
$IPTABLES -t nat -A POSTROUTING -o $EXTIF -j MASQUERADE
$IPTABLES -A FORWARD -j LOG
exit 0

-Kimmo S.
