Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264168AbTEWUOQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 16:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264169AbTEWUOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 16:14:16 -0400
Received: from galileo.bork.org ([66.11.174.148]:6922 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S264168AbTEWUOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 16:14:10 -0400
Date: Fri, 23 May 2003 16:27:15 -0400
From: Martin Hicks <mort@wildopensource.com>
To: linux-kernel@vger.kernel.org, hch@infradead.org
Subject: [PATCH] 2.5 - Change mmu_gathers into per-cpu data
Message-ID: <20030523202715.GO29833@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Here is a patch that changes mmu_gathers into a per-cpu resource.
It includes the changes for all arches except ia64.  I've sent
a separate patch to David Mosberger for ia64.

The patch is against the latest bit keeper tree.  I've tested
on ia64 and i386.

mh

-- 
Wild Open Source Inc.                  mort@wildopensource.com


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1249  -> 1.1250 
#	include/asm-generic/tlb.h	1.17    -> 1.18   
#	include/asm-arm/tlb.h	1.6     -> 1.7    
#	arch/x86_64/mm/init.c	1.16    -> 1.17   
#	  arch/ppc/mm/init.c	1.28    -> 1.29   
#	arch/sparc64/mm/init.c	1.45    -> 1.46   
#	arch/um/kernel/mem.c	1.15    -> 1.16   
#	arch/sparc/mm/init.c	1.18    -> 1.19   
#	arch/parisc/mm/init.c	1.9     -> 1.10   
#	arch/ppc64/mm/init.c	1.40    -> 1.41   
#	arch/mips64/mm/init.c	1.8     -> 1.9    
#	 arch/s390/mm/init.c	1.15    -> 1.16   
#	 arch/i386/mm/init.c	1.46    -> 1.47   
#	   arch/sh/mm/init.c	1.11    -> 1.12   
#	 arch/m68k/mm/init.c	1.9     -> 1.10   
#	 arch/mips/mm/init.c	1.7     -> 1.8    
#	arch/alpha/mm/init.c	1.16    -> 1.17   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/23	mort@plato.i.bork.org	1.1250
# Make mmu_gathers a per-cpu resource instead of a global array.
# --------------------------------------------
#
diff -Nru a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
--- a/arch/alpha/mm/init.c	Fri May 23 16:24:35 2003
+++ b/arch/alpha/mm/init.c	Fri May 23 16:24:35 2003
@@ -34,7 +34,7 @@
 #include <asm/console.h>
 #include <asm/tlb.h>
 
-struct mmu_gather mmu_gathers[NR_CPUS];
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 extern void die_if_kernel(char *,struct pt_regs *,long);
 
diff -Nru a/arch/i386/mm/init.c b/arch/i386/mm/init.c
--- a/arch/i386/mm/init.c	Fri May 23 16:24:35 2003
+++ b/arch/i386/mm/init.c	Fri May 23 16:24:35 2003
@@ -41,7 +41,7 @@
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
 
-struct mmu_gather mmu_gathers[NR_CPUS];
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 unsigned long highstart_pfn, highend_pfn;
 
 static int do_test_wp_bit(void);
diff -Nru a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
--- a/arch/m68k/mm/init.c	Fri May 23 16:24:35 2003
+++ b/arch/m68k/mm/init.c	Fri May 23 16:24:35 2003
@@ -33,7 +33,7 @@
 #endif
 #include <asm/tlb.h>
 
-struct mmu_gather mmu_gathers[NR_CPUS];
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 /*
  * ZERO_PAGE is a special page that is used for zero-initialized
diff -Nru a/arch/mips/mm/init.c b/arch/mips/mm/init.c
--- a/arch/mips/mm/init.c	Fri May 23 16:24:35 2003
+++ b/arch/mips/mm/init.c	Fri May 23 16:24:35 2003
@@ -42,7 +42,7 @@
 #include <asm/mmu_context.h>
 #include <asm/tlb.h>
 
-struct mmu_gather mmu_gathers[NR_CPUS];
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 extern void prom_free_prom_memory(void);
 
diff -Nru a/arch/mips64/mm/init.c b/arch/mips64/mm/init.c
--- a/arch/mips64/mm/init.c	Fri May 23 16:24:35 2003
+++ b/arch/mips64/mm/init.c	Fri May 23 16:24:35 2003
@@ -35,7 +35,7 @@
 #include <asm/mmu_context.h>
 #include <asm/tlb.h>
 
-struct mmu_gather mmu_gathers[NR_CPUS];
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 void pgd_init(unsigned long page)
 {
diff -Nru a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
--- a/arch/parisc/mm/init.c	Fri May 23 16:24:35 2003
+++ b/arch/parisc/mm/init.c	Fri May 23 16:24:35 2003
@@ -23,7 +23,7 @@
 #include <asm/tlb.h>
 #include <asm/pdc_chassis.h>
 
-struct mmu_gather mmu_gathers[NR_CPUS];
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 extern char _text;	/* start of kernel code, defined by linker */
 extern int  data_start;
diff -Nru a/arch/ppc/mm/init.c b/arch/ppc/mm/init.c
--- a/arch/ppc/mm/init.c	Fri May 23 16:24:35 2003
+++ b/arch/ppc/mm/init.c	Fri May 23 16:24:35 2003
@@ -53,7 +53,7 @@
 #endif
 #define MAX_LOW_MEM	CONFIG_LOWMEM_SIZE
 
-struct mmu_gather mmu_gathers[NR_CPUS];
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 unsigned long total_memory;
 unsigned long total_lowmem;
diff -Nru a/arch/ppc64/mm/init.c b/arch/ppc64/mm/init.c
--- a/arch/ppc64/mm/init.c	Fri May 23 16:24:35 2003
+++ b/arch/ppc64/mm/init.c	Fri May 23 16:24:35 2003
@@ -95,7 +95,7 @@
 /* This is declared as we are using the more or less generic 
  * include/asm-ppc64/tlb.h file -- tgall
  */
-struct mmu_gather     mmu_gathers[NR_CPUS];
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 void show_mem(void)
 {
diff -Nru a/arch/s390/mm/init.c b/arch/s390/mm/init.c
--- a/arch/s390/mm/init.c	Fri May 23 16:24:35 2003
+++ b/arch/s390/mm/init.c	Fri May 23 16:24:35 2003
@@ -38,7 +38,7 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-struct mmu_gather mmu_gathers[NR_CPUS];
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __attribute__((__aligned__(PAGE_SIZE)));
 char  empty_zero_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
diff -Nru a/arch/sh/mm/init.c b/arch/sh/mm/init.c
--- a/arch/sh/mm/init.c	Fri May 23 16:24:35 2003
+++ b/arch/sh/mm/init.c	Fri May 23 16:24:35 2003
@@ -36,7 +36,7 @@
 #include <asm/io.h>
 #include <asm/tlb.h>
 
-struct mmu_gather mmu_gathers[NR_CPUS];
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 /*
  * Cache of MMU context last used.
diff -Nru a/arch/sparc/mm/init.c b/arch/sparc/mm/init.c
--- a/arch/sparc/mm/init.c	Fri May 23 16:24:35 2003
+++ b/arch/sparc/mm/init.c	Fri May 23 16:24:35 2003
@@ -32,7 +32,7 @@
 #include <asm/pgalloc.h>	/* bug in asm-generic/tlb.h: check_pgt_cache */
 #include <asm/tlb.h>
 
-struct mmu_gather mmu_gathers[NR_CPUS];
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 unsigned long *sparc_valid_addr_bitmap;
 
diff -Nru a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
--- a/arch/sparc64/mm/init.c	Fri May 23 16:24:35 2003
+++ b/arch/sparc64/mm/init.c	Fri May 23 16:24:35 2003
@@ -36,7 +36,7 @@
 #include <asm/tlb.h>
 #include <asm/spitfire.h>
 
-struct mmu_gather mmu_gathers[NR_CPUS];
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 extern void device_scan(void);
 
diff -Nru a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
--- a/arch/um/kernel/mem.c	Fri May 23 16:24:35 2003
+++ b/arch/um/kernel/mem.c	Fri May 23 16:24:35 2003
@@ -45,7 +45,7 @@
 extern long physmem_size;
 
 /* Not changed by UML */
-struct mmu_gather mmu_gathers[NR_CPUS];
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 /* Changed during early boot */
 int kmalloc_ok = 0;
diff -Nru a/arch/x86_64/mm/init.c b/arch/x86_64/mm/init.c
--- a/arch/x86_64/mm/init.c	Fri May 23 16:24:35 2003
+++ b/arch/x86_64/mm/init.c	Fri May 23 16:24:35 2003
@@ -41,7 +41,7 @@
 
 #define Dprintk(x...) printk(x)
 
-struct mmu_gather mmu_gathers[NR_CPUS];
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 /*
  * NOTE: pagetable_init alloc all the fixmap pagetables contiguous on the
diff -Nru a/include/asm-arm/tlb.h b/include/asm-arm/tlb.h
--- a/include/asm-arm/tlb.h	Fri May 23 16:24:35 2003
+++ b/include/asm-arm/tlb.h	Fri May 23 16:24:35 2003
@@ -31,13 +31,13 @@
 	unsigned int		avoided_flushes;
 };
 
-extern struct mmu_gather mmu_gathers[NR_CPUS];
+DECLARE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 static inline struct mmu_gather *
 tlb_gather_mmu(struct mm_struct *mm, unsigned int full_mm_flush)
 {
 	int cpu = smp_processor_id();
-	struct mmu_gather *tlb = &mmu_gathers[cpu];
+	struct mmu_gather *tlb = &per_cpu(mmu_gathers, cpu);
 
 	tlb->mm = mm;
 	tlb->freed = 0;
diff -Nru a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
--- a/include/asm-generic/tlb.h	Fri May 23 16:24:35 2003
+++ b/include/asm-generic/tlb.h	Fri May 23 16:24:35 2003
@@ -44,7 +44,7 @@
 };
 
 /* Users of the generic TLB shootdown code must declare this storage space. */
-extern struct mmu_gather	mmu_gathers[NR_CPUS];
+DECLARE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 /* tlb_gather_mmu
  *	Return a pointer to an initialized struct mmu_gather.
@@ -52,7 +52,7 @@
 static inline struct mmu_gather *
 tlb_gather_mmu(struct mm_struct *mm, unsigned int full_mm_flush)
 {
-	struct mmu_gather *tlb = &mmu_gathers[smp_processor_id()];
+	struct mmu_gather *tlb = &per_cpu(mmu_gathers, smp_processor_id());
 
 	tlb->mm = mm;
 
