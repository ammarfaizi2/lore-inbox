Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVCFU6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVCFU6U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 15:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVCFU6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 15:58:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43525 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261504AbVCFU54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 15:57:56 -0500
Date: Sun, 6 Mar 2005 21:57:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: davem@davemloft.net
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/802/fc.c: #if 0 fc_type_trans
Message-ID: <20050306205754.GO5070@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only user of fc_type_trans (drivers/net/fc/iph5526.c) is BROKEN in 
2.6 and removed in -mm.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/fcdevice.h |    2 --
 net/802/fc.c             |    2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.11-mm1-full/include/linux/fcdevice.h.old	2005-03-06 21:40:36.000000000 +0100
+++ linux-2.6.11-mm1-full/include/linux/fcdevice.h	2005-03-06 21:41:07.000000000 +0100
@@ -24,12 +24,10 @@
 #define _LINUX_FCDEVICE_H
 
 
 #include <linux/if_fc.h>
 
 #ifdef __KERNEL__
-extern unsigned short	fc_type_trans(struct sk_buff *skb, struct net_device *dev); 
-
 extern struct net_device *alloc_fcdev(int sizeof_priv);
 #endif
 
 #endif	/* _LINUX_FCDEVICE_H */
--- linux-2.6.11-mm1-full/net/802/fc.c.old	2005-03-06 21:41:12.000000000 +0100
+++ linux-2.6.11-mm1-full/net/802/fc.c	2005-03-06 21:41:35.000000000 +0100
@@ -94,12 +94,13 @@
 	return arp_find(fch->daddr, skb);
 #else
 	return 0;
 #endif
 }
 
+#if 0
 unsigned short
 fc_type_trans(struct sk_buff *skb, struct net_device *dev)
 {
 	struct fch_hdr *fch = (struct fch_hdr *)skb->data;
 	struct fcllc *fcllc;
 
@@ -127,12 +128,13 @@
 		skb_pull(skb, sizeof (struct fcllc));
 		return fcllc->ethertype;
 	}
 
 	return ntohs(ETH_P_802_2);
 }
+#endif  /*  0  */
 
 static void fc_setup(struct net_device *dev)
 {
 	dev->hard_header	= fc_header;
 	dev->rebuild_header	= fc_rebuild_header;
                 

