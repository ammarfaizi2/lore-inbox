Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWBQNac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWBQNac (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWBQNaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:30:18 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:21977 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964824AbWBQN3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:29:24 -0500
Date: Fri, 17 Feb 2006 22:28:33 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 002/012] Memory hotplug for new nodes v.2. (changing to __meminit)
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060217211158.406C.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a patch to change from __init to __meminit.
These functions and data can be used after bootup by this patch.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat3/mm/page_alloc.c
===================================================================
--- pgdat3.orig/mm/page_alloc.c	2006-02-17 15:58:06.000000000 +0900
+++ pgdat3/mm/page_alloc.c	2006-02-17 16:12:43.000000000 +0900
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
@@ -1630,7 +1630,7 @@ static int __initdata node_load[MAX_NUMN
  * on them otherwise.
  * It returns -1 if no node is found.
  */
-static int __init find_next_best_node(int node, nodemask_t *used_node_mask)
+static int __meminit find_next_best_node(int node, nodemask_t *used_node_mask)
 {
 	int i, n, val;
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
 
@@ -2134,7 +2134,7 @@ static __meminit void init_currently_emp
  *   - mark all memory queues empty
  *   - clear the memory bitmaps
  */
-static void __init free_area_init_core(struct pglist_data *pgdat,
+static void __meminit free_area_init_core(struct pglist_data *pgdat,
 		unsigned long *zones_size, unsigned long *zholes_size)
 {
 	unsigned long j;
@@ -2214,7 +2214,7 @@ static void __init alloc_node_mem_map(st
 #endif /* CONFIG_FLAT_NODE_MEM_MAP */
 }
 
-void __init free_area_init_node(int nid, struct pglist_data *pgdat,
+void __meminit free_area_init_node(int nid, struct pglist_data *pgdat,
 		unsigned long *zones_size, unsigned long node_start_pfn,
 		unsigned long *zholes_size)
 {
Index: pgdat3/include/linux/bootmem.h
===================================================================
--- pgdat3.orig/include/linux/bootmem.h	2006-02-17 15:51:08.000000000 +0900
+++ pgdat3/include/linux/bootmem.h	2006-02-17 16:12:43.000000000 +0900
@@ -86,8 +86,8 @@ static inline void *alloc_remap(int nid,
 }
 #endif
 
-extern unsigned long __initdata nr_kernel_pages;
-extern unsigned long __initdata nr_all_pages;
+extern unsigned long __meminitdata nr_kernel_pages;
+extern unsigned long __meminitdata nr_all_pages;
 
 extern void *__init alloc_large_system_hash(const char *tablename,
 					    unsigned long bucketsize,

-- 
Yasunori Goto 


