Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933024AbWFWK5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933024AbWFWK5A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933023AbWFWK4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:56:35 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10764 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933015AbWFWK4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:56:24 -0400
Date: Fri, 23 Jun 2006 12:56:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] make net/core/skbuff.c:skb_release_data() static
Message-ID: <20060623105623.GT9111@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

skb_release_data() no longer has any users in other files.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/skbuff.h |    2 --
 net/core/skbuff.c      |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

--- linux-2.6.17-mm1-full/include/linux/skbuff.h.old	2006-06-23 00:45:40.000000000 +0200
+++ linux-2.6.17-mm1-full/include/linux/skbuff.h	2006-06-23 00:46:37.000000000 +0200
@@ -1289,8 +1289,6 @@
 extern void	       skb_split(struct sk_buff *skb,
 				 struct sk_buff *skb1, const u32 len);
 
-extern void	       skb_release_data(struct sk_buff *skb);
-
 static inline void *skb_header_pointer(const struct sk_buff *skb, int offset,
 				       int len, void *buffer)
 {
--- linux-2.6.17-mm1-full/net/core/skbuff.c.old	2006-06-23 00:46:44.000000000 +0200
+++ linux-2.6.17-mm1-full/net/core/skbuff.c	2006-06-23 00:46:50.000000000 +0200
@@ -292,7 +292,7 @@
 		skb_get(list);
 }
 
-void skb_release_data(struct sk_buff *skb)
+static void skb_release_data(struct sk_buff *skb)
 {
 	if (!skb->cloned ||
 	    !atomic_sub_return(skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1,

