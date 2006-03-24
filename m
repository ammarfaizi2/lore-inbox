Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422776AbWCXAJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422776AbWCXAJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 19:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422846AbWCXAJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 19:09:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64272 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422843AbWCXAJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 19:09:17 -0500
Date: Fri, 24 Mar 2006 01:09:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jing Min Zhao <zhaojignmin@hotmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org
Subject: [RFC: 2.6 patch] ip_conntrack_helper_h323.c: make get_h245_addr() static
Message-ID: <20060324000916.GN22727@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/ipv4/netfilter/ip_conntrack_helper_h323.c |    5 ++---
 net/ipv4/netfilter/ip_nat_helper_h323.c       |    2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

--- linux-2.6.16-mm1-full/net/ipv4/netfilter/ip_nat_helper_h323.c.old	2006-03-23 23:13:59.000000000 +0100
+++ linux-2.6.16-mm1-full/net/ipv4/netfilter/ip_nat_helper_h323.c	2006-03-23 23:14:05.000000000 +0100
@@ -49,8 +49,6 @@
 #define DEBUGP(format, args...)
 #endif
 
-extern int get_h245_addr(unsigned char *data, H245_TransportAddress * addr,
-			 u_int32_t * ip, u_int16_t * port);
 extern int get_h225_addr(unsigned char *data, TransportAddress * addr,
 			 u_int32_t * ip, u_int16_t * port);
 extern void ip_conntrack_h245_expect(struct ip_conntrack *new,
--- linux-2.6.16-mm1-full/net/ipv4/netfilter/ip_conntrack_helper_h323.c.old	2006-03-23 23:14:21.000000000 +0100
+++ linux-2.6.16-mm1-full/net/ipv4/netfilter/ip_conntrack_helper_h323.c	2006-03-23 23:14:35.000000000 +0100
@@ -222,8 +222,8 @@
 }
 
 /****************************************************************************/
-int get_h245_addr(unsigned char *data, H245_TransportAddress * addr,
-		  u_int32_t * ip, u_int16_t * port)
+static int get_h245_addr(unsigned char *data, H245_TransportAddress * addr,
+			 u_int32_t * ip, u_int16_t * port)
 {
 	unsigned char *p;
 
@@ -1713,7 +1713,6 @@
 module_init(init);
 module_exit(fini);
 
-EXPORT_SYMBOL(get_h245_addr);
 EXPORT_SYMBOL(get_h225_addr);
 EXPORT_SYMBOL(ip_conntrack_h245_expect);
 EXPORT_SYMBOL(ip_conntrack_q931_expect);

