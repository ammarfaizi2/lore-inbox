Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162426AbWKQRCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162426AbWKQRCK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 12:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933742AbWKQRCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 12:02:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7698 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933740AbWKQRCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 12:02:07 -0500
Date: Fri, 17 Nov 2006 18:02:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [-mm patch] make net/core/skbuff.c:skb_over_panic() static
Message-ID: <20061117170205.GE31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

skb_over_panic() can now become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

Note:
This patch depends on net-uninline-skb_put.patch.

 include/linux/skbuff.h |    2 --
 net/core/skbuff.c      |    3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

--- linux-2.6.19-rc5-mm2/include/linux/skbuff.h.old	2006-11-17 15:24:22.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/linux/skbuff.h	2006-11-17 15:24:31.000000000 +0100
@@ -364,8 +364,6 @@ extern struct sk_buff *skb_copy_expand(c
 				       gfp_t priority);
 extern int	       skb_pad(struct sk_buff *skb, int pad);
 #define dev_kfree_skb(a)	kfree_skb(a)
-extern void	      skb_over_panic(struct sk_buff *skb, int len,
-				     void *here);
 extern void	      skb_under_panic(struct sk_buff *skb, int len,
 				      void *here);
 extern void	      skb_truesize_bug(struct sk_buff *skb);
--- linux-2.6.19-rc5-mm2/net/core/skbuff.c.old	2006-11-17 15:24:38.000000000 +0100
+++ linux-2.6.19-rc5-mm2/net/core/skbuff.c	2006-11-17 15:25:09.000000000 +0100
@@ -84,7 +84,7 @@ static kmem_cache_t *skbuff_fclone_cache
  *
  *	Out of line support code for skb_put(). Not user callable.
  */
-void skb_over_panic(struct sk_buff *skb, int sz, void *here)
+static void skb_over_panic(struct sk_buff *skb, int sz, void *here)
 {
 	printk(KERN_EMERG "skb_over_panic: text:%p len:%d put:%d head:%p "
 	                  "data:%p tail:%p end:%p dev:%s\n",
@@ -2094,7 +2094,6 @@ EXPORT_SYMBOL(skb_copy_and_csum_bits);
 EXPORT_SYMBOL(skb_copy_and_csum_dev);
 EXPORT_SYMBOL(skb_copy_bits);
 EXPORT_SYMBOL(skb_copy_expand);
-EXPORT_SYMBOL(skb_over_panic);
 EXPORT_SYMBOL(skb_pad);
 EXPORT_SYMBOL(skb_realloc_headroom);
 EXPORT_SYMBOL(skb_under_panic);

