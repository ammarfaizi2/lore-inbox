Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUGTSoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUGTSoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266142AbUGTSnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:43:32 -0400
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com ([213.46.243.17]:37419
	"EHLO amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S266169AbUGTSj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:39:57 -0400
Date: Tue, 20 Jul 2004 20:39:56 +0200
Message-Id: <200407201839.i6KIduOg015570@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] <linux/mm{,zone}.h> const
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make input parameters const where possible.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/include/linux/mm.h	2004-07-15 23:15:19.000000000 +0200
+++ linux-m68k-2.6.8-rc2/include/linux/mm.h	2004-07-18 16:07:51.000000000 +0200
@@ -373,11 +373,11 @@
 #define NODEZONE_SHIFT (sizeof(page_flags_t)*8 - MAX_NODES_SHIFT - MAX_ZONES_SHIFT)
 #define NODEZONE(node, zone)	((node << ZONES_SHIFT) | zone)
 
-static inline unsigned long page_zonenum(struct page *page)
+static inline unsigned long page_zonenum(const struct page *page)
 {
 	return (page->flags >> NODEZONE_SHIFT) & (~(~0UL << ZONES_SHIFT));
 }
-static inline unsigned long page_to_nid(struct page *page)
+static inline unsigned long page_to_nid(const struct page *page)
 {
 	return (page->flags >> (NODEZONE_SHIFT + ZONES_SHIFT));
 }
@@ -385,7 +385,7 @@
 struct zone;
 extern struct zone *zone_table[];
 
-static inline struct zone *page_zone(struct page *page)
+static inline struct zone *page_zone(const struct page *page)
 {
 	return zone_table[page->flags >> NODEZONE_SHIFT];
 }
@@ -401,7 +401,7 @@
 extern struct page *mem_map;
 #endif
 
-static inline void *lowmem_page_address(struct page *page)
+static inline void *lowmem_page_address(const struct page *page)
 {
 	return __va(page_to_pfn(page) << PAGE_SHIFT);
 }
@@ -455,7 +455,7 @@
  * Return the pagecache index of the passed page.  Regular pagecache pages
  * use ->index whereas swapcache pages use ->private
  */
-static inline pgoff_t page_index(struct page *page)
+static inline pgoff_t page_index(const struct page *page)
 {
 	if (unlikely(PageSwapCache(page)))
 		return page->private;
@@ -465,7 +465,7 @@
 /*
  * Return true if this page is mapped into pagetables.
  */
-static inline int page_mapped(struct page *page)
+static inline int page_mapped(const struct page *page)
 {
 	return page->mapcount != 0;
 }
--- linux-2.6.8-rc2/include/linux/mmzone.h	2004-07-15 23:15:19.000000000 +0200
+++ linux-m68k-2.6.8-rc2/include/linux/mmzone.h	2004-07-20 15:10:18.000000000 +0200
@@ -360,20 +360,29 @@
  *              to ZONE_{DMA/NORMAL/HIGHMEM/etc} in general code to a minimum.
  * @zone - pointer to struct zone variable
  */
-static inline int is_highmem(struct zone *zone)
+static inline int is_highmem(const struct zone *zone)
 {
 	return (zone - zone->zone_pgdat->node_zones == ZONE_HIGHMEM);
 }
 
-static inline int is_normal(struct zone *zone)
+static inline int is_normal(const struct zone *zone)
 {
 	return (zone - zone->zone_pgdat->node_zones == ZONE_NORMAL);
 }
 
 /* These two functions are used to setup the per zone pages min values */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
