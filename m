Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWCQIYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWCQIYN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 03:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWCQIXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 03:23:45 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:24529 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964933AbWCQIX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 03:23:28 -0500
Date: Fri, 17 Mar 2006 17:22:45 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 013/017]Memory hotplug for new nodes v.4.(changes from __init to __meminit) 
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060317163657.C651.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a patch to change definition of some functions and data
from __init to __meminit.
These functions and data can be used after bootup by this patch to
be used for hot-add codes.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 include/linux/bootmem.h |    4 ++--
 mm/page_alloc.c         |   18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

Index: pgdat8/mm/page_alloc.c
===================================================================
--- pgdat8.orig/mm/page_alloc.c	2006-03-17 13:53:45.530940715 +0900
+++ pgdat8/mm/page_alloc.c	2006-03-17 13:53:53.011409373 +0900
@@ -82,8 +82,8 @@ EXPORT_SYMBOL(zone_table);
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
 int min_free_kbytes = 1024;
 
-unsigned long __initdata nr_kernel_pages;
-unsigned long __initdata nr_all_pages;
+unsigned long __meminitdata nr_kernel_pages;
+unsigned long __meminitdata nr_all_pages;
 
 #ifdef CONFIG_DEBUG_VM
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
@@ -1579,7 +1579,7 @@ void show_free_areas(void)
  *
  * Add all populated zones of a node to the zonelist.
  */
-static int __init build_zonelists_node(pg_data_t *pgdat,
+static int __meminit build_zonelists_node(pg_data_t *pgdat,
 			struct zonelist *zonelist, int nr_zones, int zone_type)
 {
 	struct zone *zone;
@@ -1615,7 +1615,7 @@ static inline int highest_zone(int zone_
 
 #ifdef CONFIG_NUMA
 #define MAX_NODE_LOAD (num_online_nodes())
-static int __initdata node_load[MAX_NUMNODES];
+static int __meminitdata node_load[MAX_NUMNODES];
 /**
  * find_next_best_node - find the next node that should appear in a given node's fallback list
  * @node: node whose fallback list we're appending
@@ -1630,7 +1630,7 @@ static int __initdata node_load[MAX_NUMN
  * on them otherwise.
  * It returns -1 if no node is found.
  */
-static int __init find_next_best_node(int node, nodemask_t *used_node_mask)
+static int __meminit find_next_best_node(int node, nodemask_t *used_node_mask)
 {
 	int n, val;
 	int min_val = INT_MAX;
@@ -1676,7 +1676,7 @@ static int __init find_next_best_node(in
 	return best_node;
 }
 
-static void __init build_zonelists(pg_data_t *pgdat)
+static void __meminit build_zonelists(pg_data_t *pgdat)
 {
 	int i, j, k, node, local_node;
 	int prev_node, load;
@@ -1728,7 +1728,7 @@ static void __init build_zonelists(pg_da
 
 #else	/* CONFIG_NUMA */
 
-static void __init build_zonelists(pg_data_t *pgdat)
+static void __meminit build_zonelists(pg_data_t *pgdat)
 {
 	int i, j, k, node, local_node;
 
@@ -2190,7 +2190,7 @@ __meminit int init_currently_empty_zone(
  *   - mark all memory queues empty
  *   - clear the memory bitmaps
  */
-static void __init free_area_init_core(struct pglist_data *pgdat,
+static void __meminit free_area_init_core(struct pglist_data *pgdat,
 		unsigned long *zones_size, unsigned long *zholes_size)
 {
 	unsigned long j;
@@ -2272,7 +2272,7 @@ static void __init alloc_node_mem_map(st
 #endif /* CONFIG_FLAT_NODE_MEM_MAP */
 }
 
-void __init free_area_init_node(int nid, struct pglist_data *pgdat,
+void __meminit free_area_init_node(int nid, struct pglist_data *pgdat,
 		unsigned long *zones_size, unsigned long node_start_pfn,
 		unsigned long *zholes_size)
 {
Index: pgdat8/include/linux/bootmem.h
===================================================================
--- pgdat8.orig/include/linux/bootmem.h	2006-03-17 13:53:45.530940715 +0900
+++ pgdat8/include/linux/bootmem.h	2006-03-17 13:53:53.011409373 +0900
@@ -91,8 +91,8 @@ static inline void *alloc_remap(int nid,
 }
 #endif
 
-extern unsigned long __initdata nr_kernel_pages;
-extern unsigned long __initdata nr_all_pages;
+extern unsigned long nr_kernel_pages;
+extern unsigned long nr_all_pages;
 
 extern void *__init alloc_large_system_hash(const char *tablename,
 					    unsigned long bucketsize,

-- 
Yasunori Goto 


