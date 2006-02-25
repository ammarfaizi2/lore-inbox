Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932692AbWBYGLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbWBYGLz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 01:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbWBYGLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 01:11:55 -0500
Received: from fgwnews.fujitsu.co.jp ([164.71.1.134]:41146 "EHLO
	fgwnews.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932692AbWBYGLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 01:11:54 -0500
Date: Sat, 25 Feb 2006 15:11:06 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_online_pgdat (take2)  [3/5]  renaming
 for_each_pgdat
Message-Id: <20060225151106.838aa9b4.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_pgdat() with for_each_online_pgdat().

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: linux-2.6.16-rc4-mm2/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/arch/i386/mm/pgtable.c
+++ linux-2.6.16-rc4-mm2/arch/i386/mm/pgtable.c
@@ -36,7 +36,7 @@ void show_mem(void)
 	printk(KERN_INFO "Mem-info:\n");
 	show_free_areas();
 	printk(KERN_INFO "Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
-	for_each_pgdat(pgdat) {
+	for_each_online_pgdat(pgdat) {
 		pgdat_resize_lock(pgdat, &flags);
 		for (i = 0; i < pgdat->node_spanned_pages; ++i) {
 			page = pgdat_page_nr(pgdat, i);
Index: linux-2.6.16-rc4-mm2/arch/ia64/mm/discontig.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/arch/ia64/mm/discontig.c
+++ linux-2.6.16-rc4-mm2/arch/ia64/mm/discontig.c
@@ -386,7 +386,7 @@ static void __init pgdat_insert(pg_data_
 {
 	pg_data_t *prev = NULL, *next;
 
-	for_each_pgdat(next)
+	for_each_online_pgdat(next)
 		if (pgdat->node_id < next->node_id)
 			break;
 		else
@@ -560,7 +560,7 @@ void show_mem(void)
 	printk("Mem-info:\n");
 	show_free_areas();
 	printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
-	for_each_pgdat(pgdat) {
+	for_each_online_pgdat(pgdat) {
 		unsigned long present;
 		unsigned long flags;
 		int shared = 0, cached = 0, reserved = 0;
Index: linux-2.6.16-rc4-mm2/arch/m32r/mm/init.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/arch/m32r/mm/init.c
+++ linux-2.6.16-rc4-mm2/arch/m32r/mm/init.c
@@ -47,7 +47,7 @@ void show_mem(void)
 	printk("Mem-info:\n");
 	show_free_areas();
 	printk("Free swap:       %6ldkB\n",nr_swap_pages<<(PAGE_SHIFT-10));
-	for_each_pgdat(pgdat) {
+	for_each_online_pgdat(pgdat) {
 		unsigned long flags;
 		pgdat_resize_lock(pgdat, &flags);
 		for (i = 0; i < pgdat->node_spanned_pages; ++i) {
Index: linux-2.6.16-rc4-mm2/arch/powerpc/mm/mem.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/arch/powerpc/mm/mem.c
+++ linux-2.6.16-rc4-mm2/arch/powerpc/mm/mem.c
@@ -195,7 +195,7 @@ void show_mem(void)
 	printk("Mem-info:\n");
 	show_free_areas();
 	printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
-	for_each_pgdat(pgdat) {
+	for_each_online_pgdat(pgdat) {
 		unsigned long flags;
 		pgdat_resize_lock(pgdat, &flags);
 		for (i = 0; i < pgdat->node_spanned_pages; i++) {
@@ -351,7 +351,7 @@ void __init mem_init(void)
 	max_mapnr = max_pfn;
 	totalram_pages += free_all_bootmem();
 #endif
-	for_each_pgdat(pgdat) {
+	for_each_online_pgdat(pgdat) {
 		for (i = 0; i < pgdat->node_spanned_pages; i++) {
 			if (!pfn_valid(pgdat->node_start_pfn + i))
 				continue;
Index: linux-2.6.16-rc4-mm2/arch/x86_64/mm/init.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/arch/x86_64/mm/init.c
+++ linux-2.6.16-rc4-mm2/arch/x86_64/mm/init.c
@@ -72,7 +72,7 @@ void show_mem(void)
 	show_free_areas();
 	printk(KERN_INFO "Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
 
-	for_each_pgdat(pgdat) {
+	for_each_online_pgdat(pgdat) {
                for (i = 0; i < pgdat->node_spanned_pages; ++i) {
 			page = pfn_to_page(pgdat->node_start_pfn + i);
 			total++;
Index: linux-2.6.16-rc4-mm2/fs/buffer.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/fs/buffer.c
+++ linux-2.6.16-rc4-mm2/fs/buffer.c
@@ -499,7 +499,7 @@ static void free_more_memory(void)
 	wakeup_pdflush(1024);
 	yield();
 
-	for_each_pgdat(pgdat) {
+	for_each_online_pgdat(pgdat) {
 		zones = pgdat->node_zonelists[gfp_zone(GFP_NOFS)].zones;
 		if (*zones)
 			try_to_free_pages(zones, GFP_NOFS);
Index: linux-2.6.16-rc4-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/mm/page_alloc.c
+++ linux-2.6.16-rc4-mm2/mm/page_alloc.c
@@ -1271,7 +1271,7 @@ unsigned int nr_free_highpages (void)
 	pg_data_t *pgdat;
 	unsigned int pages = 0;
 
-	for_each_pgdat(pgdat)
+	for_each_online_pgdat(pgdat)
 		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
 
 	return pages;
@@ -1415,7 +1415,7 @@ void get_zone_counts(unsigned long *acti
 	*active = 0;
 	*inactive = 0;
 	*free = 0;
-	for_each_pgdat(pgdat) {
+	for_each_online_pgdat(pgdat) {
 		unsigned long l, m, n;
 		__get_zone_counts(&l, &m, &n, pgdat);
 		*active += l;
@@ -2556,7 +2556,7 @@ static void setup_per_zone_lowmem_reserv
 	struct pglist_data *pgdat;
 	int j, idx;
 
-	for_each_pgdat(pgdat) {
+	for_each_online_pgdat(pgdat) {
 		for (j = 0; j < MAX_NR_ZONES; j++) {
 			struct zone *zone = pgdat->node_zones + j;
 			unsigned long present_pages = zone->present_pages;
Index: linux-2.6.16-rc4-mm2/mm/vmscan.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/mm/vmscan.c
+++ linux-2.6.16-rc4-mm2/mm/vmscan.c
@@ -1795,7 +1795,7 @@ int shrink_all_memory(unsigned long nr_p
 	};
 
 	current->reclaim_state = &reclaim_state;
-	for_each_pgdat(pgdat) {
+	for_each_online_pgdat(pgdat) {
 		int freed;
 		freed = balance_pgdat(pgdat, nr_to_free, 0);
 		ret += freed;
@@ -1820,7 +1820,7 @@ static int __devinit cpu_callback(struct
 	cpumask_t mask;
 
 	if (action == CPU_ONLINE) {
-		for_each_pgdat(pgdat) {
+		for_each_online_pgdat(pgdat) {
 			mask = node_to_cpumask(pgdat->node_id);
 			if (any_online_cpu(mask) != NR_CPUS)
 				/* One of our CPUs online: restore mask */
@@ -1836,7 +1836,7 @@ static int __init kswapd_init(void)
 	pg_data_t *pgdat;
 
 	swap_setup();
-	for_each_pgdat(pgdat) {
+	for_each_online_pgdat(pgdat) {
 		pid_t pid;
 
 		pid = kernel_thread(kswapd, pgdat, CLONE_KERNEL);
Index: linux-2.6.16-rc4-mm2/arch/ia64/mm/init.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/arch/ia64/mm/init.c
+++ linux-2.6.16-rc4-mm2/arch/ia64/mm/init.c
@@ -600,7 +600,7 @@ mem_init (void)
 	kclist_add(&kcore_vmem, (void *)VMALLOC_START, VMALLOC_END-VMALLOC_START);
 	kclist_add(&kcore_kernel, _stext, _end - _stext);
 
-	for_each_pgdat(pgdat)
+	for_each_online_pgdat(pgdat)
 		if (pgdat->bdata->node_bootmem_map)
 			totalram_pages += free_all_bootmem_node(pgdat);
 
