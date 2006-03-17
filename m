Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWCQUTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWCQUTu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWCQUTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:19:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12553 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751263AbWCQUTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:19:50 -0500
Date: Fri, 17 Mar 2006 21:19:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: bharata@in.ibm.com
Cc: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [-mm patch] make the dummy kmem_set_shrinker() a static inline
Message-ID: <20060317201948.GX3914@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the CONFIG_SLAB=n case we want to save space - so let's save a few 
more bytes.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/slab.h |    7 +++++++
 mm/slob.c            |    5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

--- linux-2.6.16-rc6-mm1-full/include/linux/slab.h.old	2006-03-17 13:39:18.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/include/linux/slab.h	2006-03-17 15:48:53.000000000 +0100
@@ -144,6 +144,9 @@
 extern int FASTCALL(kmem_cache_reap(int));
 extern int FASTCALL(kmem_ptr_validate(kmem_cache_t *cachep, void *ptr));
 
+struct shrinker;
+extern void kmem_set_shrinker(kmem_cache_t *cachep, struct shrinker *shrinker);
+
 #else /* CONFIG_SLOB */
 
 /* SLOB allocator routines */
@@ -176,6 +179,10 @@
 #define kmalloc_node(s, f, n) kmalloc(s, f)
 #define ____kmalloc kmalloc
 
+struct shrinker;
+static inline void kmem_set_shrinker(kmem_cache_t *cachep,
+				     struct shrinker *shrinker) {}
+
 #endif /* CONFIG_SLOB */
 
 /* System wide caches */
--- linux-2.6.16-rc6-mm1-full/mm/slob.c.old	2006-03-17 13:40:54.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/mm/slob.c	2006-03-17 13:41:01.000000000 +0100
@@ -240,11 +240,6 @@
 	return ((slob_t *)block - 1)->units * SLOB_UNIT;
 }
 
-void kmem_set_shrinker(kmem_cache_t *cachep, struct shrinker *shrinker)
-{
-}
-EXPORT_SYMBOL(kmem_set_shrinker);
-
 struct kmem_cache {
 	unsigned int size, align;
 	const char *name;

