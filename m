Return-Path: <linux-kernel-owner+w=401wt.eu-S1030231AbWL3DYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWL3DYr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 22:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWL3DYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 22:24:47 -0500
Received: from THUNK.ORG ([69.25.196.29]:51995 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030231AbWL3DYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 22:24:46 -0500
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Print sysrq-m messages with KERN_INFO priority
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1H0Uq5-0003Fo-1W@candygram.thunk.org>
Date: Fri, 29 Dec 2006 22:24:53 -0500
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Print messages resulting from sysrq-m with a KERN_INFO instead of the
default KERN_WARNING priority

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c	2006-12-25 09:21:54.000000000 -0500
+++ linux-2.6/mm/page_alloc.c	2006-12-29 17:19:11.000000000 -0500
@@ -1505,7 +1505,7 @@
 static inline void show_node(struct zone *zone)
 {
 	if (NUMA_BUILD)
-		printk("Node %d ", zone_to_nid(zone));
+		printk(KERN_INFO, "Node %d ", zone_to_nid(zone));
 }
 
 void si_meminfo(struct sysinfo *val)
@@ -1566,8 +1566,8 @@
 
 			pageset = zone_pcp(zone, cpu);
 
-			printk("CPU %4d: Hot: hi:%5d, btch:%4d usd:%4d   "
-			       "Cold: hi:%5d, btch:%4d usd:%4d\n",
+			printk(KERN_INFO "CPU %4d: Hot: hi:%5d, btch:%4d "
+			       "usd:%4d   Cold: hi:%5d, btch:%4d usd:%4d\n",
 			       cpu, pageset->pcp[0].high,
 			       pageset->pcp[0].batch, pageset->pcp[0].count,
 			       pageset->pcp[1].high, pageset->pcp[1].batch,
@@ -1577,7 +1577,7 @@
 
 	get_zone_counts(&active, &inactive, &free);
 
-	printk("Active:%lu inactive:%lu dirty:%lu writeback:%lu "
+	printk(KERN_INFO "Active:%lu inactive:%lu dirty:%lu writeback:%lu "
 		"unstable:%lu free:%u slab:%lu mapped:%lu pagetables:%lu\n",
 		active,
 		inactive,
@@ -1619,7 +1619,7 @@
 			zone->pages_scanned,
 			(zone->all_unreclaimable ? "yes" : "no")
 			);
-		printk("lowmem_reserve[]:");
+		printk(KERN_INFO "lowmem_reserve[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
 			printk(" %lu", zone->lowmem_reserve[i]);
 		printk("\n");
@@ -1875,7 +1875,7 @@
 		/* cpuset refresh routine should be here */
 	}
 	vm_total_pages = nr_free_pagecache_pages();
-	printk("Built %i zonelists.  Total pages: %ld\n",
+	printk(KERN_INFO "Built %i zonelists.  Total pages: %ld\n",
 			num_online_nodes(), vm_total_pages);
 }
 
Index: linux-2.6/mm/swap_state.c
===================================================================
--- linux-2.6.orig/mm/swap_state.c	2006-07-04 18:38:19.000000000 -0400
+++ linux-2.6/mm/swap_state.c	2006-12-29 17:18:42.000000000 -0500
@@ -57,12 +57,14 @@
 
 void show_swap_cache_info(void)
 {
-	printk("Swap cache: add %lu, delete %lu, find %lu/%lu, race %lu+%lu\n",
+	printk(KERN_INFO "Swap cache: add %lu, delete %lu, find %lu/%lu, race %lu+%lu\n",
 		swap_cache_info.add_total, swap_cache_info.del_total,
 		swap_cache_info.find_success, swap_cache_info.find_total,
 		swap_cache_info.noent_race, swap_cache_info.exist_race);
-	printk("Free swap  = %lukB\n", nr_swap_pages << (PAGE_SHIFT - 10));
-	printk("Total swap = %lukB\n", total_swap_pages << (PAGE_SHIFT - 10));
+	printk(KERN_INFO "Free swap  = %lukB\n",
+	       nr_swap_pages << (PAGE_SHIFT - 10));
+	printk(KERN_INFO "Total swap = %lukB\n",
+	       total_swap_pages << (PAGE_SHIFT - 10));
 }
 
 /*
