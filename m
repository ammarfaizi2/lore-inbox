Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266122AbSKLCW2>; Mon, 11 Nov 2002 21:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266113AbSKLCQG>; Mon, 11 Nov 2002 21:16:06 -0500
Received: from holomorphy.com ([66.224.33.161]:43960 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266114AbSKLCQB>;
	Mon, 11 Nov 2002 21:16:01 -0500
To: linux-kernel@vger.kernel.org
Subject: [3/9] NUMA-Q: declare functions and data earlier in discontig.c
Message-Id: <E18BQf6-00041C-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 11 Nov 2002 18:20:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves a number of declarations to the beginning of discontig.c
so that procedures early in the file can use some of the declarations.

 discontig.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)


diff -urpN 01_late_memset/arch/i386/mm/discontig.c 02_early_decls/arch/i386/mm/discontig.c
--- 01_late_memset/arch/i386/mm/discontig.c	2002-11-11 16:21:37.000000000 -0800
+++ 02_early_decls/arch/i386/mm/discontig.c	2002-11-11 16:27:50.000000000 -0800
@@ -48,6 +48,14 @@ extern unsigned long max_low_pfn;
 extern unsigned long totalram_pages;
 extern unsigned long totalhigh_pages;
 
+#define LARGE_PAGE_BYTES (PTRS_PER_PTE * PAGE_SIZE)
+
+unsigned long node_remap_start_pfn[MAX_NUMNODES];
+unsigned long node_remap_size[MAX_NUMNODES];
+unsigned long node_remap_offset[MAX_NUMNODES];
+void *node_remap_start_vaddr[MAX_NUMNODES];
+void set_pmd_pfn(unsigned long vaddr, unsigned long pfn, pgprot_t flags);
+
 /*
  * Find the highest page frame number we have available for the node
  */
@@ -114,14 +122,6 @@ static void __init register_bootmem_low_
 	}
 }
 
-#define LARGE_PAGE_BYTES (PTRS_PER_PTE * PAGE_SIZE)
-
-unsigned long node_remap_start_pfn[MAX_NUMNODES];
-unsigned long node_remap_size[MAX_NUMNODES];
-unsigned long node_remap_offset[MAX_NUMNODES];
-void *node_remap_start_vaddr[MAX_NUMNODES];
-extern void set_pmd_pfn(unsigned long vaddr, unsigned long pfn, pgprot_t flags);
-
 void __init remap_numa_kva(void)
 {
 	void *vaddr;
