Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030538AbWAGSPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030538AbWAGSPf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 13:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030535AbWAGSPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 13:15:35 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34053 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030534AbWAGSPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 13:15:34 -0500
Date: Sat, 7 Jan 2006 19:15:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] net/ipv4/ip_output.c: make ip_fragment() static
Message-ID: <20060107181533.GO3774@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since there's no longer any external user of ip_fragment() we can make 
it static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/net/ip.h     |    1 -
 net/ipv4/ip_output.c |    5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.15-mm2-full/include/net/ip.h.old	2006-01-07 17:12:04.000000000 +0100
+++ linux-2.6.15-mm2-full/include/net/ip.h	2006-01-07 17:12:11.000000000 +0100
@@ -95,7 +95,6 @@
 extern int		ip_mr_input(struct sk_buff *skb);
 extern int		ip_output(struct sk_buff *skb);
 extern int		ip_mc_output(struct sk_buff *skb);
-extern int		ip_fragment(struct sk_buff *skb, int (*out)(struct sk_buff*));
 extern int		ip_do_nat(struct sk_buff *skb);
 extern void		ip_send_check(struct iphdr *ip);
 extern int		ip_queue_xmit(struct sk_buff *skb, int ipfragok);
--- linux-2.6.15-mm2-full/net/ipv4/ip_output.c.old	2006-01-07 17:12:21.000000000 +0100
+++ linux-2.6.15-mm2-full/net/ipv4/ip_output.c	2006-01-07 17:21:33.000000000 +0100
@@ -85,6 +85,8 @@
 
 int sysctl_ip_default_ttl = IPDEFTTL;
 
+static int ip_fragment(struct sk_buff *skb, int (*output)(struct sk_buff*));
+
 /* Generate a checksum for an outgoing IP datagram. */
 __inline__ void ip_send_check(struct iphdr *iph)
 {
@@ -409,7 +411,7 @@
  *	single device frame, and queue such a frame for sending.
  */
 
-int ip_fragment(struct sk_buff *skb, int (*output)(struct sk_buff*))
+static int ip_fragment(struct sk_buff *skb, int (*output)(struct sk_buff*))
 {
 	struct iphdr *iph;
 	int raw = 0;
@@ -1391,7 +1393,6 @@
 #endif
 }
 
-EXPORT_SYMBOL(ip_fragment);
 EXPORT_SYMBOL(ip_generic_getfrag);
 EXPORT_SYMBOL(ip_queue_xmit);
 EXPORT_SYMBOL(ip_send_check);

