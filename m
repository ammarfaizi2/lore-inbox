Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbTDMXaV (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 19:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbTDMXaV (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 19:30:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51167 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262659AbTDMXaT (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 19:30:19 -0400
Date: Sun, 13 Apr 2003 16:34:40 -0700 (PDT)
Message-Id: <20030413.163440.22453695.davem@redhat.com>
To: bunk@fs.tum.de
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm2: multiple definition of `ipip_err'
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030413201643.GP9640@fs.tum.de>
References: <20030412180852.77b6c5e8.akpm@digeo.com>
	<20030413201643.GP9640@fs.tum.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Adrian Bunk <bunk@fs.tum.de>
   Date: Sun, 13 Apr 2003 22:16:43 +0200

   On Sat, Apr 12, 2003 at 06:08:52PM -0700, Andrew Morton wrote:
   >...
   >  linus.patch
   > 
   >  Latest -bk
   >...
   
   The following compile error seems to come from Linus' tree:
   
This patch undoubtedly fixes it.  I'm actually perplexed about that
GCC didn't at least warn about the fact that ipip_fb_tunnel_init() is
first declared static and then defined non-static.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1179  -> 1.1180 
#	net/ipv4/xfrm4_tunnel.c	1.1     -> 1.2    
#	     net/ipv4/ipip.c	1.26    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/13	davem@nuts.ninka.net	1.1180
# [IPV4]: xfrm4_tunnel and ipip need to privateize some symbols.
# --------------------------------------------
#
diff -Nru a/net/ipv4/ipip.c b/net/ipv4/ipip.c
--- a/net/ipv4/ipip.c	Sun Apr 13 16:39:07 2003
+++ b/net/ipv4/ipip.c	Sun Apr 13 16:39:07 2003
@@ -208,7 +208,7 @@
 	write_unlock_bh(&ipip_lock);
 }
 
-struct ip_tunnel * ipip_tunnel_locate(struct ip_tunnel_parm *parms, int create)
+static struct ip_tunnel * ipip_tunnel_locate(struct ip_tunnel_parm *parms, int create)
 {
 	u32 remote = parms->iph.daddr;
 	u32 local = parms->iph.saddr;
@@ -286,7 +286,7 @@
 	dev_put(dev);
 }
 
-void ipip_err(struct sk_buff *skb, void *__unused)
+static void ipip_err(struct sk_buff *skb, void *__unused)
 {
 #ifndef I_WISH_WORLD_WERE_PERFECT
 
@@ -478,7 +478,7 @@
 		IP_ECN_set_ce(inner_iph);
 }
 
-int ipip_rcv(struct sk_buff *skb)
+static int ipip_rcv(struct sk_buff *skb)
 {
 	struct iphdr *iph;
 	struct ip_tunnel *tunnel;
@@ -852,7 +852,7 @@
 	return 0;
 }
 
-int __init ipip_fb_tunnel_init(struct net_device *dev)
+static int __init ipip_fb_tunnel_init(struct net_device *dev)
 {
 	struct iphdr *iph;
 
diff -Nru a/net/ipv4/xfrm4_tunnel.c b/net/ipv4/xfrm4_tunnel.c
--- a/net/ipv4/xfrm4_tunnel.c	Sun Apr 13 16:39:07 2003
+++ b/net/ipv4/xfrm4_tunnel.c	Sun Apr 13 16:39:07 2003
@@ -163,7 +163,7 @@
 	return 0;
 }
 
-void ipip_err(struct sk_buff *skb, u32 info)
+static void ipip_err(struct sk_buff *skb, u32 info)
 {
 	struct xfrm_tunnel *handler = ipip_handler;
 	u32 arg = info;
