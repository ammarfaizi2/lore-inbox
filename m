Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161125AbWJKQkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161125AbWJKQkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161127AbWJKQk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:40:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47036 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161125AbWJKQkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:40:24 -0400
To: torvalds@osdl.org
Subject: [PATCH] alpha_ksyms.c cleanup
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXh82-00066w-1u@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 11 Oct 2006 17:40:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


taken exports to actual definitions of symbols being exported.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/kernel/alpha_ksyms.c   |   93 -------------------------------------
 arch/alpha/kernel/core_irongate.c |    2 +
 arch/alpha/kernel/irq_alpha.c     |    3 +
 arch/alpha/kernel/pci-noop.c      |    1 
 arch/alpha/kernel/pci_iommu.c     |   17 ++++++-
 arch/alpha/kernel/process.c       |    5 ++
 arch/alpha/kernel/setup.c         |    6 ++
 arch/alpha/kernel/smp.c           |    8 +++
 arch/alpha/kernel/time.c          |    1 
 arch/alpha/mm/numa.c              |    2 +
 10 files changed, 44 insertions(+), 94 deletions(-)

diff --git a/arch/alpha/kernel/alpha_ksyms.c b/arch/alpha/kernel/alpha_ksyms.c
index 8b02420..692809e 100644
--- a/arch/alpha/kernel/alpha_ksyms.c
+++ b/arch/alpha/kernel/alpha_ksyms.c
@@ -6,41 +6,14 @@
  */
 
 #include <linux/module.h>
-#include <linux/string.h>
-#include <linux/user.h>
-#include <linux/elfcore.h>
-#include <linux/socket.h>
-#include <linux/syscalls.h>
-#include <linux/in.h>
-#include <linux/in6.h>
-#include <linux/pci.h>
-#include <linux/screen_info.h>
-#include <linux/tty.h>
-#include <linux/mm.h>
-#include <linux/delay.h>
-#include <linux/dma-mapping.h>
-
-#include <asm/io.h>
 #include <asm/console.h>
-#include <asm/hwrpb.h>
 #include <asm/uaccess.h>
-#include <asm/processor.h>
 #include <asm/checksum.h>
-#include <linux/interrupt.h>
 #include <asm/fpu.h>
-#include <asm/irq.h>
 #include <asm/machvec.h>
-#include <asm/pgalloc.h>
-#include <asm/semaphore.h>
-#include <asm/tlbflush.h>
-#include <asm/cacheflush.h>
-#include <asm/vga.h>
 
 #include <asm/unistd.h>
 
-extern struct hwrpb_struct *hwrpb;
-extern spinlock_t rtc_lock;
-
 /* these are C runtime functions with special calling conventions: */
 extern void __divl (void);
 extern void __reml (void);
@@ -52,14 +25,9 @@ extern void __divqu (void);
 extern void __remqu (void);
 
 EXPORT_SYMBOL(alpha_mv);
-EXPORT_SYMBOL(screen_info);
-EXPORT_SYMBOL(perf_irq);
 EXPORT_SYMBOL(callback_getenv);
 EXPORT_SYMBOL(callback_setenv);
 EXPORT_SYMBOL(callback_save_env);
-#ifdef CONFIG_ALPHA_GENERIC
-EXPORT_SYMBOL(alpha_using_srm);
-#endif /* CONFIG_ALPHA_GENERIC */
 
 /* platform dependent support */
 EXPORT_SYMBOL(strcat);
@@ -77,47 +45,14 @@ EXPORT_SYMBOL(__constant_c_memset);
 EXPORT_SYMBOL(copy_page);
 EXPORT_SYMBOL(clear_page);
 
-EXPORT_SYMBOL(__direct_map_base);
-EXPORT_SYMBOL(__direct_map_size);
-
-#ifdef CONFIG_PCI
-EXPORT_SYMBOL(pci_alloc_consistent);
-EXPORT_SYMBOL(pci_free_consistent);
-EXPORT_SYMBOL(pci_map_single);
-EXPORT_SYMBOL(pci_map_page);
-EXPORT_SYMBOL(pci_unmap_single);
-EXPORT_SYMBOL(pci_unmap_page);
-EXPORT_SYMBOL(pci_map_sg);
-EXPORT_SYMBOL(pci_unmap_sg);
-EXPORT_SYMBOL(pci_dma_supported);
-EXPORT_SYMBOL(pci_dac_dma_supported);
-EXPORT_SYMBOL(pci_dac_page_to_dma);
-EXPORT_SYMBOL(pci_dac_dma_to_page);
-EXPORT_SYMBOL(pci_dac_dma_to_offset);
-EXPORT_SYMBOL(alpha_gendev_to_pci);
-#endif
-EXPORT_SYMBOL(dma_set_mask);
-
-EXPORT_SYMBOL(dump_thread);
-EXPORT_SYMBOL(dump_elf_thread);
-EXPORT_SYMBOL(dump_elf_task);
-EXPORT_SYMBOL(dump_elf_task_fp);
-EXPORT_SYMBOL(hwrpb);
-EXPORT_SYMBOL(start_thread);
 EXPORT_SYMBOL(alpha_read_fp_reg);
 EXPORT_SYMBOL(alpha_read_fp_reg_s);
 EXPORT_SYMBOL(alpha_write_fp_reg);
 EXPORT_SYMBOL(alpha_write_fp_reg_s);
 
-/* In-kernel system calls.  */
+/* entry.S */
 EXPORT_SYMBOL(kernel_thread);
-EXPORT_SYMBOL(sys_dup);
-EXPORT_SYMBOL(sys_exit);
-EXPORT_SYMBOL(sys_write);
-EXPORT_SYMBOL(sys_lseek);
 EXPORT_SYMBOL(kernel_execve);
-EXPORT_SYMBOL(sys_setsid);
-EXPORT_SYMBOL(sys_wait4);
 
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_tcpudp_magic);
@@ -134,10 +69,6 @@ EXPORT_SYMBOL(alpha_fp_emul_imprecise);
 EXPORT_SYMBOL(alpha_fp_emul);
 #endif
 
-#ifdef CONFIG_ALPHA_BROKEN_IRQ_MASK
-EXPORT_SYMBOL(__min_ipl);
-#endif
-
 /*
  * The following are specially called from the uaccess assembly stubs.
  */
@@ -160,27 +91,10 @@ EXPORT_SYMBOL(up);
  */
 
 #ifdef CONFIG_SMP
-EXPORT_SYMBOL(flush_tlb_mm);
-EXPORT_SYMBOL(flush_tlb_range);
-EXPORT_SYMBOL(flush_tlb_page);
-EXPORT_SYMBOL(smp_imb);
-EXPORT_SYMBOL(cpu_data);
-EXPORT_SYMBOL(smp_num_cpus);
-EXPORT_SYMBOL(smp_call_function);
-EXPORT_SYMBOL(smp_call_function_on_cpu);
 EXPORT_SYMBOL(_atomic_dec_and_lock);
 #endif /* CONFIG_SMP */
 
 /*
- * NUMA specific symbols
- */
-#ifdef CONFIG_DISCONTIGMEM
-EXPORT_SYMBOL(node_data);
-#endif /* CONFIG_DISCONTIGMEM */
-
-EXPORT_SYMBOL(rtc_lock);
-
-/*
  * The following are special because they're not called
  * explicitly (the C compiler or assembler generates them in
  * response to division operations).  Fortunately, their
@@ -200,8 +114,3 @@ EXPORT_SYMBOL(__remqu);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memchr);
-
-#ifdef CONFIG_ALPHA_IRONGATE
-EXPORT_SYMBOL(irongate_ioremap);
-EXPORT_SYMBOL(irongate_iounmap);
-#endif
diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index 138d497..e4a0bcf 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -404,6 +404,7 @@ #if 0
 #endif
 	return (void __iomem *)vaddr;
 }
+EXPORT_SYMBOL(irongate_ioremap);
 
 void
 irongate_iounmap(volatile void __iomem *xaddr)
@@ -414,3 +415,4 @@ irongate_iounmap(volatile void __iomem *
 	if (addr)
 		return vfree((void *)(PAGE_MASK & addr)); 
 }
+EXPORT_SYMBOL(irongate_iounmap);
diff --git a/arch/alpha/kernel/irq_alpha.c b/arch/alpha/kernel/irq_alpha.c
index 6dd126b..e16aeb6 100644
--- a/arch/alpha/kernel/irq_alpha.c
+++ b/arch/alpha/kernel/irq_alpha.c
@@ -6,6 +6,7 @@ #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/irq.h>
 #include <linux/kernel_stat.h>
+#include <linux/module.h>
 
 #include <asm/machvec.h>
 #include <asm/dma.h>
@@ -16,6 +17,7 @@ #include "irq_impl.h"
 /* Hack minimum IPL during interrupt processing for broken hardware.  */
 #ifdef CONFIG_ALPHA_BROKEN_IRQ_MASK
 int __min_ipl;
+EXPORT_SYMBOL(__min_ipl);
 #endif
 
 /*
@@ -30,6 +32,7 @@ dummy_perf(unsigned long vector, struct 
 }
 
 void (*perf_irq)(unsigned long, struct pt_regs *) = dummy_perf;
+EXPORT_SYMBOL(perf_irq);
 
 /*
  * The main interrupt entry point.
diff --git a/arch/alpha/kernel/pci-noop.c b/arch/alpha/kernel/pci-noop.c
index fff5cf9..174b729 100644
--- a/arch/alpha/kernel/pci-noop.c
+++ b/arch/alpha/kernel/pci-noop.c
@@ -201,6 +201,7 @@ dma_set_mask(struct device *dev, u64 mas
 
 	return 0;
 }
+EXPORT_SYMBOL(dma_set_mask);
 
 void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
 {
diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index c468e31..6e7d1fe 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -300,6 +300,7 @@ pci_map_single(struct pci_dev *pdev, voi
 	dac_allowed = pdev ? pci_dac_dma_supported(pdev, pdev->dma_mask) : 0; 
 	return pci_map_single_1(pdev, cpu_addr, size, dac_allowed);
 }
+EXPORT_SYMBOL(pci_map_single);
 
 dma_addr_t
 pci_map_page(struct pci_dev *pdev, struct page *page, unsigned long offset,
@@ -314,6 +315,7 @@ pci_map_page(struct pci_dev *pdev, struc
 	return pci_map_single_1(pdev, (char *)page_address(page) + offset, 
 				size, dac_allowed);
 }
+EXPORT_SYMBOL(pci_map_page);
 
 /* Unmap a single streaming mode DMA translation.  The DMA_ADDR and
    SIZE must match what was provided for in a previous pci_map_single
@@ -379,6 +381,7 @@ pci_unmap_single(struct pci_dev *pdev, d
 	DBGA2("pci_unmap_single: sg [%lx,%lx] np %ld from %p\n",
 	      dma_addr, size, npages, __builtin_return_address(0));
 }
+EXPORT_SYMBOL(pci_unmap_single);
 
 void
 pci_unmap_page(struct pci_dev *pdev, dma_addr_t dma_addr,
@@ -386,6 +389,7 @@ pci_unmap_page(struct pci_dev *pdev, dma
 {
 	pci_unmap_single(pdev, dma_addr, size, direction);
 }
+EXPORT_SYMBOL(pci_unmap_page);
 
 /* Allocate and map kernel buffer using consistent mode DMA for PCI
    device.  Returns non-NULL cpu-view pointer to the buffer if
@@ -427,6 +431,7 @@ try_again:
 
 	return cpu_addr;
 }
+EXPORT_SYMBOL(pci_alloc_consistent);
 
 /* Free and unmap a consistent DMA buffer.  CPU_ADDR and DMA_ADDR must
    be values that were returned from pci_alloc_consistent.  SIZE must
@@ -444,7 +449,7 @@ pci_free_consistent(struct pci_dev *pdev
 	DBGA2("pci_free_consistent: [%x,%lx] from %p\n",
 	      dma_addr, size, __builtin_return_address(0));
 }
-
+EXPORT_SYMBOL(pci_free_consistent);
 
 /* Classify the elements of the scatterlist.  Write dma_address
    of each element with:
@@ -672,6 +677,7 @@ pci_map_sg(struct pci_dev *pdev, struct 
 		pci_unmap_sg(pdev, start, out - start, direction);
 	return 0;
 }
+EXPORT_SYMBOL(pci_map_sg);
 
 /* Unmap a set of streaming mode DMA translations.  Again, cpu read
    rules concerning calls here are the same as for pci_unmap_single()
@@ -752,6 +758,7 @@ pci_unmap_sg(struct pci_dev *pdev, struc
 
 	DBGA("pci_unmap_sg: %ld entries\n", nents - (end - sg));
 }
+EXPORT_SYMBOL(pci_unmap_sg);
 
 
 /* Return whether the given PCI device DMA address mask can be
@@ -786,6 +793,7 @@ pci_dma_supported(struct pci_dev *pdev, 
 
 	return 0;
 }
+EXPORT_SYMBOL(pci_dma_supported);
 
 
 /*
@@ -908,6 +916,7 @@ pci_dac_dma_supported(struct pci_dev *de
 
 	return ok;
 }
+EXPORT_SYMBOL(pci_dac_dma_supported);
 
 dma64_addr_t
 pci_dac_page_to_dma(struct pci_dev *pdev, struct page *page,
@@ -917,6 +926,7 @@ pci_dac_page_to_dma(struct pci_dev *pdev
 		+ __pa(page_address(page)) 
 		+ (dma64_addr_t) offset);
 }
+EXPORT_SYMBOL(pci_dac_page_to_dma);
 
 struct page *
 pci_dac_dma_to_page(struct pci_dev *pdev, dma64_addr_t dma_addr)
@@ -924,13 +934,14 @@ pci_dac_dma_to_page(struct pci_dev *pdev
 	unsigned long paddr = (dma_addr & PAGE_MASK) - alpha_mv.pci_dac_offset;
 	return virt_to_page(__va(paddr));
 }
+EXPORT_SYMBOL(pci_dac_dma_to_page);
 
 unsigned long
 pci_dac_dma_to_offset(struct pci_dev *pdev, dma64_addr_t dma_addr)
 {
 	return (dma_addr & ~PAGE_MASK);
 }
-
+EXPORT_SYMBOL(pci_dac_dma_to_offset);
 
 /* Helper for generic DMA-mapping functions. */
 
@@ -957,6 +968,7 @@ alpha_gendev_to_pci(struct device *dev)
 	/* This assumes ISA bus master with dma_mask 0xffffff. */
 	return NULL;
 }
+EXPORT_SYMBOL(alpha_gendev_to_pci);
 
 int
 dma_set_mask(struct device *dev, u64 mask)
@@ -969,3 +981,4 @@ dma_set_mask(struct device *dev, u64 mas
 
 	return 0;
 }
+EXPORT_SYMBOL(dma_set_mask);
diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index b3a8a29..3370e6f 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -205,6 +205,7 @@ start_thread(struct pt_regs * regs, unsi
 	regs->ps = 8;
 	wrusp(sp);
 }
+EXPORT_SYMBOL(start_thread);
 
 /*
  * Free current thread data structures etc..
@@ -376,6 +377,7 @@ dump_thread(struct pt_regs * pt, struct 
 	dump->regs[EF_A2]  = pt->r18;
 	memcpy((char *)dump->regs + EF_SIZE, sw->fp, 32 * 8);
 }
+EXPORT_SYMBOL(dump_thread);
 
 /*
  * Fill in the user structure for a ELF core dump.
@@ -424,6 +426,7 @@ dump_elf_thread(elf_greg_t *dest, struct
 	   useful value of the thread's UNIQUE field.  */
 	dest[32] = ti->pcb.unique;
 }
+EXPORT_SYMBOL(dump_elf_thread);
 
 int
 dump_elf_task(elf_greg_t *dest, struct task_struct *task)
@@ -431,6 +434,7 @@ dump_elf_task(elf_greg_t *dest, struct t
 	dump_elf_thread(dest, task_pt_regs(task), task_thread_info(task));
 	return 1;
 }
+EXPORT_SYMBOL(dump_elf_task);
 
 int
 dump_elf_task_fp(elf_fpreg_t *dest, struct task_struct *task)
@@ -439,6 +443,7 @@ dump_elf_task_fp(elf_fpreg_t *dest, stru
 	memcpy(dest, sw->fp, 32 * 8);
 	return 1;
 }
+EXPORT_SYMBOL(dump_elf_task_fp);
 
 /*
  * sys_execve() executes a new program.
diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index a94e6d9..1aea7c7 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -66,6 +66,7 @@ #include "pci_impl.h"
 
 
 struct hwrpb_struct *hwrpb;
+EXPORT_SYMBOL(hwrpb);
 unsigned long srm_hae;
 
 int alpha_l1i_cacheshape;
@@ -111,6 +112,7 @@ unsigned long alpha_agpgart_size = DEFAU
 #ifdef CONFIG_ALPHA_GENERIC
 struct alpha_machine_vector alpha_mv;
 int alpha_using_srm;
+EXPORT_SYMBOL(alpha_using_srm);
 #endif
 
 static struct alpha_machine_vector *get_sysvec(unsigned long, unsigned long,
@@ -137,6 +139,8 @@ struct screen_info screen_info = {
 	.orig_video_points = 16
 };
 
+EXPORT_SYMBOL(screen_info);
+
 /*
  * The direct map I/O window, if any.  This should be the same
  * for all busses, since it's used by virt_to_bus.
@@ -144,6 +148,8 @@ struct screen_info screen_info = {
 
 unsigned long __direct_map_base;
 unsigned long __direct_map_size;
+EXPORT_SYMBOL(__direct_map_base);
+EXPORT_SYMBOL(__direct_map_size);
 
 /*
  * Declare all of the machine vectors.
diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 596780e..d1ec4f5 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -52,6 +52,7 @@ #endif
 
 /* A collection of per-processor data.  */
 struct cpuinfo_alpha cpu_data[NR_CPUS];
+EXPORT_SYMBOL(cpu_data);
 
 /* A collection of single bit ipi messages.  */
 static struct {
@@ -74,6 +75,7 @@ EXPORT_SYMBOL(cpu_online_map);
 
 int smp_num_probed;		/* Internal processor count */
 int smp_num_cpus = 1;		/* Number that came online.  */
+EXPORT_SYMBOL(smp_num_cpus);
 
 extern void calibrate_delay(void);
 
@@ -790,6 +792,7 @@ smp_call_function_on_cpu (void (*func) (
 
 	return 0;
 }
+EXPORT_SYMBOL(smp_call_function_on_cpu);
 
 int
 smp_call_function (void (*func) (void *info), void *info, int retry, int wait)
@@ -797,6 +800,7 @@ smp_call_function (void (*func) (void *i
 	return smp_call_function_on_cpu (func, info, retry, wait,
 					 cpu_online_map);
 }
+EXPORT_SYMBOL(smp_call_function);
 
 static void
 ipi_imb(void *ignored)
@@ -811,6 +815,7 @@ smp_imb(void)
 	if (on_each_cpu(ipi_imb, NULL, 1, 1))
 		printk(KERN_CRIT "smp_imb: timed out\n");
 }
+EXPORT_SYMBOL(smp_imb);
 
 static void
 ipi_flush_tlb_all(void *ignored)
@@ -866,6 +871,7 @@ flush_tlb_mm(struct mm_struct *mm)
 
 	preempt_enable();
 }
+EXPORT_SYMBOL(flush_tlb_mm);
 
 struct flush_tlb_page_struct {
 	struct vm_area_struct *vma;
@@ -918,6 +924,7 @@ flush_tlb_page(struct vm_area_struct *vm
 
 	preempt_enable();
 }
+EXPORT_SYMBOL(flush_tlb_page);
 
 void
 flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
@@ -925,6 +932,7 @@ flush_tlb_range(struct vm_area_struct *v
 	/* On the Alpha we always flush the whole user tlb.  */
 	flush_tlb_mm(vma->vm_mm);
 }
+EXPORT_SYMBOL(flush_tlb_range);
 
 static void
 ipi_flush_icache_page(void *x)
diff --git a/arch/alpha/kernel/time.c b/arch/alpha/kernel/time.c
index cf06665..d7053eb 100644
--- a/arch/alpha/kernel/time.c
+++ b/arch/alpha/kernel/time.c
@@ -57,6 +57,7 @@ #include "irq_impl.h"
 static int set_rtc_mmss(unsigned long);
 
 DEFINE_SPINLOCK(rtc_lock);
+EXPORT_SYMBOL(rtc_lock);
 
 #define TICK_SIZE (tick_nsec / 1000)
 
diff --git a/arch/alpha/mm/numa.c b/arch/alpha/mm/numa.c
index b826f58..e3e3806 100644
--- a/arch/alpha/mm/numa.c
+++ b/arch/alpha/mm/numa.c
@@ -13,12 +13,14 @@ #include <linux/bootmem.h>
 #include <linux/swap.h>
 #include <linux/initrd.h>
 #include <linux/pfn.h>
+#include <linux/module.h>
 
 #include <asm/hwrpb.h>
 #include <asm/pgalloc.h>
 
 pg_data_t node_data[MAX_NUMNODES];
 bootmem_data_t node_bdata[MAX_NUMNODES];
+EXPORT_SYMBOL(node_data);
 
 #undef DEBUG_DISCONTIG
 #ifdef DEBUG_DISCONTIG
-- 
1.4.2.GIT

