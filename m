Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWEYB1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWEYB1N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 21:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWEYB1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 21:27:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:30862 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964821AbWEYB1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 21:27:03 -0400
Message-Id: <20060525003423.142224000@linux-m68k.org>
References: <20060525002742.723577000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Thu, 25 May 2006 02:27:51 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] use proper defines for zone initialization
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MAX_NR_ZONES changed, so use correct defines now.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/mm/motorola.c |   12 ++++++------
 arch/m68k/mm/sun3mmu.c  |    5 ++---
 2 files changed, 8 insertions(+), 9 deletions(-)

Index: linux-2.6-mm/arch/m68k/mm/motorola.c
===================================================================
--- linux-2.6-mm.orig/arch/m68k/mm/motorola.c
+++ linux-2.6-mm/arch/m68k/mm/motorola.c
@@ -203,7 +203,7 @@ void __init paging_init(void)
 {
 	int chunk;
 	unsigned long mem_avail = 0;
-	unsigned long zones_size[3] = { 0, };
+	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
 
 #ifdef DEBUG
 	{
@@ -257,12 +257,12 @@ void __init paging_init(void)
 #ifdef DEBUG
 	printk ("before free_area_init\n");
 #endif
-	zones_size[0] = (mach_max_dma_address < (unsigned long)high_memory ?
-			 (mach_max_dma_address+1) : (unsigned long)high_memory);
-	zones_size[1] = (unsigned long)high_memory - zones_size[0];
+	zones_size[ZONE_DMA] = (mach_max_dma_address < (unsigned long)high_memory ?
+				(mach_max_dma_address+1) : (unsigned long)high_memory);
+	zones_size[ZONE_NORMAL] = (unsigned long)high_memory - zones_size[0];
 
-	zones_size[0] = (zones_size[0] - PAGE_OFFSET) >> PAGE_SHIFT;
-	zones_size[1] >>= PAGE_SHIFT;
+	zones_size[ZONE_DMA] = (zones_size[ZONE_DMA] - PAGE_OFFSET) >> PAGE_SHIFT;
+	zones_size[ZONE_NORMAL] >>= PAGE_SHIFT;
 
 	free_area_init(zones_size);
 }
Index: linux-2.6-mm/arch/m68k/mm/sun3mmu.c
===================================================================
--- linux-2.6-mm.orig/arch/m68k/mm/sun3mmu.c
+++ linux-2.6-mm/arch/m68k/mm/sun3mmu.c
@@ -46,7 +46,7 @@ void __init paging_init(void)
 	unsigned long address;
 	unsigned long next_pgtable;
 	unsigned long bootmem_end;
-	unsigned long zones_size[3] = {0, 0, 0};
+	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
 	unsigned long size;
 
 
@@ -92,8 +92,7 @@ void __init paging_init(void)
 	current->mm = NULL;
 
 	/* memory sizing is a hack stolen from motorola.c..  hope it works for us */
-	zones_size[0] = ((unsigned long)high_memory - PAGE_OFFSET) >> PAGE_SHIFT;
-	zones_size[1] = 0;
+	zones_size[ZONE_DMA] = ((unsigned long)high_memory - PAGE_OFFSET) >> PAGE_SHIFT;
 
 	free_area_init(zones_size);
 

--

