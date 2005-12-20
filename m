Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbVLTIxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbVLTIxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 03:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbVLTIxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 03:53:53 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:10682 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750876AbVLTIxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 03:53:51 -0500
Date: Tue, 20 Dec 2005 17:52:19 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: [Patch] New zone ZONE_EASY_RECLAIM take 4. (define ZONE_EASY_RECLAIM)[2/8]
Cc: Joel Schopp <jschopp@austin.ibm.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20051220172750.1B0A.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This defines new zone ZONE_EASY_RECLAIM.
ZONES_SHIFT becomes 3.
And this patch add member of sysctl_lowmem_reserve_ratio[].


take3 -> take 4:
  fixed number of index of sysctl_lowmem_reserve_ratio[].
take 2 -> take 3:
  add sysctl_lowmem_reserve_ratio[].


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: zone_reclaim/include/linux/mmzone.h
===================================================================
--- zone_reclaim.orig/include/linux/mmzone.h	2005-12-16 11:28:17.000000000 +0900
+++ zone_reclaim/include/linux/mmzone.h	2005-12-16 11:28:18.000000000 +0900
@@ -73,9 +73,10 @@ struct per_cpu_pageset {
 #define ZONE_DMA32		1
 #define ZONE_NORMAL		2
 #define ZONE_HIGHMEM		3
+#define ZONE_EASY_RECLAIM	4
 
-#define MAX_NR_ZONES		4	/* Sync this with ZONES_SHIFT */
-#define ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
+#define MAX_NR_ZONES		5	/* Sync this with ZONES_SHIFT */
+#define ZONES_SHIFT		3	/* ceil(log2(MAX_NR_ZONES)) */
 
 
 /*
Index: zone_reclaim/mm/page_alloc.c
===================================================================
--- zone_reclaim.orig/mm/page_alloc.c	2005-12-16 11:28:17.000000000 +0900
+++ zone_reclaim/mm/page_alloc.c	2005-12-16 11:40:33.000000000 +0900
@@ -68,7 +68,7 @@ static void fastcall free_hot_cold_page(
  * TBD: should special case ZONE_DMA32 machines here - in those we normally
  * don't need any ZONE_NORMAL reservation
  */
-int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 256, 32 };
+int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 256, 32 ,32};
 
 EXPORT_SYMBOL(totalram_pages);
 
@@ -79,7 +79,7 @@ EXPORT_SYMBOL(totalram_pages);
 struct zone *zone_table[1 << ZONETABLE_SHIFT] __read_mostly;
 EXPORT_SYMBOL(zone_table);
 
-static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
+static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem", "Easy Reclaim"};
 int min_free_kbytes = 1024;
 
 unsigned long __initdata nr_kernel_pages;

-- 
Yasunori Goto 


