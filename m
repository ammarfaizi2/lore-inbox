Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWHPMG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWHPMG0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWHPMG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:06:26 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:12595 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751128AbWHPMGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:06:25 -0400
Date: Wed, 16 Aug 2006 14:06:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch] s390: kernel page table allocation.
Message-ID: <20060816120622.GD24551@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] kernel page table allocation.

Don't waste DMA capable pages for identity mapping page tables.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/init.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/arch/s390/mm/init.c linux-2.6-patched/arch/s390/mm/init.c
--- linux-2.6/arch/s390/mm/init.c	2006-08-16 13:35:54.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/init.c	2006-08-16 13:36:34.000000000 +0200
@@ -129,7 +129,7 @@ void __init paging_init(void)
                 /*
                  * pg_table is physical at this point
                  */
-		pg_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+		pg_table = (pte_t *) alloc_bootmem_pages(PAGE_SIZE);
 
                 pg_dir->pgd0 =  (_PAGE_TABLE | __pa(pg_table));
                 pg_dir->pgd1 =  (_PAGE_TABLE | (__pa(pg_table)+1024));
@@ -219,7 +219,7 @@ void __init paging_init(void)
                         continue;
                 }          
         
-	        pm_dir = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE*4);
+		pm_dir = (pmd_t *) alloc_bootmem_pages(PAGE_SIZE * 4);
                 pgd_populate(&init_mm, pg_dir, pm_dir);
 
                 for (j = 0 ; j < PTRS_PER_PMD ; j++,pm_dir++) {
@@ -228,7 +228,7 @@ void __init paging_init(void)
                                 continue; 
                         }          
                         
-                        pt_dir = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+			pt_dir = (pte_t *) alloc_bootmem_pages(PAGE_SIZE);
                         pmd_populate_kernel(&init_mm, pm_dir, pt_dir);
 	
                         for (k = 0 ; k < PTRS_PER_PTE ; k++,pt_dir++) {
