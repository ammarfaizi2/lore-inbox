Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSFUCPc>; Thu, 20 Jun 2002 22:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316182AbSFUCPb>; Thu, 20 Jun 2002 22:15:31 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:55819 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S316161AbSFUCPa>;
	Thu, 20 Jun 2002 22:15:30 -0400
Date: Thu, 20 Jun 2002 22:06:35 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.24 : tr_source_route undefined fix
Message-ID: <Pine.LNX.4.44.0206202200190.2976-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   While 'make bzImage' , I received an error with net/netsyms.c that 
stated that tr_source_route was undefined. The following patch to 
net/802/tr.c and include/linux/trdevice.h addresses this compile error. 
Please review for inclusion.

Regards,
Frank

--- net/802/tr.c.old	Thu Jun 20 20:52:05 2002
+++ net/802/tr.c	Thu Jun 20 20:51:59 2002
@@ -36,7 +36,7 @@
 #include <linux/init.h>
 #include <net/arp.h>
 
-static void tr_source_route(struct sk_buff *skb, struct trh_hdr *trh, struct net_device *dev);
+void tr_source_route(struct sk_buff *skb, struct trh_hdr *trh, struct net_device *dev);
 static void tr_add_rif_info(struct trh_hdr *trh, struct net_device *dev);
 static void rif_check_expire(unsigned long dummy);
 
@@ -230,7 +230,7 @@
  *	We try to do source routing... 
  */
 
-static void tr_source_route(struct sk_buff *skb,struct trh_hdr *trh,struct net_device *dev) 
+void tr_source_route(struct sk_buff *skb,struct trh_hdr *trh,struct net_device *dev) 
 {
 	int i, slack;
 	unsigned int hash;

--- include/linux/trdevice.h.old	Thu Jun 20 21:53:21 2002
+++ include/linux/trdevice.h	Thu Jun 20 21:53:11 2002
@@ -37,6 +37,7 @@
 extern struct net_device *alloc_trdev(int sizeof_priv);
 extern int register_trdev(struct net_device *dev);
 extern void unregister_trdev(struct net_device *dev);
+extern void tr_source_route(struct sk_buff *skb, struct trh_hdr *trh, struct net_device *dev);
 
 #endif
 

