Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbVLOAb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbVLOAb7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVLOAb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:31:59 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:37077 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932649AbVLOAb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:31:58 -0500
Date: Wed, 14 Dec 2005 16:31:57 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Lameter <clameter@sgi.com>
Message-Id: <20051215003156.31788.14482.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051215003151.31788.8755.sendpatchset@schroedinger.engr.sgi.com>
References: <20051215003151.31788.8755.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC3 01/14] Add some consts for inlines in mm.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] const attributes for some inlines in mm.h

Const attributes allow the compiler to generate more efficient code by
allowing callers to keep arguments of struct page in registers.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm2/include/linux/mm.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/mm.h	2005-12-12 09:10:34.000000000 -0800
+++ linux-2.6.15-rc5-mm2/include/linux/mm.h	2005-12-14 14:39:50.000000000 -0800
@@ -456,7 +456,7 @@ void put_page(struct page *page);
 #define SECTIONS_MASK		((1UL << SECTIONS_WIDTH) - 1)
 #define ZONETABLE_MASK		((1UL << ZONETABLE_SHIFT) - 1)
 
-static inline unsigned long page_zonenum(struct page *page)
+static inline unsigned long page_zonenum(const struct page *page)
 {
 	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
 }
@@ -464,20 +464,20 @@ static inline unsigned long page_zonenum
 struct zone;
 extern struct zone *zone_table[];
 
-static inline struct zone *page_zone(struct page *page)
+static inline struct zone *page_zone(const struct page *page)
 {
 	return zone_table[(page->flags >> ZONETABLE_PGSHIFT) &
 			ZONETABLE_MASK];
 }
 
-static inline unsigned long page_to_nid(struct page *page)
+static inline unsigned long page_to_nid(const struct page *page)
 {
 	if (FLAGS_HAS_NODE)
 		return (page->flags >> NODES_PGSHIFT) & NODES_MASK;
 	else
 		return page_zone(page)->zone_pgdat->node_id;
 }
-static inline unsigned long page_to_section(struct page *page)
+static inline unsigned long page_to_section(const struct page *page)
 {
 	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
 }
@@ -511,7 +511,7 @@ static inline void set_page_links(struct
 extern struct page *mem_map;
 #endif
 
-static inline void *lowmem_page_address(struct page *page)
+static inline void *lowmem_page_address(const struct page *page)
 {
 	return __va(page_to_pfn(page) << PAGE_SHIFT);
 }
@@ -553,7 +553,7 @@ void page_address_init(void);
 #define PAGE_MAPPING_ANON	1
 
 extern struct address_space swapper_space;
-static inline struct address_space *page_mapping(struct page *page)
+static inline struct address_space *page_mapping(const struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 
@@ -564,7 +564,7 @@ static inline struct address_space *page
 	return mapping;
 }
 
-static inline int PageAnon(struct page *page)
+static inline int PageAnon(const struct page *page)
 {
 	return ((unsigned long)page->mapping & PAGE_MAPPING_ANON) != 0;
 }
@@ -573,7 +573,7 @@ static inline int PageAnon(struct page *
  * Return the pagecache index of the passed page.  Regular pagecache pages
  * use ->index whereas swapcache pages use ->private
  */
-static inline pgoff_t page_index(struct page *page)
+static inline pgoff_t page_index(const struct page *page)
 {
 	if (unlikely(PageSwapCache(page)))
 		return page_private(page);
@@ -590,7 +590,7 @@ static inline void reset_page_mapcount(s
 	atomic_set(&(page)->_mapcount, -1);
 }
 
-static inline int page_mapcount(struct page *page)
+static inline int page_mapcount(const struct page *page)
 {
 	return atomic_read(&(page)->_mapcount) + 1;
 }
@@ -598,7 +598,7 @@ static inline int page_mapcount(struct p
 /*
  * Return true if this page is mapped into pagetables.
  */
-static inline int page_mapped(struct page *page)
+static inline int page_mapped(const struct page *page)
 {
 	return atomic_read(&(page)->_mapcount) >= 0;
 }
