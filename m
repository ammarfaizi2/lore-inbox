Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266116AbSKLCQD>; Mon, 11 Nov 2002 21:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266113AbSKLCQD>; Mon, 11 Nov 2002 21:16:03 -0500
Received: from holomorphy.com ([66.224.33.161]:44472 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266116AbSKLCQB>;
	Mon, 11 Nov 2002 21:16:01 -0500
To: linux-kernel@vger.kernel.org
Subject: [5/9] NUMA-Q: reserve a larger virtual region
Message-Id: <E18BQf6-00041G-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 11 Nov 2002 18:20:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This increases the size of the virtually remapped region so it is large
enough to hold the pg_data_t's in addition to the local memory maps.

 discontig.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -urpN 03_late_alloc/arch/i386/mm/discontig.c 04_larger_remap/arch/i386/mm/discontig.c
--- 03_late_alloc/arch/i386/mm/discontig.c	2002-11-11 16:31:27.000000000 -0800
+++ 04_larger_remap/arch/i386/mm/discontig.c	2002-11-11 16:33:57.000000000 -0800
@@ -146,7 +146,7 @@ static unsigned long calculate_numa_rema
 	for (nid = 1; nid < numnodes; nid++) {
 		/* calculate the size of the mem_map needed in bytes */
 		size = (node_end_pfn[nid] - node_start_pfn[nid] + 1) 
-			* sizeof(struct page);
+			* sizeof(struct page) + sizeof(pg_data_t);
 		/* convert size to large (pmd size) pages, rounding up */
 		size = (size + LARGE_PAGE_BYTES - 1) / LARGE_PAGE_BYTES;
 		/* now the roundup is correct, convert to PAGE_SIZE pages */
