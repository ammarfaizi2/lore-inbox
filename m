Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbUDPUSA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263768AbUDPUR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:17:59 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:54071 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263686AbUDPUO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:14:56 -0400
Date: Fri, 16 Apr 2004 21:14:41 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <rth@twiddle.net>, <rmk@arm.linux.org.uk>,
       <spyro@f2s.com>, <bjornw@axis.com>, <ysato@users.sourceforge.jp>,
       <davidm@hpl.hp.com>, <jes@trained-monkey.org>, <gerg@snapgear.com>,
       <ralf@linux-mips.org>, <James.Bottomley@SteelEye.com>,
       <paulus@samba.org>, <anton@samba.org>, <schwidefsky@de.ibm.com>,
       <gniibe@m17n.org>, <wesolows@foobazco.org>, <davem@redhat.com>,
       <jdike@addtoit.com>, <miles@lsi.nec.co.jp>, <ak@suse.de>
Subject: [PATCH] rmap 13 include/asm deletions
In-Reply-To: <Pine.LNX.4.44.0404162105100.13995-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0404162107510.13995-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second of two patches against yesterday's rmap 11 or 2.6.5-mm6:
rmap 13 include/asm deletions

Delete include/asm*/rmap.h
Delete pte_addr_t typedef from include/asm*/pgtable.h
Delete KM_PTE2 from subset of include/asm*/kmap_types.h
Beware when 4G/4G returns to -mm: i386 may need KM_FILLER for 8K stack.

 include/asm-alpha/pgtable.h     |    2 -
 include/asm-alpha/rmap.h        |    7 ---
 include/asm-arm/kmap_types.h    |    1 
 include/asm-arm/pgtable.h       |    2 -
 include/asm-arm/rmap.h          |    6 ---
 include/asm-arm26/pgtable.h     |    2 -
 include/asm-arm26/rmap.h        |   66 -----------------------------------
 include/asm-cris/pgtable.h      |    2 -
 include/asm-cris/rmap.h         |    7 ---
 include/asm-generic/rmap.h      |   90 ------------------------------------------------
 include/asm-h8300/pgtable.h     |    2 -
 include/asm-i386/kmap_types.h   |   11 ++---
 include/asm-i386/pgtable.h      |   12 ------
 include/asm-i386/rmap.h         |   21 -----------
 include/asm-ia64/pgtable.h      |    2 -
 include/asm-ia64/rmap.h         |    7 ---
 include/asm-m68k/pgtable.h      |    2 -
 include/asm-m68k/rmap.h         |    7 ---
 include/asm-m68knommu/pgtable.h |    2 -
 include/asm-m68knommu/rmap.h    |    2 -
 include/asm-mips/kmap_types.h   |   11 ++---
 include/asm-mips/pgtable-32.h   |    6 ---
 include/asm-mips/pgtable-64.h   |    2 -
 include/asm-mips/rmap.h         |    7 ---
 include/asm-parisc/pgtable.h    |    2 -
 include/asm-parisc/rmap.h       |    7 ---
 include/asm-ppc/pgtable.h       |    2 -
 include/asm-ppc/rmap.h          |    9 ----
 include/asm-ppc64/pgtable.h     |    2 -
 include/asm-ppc64/rmap.h        |    9 ----
 include/asm-s390/pgtable.h      |    2 -
 include/asm-s390/rmap.h         |    7 ---
 include/asm-sh/pgtable.h        |    2 -
 include/asm-sh/rmap.h           |    7 ---
 include/asm-sparc/kmap_types.h  |    1 
 include/asm-sparc/pgtable.h     |    2 -
 include/asm-sparc/rmap.h        |    7 ---
 include/asm-sparc64/pgtable.h   |    2 -
 include/asm-sparc64/rmap.h      |    7 ---
 include/asm-um/pgtable.h        |   12 ------
 include/asm-um/rmap.h           |    6 ---
 include/asm-v850/pgtable.h      |    2 -
 include/asm-v850/rmap.h         |    1 
 include/asm-x86_64/pgtable.h    |    2 -
 include/asm-x86_64/rmap.h       |    7 ---
 45 files changed, 10 insertions(+), 367 deletions(-)

--- rmap12/include/asm-alpha/pgtable.h	2003-10-08 20:24:56.000000000 +0100
+++ rmap13/include/asm-alpha/pgtable.h	2004-04-16 19:23:35.976514696 +0100
@@ -349,6 +349,4 @@ extern void paging_init(void);
 /* We have our own get_unmapped_area to cope with ADDR_LIMIT_32BIT.  */
 #define HAVE_ARCH_UNMAPPED_AREA
 
-typedef pte_t *pte_addr_t;
-
 #endif /* _ALPHA_PGTABLE_H */
--- rmap12/include/asm-alpha/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ rmap13/include/asm-alpha/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _ALPHA_RMAP_H
-#define _ALPHA_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- rmap12/include/asm-arm/kmap_types.h	2004-01-09 06:00:24.000000000 +0000
+++ rmap13/include/asm-arm/kmap_types.h	2004-04-16 19:23:35.986513176 +0100
@@ -14,7 +14,6 @@ enum km_type {
 	KM_BIO_DST_IRQ,
 	KM_PTE0,
 	KM_PTE1,
-	KM_PTE2,
 	KM_IRQ0,
 	KM_IRQ1,
 	KM_SOFTIRQ0,
--- rmap12/include/asm-arm/pgtable.h	2004-01-09 06:00:23.000000000 +0000
+++ rmap13/include/asm-arm/pgtable.h	2004-04-16 19:23:35.988512872 +0100
@@ -353,8 +353,6 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD
 #define io_remap_page_range(vma,from,phys,size,prot) \
 		remap_page_range(vma,from,phys,size,prot)
 
-typedef pte_t *pte_addr_t;
-
 #define pgtable_cache_init() do { } while (0)
 
 #endif /* !__ASSEMBLY__ */
--- rmap12/include/asm-arm/rmap.h	2002-08-01 22:17:36.000000000 +0100
+++ rmap13/include/asm-arm/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,6 +0,0 @@
-#ifndef _ARM_RMAP_H
-#define _ARM_RMAP_H
-
-#include <asm-generic/rmap.h>
-
-#endif /* _ARM_RMAP_H */
--- rmap12/include/asm-arm26/pgtable.h	2003-10-08 20:24:55.000000000 +0100
+++ rmap13/include/asm-arm26/pgtable.h	2004-04-16 19:23:35.989512720 +0100
@@ -290,8 +290,6 @@ static inline pte_t mk_pte_phys(unsigned
 #define io_remap_page_range(vma,from,phys,size,prot) \
 		remap_page_range(vma,from,phys,size,prot)
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASMARM_PGTABLE_H */
--- rmap12/include/asm-arm26/rmap.h	2003-06-14 20:18:58.000000000 +0100
+++ rmap13/include/asm-arm26/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,66 +0,0 @@
-#ifndef _ARM_RMAP_H
-#define _ARM_RMAP_H
-
-/*
- * linux/include/asm-arm26/proc-armv/rmap.h
- *
- * Architecture dependant parts of the reverse mapping code,
- *
- * ARM is different since hardware page tables are smaller than
- * the page size and Linux uses a "duplicate" one with extra info.
- * For rmap this means that the first 2 kB of a page are the hardware
- * page tables and the last 2 kB are the software page tables.
- */
-
-static inline void pgtable_add_rmap(struct page *page, struct mm_struct * mm, unsigned long address)
-{
-        page->mapping = (void *)mm;
-        page->index = address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
-        inc_page_state(nr_page_table_pages);
-}
-
-static inline void pgtable_remove_rmap(struct page *page)
-{
-        page->mapping = NULL;
-        page->index = 0;
-        dec_page_state(nr_page_table_pages);
-}
-
-static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
-{
-	struct page * page = virt_to_page(ptep);
-        return (struct mm_struct *)page->mapping;
-}
-
-/* The page table takes half of the page */
-#define PTE_MASK  ((PAGE_SIZE / 2) - 1)
-
-static inline unsigned long ptep_to_address(pte_t * ptep)
-{
-        struct page * page = virt_to_page(ptep);
-        unsigned long low_bits;
-
-        low_bits = ((unsigned long)ptep & PTE_MASK) * PTRS_PER_PTE;
-        return page->index + low_bits;
-}
- 
-//FIXME!!! IS these correct?
-static inline pte_addr_t ptep_to_paddr(pte_t *ptep)
-{
-        return (pte_addr_t)ptep;
-}
-
-static inline pte_t *rmap_ptep_map(pte_addr_t pte_paddr)
-{
-        return (pte_t *)pte_paddr;
-}
-
-static inline void rmap_ptep_unmap(pte_t *pte)
-{
-        return;
-}
-
-
-//#include <asm-generic/rmap.h>
-
-#endif /* _ARM_RMAP_H */
--- rmap12/include/asm-cris/pgtable.h	2003-07-10 21:16:26.000000000 +0100
+++ rmap13/include/asm-cris/pgtable.h	2004-04-16 19:23:35.991512416 +0100
@@ -337,6 +337,4 @@ extern inline void update_mmu_cache(stru
 #define pte_to_pgoff(x)	(pte_val(x) >> 6)
 #define pgoff_to_pte(x)	__pte(((x) << 6) | _PAGE_FILE)
 
-typedef pte_t *pte_addr_t;
-
 #endif /* _CRIS_PGTABLE_H */
--- rmap12/include/asm-cris/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ rmap13/include/asm-cris/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _CRIS_RMAP_H
-#define _CRIS_RMAP_H
-
-/* nothing to see, move along :) */
-#include <asm-generic/rmap.h>
-
-#endif
--- rmap12/include/asm-generic/rmap.h	2003-05-27 02:01:29.000000000 +0100
+++ rmap13/include/asm-generic/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,90 +0,0 @@
-#ifndef _GENERIC_RMAP_H
-#define _GENERIC_RMAP_H
-/*
- * linux/include/asm-generic/rmap.h
- *
- * Architecture dependent parts of the reverse mapping code,
- * this version should work for most architectures with a
- * 'normal' page table layout.
- *
- * We use the struct page of the page table page to find out
- * the process and full address of a page table entry:
- * - page->mapping points to the process' mm_struct
- * - page->index has the high bits of the address
- * - the lower bits of the address are calculated from the
- *   offset of the page table entry within the page table page
- *
- * For CONFIG_HIGHPTE, we need to represent the address of a pte in a
- * scalar pte_addr_t.  The pfn of the pte's page is shifted left by PAGE_SIZE
- * bits and is then ORed with the byte offset of the pte within its page.
- *
- * For CONFIG_HIGHMEM4G, the pte_addr_t is 32 bits.  20 for the pfn, 12 for
- * the offset.
- *
- * For CONFIG_HIGHMEM64G, the pte_addr_t is 64 bits.  52 for the pfn, 12 for
- * the offset.
- */
-#include <linux/mm.h>
-
-static inline void pgtable_add_rmap(struct page * page, struct mm_struct * mm, unsigned long address)
-{
-#ifdef BROKEN_PPC_PTE_ALLOC_ONE
-	/* OK, so PPC calls pte_alloc() before mem_map[] is setup ... ;( */
-	extern int mem_init_done;
-
-	if (!mem_init_done)
-		return;
-#endif
-	page->mapping = (void *)mm;
-	page->index = address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
-	inc_page_state(nr_page_table_pages);
-}
-
-static inline void pgtable_remove_rmap(struct page * page)
-{
-	page->mapping = NULL;
-	page->index = 0;
-	dec_page_state(nr_page_table_pages);
-}
-
-static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
-{
-	struct page * page = kmap_atomic_to_page(ptep);
-	return (struct mm_struct *) page->mapping;
-}
-
-static inline unsigned long ptep_to_address(pte_t * ptep)
-{
-	struct page * page = kmap_atomic_to_page(ptep);
-	unsigned long low_bits;
-	low_bits = ((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE;
-	return page->index + low_bits;
-}
-
-#ifdef CONFIG_HIGHPTE
-static inline pte_addr_t ptep_to_paddr(pte_t *ptep)
-{
-	pte_addr_t paddr;
-	paddr = ((pte_addr_t)page_to_pfn(kmap_atomic_to_page(ptep))) << PAGE_SHIFT;
-	return paddr + (pte_addr_t)((unsigned long)ptep & ~PAGE_MASK);
-}
-#else
-static inline pte_addr_t ptep_to_paddr(pte_t *ptep)
-{
-	return (pte_addr_t)ptep;
-}
-#endif
-
-#ifndef CONFIG_HIGHPTE
-static inline pte_t *rmap_ptep_map(pte_addr_t pte_paddr)
-{
-	return (pte_t *)pte_paddr;
-}
-
-static inline void rmap_ptep_unmap(pte_t *pte)
-{
-	return;
-}
-#endif
-
-#endif /* _GENERIC_RMAP_H */
--- rmap12/include/asm-h8300/pgtable.h	2003-08-09 05:44:10.000000000 +0100
+++ rmap13/include/asm-h8300/pgtable.h	2004-04-16 19:23:35.996511656 +0100
@@ -7,8 +7,6 @@
 #include <asm/page.h>
 #include <asm/io.h>
 
-typedef pte_t *pte_addr_t;
-
 #define pgd_present(pgd)     (1)       /* pages are always present on NO_MM */
 #define pgd_none(pgd)		(0)
 #define pgd_bad(pgd)		(0)
--- rmap12/include/asm-i386/kmap_types.h	2003-05-27 02:01:30.000000000 +0100
+++ rmap13/include/asm-i386/kmap_types.h	2004-04-16 19:23:35.997511504 +0100
@@ -19,12 +19,11 @@ D(5)	KM_BIO_SRC_IRQ,
 D(6)	KM_BIO_DST_IRQ,
 D(7)	KM_PTE0,
 D(8)	KM_PTE1,
-D(9)	KM_PTE2,
-D(10)	KM_IRQ0,
-D(11)	KM_IRQ1,
-D(12)	KM_SOFTIRQ0,
-D(13)	KM_SOFTIRQ1,
-D(14)	KM_TYPE_NR
+D(9)	KM_IRQ0,
+D(10)	KM_IRQ1,
+D(11)	KM_SOFTIRQ0,
+D(12)	KM_SOFTIRQ1,
+D(13)	KM_TYPE_NR
 };
 
 #undef D
--- rmap12/include/asm-i386/pgtable.h	2004-04-15 09:01:58.359937456 +0100
+++ rmap13/include/asm-i386/pgtable.h	2004-04-16 19:23:35.998511352 +0100
@@ -314,18 +314,6 @@ static inline pte_t pte_modify(pte_t pte
 #define pte_unmap_nested(pte) do { } while (0)
 #endif
 
-#if defined(CONFIG_HIGHPTE) && defined(CONFIG_HIGHMEM4G)
-typedef u32 pte_addr_t;
-#endif
-
-#if defined(CONFIG_HIGHPTE) && defined(CONFIG_HIGHMEM64G)
-typedef u64 pte_addr_t;
-#endif
-
-#if !defined(CONFIG_HIGHPTE)
-typedef pte_t *pte_addr_t;
-#endif
-
 /*
  * The i386 doesn't have any external MMU info: the kernel page
  * tables contain all the necessary information.
--- rmap12/include/asm-i386/rmap.h	2002-09-16 03:19:56.000000000 +0100
+++ rmap13/include/asm-i386/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,21 +0,0 @@
-#ifndef _I386_RMAP_H
-#define _I386_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#ifdef CONFIG_HIGHPTE
-static inline pte_t *rmap_ptep_map(pte_addr_t pte_paddr)
-{
-	unsigned long pfn = (unsigned long)(pte_paddr >> PAGE_SHIFT);
-	unsigned long off = ((unsigned long)pte_paddr) & ~PAGE_MASK;
-	return (pte_t *)((char *)kmap_atomic(pfn_to_page(pfn), KM_PTE2) + off);
-}
-
-static inline void rmap_ptep_unmap(pte_t *pte)
-{
-	kunmap_atomic(pte, KM_PTE2);
-}
-#endif
-
-#endif
--- rmap12/include/asm-ia64/pgtable.h	2004-04-15 09:01:58.432926360 +0100
+++ rmap13/include/asm-ia64/pgtable.h	2004-04-16 19:23:36.000511048 +0100
@@ -469,8 +469,6 @@ extern void hugetlb_free_pgtables(struct
 	struct vm_area_struct * prev, unsigned long start, unsigned long end);
 #endif
 
-typedef pte_t *pte_addr_t;
-
 /*
  * IA-64 doesn't have any external MMU info: the page tables contain all the necessary
  * information.  However, we use this routine to take care of any (delayed) i-cache
--- rmap12/include/asm-ia64/rmap.h	2002-08-27 20:28:05.000000000 +0100
+++ rmap13/include/asm-ia64/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _ASM_IA64_RMAP_H
-#define _ASM_IA64_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif /* _ASM_IA64_RMAP_H */
--- rmap12/include/asm-m68k/pgtable.h	2004-02-04 02:45:41.000000000 +0000
+++ rmap13/include/asm-m68k/pgtable.h	2004-04-16 19:23:36.002510744 +0100
@@ -168,8 +168,6 @@ static inline void update_mmu_cache(stru
 	    ? (__pgprot((pgprot_val(prot) & _CACHEMASK040) | _PAGE_NOCACHE_S))	\
 	    : (prot)))
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 /*
--- rmap12/include/asm-m68k/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ rmap13/include/asm-m68k/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _M68K_RMAP_H
-#define _M68K_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- rmap12/include/asm-m68knommu/pgtable.h	2003-05-27 02:01:29.000000000 +0100
+++ rmap13/include/asm-m68knommu/pgtable.h	2004-04-16 19:23:36.003510592 +0100
@@ -11,8 +11,6 @@
 #include <asm/page.h>
 #include <asm/io.h>
 
-typedef pte_t *pte_addr_t;
-
 /*
  * Trivial page table functions.
  */
--- rmap12/include/asm-m68knommu/rmap.h	2002-11-04 21:31:04.000000000 +0000
+++ rmap13/include/asm-m68knommu/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,2 +0,0 @@
-/* Do not need anything here */
-
--- rmap12/include/asm-mips/kmap_types.h	2003-07-02 22:00:48.000000000 +0100
+++ rmap13/include/asm-mips/kmap_types.h	2004-04-16 19:23:36.211478976 +0100
@@ -19,12 +19,11 @@ D(5)	KM_BIO_SRC_IRQ,
 D(6)	KM_BIO_DST_IRQ,
 D(7)	KM_PTE0,
 D(8)	KM_PTE1,
-D(9)	KM_PTE2,
-D(10)	KM_IRQ0,
-D(11)	KM_IRQ1,
-D(12)	KM_SOFTIRQ0,
-D(13)	KM_SOFTIRQ1,
-D(14)	KM_TYPE_NR
+D(9)	KM_IRQ0,
+D(10)	KM_IRQ1,
+D(11)	KM_SOFTIRQ0,
+D(12)	KM_SOFTIRQ1,
+D(13)	KM_TYPE_NR
 };
 
 #undef D
--- rmap12/include/asm-mips/pgtable-32.h	2004-03-11 01:56:09.000000000 +0000
+++ rmap13/include/asm-mips/pgtable-32.h	2004-04-16 19:23:36.212478824 +0100
@@ -216,10 +216,4 @@ static inline pmd_t *pmd_offset(pgd_t *d
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-#ifdef CONFIG_64BIT_PHYS_ADDR
-typedef u64 pte_addr_t;
-#else
-typedef pte_t *pte_addr_t;
-#endif
-
 #endif /* _ASM_PGTABLE_32_H */
--- rmap12/include/asm-mips/pgtable-64.h	2004-03-11 01:56:07.000000000 +0000
+++ rmap13/include/asm-mips/pgtable-64.h	2004-04-16 19:23:36.213478672 +0100
@@ -214,6 +214,4 @@ static inline pte_t mk_swap_pte(unsigned
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-typedef pte_t *pte_addr_t;
-
 #endif /* _ASM_PGTABLE_64_H */
--- rmap12/include/asm-mips/rmap.h	2003-07-02 22:00:11.000000000 +0100
+++ rmap13/include/asm-mips/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef __ASM_RMAP_H
-#define __ASM_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif /* __ASM_RMAP_H */
--- rmap12/include/asm-parisc/pgtable.h	2004-02-04 02:45:42.000000000 +0000
+++ rmap13/include/asm-parisc/pgtable.h	2004-04-16 19:23:36.215478368 +0100
@@ -450,8 +450,6 @@ static inline void ptep_mkdirty(pte_t *p
 
 #define pte_same(A,B)	(pte_val(A) == pte_val(B))
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 #define io_remap_page_range remap_page_range
--- rmap12/include/asm-parisc/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ rmap13/include/asm-parisc/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _PARISC_RMAP_H
-#define _PARISC_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- rmap12/include/asm-ppc/pgtable.h	2004-02-18 03:00:06.000000000 +0000
+++ rmap13/include/asm-ppc/pgtable.h	2004-04-16 19:23:36.217478064 +0100
@@ -670,8 +670,6 @@ extern void kernel_set_cachemode (unsign
  */
 #define pgtable_cache_init()	do { } while (0)
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
--- rmap12/include/asm-ppc/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ rmap13/include/asm-ppc/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,9 +0,0 @@
-#ifndef _PPC_RMAP_H
-#define _PPC_RMAP_H
-
-/* PPC calls pte_alloc() before mem_map[] is setup ... */
-#define BROKEN_PPC_PTE_ALLOC_ONE
-
-#include <asm-generic/rmap.h>
-
-#endif
--- rmap12/include/asm-ppc64/pgtable.h	2004-04-15 09:01:58.678888968 +0100
+++ rmap13/include/asm-ppc64/pgtable.h	2004-04-16 19:23:36.219477760 +0100
@@ -471,8 +471,6 @@ extern struct vm_struct * im_get_area(un
 			int region_type);
 unsigned long im_free(void *addr);
 
-typedef pte_t *pte_addr_t;
-
 long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 			      unsigned long va, unsigned long prpn,
 			      int secondary, unsigned long hpteflags,
--- rmap12/include/asm-ppc64/rmap.h	2002-07-24 22:03:39.000000000 +0100
+++ rmap13/include/asm-ppc64/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,9 +0,0 @@
-#ifndef _PPC64_RMAP_H
-#define _PPC64_RMAP_H
-
-/* PPC64 calls pte_alloc() before mem_map[] is setup ... */
-#define BROKEN_PPC_PTE_ALLOC_ONE
-
-#include <asm-generic/rmap.h>
-
-#endif
--- rmap12/include/asm-s390/pgtable.h	2004-04-04 03:38:55.000000000 +0100
+++ rmap13/include/asm-s390/pgtable.h	2004-04-16 19:23:36.239474720 +0100
@@ -760,8 +760,6 @@ extern inline pte_t mk_swap_pte(unsigned
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-typedef pte_t *pte_addr_t;
-
 #ifndef __s390x__
 # define PTE_FILE_MAX_BITS	26
 #else /* __s390x__ */
--- rmap12/include/asm-s390/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ rmap13/include/asm-s390/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _S390_RMAP_H
-#define _S390_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- rmap12/include/asm-sh/pgtable.h	2004-04-04 03:38:57.000000000 +0100
+++ rmap13/include/asm-sh/pgtable.h	2004-04-16 19:23:36.241474416 +0100
@@ -274,8 +274,6 @@ extern void update_mmu_cache(struct vm_a
 
 #define pte_same(A,B)	(pte_val(A) == pte_val(B))
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 #define kern_addr_valid(addr)	(1)
--- rmap12/include/asm-sh/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ rmap13/include/asm-sh/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _SH_RMAP_H
-#define _SH_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- rmap12/include/asm-sparc/kmap_types.h	2004-01-09 06:00:23.000000000 +0000
+++ rmap13/include/asm-sparc/kmap_types.h	2004-04-16 19:23:36.259471680 +0100
@@ -11,7 +11,6 @@ enum km_type {
 	KM_BIO_DST_IRQ,
 	KM_PTE0,
 	KM_PTE1,
-	KM_PTE2,
 	KM_IRQ0,
 	KM_IRQ1,
 	KM_SOFTIRQ0,
--- rmap12/include/asm-sparc/pgtable.h	2004-04-04 03:38:44.000000000 +0100
+++ rmap13/include/asm-sparc/pgtable.h	2004-04-16 19:23:36.260471528 +0100
@@ -491,8 +491,6 @@ extern int io_remap_page_range(struct vm
 
 #include <asm-generic/pgtable.h>
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !(__ASSEMBLY__) */
 
 /* We provide our own get_unmapped_area to cope with VA holes for userland */
--- rmap12/include/asm-sparc/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ rmap13/include/asm-sparc/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _SPARC_RMAP_H
-#define _SPARC_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- rmap12/include/asm-sparc64/pgtable.h	2004-01-09 06:00:23.000000000 +0000
+++ rmap13/include/asm-sparc64/pgtable.h	2004-04-16 19:23:36.262471224 +0100
@@ -384,8 +384,6 @@ extern unsigned long get_fb_unmapped_are
 
 extern void check_pgt_cache(void);
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(_SPARC64_PGTABLE_H) */
--- rmap12/include/asm-sparc64/rmap.h	2002-07-20 20:12:35.000000000 +0100
+++ rmap13/include/asm-sparc64/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _SPARC64_RMAP_H
-#define _SPARC64_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif
--- rmap12/include/asm-um/pgtable.h	2003-10-08 20:24:57.000000000 +0100
+++ rmap13/include/asm-um/pgtable.h	2004-04-16 19:23:36.263471072 +0100
@@ -384,18 +384,6 @@ static inline pmd_t * pmd_offset(pgd_t *
 #define pte_unmap(pte) kunmap_atomic((pte), KM_PTE0)
 #define pte_unmap_nested(pte) kunmap_atomic((pte), KM_PTE1)
 
-#if defined(CONFIG_HIGHPTE) && defined(CONFIG_HIGHMEM4G)
-typedef u32 pte_addr_t;
-#endif
-
-#if defined(CONFIG_HIGHPTE) && defined(CONFIG_HIGHMEM64G)
-typedef u64 pte_addr_t;
-#endif
-
-#if !defined(CONFIG_HIGHPTE)
-typedef pte_t *pte_addr_t;
-#endif
-
 #define update_mmu_cache(vma,address,pte) do ; while (0)
 
 /* Encode and de-code a swap entry */
--- rmap12/include/asm-um/rmap.h	2002-09-16 03:20:25.000000000 +0100
+++ rmap13/include/asm-um/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,6 +0,0 @@
-#ifndef __UM_RMAP_H
-#define __UM_RMAP_H
-
-#include "asm/arch/rmap.h"
-
-#endif
--- rmap12/include/asm-v850/pgtable.h	2002-11-04 21:31:04.000000000 +0000
+++ rmap13/include/asm-v850/pgtable.h	2004-04-16 19:23:36.265470768 +0100
@@ -5,8 +5,6 @@
 #include <asm/page.h>
 
 
-typedef pte_t *pte_addr_t;
-
 #define pgd_present(pgd)	(1) /* pages are always present on NO_MM */
 #define pgd_none(pgd)		(0)
 #define pgd_bad(pgd)		(0)
--- rmap12/include/asm-v850/rmap.h	2002-11-04 21:31:04.000000000 +0000
+++ rmap13/include/asm-v850/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1 +0,0 @@
-/* Do not need anything here */
--- rmap12/include/asm-x86_64/pgtable.h	2004-03-11 01:56:11.000000000 +0000
+++ rmap13/include/asm-x86_64/pgtable.h	2004-04-16 19:23:36.267470464 +0100
@@ -390,8 +390,6 @@ extern inline pte_t pte_modify(pte_t pte
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-typedef pte_t *pte_addr_t;
-
 #endif /* !__ASSEMBLY__ */
 
 extern int kern_addr_valid(unsigned long addr); 
--- rmap12/include/asm-x86_64/rmap.h	2002-10-16 04:29:25.000000000 +0100
+++ rmap13/include/asm-x86_64/rmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,7 +0,0 @@
-#ifndef _X8664_RMAP_H
-#define _X8664_RMAP_H
-
-/* nothing to see, move along */
-#include <asm-generic/rmap.h>
-
-#endif

