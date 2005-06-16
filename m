Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVFPHAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVFPHAw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 03:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVFPHAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 03:00:52 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:23682 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261767AbVFPG7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 02:59:22 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Kill stray newline
Date: Thu, 16 Jun 2005 09:59:01 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1MSsCh4I31NCACU"
Message-Id: <200506160959.01522.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_1MSsCh4I31NCACU
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andrew,

OOM killer prints a stray newline:

2005-05-17_10:24:16.76726 kern.info: oom-killer: gfp_mask=0x80d2
2005-05-17_10:24:16.81850 kern.info: DMA per-cpu:
2005-05-17_10:24:16.81862 kern.info: cpu 0 hot: low 2, high 6, batch
2005-05-17_10:24:16.81868 kern.info: cpu 0 cold: low 0, high 2, batch 1
2005-05-17_10:24:16.81875 kern.info: Normal per-cpu:
2005-05-17_10:24:16.81881 kern.info: cpu 0 hot: low 28, high 84, batch 14
2005-05-17_10:24:16.81888 kern.info: cpu 0 cold: low 0, high 28, batch 14
2005-05-17_10:24:16.81895 kern.info: HighMem per-cpu: empty
2005-05-17_10:24:16.81901 kern.info:
2005-05-17_10:24:16.81907 kern.info: Free pages:        3064kB (0kB HighMem)
2005-05-17_10:24:16.81914 kern.info: Active:56193 inactive:864 dirty:0 writeback:0 unstable:0 free:766 slab:3928 mapped:55276 pagetables:75
2005-05-17_10:24:16.81922 kern.info: DMA free:1080kB min:124kB low:152kB high:184kB active:9464kB inactive:0kB present:16384kB pages_scanne
2005-05-17_10:24:16.81932 kern.info: lowmem_reserve[]: 0 239 239
2005-05-17_10:24:16.81938 kern.info: Normal free:1984kB min:1916kB low:2392kB high:2872kB active:215308kB inactive:3456kB present:245696kB
2005-05-17_10:24:16.81948 kern.info: lowmem_reserve[]: 0 0 0
2005-05-17_10:24:16.81954 kern.info: HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 al
2005-05-17_10:24:16.81965 kern.info: lowmem_reserve[]: 0 0 0
2005-05-17_10:24:16.81974 kern.info: DMA: 0*4kB 1*8kB 1*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1080kB
2005-05-17_10:24:16.81983 kern.info: Normal: 26*4kB 1*8kB 1*16kB 2*32kB 0*64kB 4*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1984kB
2005-05-17_10:24:16.81991 kern.info: HighMem: empty
2005-05-17_10:24:16.81997 kern.info: Swap cache: add 0, delete 0, find 0/0, race 0+0
2005-05-17_10:24:16.82004 kern.info: Free swap  = 0kB
2005-05-17_10:24:16.82011 kern.info: Total swap = 0kB

Patch is below.
--
vda

--Boundary-00=_1MSsCh4I31NCACU
Content-Type: text/x-diff;
  charset="koi8-r";
  name="page_alloc.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="page_alloc.c.diff"

--- linux-2.6.12-rc2.src/mm/page_alloc.c.orig	Mon Apr 18 17:15:53 2005
+++ linux-2.6.12-rc2.src/mm/page_alloc.c	Thu Jun 16 09:53:32 2005
@@ -1219,61 +1219,61 @@ void show_free_areas(void)
 		show_node(zone);
 		printk("%s per-cpu:", zone->name);
 
 		if (!zone->present_pages) {
 			printk(" empty\n");
 			continue;
 		} else
 			printk("\n");
 
 		for (cpu = 0; cpu < NR_CPUS; ++cpu) {
 			struct per_cpu_pageset *pageset;
 
 			if (!cpu_possible(cpu))
 				continue;
 
 			pageset = zone->pageset + cpu;
 
 			for (temperature = 0; temperature < 2; temperature++)
 				printk("cpu %d %s: low %d, high %d, batch %d\n",
 					cpu,
 					temperature ? "cold" : "hot",
 					pageset->pcp[temperature].low,
 					pageset->pcp[temperature].high,
 					pageset->pcp[temperature].batch);
 		}
 	}
 
 	get_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);
 
-	printk("\nFree pages: %11ukB (%ukB HighMem)\n",
+	printk("Free pages: %11ukB (%ukB HighMem)\n",
 		K(nr_free_pages()),
 		K(nr_free_highpages()));
 
 	printk("Active:%lu inactive:%lu dirty:%lu writeback:%lu "
 		"unstable:%lu free:%u slab:%lu mapped:%lu pagetables:%lu\n",
 		active,
 		inactive,
 		ps.nr_dirty,
 		ps.nr_writeback,
 		ps.nr_unstable,
 		nr_free_pages(),
 		ps.nr_slab,
 		ps.nr_mapped,
 		ps.nr_page_table_pages);
 
 	for_each_zone(zone) {
 		int i;
 
 		show_node(zone);
 		printk("%s"
 			" free:%lukB"
 			" min:%lukB"
 			" low:%lukB"
 			" high:%lukB"
 			" active:%lukB"
 			" inactive:%lukB"
 			" present:%lukB"
 			" pages_scanned:%lu"
 			" all_unreclaimable? %s"
 			"\n",

--Boundary-00=_1MSsCh4I31NCACU--

