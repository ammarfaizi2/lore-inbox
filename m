Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbULOBXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbULOBXk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 20:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbULOBVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 20:21:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57100 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261794AbULOArt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:47:49 -0500
Date: Wed, 15 Dec 2004 01:47:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/packet/af_packet.c: make some code static
Message-ID: <20041215004745.GI23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 net/packet/af_packet.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/net/packet/af_packet.c.old	2004-12-14 21:47:49.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/packet/af_packet.c	2004-12-14 21:50:25.000000000 +0100
@@ -145,10 +145,10 @@
  */
 
 /* List of all packet sockets. */
-HLIST_HEAD(packet_sklist);
+static HLIST_HEAD(packet_sklist);
 static rwlock_t packet_sklist_lock = RW_LOCK_UNLOCKED;
 
-atomic_t packet_socks_nr;
+static atomic_t packet_socks_nr;
 
 
 /* Private packet socket structures. */
@@ -215,7 +215,7 @@
 
 #define pkt_sk(__sk) ((struct packet_opt *)(__sk)->sk_protinfo)
 
-void packet_sock_destruct(struct sock *sk)
+static void packet_sock_destruct(struct sock *sk)
 {
 	BUG_TRAP(!atomic_read(&sk->sk_rmem_alloc));
 	BUG_TRAP(!atomic_read(&sk->sk_wmem_alloc));
@@ -234,10 +234,10 @@
 }
 
 
-extern struct proto_ops packet_ops;
+static struct proto_ops packet_ops;
 
 #ifdef CONFIG_SOCK_PACKET
-extern struct proto_ops packet_ops_spkt;
+static struct proto_ops packet_ops_spkt;
 
 static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,  struct packet_type *pt)
 {
@@ -1350,8 +1350,8 @@
 	}
 }
 
-int packet_getsockopt(struct socket *sock, int level, int optname,
-		      char __user *optval, int __user *optlen)
+static int packet_getsockopt(struct socket *sock, int level, int optname,
+			     char __user *optval, int __user *optlen)
 {
 	int len;
 	struct sock *sk = sock->sk;
@@ -1500,7 +1500,8 @@
 #define packet_poll datagram_poll
 #else
 
-unsigned int packet_poll(struct file * file, struct socket *sock, poll_table *wait)
+static unsigned int packet_poll(struct file * file, struct socket *sock,
+				poll_table *wait)
 {
 	struct sock *sk = sock->sk;
 	struct packet_opt *po = pkt_sk(sk);
@@ -1747,7 +1748,7 @@
 
 
 #ifdef CONFIG_SOCK_PACKET
-struct proto_ops packet_ops_spkt = {
+static struct proto_ops packet_ops_spkt = {
 	.family =	PF_PACKET,
 	.owner =	THIS_MODULE,
 	.release =	packet_release,
@@ -1769,7 +1770,7 @@
 };
 #endif
 
-struct proto_ops packet_ops = {
+static struct proto_ops packet_ops = {
 	.family =	PF_PACKET,
 	.owner =	THIS_MODULE,
 	.release =	packet_release,

