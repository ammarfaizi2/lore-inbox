Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932759AbVJ3BFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbVJ3BFW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 21:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932760AbVJ3BFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 21:05:22 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24586 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932759AbVJ3BFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 21:05:20 -0400
Date: Sun, 30 Oct 2005 02:05:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/: small cleanups
Message-ID: <20051030010508.GU4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make some needlessly global functions static
- vmscan.c: #if 0 the unused global function sys_set_zone_reclaim


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 mm/page_alloc.c |   12 +++++++-----
 mm/vmalloc.c    |   12 +++++++-----
 mm/vmscan.c     |    3 +++
 3 files changed, 17 insertions(+), 10 deletions(-)

--- linux-2.6.14-rc5-mm1-full/mm/page_alloc.c.old	2005-10-30 02:35:18.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/mm/page_alloc.c	2005-10-30 02:36:49.000000000 +0200
@@ -393,7 +393,7 @@
 	return ret;
 }
 
-void __free_pages_ok(struct page *page, unsigned int order)
+static void __free_pages_ok(struct page *page, unsigned int order)
 {
 	LIST_HEAD(list);
 	int i;
@@ -1228,7 +1228,8 @@
 DEFINE_PER_CPU(long, nr_pagecache_local) = 0;
 #endif
 
-void __get_page_state(struct page_state *ret, int nr, cpumask_t *cpumask)
+static void __get_page_state(struct page_state *ret, int nr,
+			     cpumask_t *cpumask)
 {
 	int cpu = 0;
 
@@ -1786,8 +1787,8 @@
 	}
 }
 
-void zone_init_free_lists(struct pglist_data *pgdat, struct zone *zone,
-				unsigned long size)
+static void zone_init_free_lists(struct pglist_data *pgdat, struct zone *zone,
+				 unsigned long size)
 {
 	int order;
 	for (order = 0; order < MAX_ORDER ; order++) {
@@ -1847,7 +1848,8 @@
 	return batch;
 }
 
-inline void setup_pageset(struct per_cpu_pageset *p, unsigned long batch)
+static inline void setup_pageset(struct per_cpu_pageset *p,
+				 unsigned long batch)
 {
 	struct per_cpu_pages *pcp;
 
--- linux-2.6.14-rc5-mm1-full/mm/vmscan.c.old	2005-10-30 02:37:46.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/mm/vmscan.c	2005-10-30 02:38:13.000000000 +0200
@@ -1387,6 +1387,7 @@
 	return total_reclaimed;
 }
 
+#if 0
 asmlinkage long sys_set_zone_reclaim(unsigned int node, unsigned int zone,
 				     unsigned int state)
 {
@@ -1417,3 +1418,5 @@
 
 	return 0;
 }
+#endif  /*  0  */
+
--- linux-2.6.14-rc5-mm1-full/mm/vmalloc.c.old	2005-10-30 02:38:49.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/mm/vmalloc.c	2005-10-30 02:39:42.000000000 +0200
@@ -157,8 +157,10 @@
 	return err;
 }
 
-struct vm_struct *__get_vm_area_node(unsigned long size, unsigned long flags,
-				unsigned long start, unsigned long end, int node)
+static struct vm_struct *__get_vm_area_node(unsigned long size,
+					    unsigned long flags,
+					    unsigned long start,
+					    unsigned long end, int node)
 {
 	struct vm_struct **p, *tmp, *area;
 	unsigned long align = 1;
@@ -296,7 +298,7 @@
 	return v;
 }
 
-void __vunmap(void *addr, int deallocate_pages)
+static void __vunmap(void *addr, int deallocate_pages)
 {
 	struct vm_struct *area;
 
@@ -402,8 +404,8 @@
 }
 EXPORT_SYMBOL(vmap);
 
-void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
-				pgprot_t prot, int node)
+static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
+				 pgprot_t prot, int node)
 {
 	struct page **pages;
 	unsigned int nr_pages, array_size, i;

