Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266441AbUGBERx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266441AbUGBERx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 00:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266456AbUGBERx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 00:17:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41072 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S266441AbUGBERP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 00:17:15 -0400
Date: Fri, 02 Jul 2004 00:17:13 -0400
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [PATCH 2.4.27-rc2]  [TRIVIAL]  C99 initializers
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Message-id: <40E4E1C9.9080007@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_Vrv9Y8RCtu4+eZ+LpQX2aw)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_Vrv9Y8RCtu4+eZ+LpQX2aw)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Dave,

    the attached patches add C99 initializers to the following files in 
the net/ipv4 directory:

    arp.c
    udp.c
    protocol.c
    tcp_ipv4.c

Regards,

Stephane Ouellette


--Boundary_(ID_Vrv9Y8RCtu4+eZ+LpQX2aw)
Content-type: text/plain; name=arp.c.patch; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=arp.c.patch

--- linux-2.4.27-rc2/net/ipv4/arp.c	Thu Jul  1 23:07:49 2004
+++ linux-2.4.27-rc2-fixed/net/ipv4/arp.c	Thu Jul  1 23:47:58 2004
@@ -129,70 +129,70 @@
 static void parp_redo(struct sk_buff *skb);
 
 static struct neigh_ops arp_generic_ops = {
-	family:			AF_INET,
-	solicit:		arp_solicit,
-	error_report:		arp_error_report,
-	output:			neigh_resolve_output,
-	connected_output:	neigh_connected_output,
-	hh_output:		dev_queue_xmit,
-	queue_xmit:		dev_queue_xmit,
+	.family =		AF_INET,
+	.solicit =		arp_solicit,
+	.error_report =		arp_error_report,
+	.output =		neigh_resolve_output,
+	.connected_output =	neigh_connected_output,
+	.hh_output =		dev_queue_xmit,
+	.queue_xmit =		dev_queue_xmit,
 };
 
 static struct neigh_ops arp_hh_ops = {
-	family:			AF_INET,
-	solicit:		arp_solicit,
-	error_report:		arp_error_report,
-	output:			neigh_resolve_output,
-	connected_output:	neigh_resolve_output,
-	hh_output:		dev_queue_xmit,
-	queue_xmit:		dev_queue_xmit,
+	.family =		AF_INET,
+	.solicit =		arp_solicit,
+	.error_report =		arp_error_report,
+	.output =		neigh_resolve_output,
+	.connected_output =	neigh_resolve_output,
+	.hh_output =		dev_queue_xmit,
+	.queue_xmit =		dev_queue_xmit,
 };
 
 static struct neigh_ops arp_direct_ops = {
-	family:			AF_INET,
-	output:			dev_queue_xmit,
-	connected_output:	dev_queue_xmit,
-	hh_output:		dev_queue_xmit,
-	queue_xmit:		dev_queue_xmit,
+	.family =		AF_INET,
+	.output =		dev_queue_xmit,
+	.connected_output =	dev_queue_xmit,
+	.hh_output =		dev_queue_xmit,
+	.queue_xmit =		dev_queue_xmit,
 };
 
 struct neigh_ops arp_broken_ops = {
-	family:			AF_INET,
-	solicit:		arp_solicit,
-	error_report:		arp_error_report,
-	output:			neigh_compat_output,
-	connected_output:	neigh_compat_output,
-	hh_output:		dev_queue_xmit,
-	queue_xmit:		dev_queue_xmit,
+	.family =		AF_INET,
+	.solicit =		arp_solicit,
+	.error_report =		arp_error_report,
+	.output =		neigh_compat_output,
+	.connected_output =	neigh_compat_output,
+	.hh_output =		dev_queue_xmit,
+	.queue_xmit =		dev_queue_xmit,
 };
 
 struct neigh_table arp_tbl = {
-	family:		AF_INET,
-	entry_size:	sizeof(struct neighbour) + 4,
-	key_len:	4,
-	hash:		arp_hash,
-	constructor:	arp_constructor,
-	proxy_redo:	parp_redo,
-	id:		"arp_cache",
-	parms: {
-		tbl:			&arp_tbl,
-		base_reachable_time:	30 * HZ,
-		retrans_time:		1 * HZ,
-		gc_staletime:		60 * HZ,
-		reachable_time:		30 * HZ,
-		delay_probe_time:	5 * HZ,
-		queue_len:		3,
-		ucast_probes:		3,
-		mcast_probes:		3,
-		anycast_delay:		1 * HZ,
-		proxy_delay:		(8 * HZ) / 10,
-		proxy_qlen:		64,
-		locktime:		1 * HZ,
+	.family =	AF_INET,
+	.entry_size =	sizeof(struct neighbour) + 4,
+	.key_len =	4,
+	.hash =		arp_hash,
+	.constructor =	arp_constructor,
+	.proxy_redo =	parp_redo,
+	.id =		"arp_cache",
+	.parms = {
+		.tbl =			&arp_tbl,
+		.base_reachable_time =	30 * HZ,
+		.retrans_time =		1 * HZ,
+		.gc_staletime =		60 * HZ,
+		.reachable_time =	30 * HZ,
+		.delay_probe_time =	5 * HZ,
+		.queue_len =		3,
+		.ucast_probes =		3,
+		.mcast_probes =		3,
+		.anycast_delay =	1 * HZ,
+		.proxy_delay =		(8 * HZ) / 10,
+		.proxy_qlen =		64,
+		.locktime =		1 * HZ,
 	},
-	gc_interval:	30 * HZ,
-	gc_thresh1:	128,
-	gc_thresh2:	512,
-	gc_thresh3:	1024,
+	.gc_interval =	30 * HZ,
+	.gc_thresh1 =	128,
+	.gc_thresh2 =	512,
+	.gc_thresh3 =	1024,
 };
 
 int arp_mc_map(u32 addr, u8 *haddr, struct net_device *dev, int dir)
@@ -1344,9 +1344,9 @@
  */
 
 static struct packet_type arp_packet_type = {
-	type:	__constant_htons(ETH_P_ARP),
-	func:	arp_rcv,
-	data:	(void*) 1, /* understand shared skbs */
+	.type =	__constant_htons(ETH_P_ARP),
+	.func =	arp_rcv,
+	.data =	(void*) 1, /* understand shared skbs */
 };
 
 void __init arp_init (void)

--Boundary_(ID_Vrv9Y8RCtu4+eZ+LpQX2aw)
Content-type: text/plain; name=protocol.c.patch; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=protocol.c.patch

--- linux-2.4.27-rc2/net/ipv4/protocol.c	Sat May 19 20:56:43 2001
+++ linux-2.4.27-rc2-fixed/net/ipv4/protocol.c	Thu Jul  1 23:11:08 2004
@@ -53,10 +53,10 @@
 #ifdef CONFIG_IP_MULTICAST
 
 static struct inet_protocol igmp_protocol = {
-	handler:	igmp_rcv,
-	next:		IPPROTO_PREVIOUS,
-	protocol:	IPPROTO_IGMP,
-	name:		"IGMP"
+	.handler  =	igmp_rcv,
+	.next     =	IPPROTO_PREVIOUS,
+	.protocol =	IPPROTO_IGMP,
+	.name	  =	"IGMP"
 };
 
 #undef  IPPROTO_PREVIOUS
@@ -65,32 +65,32 @@
 #endif
 
 static struct inet_protocol tcp_protocol = {
-	handler:	tcp_v4_rcv,
-	err_handler:	tcp_v4_err,
-	next:		IPPROTO_PREVIOUS,
-	protocol:	IPPROTO_TCP,
-	name:		"TCP"
+	.handler     =	tcp_v4_rcv,
+	.err_handler =	tcp_v4_err,
+	.next	     =	IPPROTO_PREVIOUS,
+	.protocol    =	IPPROTO_TCP,
+	.name	     =	"TCP"
 };
 
 #undef  IPPROTO_PREVIOUS
 #define IPPROTO_PREVIOUS &tcp_protocol
 
 static struct inet_protocol udp_protocol = {
-	handler:	udp_rcv,
-	err_handler:	udp_err,
-	next:		IPPROTO_PREVIOUS,
-	protocol:	IPPROTO_UDP,
-	name:		"UDP"
+	.handler     =	udp_rcv,
+	.err_handler =	udp_err,
+	.next	     =	IPPROTO_PREVIOUS,
+	.protocol    =	IPPROTO_UDP,
+	.name	     =	"UDP"
 };
 
 #undef  IPPROTO_PREVIOUS
 #define IPPROTO_PREVIOUS &udp_protocol
 
 static struct inet_protocol icmp_protocol = {
-	handler:	icmp_rcv,
-	next:		IPPROTO_PREVIOUS,
-	protocol:	IPPROTO_ICMP,
-	name:		"ICMP"
+	.handler  =	icmp_rcv,
+	.next	  =	IPPROTO_PREVIOUS,
+	.protocol =	IPPROTO_ICMP,
+	.name	  =	"ICMP"
 };
 
 #undef  IPPROTO_PREVIOUS
@@ -112,7 +112,7 @@
 
 	hash = prot->protocol & (MAX_INET_PROTOS - 1);
 	br_write_lock_bh(BR_NETPROTO_LOCK);
-	prot ->next = inet_protos[hash];
+	prot->next = inet_protos[hash];
 	inet_protos[hash] = prot;
 	prot->copy = 0;
 

--Boundary_(ID_Vrv9Y8RCtu4+eZ+LpQX2aw)
Content-type: text/plain; name=tcp_ipv4.c.patch; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=tcp_ipv4.c.patch

--- linux-2.4.27-rc2/net/ipv4/tcp_ipv4.c	Thu Jul  1 23:07:49 2004
+++ linux-2.4.27-rc2-fixed/net/ipv4/tcp_ipv4.c	Thu Jul  1 23:51:55 2004
@@ -87,16 +87,16 @@
  * ALL members must be initialised to prevent gcc-2.7.2.3 miscompilation
  */
 struct tcp_hashinfo __cacheline_aligned tcp_hashinfo = {
-	__tcp_ehash:          NULL,
-	__tcp_bhash:          NULL,
-	__tcp_bhash_size:     0,
-	__tcp_ehash_size:     0,
-	__tcp_listening_hash: { NULL, },
-	__tcp_lhash_lock:     RW_LOCK_UNLOCKED,
-	__tcp_lhash_users:    ATOMIC_INIT(0),
-	__tcp_lhash_wait:
+	.__tcp_ehash =          NULL,
+	.__tcp_bhash =          NULL,
+	.__tcp_bhash_size =     0,
+	.__tcp_ehash_size =     0,
+	.__tcp_listening_hash = { NULL, },
+	.__tcp_lhash_lock =     RW_LOCK_UNLOCKED,
+	.__tcp_lhash_users =    ATOMIC_INIT(0),
+	.__tcp_lhash_wait =
 	  __WAIT_QUEUE_HEAD_INITIALIZER(tcp_hashinfo.__tcp_lhash_wait),
-	__tcp_portalloc_lock: SPIN_LOCK_UNLOCKED
+	.__tcp_portalloc_lock = SPIN_LOCK_UNLOCKED
 };
 
 /*
@@ -2290,23 +2290,23 @@
 }
 
 struct proto tcp_prot = {
-	name:		"TCP",
-	close:		tcp_close,
-	connect:	tcp_v4_connect,
-	disconnect:	tcp_disconnect,
-	accept:		tcp_accept,
-	ioctl:		tcp_ioctl,
-	init:		tcp_v4_init_sock,
-	destroy:	tcp_v4_destroy_sock,
-	shutdown:	tcp_shutdown,
-	setsockopt:	tcp_setsockopt,
-	getsockopt:	tcp_getsockopt,
-	sendmsg:	tcp_sendmsg,
-	recvmsg:	tcp_recvmsg,
-	backlog_rcv:	tcp_v4_do_rcv,
-	hash:		tcp_v4_hash,
-	unhash:		tcp_unhash,
-	get_port:	tcp_v4_get_port,
+	.name =		"TCP",
+	.close =	tcp_close,
+	.connect =	tcp_v4_connect,
+	.disconnect =	tcp_disconnect,
+	.accept =	tcp_accept,
+	.ioctl =	tcp_ioctl,
+	.init =		tcp_v4_init_sock,
+	.destroy =	tcp_v4_destroy_sock,
+	.shutdown =	tcp_shutdown,
+	.setsockopt =	tcp_setsockopt,
+	.getsockopt =	tcp_getsockopt,
+	.sendmsg =	tcp_sendmsg,
+	.recvmsg =	tcp_recvmsg,
+	.backlog_rcv =	tcp_v4_do_rcv,
+	.hash =		tcp_v4_hash,
+	.unhash =	tcp_unhash,
+	.get_port =	tcp_v4_get_port,
 };
 
 

--Boundary_(ID_Vrv9Y8RCtu4+eZ+LpQX2aw)
Content-type: text/plain; name=udp.c.patch; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=udp.c.patch

--- linux-2.4.27-rc2/net/ipv4/udp.c	Thu Jul  1 23:07:53 2004
+++ linux-2.4.27-rc2-fixed/net/ipv4/udp.c	Thu Jul  1 23:11:18 2004
@@ -874,7 +874,7 @@
 
 /* Initialize UDP checksum. If exited with zero value (success),
  * CHECKSUM_UNNECESSARY means, that no more checks are required.
- * Otherwise, csum completion requires chacksumming packet body,
+ * Otherwise, csum completion requires checksumming packet body,
  * including udp header and folding it to skb->csum.
  */
 static int udp_checksum_init(struct sk_buff *skb, struct udphdr *uh,
@@ -1048,17 +1048,17 @@
 }
 
 struct proto udp_prot = {
- 	name:		"UDP",
-	close:		udp_close,
-	connect:	udp_connect,
-	disconnect:	udp_disconnect,
-	ioctl:		udp_ioctl,
-	setsockopt:	ip_setsockopt,
-	getsockopt:	ip_getsockopt,
-	sendmsg:	udp_sendmsg,
-	recvmsg:	udp_recvmsg,
-	backlog_rcv:	udp_queue_rcv_skb,
-	hash:		udp_v4_hash,
-	unhash:		udp_v4_unhash,
-	get_port:	udp_v4_get_port,
+	.name	     =	"UDP",
+	.close	     =	udp_close,
+	.connect     =	udp_connect,
+	.disconnect  =	udp_disconnect,
+	.ioctl       =	udp_ioctl,
+	.setsockopt  =	ip_setsockopt,
+	.getsockopt  =	ip_getsockopt,
+	.sendmsg     =	udp_sendmsg,
+	.recvmsg     =	udp_recvmsg,
+	.backlog_rcv =	udp_queue_rcv_skb,
+	.hash	     =	udp_v4_hash,
+	.unhash	     =	udp_v4_unhash,
+	.get_port    =	udp_v4_get_port,
 };

--Boundary_(ID_Vrv9Y8RCtu4+eZ+LpQX2aw)--
