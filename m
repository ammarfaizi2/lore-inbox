Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSFUPYR>; Fri, 21 Jun 2002 11:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316663AbSFUPYQ>; Fri, 21 Jun 2002 11:24:16 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:2052 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S316662AbSFUPYM>; Fri, 21 Jun 2002 11:24:12 -0400
Date: Fri, 21 Jun 2002 19:24:05 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jurriaan on Alpha <thunder7@xs4all.nl>
Cc: Oliver Pitzeier <o.pitzeier@uptime.at>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.24 doesn't compile on Alpha
Message-ID: <20020621192405.A749@jurassic.park.msu.ru>
References: <20020621064835.GA13502@alpha.of.nowhere> <000301c2191e$5a4a3080$010b10ac@sbp.uptime.at> <20020621141957.GA22555@alpha.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020621141957.GA22555@alpha.of.nowhere>; from thunder7@xs4all.nl on Fri, Jun 21, 2002 at 04:19:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 04:19:57PM +0200, Jurriaan on Alpha wrote:
> I tried #define smp_num_cpus 1 in include/asm-alpha/smp.h (the non-smp
> section) but the same line in include/asm/mmu_context.h works - for a
> while.

I'm running 2.5.24 on sx164 with following (unfinished - SMP is broken)
patch.

Ivan.

--- 2.5.24/drivers/char/rtc.c	Mon Jun  3 05:44:47 2002
+++ linux/drivers/char/rtc.c	Fri Jun 21 18:07:57 2002
@@ -870,7 +870,9 @@ no_irq:
 
 	if (misc_register(&rtc_dev))
 		{
+#if RTC_IRQ
 		free_irq(RTC_IRQ, NULL);
+#endif
 		release_region(RTC_PORT(0), RTC_IO_EXTENT);
 		return -ENODEV;
 		}
--- 2.5.24/arch/alpha/lib/stxcpy.S	Mon Jun  3 05:44:44 2002
+++ linux/arch/alpha/lib/stxcpy.S	Fri Jun 21 18:07:57 2002
@@ -20,7 +20,7 @@
  * Furthermore, v0, a3-a5, t11, and t12 are untouched.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noat
 	.set noreorder
--- 2.5.24/arch/alpha/lib/ev6-stxcpy.S	Mon Jun  3 05:44:37 2002
+++ linux/arch/alpha/lib/ev6-stxcpy.S	Fri Jun 21 18:07:57 2002
@@ -30,7 +30,7 @@
  * Try not to change the actual algorithm if possible for consistency.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noat
 	.set noreorder
--- 2.5.24/arch/alpha/lib/ev6-stxncpy.S	Mon Jun  3 05:44:52 2002
+++ linux/arch/alpha/lib/ev6-stxncpy.S	Fri Jun 21 18:07:57 2002
@@ -38,7 +38,7 @@
  * Try not to change the actual algorithm if possible for consistency.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noat
 	.set noreorder
--- 2.5.24/arch/alpha/lib/strncpy_from_user.S	Mon Jun  3 05:44:41 2002
+++ linux/arch/alpha/lib/strncpy_from_user.S	Fri Jun 21 18:07:57 2002
@@ -12,7 +12,7 @@
 
 
 #include <asm/errno.h>
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 
 /* Allow an exception for an insn; exit if we get one.  */
--- 2.5.24/arch/alpha/lib/stxncpy.S	Mon Jun  3 05:44:48 2002
+++ linux/arch/alpha/lib/stxncpy.S	Fri Jun 21 18:07:57 2002
@@ -28,7 +28,7 @@
  * Furthermore, v0, a3-a5, t11, t12, and $at are untouched.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noat
 	.set noreorder
--- 2.5.24/arch/alpha/lib/ev67-strlen_user.S	Mon Jun  3 05:44:48 2002
+++ linux/arch/alpha/lib/ev67-strlen_user.S	Fri Jun 21 18:07:57 2002
@@ -23,7 +23,7 @@
  * Try not to change the actual algorithm if possible for consistency.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 
 /* Allow an exception for an insn; exit if we get one.  */
--- 2.5.24/arch/alpha/lib/strchr.S	Mon Jun  3 05:44:49 2002
+++ linux/arch/alpha/lib/strchr.S	Fri Jun 21 18:07:57 2002
@@ -6,7 +6,7 @@
  * string, or null if it is not found.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noreorder
 	.set noat
--- 2.5.24/arch/alpha/lib/strlen_user.S	Mon Jun  3 05:44:50 2002
+++ linux/arch/alpha/lib/strlen_user.S	Fri Jun 21 18:07:57 2002
@@ -12,7 +12,7 @@
  * boundary when doing so.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 
 /* Allow an exception for an insn; exit if we get one.  */
--- 2.5.24/arch/alpha/lib/ev67-strrchr.S	Mon Jun  3 05:44:50 2002
+++ linux/arch/alpha/lib/ev67-strrchr.S	Fri Jun 21 18:07:57 2002
@@ -19,7 +19,7 @@
  */
 
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noreorder
 	.set noat
--- 2.5.24/arch/alpha/lib/ev67-strchr.S	Mon Jun  3 05:44:50 2002
+++ linux/arch/alpha/lib/ev67-strchr.S	Fri Jun 21 18:07:57 2002
@@ -16,7 +16,7 @@
  * Try not to change the actual algorithm if possible for consistency.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noreorder
 	.set noat
--- 2.5.24/arch/alpha/lib/strrchr.S	Mon Jun  3 05:44:52 2002
+++ linux/arch/alpha/lib/strrchr.S	Fri Jun 21 18:07:57 2002
@@ -6,7 +6,7 @@
  * within a null-terminated string, or null if it is not found.
  */
 
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 	.set noreorder
 	.set noat
--- 2.5.24/arch/alpha/lib/ev6-strncpy_from_user.S	Mon Jun  3 05:44:53 2002
+++ linux/arch/alpha/lib/ev6-strncpy_from_user.S	Fri Jun 21 18:07:57 2002
@@ -27,7 +27,7 @@
 
 
 #include <asm/errno.h>
-#include <alpha/regdef.h>
+#include <asm/regdef.h>
 
 
 /* Allow an exception for an insn; exit if we get one.  */
--- 2.5.24/arch/alpha/kernel/pci.c	Mon Jun  3 05:44:41 2002
+++ linux/arch/alpha/kernel/pci.c	Fri Jun 21 18:07:58 2002
@@ -190,12 +190,12 @@ pcibios_align_resource(void *data, struc
 #undef MB
 #undef GB
 
-static void __init
+static int __init
 pcibios_init(void)
 {
-	if (!alpha_mv.init_pci)
-		return;
-	alpha_mv.init_pci();
+	if (alpha_mv.init_pci)
+		alpha_mv.init_pci();
+	return 0;
 }
 
 subsys_initcall(pcibios_init);
--- 2.5.24/arch/alpha/kernel/signal.c	Mon Jun 10 14:25:18 2002
+++ linux/arch/alpha/kernel/signal.c	Fri Jun 21 18:07:57 2002
@@ -18,6 +18,7 @@
 #include <linux/smp_lock.h>
 #include <linux/stddef.h>
 #include <linux/tty.h>
+#include <linux/binfmts.h>
 
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
--- 2.5.24/arch/alpha/kernel/osf_sys.c	Mon Jun 10 14:25:18 2002
+++ linux/arch/alpha/kernel/osf_sys.c	Fri Jun 21 18:07:57 2002
@@ -33,6 +33,7 @@
 #include <linux/file.h>
 #include <linux/types.h>
 #include <linux/ipc.h>
+#include <linux/namei.h>
 
 #include <asm/fpu.h>
 #include <asm/io.h>
--- 2.5.24/arch/alpha/kernel/alpha_ksyms.c	Mon Jun  3 05:44:41 2002
+++ linux/arch/alpha/kernel/alpha_ksyms.c	Fri Jun 21 18:07:58 2002
@@ -214,7 +214,6 @@ EXPORT_SYMBOL(flush_tlb_page);
 EXPORT_SYMBOL(smp_imb);
 EXPORT_SYMBOL(cpu_data);
 EXPORT_SYMBOL(__cpu_number_map);
-EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(smp_call_function);
 EXPORT_SYMBOL(smp_call_function_on_cpu);
 EXPORT_SYMBOL(global_irq_holder);
--- 2.5.24/arch/alpha/kernel/setup.c	Thu Jun 20 14:27:39 2002
+++ linux/arch/alpha/kernel/setup.c	Fri Jun 21 18:09:36 2002
@@ -1109,7 +1109,7 @@ show_cpuinfo(struct seq_file *f, void *s
 #ifdef CONFIG_SMP
 	seq_printf(f, "cpus active\t\t: %d\n"
 		      "cpu active mask\t\t: %016lx\n",
-		       smp_num_cpus, cpu_present_mask);
+		       num_online_cpus(), cpu_present_mask);
 #endif
 
 	return 0;
--- 2.5.24/include/asm-alpha/page.h	Mon Jun  3 05:44:52 2002
+++ linux/include/asm-alpha/page.h	Fri Jun 21 18:07:58 2002
@@ -15,10 +15,10 @@
 #define STRICT_MM_TYPECHECKS
 
 extern void clear_page(void *page);
-#define clear_user_page(page, vaddr)	clear_page(page)
+#define clear_user_page(page, vaddr, pg)	clear_page(page)
 
 extern void copy_page(void * _to, void * _from);
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
 #ifdef STRICT_MM_TYPECHECKS
 /*
@@ -95,8 +95,12 @@ extern __inline__ int get_order(unsigned
 #define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
 #ifndef CONFIG_DISCONTIGMEM
-#define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
-#define VALID_PAGE(page)	(((page) - mem_map) < max_mapnr)
+#define pfn_to_page(pfn)	(mem_map + (pfn))
+#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
+#define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+
+#define pfn_valid(pfn)		((pfn) < max_mapnr)
+#define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 #endif /* CONFIG_DISCONTIGMEM */
 
 #define VM_DATA_DEFAULT_FLAGS		(VM_READ | VM_WRITE | VM_EXEC | \
--- 2.5.24/include/asm-alpha/pgtable.h	Mon Jun  3 05:44:45 2002
+++ linux/include/asm-alpha/pgtable.h	Fri Jun 21 18:07:58 2002
@@ -179,11 +179,12 @@ extern unsigned long __zero_page(void);
 #endif
 #if defined(CONFIG_ALPHA_GENERIC) || \
     (defined(CONFIG_ALPHA_EV6) && !defined(USE_48_BIT_KSEG))
-#define PHYS_TWIDDLE(phys) \
-  ((((phys) & 0xc0000000000UL) == 0x40000000000UL) \
-  ? ((phys) ^= 0xc0000000000UL) : (phys))
+#define KSEG_PFN	(0xc0000000000UL >> PAGE_SHIFT)
+#define PHYS_TWIDDLE(pfn) \
+  ((((pfn) & KSEG_PFN) == (0x40000000000UL >> PAGE_SHIFT)) \
+  ? ((pfn) ^= KSEG_PFN) : (pfn))
 #else
-#define PHYS_TWIDDLE(phys) (phys)
+#define PHYS_TWIDDLE(pfn) (pfn)
 #endif
 
 /*
@@ -199,12 +200,13 @@ extern unsigned long __zero_page(void);
 #endif
 
 #ifndef CONFIG_DISCONTIGMEM
+#define pte_pfn(pte)	(pte_val(pte) >> 32)
+#define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 #define mk_pte(page, pgprot)						\
 ({									\
 	pte_t pte;							\
 									\
-	pte_val(pte) = ((unsigned long)(page - mem_map) << 32) |	\
-		       pgprot_val(pgprot);				\
+	pte_val(pte) = (page_to_pfn(page) << 32) | pgprot_val(pgprot);	\
 	pte;								\
 })
 #else
@@ -219,10 +221,20 @@ extern unsigned long __zero_page(void);
 										\
 	pte;									\
 })
+#define pte_page(x)							\
+({									\
+	unsigned long kvirt;						\
+	struct page * __xx;						\
+									\
+	kvirt = (unsigned long)__va(pte_val(x) >> (32-PAGE_SHIFT));	\
+	__xx = virt_to_page(kvirt);					\
+									\
+	__xx;								\
+})
 #endif
 
-extern inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
-{ pte_t pte; pte_val(pte) = (PHYS_TWIDDLE(physpage) << (32-PAGE_SHIFT)) | pgprot_val(pgprot); return pte; }
+extern inline pte_t pfn_pte(unsigned long physpfn, pgprot_t pgprot)
+{ pte_t pte; pte_val(pte) = (PHYS_TWIDDLE(physpfn) << 32) | pgprot_val(pgprot); return pte; }
 
 extern inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 { pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot); return pte; }
@@ -233,20 +245,6 @@ extern inline void pmd_set(pmd_t * pmdp,
 extern inline void pgd_set(pgd_t * pgdp, pmd_t * pmdp)
 { pgd_val(*pgdp) = _PAGE_TABLE | ((((unsigned long) pmdp) - PAGE_OFFSET) << (32-PAGE_SHIFT)); }
 
-#ifndef CONFIG_DISCONTIGMEM
-#define pte_page(x)	(mem_map+(unsigned long)((pte_val(x) >> 32)))
-#else
-#define pte_page(x)							\
-({									\
-	unsigned long kvirt;						\
-	struct page * __xx;						\
-									\
-	kvirt = (unsigned long)__va(pte_val(x) >> (32-PAGE_SHIFT));	\
-	__xx = virt_to_page(kvirt);					\
-									\
-	__xx;								\
-})
-#endif
 
 extern inline unsigned long
 pmd_page_kernel(pmd_t pmd)
--- 2.5.24/include/asm-alpha/tlb.h	Mon Jun  3 05:44:48 2002
+++ linux/include/asm-alpha/tlb.h	Fri Jun 21 18:07:58 2002
@@ -1 +1,15 @@
+#ifndef _ALPHA_TLB_H
+#define _ALPHA_TLB_H
+
+#define tlb_start_vma(tlb, vma)			do { } while (0)
+#define tlb_end_vma(tlb, vma)			do { } while (0)
+#define tlb_remove_tlb_entry(tlb, pte, addr)	do { } while (0)
+
+#define tlb_flush(tlb)				flush_tlb_mm((tlb)->mm)
+
 #include <asm-generic/tlb.h>
+
+#define pte_free_tlb(tlb,pte)			pte_free(pte)
+#define pmd_free_tlb(tlb,pmd)			pmd_free(pmd)
+ 
+#endif
--- 2.5.24/include/asm-alpha/bitops.h	Mon Jun  3 05:44:49 2002
+++ linux/include/asm-alpha/bitops.h	Fri Jun 21 18:07:58 2002
@@ -315,6 +315,20 @@ static inline int ffs(int word)
 	return word ? result+1 : 0;
 }
 
+/*
+ * fls: find last bit set.
+ */
+#if defined(__alpha_cix__) && defined(__alpha_fix__)
+static inline int fls(int word)
+{
+	long result;
+	__asm__("ctlz %1,%0" : "=r"(result) : "r"(word & 0xffffffff));
+	return 64 - result;
+}
+#else
+#define fls	generic_fls
+#endif
+
 /* Compute powers of two for the given integer.  */
 static inline int floor_log2(unsigned long word)
 {
--- 2.5.24/include/asm-alpha/regdef.h	Thu Jan  1 00:00:00 1970
+++ linux/include/asm-alpha/regdef.h	Fri Jun 21 18:07:58 2002
@@ -0,0 +1,44 @@
+#ifndef __alpha_regdef_h__
+#define __alpha_regdef_h__
+
+#define v0	$0	/* function return value */
+
+#define t0	$1	/* temporary registers (caller-saved) */
+#define t1	$2
+#define t2	$3
+#define t3	$4
+#define t4	$5
+#define t5	$6
+#define t6	$7
+#define t7	$8
+
+#define	s0	$9	/* saved-registers (callee-saved registers) */
+#define	s1	$10
+#define	s2	$11
+#define	s3	$12
+#define	s4	$13
+#define	s5	$14
+#define	s6	$15
+#define	fp	s6	/* frame-pointer (s6 in frame-less procedures) */
+
+#define a0	$16	/* argument registers (caller-saved) */
+#define a1	$17
+#define a2	$18
+#define a3	$19
+#define a4	$20
+#define a5	$21
+
+#define t8	$22	/* more temps (caller-saved) */
+#define t9	$23
+#define t10	$24
+#define t11	$25
+#define ra	$26	/* return address register */
+#define t12	$27
+
+#define pv	t12	/* procedure-variable register */
+#define AT	$at	/* assembler temporary */
+#define gp	$29	/* global pointer */
+#define sp	$30	/* stack pointer */
+#define zero	$31	/* reads as zero, writes are noops */
+
+#endif /* __alpha_regdef_h__ */
--- 2.5.24/include/asm-alpha/hardirq.h	Mon Jun  3 05:44:41 2002
+++ linux/include/asm-alpha/hardirq.h	Fri Jun 21 18:07:58 2002
@@ -56,7 +56,7 @@ static inline int irqs_running (void)
 {
 	int i;
 
-	for (i = 0; i < smp_num_cpus; i++)
+	for (i = 0; i < NR_CPUS; i++)
 		if (local_irq_count(i))
 			return 1;
 	return 0;
--- 2.5.24/include/asm-alpha/mmu_context.h	Mon Jun  3 05:44:50 2002
+++ linux/include/asm-alpha/mmu_context.h	Fri Jun 21 18:07:58 2002
@@ -227,8 +227,9 @@ init_new_context(struct task_struct *tsk
 {
 	int i;
 
-	for (i = 0; i < smp_num_cpus; i++)
-		mm->context[cpu_logical_map(i)] = 0;
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_online(i))
+			mm->context[i] = 0;
         tsk->thread_info->pcb.ptbr
 	  = ((unsigned long)mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
 	return 0;
--- 2.5.24/include/asm-alpha/smp.h	Mon Jun  3 05:44:47 2002
+++ linux/include/asm-alpha/smp.h	Fri Jun 21 18:07:58 2002
@@ -42,15 +42,6 @@ extern struct cpuinfo_alpha cpu_data[NR_
 
 #define PROC_CHANGE_PENALTY     20
 
-/* Map from cpu id to sequential logical cpu number.  This will only
-   not be idempotent when cpus failed to come on-line.  */
-extern int __cpu_number_map[NR_CPUS];
-#define cpu_number_map(cpu)  __cpu_number_map[cpu]
-
-/* The reverse map from sequential logical cpu number to cpu id.  */
-extern int __cpu_logical_map[NR_CPUS];
-#define cpu_logical_map(cpu)  __cpu_logical_map[cpu]
-
 #define hard_smp_processor_id()	__hard_smp_processor_id()
 #define smp_processor_id()	(current_thread_info()->cpu)
 
--- 2.5.24/include/asm-alpha/system.h	Mon Jun  3 05:44:51 2002
+++ linux/include/asm-alpha/system.h	Fri Jun 21 18:07:58 2002
@@ -130,8 +130,12 @@ struct el_common_EV6_mcheck {
 extern void halt(void) __attribute__((noreturn));
 #define __halt() __asm__ __volatile__ ("call_pal %0 #halt" : : "i" (PAL_halt))
 
-#define prepare_to_switch()	do { } while(0)
-#define switch_to(prev,next)						  \
+#define prepare_arch_schedule(prev)		do { } while(0)
+#define finish_arch_schedule(prev)		do { } while(0)
+#define prepare_arch_switch(rq)			do { } while(0)
+#define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
+
+#define switch_to(prev,next,last)						  \
 do {									  \
 	alpha_switch_to(virt_to_phys(&(next)->thread_info->pcb), (prev)); \
 	check_mmu_context();						  \
