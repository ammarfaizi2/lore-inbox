Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267392AbSLEUrN>; Thu, 5 Dec 2002 15:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267393AbSLEUrN>; Thu, 5 Dec 2002 15:47:13 -0500
Received: from HIC-SR1.hickam.af.mil ([131.38.214.75]:63703 "EHLO
	hic-sr1.hickam.af.mil") by vger.kernel.org with ESMTP
	id <S267392AbSLEUrJ>; Thu, 5 Dec 2002 15:47:09 -0500
Message-ID: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil>
From: Bingner Sam J Contractor PACAF CSS/SCHE 
	<Sam.Bingner@hickam.af.mil>
To: "'ja@ssi.bg'" <ja@ssi.bg>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: hidden interface (ARP) 2.4.20
Date: Thu, 5 Dec 2002 20:53:52 -0000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C29CA0.6B111EDE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C29CA0.6B111EDE
Content-Type: text/plain;
	charset="iso-8859-1"

Attached is a patch that seems to work for the hidden flag in 2.4.20... for
anybody else who needs this functionality

	Sam Bingner
	PACAF CSS/SCHE


------_=_NextPart_000_01C29CA0.6B111EDE
Content-Type: application/octet-stream;
	name="hidden-2.4.20.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hidden-2.4.20.diff"

diff -u -r linux-2.4.20/Documentation/filesystems/proc.txt =
linux-hidden/Documentation/filesystems/proc.txt=0A=
--- linux-2.4.20/Documentation/filesystems/proc.txt	Thu Nov 28 13:53:08 =
2002=0A=
+++ linux-hidden/Documentation/filesystems/proc.txt	Thu Dec  5 08:57:03 =
2002=0A=
@@ -1573,6 +1573,16 @@=0A=
 =0A=
 Determines whether to send ICMP redirects to other hosts.=0A=
 =0A=
+hidden=0A=
+------=0A=
+=0A=
+Hide addresses attached to this device from another devices.=0A=
+Such addresses will never be selected by source address =
autoselection=0A=
+mechanism, host does not answer broadcast ARP requests for them,=0A=
+does not announce it as source address of ARP requests, but they=0A=
+are still reachable via IP. This flag is activated only if it is=0A=
+enabled both in specific device section and in "all" section.=0A=
+=0A=
 Routing settings=0A=
 ----------------=0A=
 =0A=
diff -u -r linux-2.4.20/Documentation/networking/ip-sysctl.txt =
linux-hidden/Documentation/networking/ip-sysctl.txt=0A=
--- linux-2.4.20/Documentation/networking/ip-sysctl.txt	Fri Aug  2 =
14:39:42 2002=0A=
+++ linux-hidden/Documentation/networking/ip-sysctl.txt	Thu Dec  5 =
08:57:03 2002=0A=
@@ -445,6 +445,14 @@=0A=
 Alpha 1/1024s. See the HZ define in /usr/include/asm/param.h for the =
exact=0A=
 value on your system. =0A=
 =0A=
+hidden - BOOLEAN=0A=
+	Hide addresses attached to this device from another devices.=0A=
+	Such addresses will never be selected by source address =
autoselection=0A=
+	mechanism, host does not answer broadcast ARP requests for them,=0A=
+	does not announce it as source address of ARP requests, but they=0A=
+	are still reachable via IP. This flag is activated only if it is=0A=
+	enabled both in specific device section and in "all" section.=0A=
+=0A=
 Alexey Kuznetsov.=0A=
 kuznet@ms2.inr.ac.ru=0A=
 =0A=
diff -u -r linux-2.4.20/include/linux/inetdevice.h =
linux-hidden/include/linux/inetdevice.h=0A=
--- linux-2.4.20/include/linux/inetdevice.h	Fri Aug  2 14:39:45 2002=0A=
+++ linux-hidden/include/linux/inetdevice.h	Thu Dec  5 08:57:03 2002=0A=
@@ -17,6 +17,7 @@=0A=
 	int	forwarding;=0A=
 	int	mc_forwarding;=0A=
 	int	tag;=0A=
+	int	hidden;=0A=
 	int     arp_filter;=0A=
 	int	medium_id;=0A=
 	void	*sysctl;=0A=
@@ -45,6 +46,7 @@=0A=
 =0A=
 #define IN_DEV_LOG_MARTIANS(in_dev)	(ipv4_devconf.log_martians || =
(in_dev)->cnf.log_martians)=0A=
 #define IN_DEV_PROXY_ARP(in_dev)	(ipv4_devconf.proxy_arp || =
(in_dev)->cnf.proxy_arp)=0A=
+#define IN_DEV_HIDDEN(in_dev)		((in_dev)->cnf.hidden && =
ipv4_devconf.hidden)=0A=
 #define IN_DEV_SHARED_MEDIA(in_dev)	(ipv4_devconf.shared_media || =
(in_dev)->cnf.shared_media)=0A=
 #define IN_DEV_TX_REDIRECTS(in_dev)	(ipv4_devconf.send_redirects || =
(in_dev)->cnf.send_redirects)=0A=
 #define IN_DEV_SEC_REDIRECTS(in_dev)	(ipv4_devconf.secure_redirects || =
(in_dev)->cnf.secure_redirects)=0A=
diff -u -r linux-2.4.20/include/linux/sysctl.h =
linux-hidden/include/linux/sysctl.h=0A=
--- linux-2.4.20/include/linux/sysctl.h	Thu Nov 28 13:53:15 2002=0A=
+++ linux-hidden/include/linux/sysctl.h	Thu Dec  5 08:57:03 2002=0A=
@@ -339,6 +339,7 @@=0A=
 	NET_IPV4_CONF_TAG=3D12,=0A=
 	NET_IPV4_CONF_ARPFILTER=3D13,=0A=
 	NET_IPV4_CONF_MEDIUM_ID=3D14,=0A=
+	NET_IPV4_CONF_HIDDEN=3D15,=0A=
 };=0A=
 =0A=
 /* /proc/sys/net/ipv6 */=0A=
diff -u -r linux-2.4.20/net/ipv4/arp.c linux-hidden/net/ipv4/arp.c=0A=
--- linux-2.4.20/net/ipv4/arp.c	Thu Nov 28 13:53:15 2002=0A=
+++ linux-hidden/net/ipv4/arp.c	Thu Dec  5 08:57:42 2002=0A=
@@ -66,6 +66,8 @@=0A=
  *		Alexey Kuznetsov:	new arp state machine;=0A=
  *					now it is in net/core/neighbour.c.=0A=
  *		Krzysztof Halasa:	Added Frame Relay ARP support.=0A=
+ *		Julian Anastasov:	"hidden" flag: hide the=0A=
+ *					interface and don't reply for it=0A=
  */=0A=
 =0A=
 #include <linux/types.h>=0A=
@@ -317,12 +319,23 @@=0A=
 static void arp_solicit(struct neighbour *neigh, struct sk_buff =
*skb)=0A=
 {=0A=
 	u32 saddr;=0A=
+	int from_skb;=0A=
+	struct in_device *in_dev2 =3D NULL;=0A=
+	struct net_device *dev2 =3D NULL;=0A=
 	u8  *dst_ha =3D NULL;=0A=
 	struct net_device *dev =3D neigh->dev;=0A=
 	u32 target =3D *(u32*)neigh->primary_key;=0A=
 	int probes =3D atomic_read(&neigh->probes);=0A=
 =0A=
-	if (skb && inet_addr_type(skb->nh.iph->saddr) =3D=3D RTN_LOCAL)=0A=
+	from_skb =3D (skb &&=0A=
+		(dev2 =3D ip_dev_find(skb->nh.iph->saddr)) !=3D NULL &&=0A=
+		(in_dev2 =3D in_dev_get(dev2)) !=3D NULL &&=0A=
+		!IN_DEV_HIDDEN(in_dev2));=0A=
+	if (dev2) {=0A=
+		if (in_dev2) in_dev_put(in_dev2);=0A=
+		dev_put(dev2);=0A=
+	}=0A=
+	if (from_skb)=0A=
 		saddr =3D skb->nh.iph->saddr;=0A=
 	else=0A=
 		saddr =3D inet_select_addr(dev, target, RT_SCOPE_LINK);=0A=
@@ -754,9 +767,22 @@=0A=
 =0A=
 	/* Special case: IPv4 duplicate address detection packet (RFC2131) =
*/=0A=
 	if (sip =3D=3D 0) {=0A=
-		if (arp->ar_op =3D=3D htons(ARPOP_REQUEST) &&=0A=
-		    inet_addr_type(tip) =3D=3D RTN_LOCAL)=0A=
+ 		int reply;=0A=
+ 		struct net_device *dev2 =3D NULL;=0A=
+ 		struct in_device *in_dev2 =3D NULL;=0A=
+ =0A=
+ 		reply =3D=0A=
+ 		    (arp->ar_op =3D=3D htons(ARPOP_REQUEST) &&=0A=
+ 		    (dev2 =3D ip_dev_find(tip)) !=3D NULL &&=0A=
+ 		    (dev2 =3D=3D dev ||=0A=
+ 		    ((in_dev2 =3D in_dev_get(dev2)) !=3D NULL &&=0A=
+ 		    !IN_DEV_HIDDEN(in_dev2))));=0A=
+ 		if (dev2) {=0A=
+ 		    if (in_dev2) in_dev_put(in_dev2);=0A=
+ 		    dev_put(dev2);=0A=
+ 		    if (reply)=0A=
 			=
arp_send(ARPOP_REPLY,ETH_P_ARP,tip,dev,tip,sha,dev->dev_addr,dev->dev_ad=
dr);=0A=
+ 		}=0A=
 		goto out;=0A=
 	}=0A=
 =0A=
@@ -770,6 +796,21 @@=0A=
 			n =3D neigh_event_ns(&arp_tbl, sha, &sip, dev);=0A=
 			if (n) {=0A=
 				int dont_send =3D 0;=0A=
+				if (ipv4_devconf.hidden &&=0A=
+				    skb->pkt_type !=3D PACKET_HOST) {=0A=
+					struct net_device *dev2 =3D NULL;=0A=
+					struct in_device *in_dev2 =3D NULL;=0A=
+=0A=
+					dont_send |=3D=0A=
+					  ((dev2 =3D ip_dev_find(tip)) !=3D NULL &&=0A=
+					  dev2 !=3D dev &&=0A=
+					  (in_dev2=3Din_dev_get(dev2)) !=3D NULL &&=0A=
+					  IN_DEV_HIDDEN(in_dev2));=0A=
+					if (dev2) {=0A=
+					    if (in_dev2) in_dev_put(in_dev2);=0A=
+					    dev_put(dev2);=0A=
+					}=0A=
+				}=0A=
 				if (IN_DEV_ARPFILTER(in_dev))=0A=
 					dont_send |=3D arp_filter(sip,tip,dev); =0A=
 				if (!dont_send)=0A=
diff -u -r linux-2.4.20/net/ipv4/devinet.c =
linux-hidden/net/ipv4/devinet.c=0A=
--- linux-2.4.20/net/ipv4/devinet.c	Fri Aug  2 14:39:46 2002=0A=
+++ linux-hidden/net/ipv4/devinet.c	Thu Dec  5 08:57:03 2002=0A=
@@ -756,7 +756,8 @@=0A=
 =0A=
 		read_lock(&in_dev->lock);=0A=
 		for_primary_ifa(in_dev) {=0A=
-			if (ifa->ifa_scope !=3D RT_SCOPE_LINK &&=0A=
+			if (!IN_DEV_HIDDEN(in_dev) &&=0A=
+			    ifa->ifa_scope !=3D RT_SCOPE_LINK &&=0A=
 			    ifa->ifa_scope <=3D scope) {=0A=
 				read_unlock(&in_dev->lock);=0A=
 				read_unlock(&inetdev_lock);=0A=
@@ -1032,7 +1033,7 @@=0A=
 static struct devinet_sysctl_table=0A=
 {=0A=
 	struct ctl_table_header *sysctl_header;=0A=
-	ctl_table devinet_vars[15];=0A=
+	ctl_table devinet_vars[16];=0A=
 	ctl_table devinet_dev[2];=0A=
 	ctl_table devinet_conf_dir[2];=0A=
 	ctl_table devinet_proto_dir[2];=0A=
@@ -1078,6 +1079,9 @@=0A=
 	{NET_IPV4_CONF_TAG, "tag",=0A=
 	 &ipv4_devconf.tag, sizeof(int), 0644, NULL,=0A=
 	 &proc_dointvec},=0A=
+	{NET_IPV4_CONF_HIDDEN, "hidden",=0A=
+	 &ipv4_devconf.hidden, sizeof(int), 0644, NULL,=0A=
+	 &proc_dointvec},=0A=
 	{NET_IPV4_CONF_ARPFILTER, "arp_filter",=0A=
 	 &ipv4_devconf.arp_filter, sizeof(int), 0644, NULL,=0A=
 	 &proc_dointvec},=0A=

------_=_NextPart_000_01C29CA0.6B111EDE--
