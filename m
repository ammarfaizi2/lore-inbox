Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVDGBZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVDGBZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 21:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVDGBZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 21:25:17 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:54919 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262370AbVDGBSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 21:18:38 -0400
Date: Thu, 7 Apr 2005 02:18:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Russell King <rmk@arm.linux.org.uk>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] freepgt2: arch FIRST_USER_ADDRESS 0
In-Reply-To: <Pine.LNX.4.61.0504070204390.24723@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0504070216480.24723@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0504070204390.24723@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace misleading definition of FIRST_USER_PGD_NR 0 by definition of
FIRST_USER_ADDRESS 0 in all the MMU architectures beyond arm and arm26.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/asm-alpha/pgtable.h     |    2 +-
 include/asm-cris/pgtable.h      |    2 +-
 include/asm-frv/pgtable.h       |    2 +-
 include/asm-i386/pgtable.h      |    2 +-
 include/asm-ia64/pgtable.h      |    2 +-
 include/asm-m32r/pgtable.h      |    2 +-
 include/asm-m68k/pgtable.h      |    2 +-
 include/asm-mips/pgtable-32.h   |    2 +-
 include/asm-mips/pgtable-64.h   |    2 +-
 include/asm-parisc/pgtable.h    |    2 +-
 include/asm-ppc/pgtable.h       |    2 +-
 include/asm-ppc64/pgtable.h     |    2 +-
 include/asm-s390/pgtable.h      |    4 ++--
 include/asm-sh/pgtable.h        |    2 +-
 include/asm-sh64/pgtable.h      |    2 +-
 include/asm-sparc/pgtable.h     |    2 +-
 include/asm-sparc64/pgtable.h   |    2 +-
 include/asm-um/pgtable-2level.h |    2 +-
 include/asm-um/pgtable-3level.h |    2 +-
 include/asm-x86_64/pgtable.h    |    2 +-
 20 files changed, 21 insertions(+), 21 deletions(-)

--- 2.6.12-rc2-mm1/include/asm-alpha/pgtable.h	2005-04-05 15:20:54.000000000 +0100
+++ linux/include/asm-alpha/pgtable.h	2005-04-05 18:59:00.000000000 +0100
@@ -42,7 +42,7 @@
 #define PTRS_PER_PMD	(1UL << (PAGE_SHIFT-3))
 #define PTRS_PER_PGD	(1UL << (PAGE_SHIFT-3))
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
-#define FIRST_USER_PGD_NR	0
+#define FIRST_USER_ADDRESS	0
 
 /* Number of pointers that fit on a page:  this will go away. */
 #define PTRS_PER_PAGE	(1UL << (PAGE_SHIFT-3))
--- 2.6.12-rc2-mm1/include/asm-cris/pgtable.h	2005-04-05 15:20:55.000000000 +0100
+++ linux/include/asm-cris/pgtable.h	2005-04-05 18:59:00.000000000 +0100
@@ -76,7 +76,7 @@ extern void paging_init(void);
  */
 
 #define USER_PTRS_PER_PGD       (TASK_SIZE/PGDIR_SIZE)
-#define FIRST_USER_PGD_NR       0
+#define FIRST_USER_ADDRESS      0
 
 /* zero page used for uninitialized stuff */
 #ifndef __ASSEMBLY__
--- 2.6.12-rc2-mm1/include/asm-frv/pgtable.h	2005-04-05 15:20:55.000000000 +0100
+++ linux/include/asm-frv/pgtable.h	2005-04-05 18:59:00.000000000 +0100
@@ -141,7 +141,7 @@ extern unsigned long empty_zero_page;
 #define PTRS_PER_PTE		4096
 
 #define USER_PGDS_IN_LAST_PML4	(TASK_SIZE / PGDIR_SIZE)
-#define FIRST_USER_PGD_NR	0
+#define FIRST_USER_ADDRESS	0
 
 #define USER_PGD_PTRS		(PAGE_OFFSET >> PGDIR_SHIFT)
 #define KERNEL_PGD_PTRS		(PTRS_PER_PGD - USER_PGD_PTRS)
--- 2.6.12-rc2-mm1/include/asm-i386/pgtable.h	2005-04-05 15:20:55.000000000 +0100
+++ linux/include/asm-i386/pgtable.h	2005-04-05 18:59:00.000000000 +0100
@@ -60,7 +60,7 @@ void paging_init(void);
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
-#define FIRST_USER_PGD_NR	0
+#define FIRST_USER_ADDRESS	0
 
 #define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
 #define KERNEL_PGD_PTRS (PTRS_PER_PGD-USER_PGD_PTRS)
--- 2.6.12-rc2-mm1/include/asm-ia64/pgtable.h	2005-04-05 15:22:58.000000000 +0100
+++ linux/include/asm-ia64/pgtable.h	2005-04-05 18:59:00.000000000 +0100
@@ -93,7 +93,7 @@
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
 #define PTRS_PER_PGD		(1UL << (PAGE_SHIFT-3))
 #define USER_PTRS_PER_PGD	(5*PTRS_PER_PGD/8)	/* regions 0-4 are user regions */
-#define FIRST_USER_PGD_NR	0
+#define FIRST_USER_ADDRESS	0
 
 /*
  * Definitions for second level:
--- 2.6.12-rc2-mm1/include/asm-m32r/pgtable.h	2005-04-05 15:20:56.000000000 +0100
+++ linux/include/asm-m32r/pgtable.h	2005-04-05 18:59:00.000000000 +0100
@@ -51,7 +51,7 @@ extern unsigned long empty_zero_page[102
 #define PGDIR_MASK	(~(PGDIR_SIZE - 1))
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
-#define FIRST_USER_PGD_NR	0
+#define FIRST_USER_ADDRESS	0
 
 #ifndef __ASSEMBLY__
 /* Just any arbitrary offset to the start of the vmalloc VM area: the
--- 2.6.12-rc2-mm1/include/asm-m68k/pgtable.h	2005-04-05 15:20:56.000000000 +0100
+++ linux/include/asm-m68k/pgtable.h	2005-04-05 18:59:00.000000000 +0100
@@ -61,7 +61,7 @@
 #define PTRS_PER_PGD	128
 #endif
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
-#define FIRST_USER_PGD_NR	0
+#define FIRST_USER_ADDRESS	0
 
 /* Virtual address region for use by kernel_map() */
 #ifdef CONFIG_SUN3
--- 2.6.12-rc2-mm1/include/asm-mips/pgtable-32.h	2005-03-02 07:38:57.000000000 +0000
+++ linux/include/asm-mips/pgtable-32.h	2005-04-05 18:59:00.000000000 +0100
@@ -74,7 +74,7 @@ extern int add_temporary_entry(unsigned 
 #define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
 
 #define USER_PTRS_PER_PGD	(0x80000000UL/PGDIR_SIZE)
-#define FIRST_USER_PGD_NR	0
+#define FIRST_USER_ADDRESS	0
 
 #define VMALLOC_START     KSEG2
 
--- 2.6.12-rc2-mm1/include/asm-mips/pgtable-64.h	2004-12-24 21:36:18.000000000 +0000
+++ linux/include/asm-mips/pgtable-64.h	2005-04-05 18:59:00.000000000 +0100
@@ -89,7 +89,7 @@
 #define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
-#define FIRST_USER_PGD_NR	0
+#define FIRST_USER_ADDRESS	0
 
 #define VMALLOC_START		XKSEG
 #define VMALLOC_END	\
--- 2.6.12-rc2-mm1/include/asm-parisc/pgtable.h	2005-04-05 15:20:57.000000000 +0100
+++ linux/include/asm-parisc/pgtable.h	2005-04-05 18:59:00.000000000 +0100
@@ -120,7 +120,7 @@
  * pgd entries used up by user/kernel:
  */
 
-#define FIRST_USER_PGD_NR	0
+#define FIRST_USER_ADDRESS	0
 
 #ifndef __ASSEMBLY__
 extern  void *vmalloc_start;
--- 2.6.12-rc2-mm1/include/asm-ppc/pgtable.h	2005-04-05 15:20:57.000000000 +0100
+++ linux/include/asm-ppc/pgtable.h	2005-04-05 18:59:01.000000000 +0100
@@ -96,7 +96,7 @@ extern unsigned long ioremap_bot, iorema
 #define PTRS_PER_PGD	(1 << (32 - PGDIR_SHIFT))
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
-#define FIRST_USER_PGD_NR	0
+#define FIRST_USER_ADDRESS	0
 
 #define USER_PGD_PTRS (PAGE_OFFSET >> PGDIR_SHIFT)
 #define KERNEL_PGD_PTRS (PTRS_PER_PGD-USER_PGD_PTRS)
--- 2.6.12-rc2-mm1/include/asm-ppc64/pgtable.h	2005-04-05 15:22:59.000000000 +0100
+++ linux/include/asm-ppc64/pgtable.h	2005-04-05 18:59:01.000000000 +0100
@@ -41,7 +41,7 @@
 #define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
 
 #define USER_PTRS_PER_PGD	(1024)
-#define FIRST_USER_PGD_NR	0
+#define FIRST_USER_ADDRESS	0
 
 #define EADDR_SIZE (PTE_INDEX_SIZE + PMD_INDEX_SIZE + \
                     PGD_INDEX_SIZE + PAGE_SHIFT) 
--- 2.6.12-rc2-mm1/include/asm-s390/pgtable.h	2005-04-05 15:20:57.000000000 +0100
+++ linux/include/asm-s390/pgtable.h	2005-04-05 18:59:01.000000000 +0100
@@ -95,14 +95,14 @@ extern char empty_zero_page[PAGE_SIZE];
 # define USER_PTRS_PER_PGD  512
 # define USER_PGD_PTRS      512
 # define KERNEL_PGD_PTRS    512
-# define FIRST_USER_PGD_NR  0
 #else /* __s390x__ */
 # define USER_PTRS_PER_PGD  2048
 # define USER_PGD_PTRS      2048
 # define KERNEL_PGD_PTRS    2048
-# define FIRST_USER_PGD_NR  0
 #endif /* __s390x__ */
 
+#define FIRST_USER_ADDRESS  0
+
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %p.\n", __FILE__, __LINE__, (void *) pte_val(e))
 #define pmd_ERROR(e) \
--- 2.6.12-rc2-mm1/include/asm-sh/pgtable.h	2005-04-05 15:20:58.000000000 +0100
+++ linux/include/asm-sh/pgtable.h	2005-04-05 18:59:01.000000000 +0100
@@ -44,7 +44,7 @@ extern unsigned long empty_zero_page[102
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
-#define FIRST_USER_PGD_NR	0
+#define FIRST_USER_ADDRESS	0
 
 #define PTE_PHYS_MASK	0x1ffff000
 
--- 2.6.12-rc2-mm1/include/asm-sh64/pgtable.h	2005-04-05 15:20:58.000000000 +0100
+++ linux/include/asm-sh64/pgtable.h	2005-04-05 18:59:01.000000000 +0100
@@ -238,7 +238,7 @@ static inline pmd_t * pmd_offset(pgd_t *
 
 /* Round it up ! */
 #define USER_PTRS_PER_PGD	((TASK_SIZE+PGDIR_SIZE-1)/PGDIR_SIZE)
-#define FIRST_USER_PGD_NR	0
+#define FIRST_USER_ADDRESS	0
 
 #ifndef __ASSEMBLY__
 #define VMALLOC_END	0xff000000
--- 2.6.12-rc2-mm1/include/asm-sparc/pgtable.h	2005-04-05 15:20:58.000000000 +0100
+++ linux/include/asm-sparc/pgtable.h	2005-04-05 18:59:01.000000000 +0100
@@ -63,7 +63,7 @@ BTFIXUPDEF_INT(page_kernel)
 #define PTRS_PER_PMD    	BTFIXUP_SIMM13(ptrs_per_pmd)
 #define PTRS_PER_PGD    	BTFIXUP_SIMM13(ptrs_per_pgd)
 #define USER_PTRS_PER_PGD	BTFIXUP_SIMM13(user_ptrs_per_pgd)
-#define FIRST_USER_PGD_NR	0
+#define FIRST_USER_ADDRESS	0
 #define PTE_SIZE		(PTRS_PER_PTE*4)
 
 #define PAGE_NONE      __pgprot(BTFIXUP_INT(page_none))
--- 2.6.12-rc2-mm1/include/asm-sparc64/pgtable.h	2005-04-05 15:22:59.000000000 +0100
+++ linux/include/asm-sparc64/pgtable.h	2005-04-05 18:59:01.000000000 +0100
@@ -78,7 +78,7 @@
 #define PTRS_PER_PGD	(1UL << PGDIR_BITS)
 
 /* Kernel has a separate 44bit address space. */
-#define FIRST_USER_PGD_NR	0
+#define FIRST_USER_ADDRESS	0
 
 #define pte_ERROR(e)	__builtin_trap()
 #define pmd_ERROR(e)	__builtin_trap()
--- 2.6.12-rc2-mm1/include/asm-um/pgtable-2level.h	2005-04-05 15:20:58.000000000 +0100
+++ linux/include/asm-um/pgtable-2level.h	2005-04-05 18:59:01.000000000 +0100
@@ -23,7 +23,7 @@
 #define PTRS_PER_PTE	1024
 #define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
 #define PTRS_PER_PGD	1024
-#define FIRST_USER_PGD_NR       0
+#define FIRST_USER_ADDRESS	0
 
 #define pte_ERROR(e) \
         printk("%s:%d: bad pte %p(%08lx).\n", __FILE__, __LINE__, &(e), \
--- 2.6.12-rc2-mm1/include/asm-um/pgtable-3level.h	2005-04-05 15:20:58.000000000 +0100
+++ linux/include/asm-um/pgtable-3level.h	2005-04-05 18:59:01.000000000 +0100
@@ -31,7 +31,7 @@
 #define PTRS_PER_PMD 512
 #define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
 #define PTRS_PER_PGD 512
-#define FIRST_USER_PGD_NR       0
+#define FIRST_USER_ADDRESS	0
 
 #define pte_ERROR(e) \
         printk("%s:%d: bad pte %p(%016lx).\n", __FILE__, __LINE__, &(e), \
--- 2.6.12-rc2-mm1/include/asm-x86_64/pgtable.h	2005-04-05 15:20:58.000000000 +0100
+++ linux/include/asm-x86_64/pgtable.h	2005-04-05 18:59:01.000000000 +0100
@@ -114,7 +114,7 @@ extern inline void pgd_clear (pgd_t * pg
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
-#define FIRST_USER_PGD_NR	0
+#define FIRST_USER_ADDRESS	0
 
 #ifndef __ASSEMBLY__
 #define MAXMEM		 0x3fffffffffffUL
