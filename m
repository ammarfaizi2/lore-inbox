Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVC0OeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVC0OeM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 09:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVC0OeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 09:34:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6157 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261677AbVC0Od6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 09:33:58 -0500
Date: Sun, 27 Mar 2005 16:33:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/slab.c: make kmem_cache_alloc_node static
Message-ID: <20050327143357.GD4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kmem_cache_alloc_node isn't used outside of this file.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 Mar 2005

 include/linux/slab.h |    8 --------
 mm/slab.c            |   12 ++++++++++--
 2 files changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.11-mm1-full/include/linux/slab.h.old	2005-03-06 15:40:31.000000000 +0100
+++ linux-2.6.11-mm1-full/include/linux/slab.h	2005-03-06 15:40:43.000000000 +0100
@@ -62,14 +62,6 @@
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
-#ifdef CONFIG_NUMA
-extern void *kmem_cache_alloc_node(kmem_cache_t *, int);
-#else
-static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, int node)
-{
-	return kmem_cache_alloc(cachep, GFP_KERNEL);
-}
-#endif
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);
 
--- linux-2.6.11-mm1-full/mm/slab.c.old	2005-03-06 15:40:38.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/slab.c	2005-03-06 15:41:06.000000000 +0100
@@ -575,6 +575,15 @@
 static void enable_cpucache (kmem_cache_t *cachep);
 static void cache_reap (void *unused);
 
+#ifdef CONFIG_NUMA
+static void *kmem_cache_alloc_node(kmem_cache_t *, int);
+#else
+static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, int node)
+{
+	return kmem_cache_alloc(cachep, GFP_KERNEL);
+}
+#endif
+
 static inline void ** ac_entry(struct array_cache *ac)
 {
 	return (void**)(ac+1);
@@ -2359,7 +2368,7 @@
  * and can sleep. And it will allocate memory on the given node, which
  * can improve the performance for cpu bound structures.
  */
-void *kmem_cache_alloc_node(kmem_cache_t *cachep, int nodeid)
+static void *kmem_cache_alloc_node(kmem_cache_t *cachep, int nodeid)
 {
 	int loop;
 	void *objp;
@@ -2431,7 +2440,6 @@
 					__builtin_return_address(0));
 	return objp;
 }
-EXPORT_SYMBOL(kmem_cache_alloc_node);
 
 #endif
 

