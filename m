Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbULLVLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbULLVLn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 16:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbULLVLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 16:11:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45574 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262119AbULLVLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 16:11:38 -0500
Date: Sun, 12 Dec 2004 22:11:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: acme@conectiva.com.br
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/appletalk/: make some code static
Message-ID: <20041212211128.GW22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 include/linux/atalk.h      |    2 --
 net/appletalk/aarp.c       |    4 ++--
 net/appletalk/atalk_proc.c |    6 +++---
 net/appletalk/ddp.c        |    6 +++---
 4 files changed, 8 insertions(+), 10 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/linux/atalk.h.old	2004-12-12 18:21:46.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/atalk.h	2004-12-12 18:21:53.000000000 +0100
@@ -188,8 +188,6 @@
 extern int		 aarp_send_ddp(struct net_device *dev,
 				       struct sk_buff *skb,
 				       struct atalk_addr *sa, void *hwaddr);
-extern void		 aarp_send_probe(struct net_device *dev,
-					 struct atalk_addr *addr);
 extern void		 aarp_device_down(struct net_device *dev);
 extern void		 aarp_probe_network(struct atalk_iface *atif);
 extern int 		 aarp_proxy_probe_network(struct atalk_iface *atif,
--- linux-2.6.10-rc2-mm4-full/net/appletalk/aarp.c.old	2004-12-12 18:22:02.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/appletalk/aarp.c	2004-12-12 18:22:12.000000000 +0100
@@ -199,7 +199,7 @@
  *	aarp_proxy_probe_network.
  */
 
-void aarp_send_probe(struct net_device *dev, struct atalk_addr *us)
+static void aarp_send_probe(struct net_device *dev, struct atalk_addr *us)
 {
 	struct elapaarp *eah;
 	int len = dev->hard_header_len + sizeof(*eah) + aarp_dl->header_length;
@@ -429,7 +429,7 @@
  * Probe a Phase 1 device or a device that requires its Net:Node to
  * be set via an ioctl.
  */
-void aarp_send_probe_phase1(struct atalk_iface *iface)
+static void aarp_send_probe_phase1(struct atalk_iface *iface)
 {
 	struct ifreq atreq;
 	struct sockaddr_at *sa = (struct sockaddr_at *)&atreq.ifr_addr;
--- linux-2.6.10-rc2-mm4-full/net/appletalk/atalk_proc.c.old	2004-12-12 18:22:28.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/appletalk/atalk_proc.c	2004-12-12 18:23:02.000000000 +0100
@@ -205,21 +205,21 @@
 	return 0;
 }
 
-struct seq_operations atalk_seq_interface_ops = {
+static struct seq_operations atalk_seq_interface_ops = {
 	.start  = atalk_seq_interface_start,
 	.next   = atalk_seq_interface_next,
 	.stop   = atalk_seq_interface_stop,
 	.show   = atalk_seq_interface_show,
 };
 
-struct seq_operations atalk_seq_route_ops = {
+static struct seq_operations atalk_seq_route_ops = {
 	.start  = atalk_seq_route_start,
 	.next   = atalk_seq_route_next,
 	.stop   = atalk_seq_route_stop,
 	.show   = atalk_seq_route_show,
 };
 
-struct seq_operations atalk_seq_socket_ops = {
+static struct seq_operations atalk_seq_socket_ops = {
 	.start  = atalk_seq_socket_start,
 	.next   = atalk_seq_socket_next,
 	.stop   = atalk_seq_socket_stop,
--- linux-2.6.10-rc2-mm4-full/net/appletalk/ddp.c.old	2004-12-12 18:23:35.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/appletalk/ddp.c	2004-12-12 18:24:11.000000000 +0100
@@ -612,7 +612,7 @@
  * Called when a device is downed. Just throw away any routes
  * via it.
  */
-void atrtr_device_down(struct net_device *dev)
+static void atrtr_device_down(struct net_device *dev)
 {
 	struct atalk_route **r = &atalk_routes;
 	struct atalk_route *tmp;
@@ -1854,12 +1854,12 @@
 	.notifier_call	= ddp_device_event,
 };
 
-struct packet_type ltalk_packet_type = {
+static struct packet_type ltalk_packet_type = {
 	.type		= __constant_htons(ETH_P_LOCALTALK),
 	.func		= ltalk_rcv,
 };
 
-struct packet_type ppptalk_packet_type = {
+static struct packet_type ppptalk_packet_type = {
 	.type		= __constant_htons(ETH_P_PPPTALK),
 	.func		= atalk_rcv,
 };

