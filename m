Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSGRFNV>; Thu, 18 Jul 2002 01:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317724AbSGRFNV>; Thu, 18 Jul 2002 01:13:21 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:45765 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316545AbSGRFNU>;
	Thu, 18 Jul 2002 01:13:20 -0400
Date: Wed, 17 Jul 2002 22:13:44 -0700
From: Anton Blanchard <anton@samba.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix token ring compile
Message-ID: <20020718051344.GC1204@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Since we EXPORT_SYMBOL(tr_source_route) in net/netsyms.c and it needs a
prototype, move it into include/linux/trdevice.h

Anton

===== include/linux/trdevice.h 1.2 vs edited =====
--- 1.2/include/linux/trdevice.h	Mon Feb  4 23:38:37 2002
+++ edited/include/linux/trdevice.h	Wed Jul 17 19:52:46 2002
@@ -33,6 +33,7 @@
 				   void *saddr, unsigned len);
 extern int		tr_rebuild_header(struct sk_buff *skb);
 extern unsigned short	tr_type_trans(struct sk_buff *skb, struct net_device *dev);
+extern void tr_source_route(struct sk_buff *skb, struct trh_hdr *trh, struct net_device *dev);
 extern struct net_device *init_trdev(struct net_device *dev, int sizeof_priv);
 extern struct net_device *alloc_trdev(int sizeof_priv);
 extern int register_trdev(struct net_device *dev);
===== net/802/tr.c 1.2 vs edited =====
--- 1.2/net/802/tr.c	Wed May 22 11:16:37 2002
+++ edited/net/802/tr.c	Wed Jul 17 19:52:47 2002
@@ -36,7 +36,6 @@
 #include <linux/init.h>
 #include <net/arp.h>
 
-static void tr_source_route(struct sk_buff *skb, struct trh_hdr *trh, struct net_device *dev);
 static void tr_add_rif_info(struct trh_hdr *trh, struct net_device *dev);
 static void rif_check_expire(unsigned long dummy);
 
@@ -230,7 +229,7 @@
  *	We try to do source routing... 
  */
 
-static void tr_source_route(struct sk_buff *skb,struct trh_hdr *trh,struct net_device *dev) 
+void tr_source_route(struct sk_buff *skb,struct trh_hdr *trh,struct net_device *dev) 
 {
 	int i, slack;
 	unsigned int hash;
