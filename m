Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266115AbSKLCR1>; Mon, 11 Nov 2002 21:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266120AbSKLCQQ>; Mon, 11 Nov 2002 21:16:16 -0500
Received: from holomorphy.com ([66.224.33.161]:44216 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266115AbSKLCQB>;
	Mon, 11 Nov 2002 21:16:01 -0500
To: linux-kernel@vger.kernel.org
Subject: [4/9] NUMA-Q: allocate pgdats later in boot
Message-Id: <E18BQf6-00041E-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 11 Nov 2002 18:20:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order for allocate_pgdat() to manipulate the virtual memory regions,
it must be called only after the tables describing them are initialized.

 discontig.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -urpN 02_early_decls/arch/i386/mm/discontig.c 03_late_alloc/arch/i386/mm/discontig.c
--- 02_early_decls/arch/i386/mm/discontig.c	2002-11-11 16:27:50.000000000 -0800
+++ 03_late_alloc/arch/i386/mm/discontig.c	2002-11-11 16:31:27.000000000 -0800
@@ -196,9 +196,9 @@ unsigned long __init setup_memory(void)
 	printk("Low memory ends at vaddr %08lx\n",
 			(ulong) pfn_to_kaddr(max_low_pfn));
 	for (nid = 0; nid < numnodes; nid++) {
-		allocate_pgdat(nid);
 		node_remap_start_vaddr[nid] = pfn_to_kaddr(
 			highstart_pfn - node_remap_offset[nid]);
+		allocate_pgdat(nid);
 		printk ("node %d will remap to vaddr %08lx - %08lx\n", nid,
 			(ulong) node_remap_start_vaddr[nid],
 			(ulong) pfn_to_kaddr(highstart_pfn
