Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWDKLb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWDKLb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWDKLb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:31:26 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:61838 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750767AbWDKLbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:31:22 -0400
Date: Tue, 11 Apr 2006 20:30:25 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:002/005] wait_table and zonelist initializing for memory hotadd (change to meminit for build_zonelist)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060411202031.5643.Y-GOTO@jp.fujitsu.com>
References: <20060411202031.5643.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060411202606.5647.Y-GOTO@jp.fujitsu.com>
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

Index: pgdat10/mm/page_alloc.c
===================================================================
--- pgdat10.orig/mm/page_alloc.c	2006-04-11 14:07:26.000000000 +0900
+++ pgdat10/mm/page_alloc.c	2006-04-11 15:15:28.000000000 +0900
@@ -82,8 +82,8 @@ EXPORT_SYMBOL(zone_table);
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
 int min_free_kbytes = 1024;
 
-unsigned long __initdata nr_kernel_pages;
-unsigned long __initdata nr_all_pages;
+unsigned long __meminitdata nr_kernel_pages;
+unsigned long __meminitdata nr_all_pages;
 
 #ifdef CONFIG_DEBUG_VM
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
@@ -1576,7 +1576,7 @@ void show_free_areas(void)
  *
  * Add all populated zones of a node to the zonelist.
  */
-static int __init build_zonelists_node(pg_data_t *pgdat,
+static int __meminit build_zonelists_node(pg_data_t *pgdat,
 			struct zonelist *zonelist, int nr_zones, int zone_type)
 {
 	struct zone *zone;
@@ -1612,7 +1612,7 @@ static inline int highest_zone(int zone_
 
 #ifdef CONFIG_NUMA
 #define MAX_NODE_LOAD (num_online_nodes())
-static int __initdata node_load[MAX_NUMNODES];
+static int __meminitdata node_load[MAX_NUMNODES];
 /**
  * find_next_best_node - find the next node that should appear in a given node's fallback list
  * @node: node whose fallback list we're appending
@@ -1627,7 +1627,7 @@ static int __initdata node_load[MAX_NUMN
  * on them otherwise.
  * It returns -1 if no node is found.
  */
-static int __init find_next_best_node(int node, nodemask_t *used_node_mask)
+static int __meminit find_next_best_node(int node, nodemask_t *used_node_mask)
 {
 	int n, val;
 	int min_val = INT_MAX;
@@ -1673,7 +1673,7 @@ static int __init find_next_best_node(in
 	return best_node;
 }
 
-static void __init build_zonelists(pg_data_t *pgdat)
+static void __meminit build_zonelists(pg_data_t *pgdat)
 {
 	int i, j, k, node, local_node;
 	int prev_node, load;
@@ -1725,7 +1725,7 @@ static void __init build_zonelists(pg_da
 
 #else	/* CONFIG_NUMA */
 
-static void __init build_zonelists(pg_data_t *pgdat)
+static void __meminit build_zonelists(pg_data_t *pgdat)
 {
 	int i, j, k, node, local_node;
 
@@ -2133,7 +2133,7 @@ static __meminit void init_currently_emp
  *   - mark all memory queues empty
  *   - clear the memory bitmaps
  */
-static void __init free_area_init_core(struct pglist_data *pgdat,
+static void __meminit free_area_init_core(struct pglist_data *pgdat,
 		unsigned long *zones_size, unsigned long *zholes_size)
 {
 	unsigned long j;
@@ -2213,7 +2213,7 @@ static void __init alloc_node_mem_map(st
 #endif /* CONFIG_FLAT_NODE_MEM_MAP */
 }
 
-void __init free_area_init_node(int nid, struct pglist_data *pgdat,
+void __meminit free_area_init_node(int nid, struct pglist_data *pgdat,
 		unsigned long *zones_size, unsigned long node_start_pfn,
 		unsigned long *zholes_size)
 {
Index: pgdat10/include/linux/bootmem.h
===================================================================
--- pgdat10.orig/include/linux/bootmem.h	2006-04-10 18:30:42.000000000 +0900
+++ pgdat10/include/linux/bootmem.h	2006-04-11 14:07:27.000000000 +0900
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


