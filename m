Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVDAMwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVDAMwi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 07:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVDAMwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 07:52:38 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:13250 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S262727AbVDAMnZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 07:43:25 -0500
Subject: [RFC] : remove unreliable, unused and unmainained arch from kernel.
In-Reply-To: <11123574931907@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 16:11:33 +0400
Message-Id: <11123574932506@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Fri, 01 Apr 2005 16:43:24 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -ru ./linux-2.6.9-orig/arch/arm/Kconfig ./linux-2.6.9/arch/arm/Kconfig
--- ./linux-2.6.9-orig/arch/arm/Kconfig	2005-03-31 16:27:02.000000000 +0400
+++ ./linux-2.6.9/arch/arm/Kconfig	2005-03-31 17:41:31.000000000 +0400
@@ -278,7 +278,7 @@
 	  run faster if you say N here.
 
 	  See also the <file:Documentation/smp.tex>,
-	  <file:Documentation/smp.txt>, <file:Documentation/i386/IO-APIC.txt>,
+	  <file:Documentation/smp.txt>,
 	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
 	  <http://www.linuxdoc.org/docs.html#howto>.
 
diff -ru ./linux-2.6.9-orig/arch/ppc/boot/utils/mkbugboot.c ./linux-2.6.9/arch/ppc/boot/utils/mkbugboot.c
--- ./linux-2.6.9-orig/arch/ppc/boot/utils/mkbugboot.c	2005-03-31 16:27:00.000000000 +0400
+++ ./linux-2.6.9/arch/ppc/boot/utils/mkbugboot.c	2005-03-31 17:40:33.000000000 +0400
@@ -27,13 +27,8 @@
 #include <stdint.h>
 #endif
 
-#ifdef __i386__
-#define cpu_to_be32(x) le32_to_cpu(x)
-#define cpu_to_be16(x) le16_to_cpu(x)
-#else
 #define cpu_to_be32(x) (x)
 #define cpu_to_be16(x) (x)
-#endif
 
 #define cpu_to_le32(x) le32_to_cpu((x))
 unsigned long le32_to_cpu(unsigned long x)
diff -ru ./linux-2.6.9-orig/arch/ppc/boot/utils/mkprep.c ./linux-2.6.9/arch/ppc/boot/utils/mkprep.c
--- ./linux-2.6.9-orig/arch/ppc/boot/utils/mkprep.c	2005-03-31 16:27:00.000000000 +0400
+++ ./linux-2.6.9/arch/ppc/boot/utils/mkprep.c	2005-03-31 17:40:52.000000000 +0400
@@ -163,13 +163,8 @@
   bzero( block, sizeof block );
 
   /* set entry point and boot image size skipping over elf header */
-#ifdef __i386__
-  *entry = 0x400/*+65536*/;
-  *length = info.st_size-elfhdr_size+0x400;
-#else
   *entry = cpu_to_le32(0x400/*+65536*/);
   *length = cpu_to_le32(info.st_size-elfhdr_size+0x400);
-#endif /* __i386__ */
 
   /* sets magic number for msdos partition (used by linux) */
   block[510] = 0x55;
@@ -206,18 +201,10 @@
   pe.beginning_sector  = cpu_to_le32(1);
 #else
   /* This has to be 0 on the PowerStack? */
-#ifdef __i386__
-  pe.beginning_sector  = 0;
-#else
   pe.beginning_sector  = cpu_to_le32(0);
-#endif /* __i386__ */
 #endif
 
-#ifdef __i386__
-  pe.number_of_sectors = 2*18*80-1;
-#else
   pe.number_of_sectors = cpu_to_le32(2*18*80-1);
-#endif /* __i386__ */
 
   memcpy(&block[0x1BE], &pe, sizeof(pe));
 
diff -ru ./linux-2.6.9-orig/arch/um/Makefile-x86_64 ./linux-2.6.9/arch/um/Makefile-x86_64
--- ./linux-2.6.9-orig/arch/um/Makefile-x86_64	2005-03-31 16:27:10.000000000 +0400
+++ ./linux-2.6.9/arch/um/Makefile-x86_64	2005-03-31 17:43:05.000000000 +0400
@@ -7,7 +7,7 @@
 CFLAGS += -U__$(SUBARCH)__ -fno-builtin
 ARCH_USER_CFLAGS := -D__x86_64__
 
-ELF_ARCH := i386:x86-64
+ELF_ARCH := x86-64
 ELF_FORMAT := elf64-x86-64
 
 SYS_UTIL_DIR := $(ARCH_DIR)/sys-x86_64/util
diff -ru ./linux-2.6.9-orig/arch/um/os-Linux/user_syms.c ./linux-2.6.9/arch/um/os-Linux/user_syms.c
--- ./linux-2.6.9-orig/arch/um/os-Linux/user_syms.c	2005-03-31 16:27:10.000000000 +0400
+++ ./linux-2.6.9/arch/um/os-Linux/user_syms.c	2005-03-31 17:42:32.000000000 +0400
@@ -34,11 +34,6 @@
        int sym(void);                  \
        EXPORT_SYMBOL(sym);
 
-#ifdef SUBARCH_i386
-EXPORT_SYMBOL(vsyscall_ehdr);
-EXPORT_SYMBOL(vsyscall_end);
-#endif
-
 EXPORT_SYMBOL_PROTO(__errno_location);
 
 EXPORT_SYMBOL_PROTO(access);
diff -ru ./linux-2.6.9-orig/arch/x86_64/kernel/acpi/Makefile ./linux-2.6.9/arch/x86_64/kernel/acpi/Makefile
--- ./linux-2.6.9-orig/arch/x86_64/kernel/acpi/Makefile	2005-03-31 16:27:10.000000000 +0400
+++ ./linux-2.6.9/arch/x86_64/kernel/acpi/Makefile	2005-03-31 17:44:14.000000000 +0400
@@ -1,3 +1 @@
-obj-$(CONFIG_ACPI_BOOT)		:= boot.o
-boot-$(CONFIG_ACPI_BOOT)	:= ../../../i386/kernel/acpi/boot.o
 obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup.o
diff -ru ./linux-2.6.9-orig/arch/x86_64/kernel/early_printk.c ./linux-2.6.9/arch/x86_64/kernel/early_printk.c
--- ./linux-2.6.9-orig/arch/x86_64/kernel/early_printk.c	2005-03-31 16:27:10.000000000 +0400
+++ ./linux-2.6.9/arch/x86_64/kernel/early_printk.c	2005-03-31 17:45:58.000000000 +0400
@@ -7,11 +7,7 @@
 
 /* Simple VGA output */
 
-#ifdef __i386__
-#define VGABASE		(__ISA_IO_base + 0xb8000)
-#else
 #define VGABASE		((void __iomem *)0xffffffff800b8000UL)
-#endif
 
 #define MAX_YPOS	25
 #define MAX_XPOS	80
diff -ru ./linux-2.6.9-orig/arch/x86_64/kernel/Makefile ./linux-2.6.9/arch/x86_64/kernel/Makefile
--- ./linux-2.6.9-orig/arch/x86_64/kernel/Makefile	2005-03-31 16:27:10.000000000 +0400
+++ ./linux-2.6.9/arch/x86_64/kernel/Makefile	2005-03-31 18:53:34.000000000 +0400
@@ -11,8 +11,6 @@
 
 obj-$(CONFIG_X86_MCE)         += mce.o
 obj-$(CONFIG_X86_MCE_INTEL)	+= mce_intel.o
-obj-$(CONFIG_MTRR)		+= ../../i386/kernel/cpu/mtrr/
-obj-$(CONFIG_ACPI_BOOT)		+= acpi/
 obj-$(CONFIG_X86_MSR)		+= msr.o
 obj-$(CONFIG_MICROCODE)		+= microcode.o
 obj-$(CONFIG_X86_CPUID)		+= cpuid.o
diff -ru ./linux-2.6.9-orig/drivers/acpi/numa.c ./linux-2.6.9/drivers/acpi/numa.c
--- ./linux-2.6.9-orig/drivers/acpi/numa.c	2005-03-31 16:26:46.000000000 +0400
+++ ./linux-2.6.9/drivers/acpi/numa.c	2005-03-31 17:04:50.000000000 +0400
@@ -95,7 +95,7 @@
 
 	slit = (struct acpi_table_slit *) __va(phys_addr);
 
-	/* downcast just for %llu vs %lu for i386/ia64  */
+	/* downcast just for %llu vs %lu for ia64  */
 	localities = (u32) slit->localities;
 
 	acpi_numa_slit_init(slit);
diff -ru ./linux-2.6.9-orig/drivers/acpi/osl.c ./linux-2.6.9/drivers/acpi/osl.c
--- ./linux-2.6.9-orig/drivers/acpi/osl.c	2005-03-31 16:26:46.000000000 +0400
+++ ./linux-2.6.9/drivers/acpi/osl.c	2005-03-31 17:04:33.000000000 +0400
@@ -1017,7 +1017,7 @@
 u8
 acpi_os_readable(void *ptr, acpi_size len)
 {
-#if defined(__i386__) || defined(__x86_64__) 
+#if defined(__x86_64__) 
 	char tmp;
 	return !__get_user(tmp, (char __user *)ptr) && !__get_user(tmp, (char __user *)ptr + len - 1);
 #endif
diff -ru ./linux-2.6.9-orig/drivers/atm/eni.c ./linux-2.6.9/drivers/atm/eni.c
--- ./linux-2.6.9-orig/drivers/atm/eni.c	2005-03-31 16:26:57.000000000 +0400
+++ ./linux-2.6.9/drivers/atm/eni.c	2005-03-31 17:24:42.000000000 +0400
@@ -31,7 +31,7 @@
 #include "suni.h"
 #include "eni.h"
 
-#if !defined(__i386__) && !defined(__x86_64__)
+#if !defined(__x86_64__)
 #ifndef ioremap_nocache
 #define ioremap_nocache(X,Y) ioremap(X,Y)
 #endif 
diff -ru ./linux-2.6.9-orig/drivers/atm/fore200e.c ./linux-2.6.9/drivers/atm/fore200e.c
--- ./linux-2.6.9-orig/drivers/atm/fore200e.c	2005-03-31 16:26:58.000000000 +0400
+++ ./linux-2.6.9/drivers/atm/fore200e.c	2005-03-31 17:24:59.000000000 +0400
@@ -7,7 +7,7 @@
   Based on the PCA-200E driver from Uwe Dannowski (Uwe.Dannowski@inf.tu-dresden.de).
 
   This driver simultaneously supports PCA-200E and SBA-200E adapters
-  on i386, alpha (untested), powerpc, sparc and sparc64 architectures.
+  on alpha (untested), powerpc, sparc and sparc64 architectures.
 
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
diff -ru ./linux-2.6.9-orig/drivers/base/dmapool.c ./linux-2.6.9/drivers/base/dmapool.c
--- ./linux-2.6.9-orig/drivers/base/dmapool.c	2005-03-31 16:26:44.000000000 +0400
+++ ./linux-2.6.9/drivers/base/dmapool.c	2005-03-31 16:54:19.000000000 +0400
@@ -1,8 +1,6 @@
 
 #include <linux/device.h>
 #include <linux/mm.h>
-#include <asm/io.h>		/* Needed for i386 to build */
-#include <asm/scatterlist.h>	/* Needed for i386 to build */
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/slab.h>
diff -ru ./linux-2.6.9-orig/drivers/block/floppy.c ./linux-2.6.9/drivers/block/floppy.c
--- ./linux-2.6.9-orig/drivers/block/floppy.c	2005-03-31 16:26:56.000000000 +0400
+++ ./linux-2.6.9/drivers/block/floppy.c	2005-03-31 17:18:29.000000000 +0400
@@ -1832,7 +1832,7 @@
 	reset_fdc_info(0);
 
 	/* Pseudo-DMA may intercept 'reset finished' interrupt.  */
-	/* Irrelevant for systems with true DMA (i386).          */
+	/* Irrelevant for systems with true DMA.       		 */
 
 	flags = claim_dma_lock();
 	fd_disable_dma();
diff -ru ./linux-2.6.9-orig/drivers/char/agp/amd64-agp.c ./linux-2.6.9/drivers/char/agp/amd64-agp.c
--- ./linux-2.6.9-orig/drivers/char/agp/amd64-agp.c	2005-03-31 16:26:45.000000000 +0400
+++ ./linux-2.6.9/drivers/char/agp/amd64-agp.c	2005-03-31 16:57:49.000000000 +0400
@@ -370,7 +370,6 @@
 		if (fix_northbridge(loop_dev, pdev, cap_ptr) < 0) {
 			printk(KERN_ERR PFX "No usable aperture found.\n");
 #ifdef __x86_64__
-			/* should port this to i386 */
 			printk(KERN_ERR PFX "Consider rebooting with iommu=memaper=2 to get a good aperture.\n");
 #endif
 			return -1;
diff -ru ./linux-2.6.9-orig/drivers/char/drm/ati_pcigart.c ./linux-2.6.9/drivers/char/drm/ati_pcigart.c
--- ./linux-2.6.9-orig/drivers/char/drm/ati_pcigart.c	2005-03-31 16:26:45.000000000 +0400
+++ ./linux-2.6.9/drivers/char/drm/ati_pcigart.c	2005-03-31 16:57:01.000000000 +0400
@@ -194,7 +194,7 @@
 
 	ret = 1;
 
-#if defined(__i386__) || defined(__x86_64__)
+#if defined(__x86_64__)
 	wbinvd();
 #else
 	mb();
diff -ru ./linux-2.6.9-orig/drivers/char/drm/drm_init.c ./linux-2.6.9/drivers/char/drm/drm_init.c
--- ./linux-2.6.9-orig/drivers/char/drm/drm_init.c	2005-03-31 16:26:45.000000000 +0400
+++ ./linux-2.6.9/drivers/char/drm/drm_init.c	2005-03-31 16:56:20.000000000 +0400
@@ -42,9 +42,6 @@
  */
 int drm_cpu_valid(void)
 {
-#if defined(__i386__)
-	if (boot_cpu_data.x86 == 3) return 0; /* No cmpxchg on a 386 */
-#endif
 #if defined(__sparc__) && !defined(__sparc_v9__)
 	return 0; /* No cmpxchg before v9 sparc. */
 #endif
diff -ru ./linux-2.6.9-orig/drivers/char/drm/drm_proc.c ./linux-2.6.9/drivers/char/drm/drm_proc.c
--- ./linux-2.6.9-orig/drivers/char/drm/drm_proc.c	2005-03-31 16:26:45.000000000 +0400
+++ ./linux-2.6.9/drivers/char/drm/drm_proc.c	2005-03-31 16:56:46.000000000 +0400
@@ -473,9 +473,6 @@
 	int                   len  = 0;
 	drm_vma_entry_t	      *pt;
 	struct vm_area_struct *vma;
-#if defined(__i386__)
-	unsigned int	      pgprot;
-#endif
 
 	if (offset > DRM_PROC_LIMIT) {
 		*eof = 1;
@@ -502,19 +499,6 @@
 			       vma->vm_flags & VM_IO	   ? 'i' : '-',
 			       VM_OFFSET(vma));
 
-#if defined(__i386__)
-		pgprot = pgprot_val(vma->vm_page_prot);
-		DRM_PROC_PRINT(" %c%c%c%c%c%c%c%c%c",
-			       pgprot & _PAGE_PRESENT  ? 'p' : '-',
-			       pgprot & _PAGE_RW       ? 'w' : 'r',
-			       pgprot & _PAGE_USER     ? 'u' : 's',
-			       pgprot & _PAGE_PWT      ? 't' : 'b',
-			       pgprot & _PAGE_PCD      ? 'u' : 'c',
-			       pgprot & _PAGE_ACCESSED ? 'a' : '-',
-			       pgprot & _PAGE_DIRTY    ? 'd' : '-',
-			       pgprot & _PAGE_PSE      ? 'm' : 'k',
-			       pgprot & _PAGE_GLOBAL   ? 'g' : 'l' );
-#endif
 		DRM_PROC_PRINT("\n");
 	}
 
diff -ru ./linux-2.6.9-orig/drivers/char/drm/drm_vm.c ./linux-2.6.9/drivers/char/drm/drm_vm.c
--- ./linux-2.6.9-orig/drivers/char/drm/drm_vm.c	2005-03-31 16:26:45.000000000 +0400
+++ ./linux-2.6.9/drivers/char/drm/drm_vm.c	2005-03-31 16:56:33.000000000 +0400
@@ -575,7 +575,7 @@
 
 	if (!capable(CAP_SYS_ADMIN) && (map->flags & _DRM_READ_ONLY)) {
 		vma->vm_flags &= ~(VM_WRITE | VM_MAYWRITE);
-#if defined(__i386__) || defined(__x86_64__)
+#if defined(__x86_64__)
 		pgprot_val(vma->vm_page_prot) &= ~_PAGE_RW;
 #else
 				/* Ye gads this is ugly.  With more thought
@@ -604,7 +604,7 @@
 	case _DRM_FRAME_BUFFER:
 	case _DRM_REGISTERS:
 		if (VM_OFFSET(vma) >= __pa(high_memory)) {
-#if defined(__i386__) || defined(__x86_64__)
+#if defined(__x86_64__)
 			if (boot_cpu_data.x86 > 3 && map->type != _DRM_AGP) {
 				pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
 				pgprot_val(vma->vm_page_prot) &= ~_PAGE_PWT;
diff -ru ./linux-2.6.9-orig/drivers/char/ftape/lowlevel/ftape-calibr.c ./linux-2.6.9/drivers/char/ftape/lowlevel/ftape-calibr.c
--- ./linux-2.6.9-orig/drivers/char/ftape/lowlevel/ftape-calibr.c	2005-03-31 16:26:44.000000000 +0400
+++ ./linux-2.6.9/drivers/char/ftape/lowlevel/ftape-calibr.c	2005-03-31 16:55:18.000000000 +0400
@@ -34,8 +34,6 @@
 #elif defined(__x86_64__)
 # include <asm/msr.h>
 # include <asm/timex.h>
-#elif defined(__i386__)
-# include <linux/timex.h>
 #endif
 #include <linux/ftape.h>
 #include "../lowlevel/ftape-tracing.h"
@@ -44,7 +42,7 @@
 
 #undef DEBUG
 
-#if !defined(__alpha__) && !defined(__i386__) && !defined(__x86_64__)
+#if !defined(__alpha__) && !defined(__x86_64__)
 # error Ftape is not implemented for this architecture!
 #endif
 
@@ -79,25 +77,6 @@
 	unsigned long r;
 	rdtscl(r);
 	return r;
-#elif defined(__i386__)
-
-/*
- * Note that there is some time between counter underflowing and jiffies
- * increasing, so the code below won't always give correct output.
- * -Vojtech
- */
-
-	unsigned long flags;
-	__u16 lo;
-	__u16 hi;
-
-	spin_lock_irqsave(&calibr_lock, flags);
-	outb_p(0x00, 0x43);	/* latch the count ASAP */
-	lo = inb_p(0x40);	/* read the latched count */
-	lo |= inb(0x40) << 8;
-	hi = jiffies;
-	spin_unlock_irqrestore(&calibr_lock, flags);
-	return ((hi + 1) * (unsigned int) LATCH) - lo;  /* downcounter ! */
 #endif
 }
 
@@ -105,16 +84,6 @@
 {
 #if defined(__alpha__) || defined(__x86_64__)
 	return ftape_timestamp();
-#elif defined(__i386__)
-	unsigned int count;
- 	unsigned long flags;
- 
-	spin_lock_irqsave(&calibr_lock, flags);
- 	outb_p(0x00, 0x43);	/* latch the count ASAP */
-	count = inb_p(0x40);	/* read the latched count */
-	count |= inb(0x40) << 8;
-	spin_unlock_irqrestore(&calibr_lock, flags);
-	return (LATCH - count);	/* normal: downcounter */
 #endif
 }
 
@@ -122,15 +91,6 @@
 {
 #if defined(__alpha__) || defined(__x86_64__)
 	return (t1 - t0);
-#elif defined(__i386__)
-	/*
-	 * This is tricky: to work for both short and full ftape_timestamps
-	 * we'll have to discriminate between these.
-	 * If it _looks_ like short stamps with wrapping around we'll
-	 * asume it are. This will generate a small error if it really
-	 * was a (very large) delta from full ftape_timestamps.
-	 */
-	return (t1 <= t0 && t0 <= LATCH) ? t1 + LATCH - t0 : t1 - t0;
 #endif
 }
 
@@ -138,8 +98,6 @@
 {
 #if defined(__alpha__) || defined(__x86_64__)
 	return (ps_per_cycle * count) / 1000000UL;
-#elif defined(__i386__)
-	return (10000 * count) / ((CLOCK_TICK_RATE + 50) / 100);
 #endif
 }
 
@@ -147,8 +105,6 @@
 {
 	/*
 	 *  Calculate difference in usec for ftape_timestamp results t0 & t1.
-	 *  Note that on the i386 platform with short time-stamps, the
-	 *  maximum allowed timespan is 1/HZ or we'll lose ticks!
 	 */
 	return usecs(diff(t0, t1));
 }
@@ -202,11 +158,6 @@
 	unsigned int tc = 0;
 	unsigned int count;
 	unsigned int time;
-#if defined(__i386__)
-	unsigned int old_tc = 0;
-	unsigned int old_count = 1;
-	unsigned int old_time = 1;
-#endif
 	TRACE_FUN(ft_t_flow);
 
 	if (first_time) {             /* get idea of I/O performance */
@@ -252,19 +203,6 @@
 		if (time >= 100*1000) {
 			break;
 		}
-#elif defined(__i386__)
-		/*
-		 * increase the count until the resulting time nears 2/HZ,
-		 * then the tc will drop sharply because we lose LATCH counts.
-		 */
-		if (tc <= old_tc / 2) {
-			time = old_time;
-			count = old_count;
-			break;
-		}
-		old_tc = tc;
-		old_count = count;
-		old_time = time;
 #endif
 		count *= 2;
 	}
diff -ru ./linux-2.6.9-orig/drivers/char/mem.c ./linux-2.6.9/drivers/char/mem.c
--- ./linux-2.6.9-orig/drivers/char/mem.c	2005-03-31 16:26:46.000000000 +0400
+++ ./linux-2.6.9/drivers/char/mem.c	2005-03-31 17:01:51.000000000 +0400
@@ -42,34 +42,15 @@
  */
 static inline int uncached_access(struct file *file, unsigned long addr)
 {
-#if defined(__i386__)
-	/*
-	 * On the PPro and successors, the MTRRs are used to set
-	 * memory types for physical addresses outside main memory,
-	 * so blindly setting PCD or PWT on those pages is wrong.
-	 * For Pentiums and earlier, the surround logic should disable
-	 * caching for the high addresses through the KEN pin, but
-	 * we maintain the tradition of paranoia in this code.
-	 */
-	if (file->f_flags & O_SYNC)
-		return 1;
- 	return !( test_bit(X86_FEATURE_MTRR, boot_cpu_data.x86_capability) ||
-		  test_bit(X86_FEATURE_K6_MTRR, boot_cpu_data.x86_capability) ||
-		  test_bit(X86_FEATURE_CYRIX_ARR, boot_cpu_data.x86_capability) ||
-		  test_bit(X86_FEATURE_CENTAUR_MCR, boot_cpu_data.x86_capability) )
-	  && addr >= __pa(high_memory);
-#elif defined(__x86_64__)
+#if defined(__x86_64__)
 	/* 
 	 * This is broken because it can generate memory type aliases,
 	 * which can cause cache corruptions
-	 * But it is only available for root and we have to be bug-to-bug
-	 * compatible with i386.
+	 * But it is only available for root.
 	 */
 	if (file->f_flags & O_SYNC)
 		return 1;
-	/* same behaviour as i386. PAT always set to cached and MTRRs control the
-	   caching behaviour. 
-	   Hopefully a full PAT implementation will fix that soon. */	   
+	   /* Hopefully a full PAT implementation will fix that soon. */	   
 	return 0;
 #elif defined(CONFIG_IA64)
 	/*
diff -ru ./linux-2.6.9-orig/drivers/char/nvram.c ./linux-2.6.9/drivers/char/nvram.c
--- ./linux-2.6.9-orig/drivers/char/nvram.c	2005-03-31 16:26:45.000000000 +0400
+++ ./linux-2.6.9/drivers/char/nvram.c	2005-03-31 17:00:41.000000000 +0400
@@ -49,7 +49,7 @@
 /* select machine configuration */
 #if defined(CONFIG_ATARI)
 #  define MACH ATARI
-#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__)  /* and others?? */
+#elif defined(__x86_64__) || defined(__arm__)  /* and others?? */
 #define MACH PC
 #  if defined(CONFIG_COBALT)
 #    include <linux/cobalt-nvram.h>
diff -ru ./linux-2.6.9-orig/drivers/char/pcmcia/synclink_cs.c ./linux-2.6.9/drivers/char/pcmcia/synclink_cs.c
--- ./linux-2.6.9-orig/drivers/char/pcmcia/synclink_cs.c	2005-03-31 16:26:45.000000000 +0400
+++ ./linux-2.6.9/drivers/char/pcmcia/synclink_cs.c	2005-03-31 16:59:45.000000000 +0400
@@ -27,11 +27,7 @@
  */
 
 #define VERSION(ver,rel,seq) (((ver)<<16) | ((rel)<<8) | (seq))
-#if defined(__i386__)
-#  define BREAKPOINT() asm("   int $3");
-#else
 #  define BREAKPOINT() { }
-#endif
 
 #define MAX_DEVICE_COUNT 4
 
diff -ru ./linux-2.6.9-orig/drivers/char/random.c ./linux-2.6.9/drivers/char/random.c
--- ./linux-2.6.9-orig/drivers/char/random.c	2005-03-31 16:26:45.000000000 +0400
+++ ./linux-2.6.9/drivers/char/random.c	2005-03-31 16:58:46.000000000 +0400
@@ -412,25 +412,10 @@
  *
  *****************************************************************/
 
-/*
- * Unfortunately, while the GCC optimizer for the i386 understands how
- * to optimize a static rotate left of x bits, it doesn't know how to
- * deal with a variable rotate of x bits.  So we use a bit of asm magic.
- */
-#if (!defined (__i386__))
 static inline __u32 rotate_left(int i, __u32 word)
 {
 	return (word << i) | (word >> (32 - i));
 }
-#else
-static inline __u32 rotate_left(int i, __u32 word)
-{
-	__asm__("roll %%cl,%0"
-		:"=r" (word)
-		:"0" (word),"c" (i));
-	return word;
-}
-#endif
 
 /*
  * More asm magic....
@@ -996,7 +981,7 @@
 #if SHA_CODE_SIZE == 0
 	/*
 	 * Approximately 50% of the speed of the largest version, but
-	 * takes up 1/16 the space.  Saves about 6k on an i386 kernel.
+	 * takes up 1/16 the space.
 	 */
 	for (i = 0; i < 80; i++) {
 		if (i < 40) {
diff -ru ./linux-2.6.9-orig/drivers/char/rtc.c ./linux-2.6.9/drivers/char/rtc.c
--- ./linux-2.6.9-orig/drivers/char/rtc.c	2005-03-31 16:26:46.000000000 +0400
+++ ./linux-2.6.9/drivers/char/rtc.c	2005-03-31 17:03:02.000000000 +0400
@@ -82,10 +82,6 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-#if defined(__i386__)
-#include <asm/hpet.h>
-#endif
-
 #ifdef __sparc__
 #include <linux/pci.h>
 #include <asm/ebus.h>
diff -ru ./linux-2.6.9-orig/drivers/char/synclink.c ./linux-2.6.9/drivers/char/synclink.c
--- ./linux-2.6.9-orig/drivers/char/synclink.c	2005-03-31 16:26:45.000000000 +0400
+++ ./linux-2.6.9/drivers/char/synclink.c	2005-03-31 17:39:37.000000000 +0400
@@ -53,11 +53,7 @@
  * OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-#if defined(__i386__)
-#  define BREAKPOINT() asm("   int $3");
-#else
 #  define BREAKPOINT() { }
-#endif
 
 #define MAX_ISA_DEVICES 10
 #define MAX_PCI_DEVICES 10
diff -ru ./linux-2.6.9-orig/drivers/char/synclinkmp.c ./linux-2.6.9/drivers/char/synclinkmp.c
--- ./linux-2.6.9-orig/drivers/char/synclinkmp.c	2005-03-31 16:26:45.000000000 +0400
+++ ./linux-2.6.9/drivers/char/synclinkmp.c	2005-03-31 16:59:05.000000000 +0400
@@ -26,11 +26,7 @@
  */
 
 #define VERSION(ver,rel,seq) (((ver)<<16) | ((rel)<<8) | (seq))
-#if defined(__i386__)
-#  define BREAKPOINT() asm("   int $3");
-#else
 #  define BREAKPOINT() { }
-#endif
 
 #define MAX_DEVICES 12
 
diff -ru ./linux-2.6.9-orig/drivers/char/vt_ioctl.c ./linux-2.6.9/drivers/char/vt_ioctl.c
--- ./linux-2.6.9-orig/drivers/char/vt_ioctl.c	2005-03-31 16:26:46.000000000 +0400
+++ ./linux-2.6.9/drivers/char/vt_ioctl.c	2005-03-31 17:03:59.000000000 +0400
@@ -428,24 +428,8 @@
 		 *
 		 * XXX: you should never use these, just call ioperm directly..
 		 */
-#ifdef CONFIG_X86
-	case KDADDIO:
-	case KDDELIO:
-		/*
-		 * KDADDIO and KDDELIO may be able to add ports beyond what
-		 * we reject here, but to be safe...
-		 */
-		if (arg < GPFIRST || arg > GPLAST)
-			return -EINVAL;
-		return sys_ioperm(arg, 1, (cmd == KDADDIO)) ? -ENXIO : 0;
-
-	case KDENABIO:
-	case KDDISABIO:
-		return sys_ioperm(GPFIRST, GPNUM,
-				  (cmd == KDENABIO)) ? -ENXIO : 0;
-#endif
 
-	/* Linux m68k/i386 interface for setting the keyboard delay/repeat rate */
+	/* Linux m68k interface for setting the keyboard delay/repeat rate */
 		
 	case KDKBDREP:
 	{
diff -ru ./linux-2.6.9-orig/drivers/char/watchdog/Kconfig ./linux-2.6.9/drivers/char/watchdog/Kconfig
--- ./linux-2.6.9-orig/drivers/char/watchdog/Kconfig	2005-03-31 16:26:45.000000000 +0400
+++ ./linux-2.6.9/drivers/char/watchdog/Kconfig	2005-03-31 16:58:03.000000000 +0400
@@ -139,7 +139,7 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called sa1100_wdt.
 
-# X86 (i386 + ia64 + x86_64) Architecture
+# X86 (ia64 + x86_64) Architecture
 
 config ACQUIRE_WDT
 	tristate "Acquire SBC Watchdog Timer"
diff -ru ./linux-2.6.9-orig/drivers/ide/legacy/hd.c ./linux-2.6.9/drivers/ide/legacy/hd.c
--- ./linux-2.6.9-orig/drivers/ide/legacy/hd.c	2005-03-31 16:26:58.000000000 +0400
+++ ./linux-2.6.9/drivers/ide/legacy/hd.c	2005-03-31 17:25:23.000000000 +0400
@@ -724,62 +724,6 @@
 	device_timer.function = hd_times_out;
 	blk_queue_hardsect_size(hd_queue, 512);
 
-#ifdef __i386__
-	if (!NR_HD) {
-		extern struct drive_info drive_info;
-		unsigned char *BIOS = (unsigned char *) &drive_info;
-		unsigned long flags;
-		int cmos_disks;
-
-		for (drive=0 ; drive<2 ; drive++) {
-			hd_info[drive].cyl = *(unsigned short *) BIOS;
-			hd_info[drive].head = *(2+BIOS);
-			hd_info[drive].wpcom = *(unsigned short *) (5+BIOS);
-			hd_info[drive].ctl = *(8+BIOS);
-			hd_info[drive].lzone = *(unsigned short *) (12+BIOS);
-			hd_info[drive].sect = *(14+BIOS);
-#ifdef does_not_work_for_everybody_with_scsi_but_helps_ibm_vp
-			if (hd_info[drive].cyl && NR_HD == drive)
-				NR_HD++;
-#endif
-			BIOS += 16;
-		}
-
-	/*
-		We query CMOS about hard disks : it could be that 
-		we have a SCSI/ESDI/etc controller that is BIOS
-		compatible with ST-506, and thus showing up in our
-		BIOS table, but not register compatible, and therefore
-		not present in CMOS.
-
-		Furthermore, we will assume that our ST-506 drives
-		<if any> are the primary drives in the system, and 
-		the ones reflected as drive 1 or 2.
-
-		The first drive is stored in the high nibble of CMOS
-		byte 0x12, the second in the low nibble.  This will be
-		either a 4 bit drive type or 0xf indicating use byte 0x19 
-		for an 8 bit type, drive 1, 0x1a for drive 2 in CMOS.
-
-		Needless to say, a non-zero value means we have 
-		an AT controller hard disk for that drive.
-
-		Currently the rtc_lock is a bit academic since this
-		driver is non-modular, but someday... ?         Paul G.
-	*/
-
-		spin_lock_irqsave(&rtc_lock, flags);
-		cmos_disks = CMOS_READ(0x12);
-		spin_unlock_irqrestore(&rtc_lock, flags);
-
-		if (cmos_disks & 0xf0) {
-			if (cmos_disks & 0x0f)
-				NR_HD = 2;
-			else
-				NR_HD = 1;
-		}
-	}
-#endif /* __i386__ */
 #ifdef __arm__
 	if (!NR_HD) {
 		/* We don't know anything about the drive.  This means
diff -ru ./linux-2.6.9-orig/drivers/ide/pci/cmd64x.c ./linux-2.6.9/drivers/ide/pci/cmd64x.c
--- ./linux-2.6.9-orig/drivers/ide/pci/cmd64x.c	2005-03-31 16:26:58.000000000 +0400
+++ ./linux-2.6.9/drivers/ide/pci/cmd64x.c	2005-03-31 17:25:39.000000000 +0400
@@ -606,13 +606,6 @@
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
 
-#ifdef __i386__
-	if (dev->resource[PCI_ROM_RESOURCE].start) {
-		pci_write_config_byte(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
-	}
-#endif
-
 	switch(dev->device) {
 		case PCI_DEVICE_ID_CMD_643:
 			break;
@@ -662,11 +655,7 @@
 	(void) pci_write_config_byte(dev, DRWTIM0,  0x3f);
 	(void) pci_write_config_byte(dev, ARTTIM1,  0x40);
 	(void) pci_write_config_byte(dev, DRWTIM1,  0x3f);
-#ifdef __i386__
-	(void) pci_write_config_byte(dev, ARTTIM23, 0x1c);
-#else
 	(void) pci_write_config_byte(dev, ARTTIM23, 0x5c);
-#endif
 	(void) pci_write_config_byte(dev, DRWTIM23, 0x3f);
 	(void) pci_write_config_byte(dev, DRWTIM3,  0x3f);
 #ifdef CONFIG_PPC
diff -ru ./linux-2.6.9-orig/drivers/input/gameport/gameport.c ./linux-2.6.9/drivers/input/gameport/gameport.c
--- ./linux-2.6.9-orig/drivers/input/gameport/gameport.c	2005-03-31 16:26:57.000000000 +0400
+++ ./linux-2.6.9/drivers/input/gameport/gameport.c	2005-03-31 17:24:29.000000000 +0400
@@ -35,60 +35,12 @@
 static LIST_HEAD(gameport_list);
 static LIST_HEAD(gameport_dev_list);
 
-#ifdef __i386__
-
-#define DELTA(x,y)      ((y)-(x)+((y)<(x)?1193182/HZ:0))
-#define GET_TIME(x)     do { x = get_time_pit(); } while (0)
-
-static unsigned int get_time_pit(void)
-{
-	extern spinlock_t i8253_lock;
-	unsigned long flags;
-	unsigned int count;
-
-	spin_lock_irqsave(&i8253_lock, flags);
-	outb_p(0x00, 0x43);
-	count = inb_p(0x40);
-	count |= inb_p(0x40) << 8;
-	spin_unlock_irqrestore(&i8253_lock, flags);
-
-	return count;
-}
-
-#endif
-
 /*
  * gameport_measure_speed() measures the gameport i/o speed.
  */
 
 static int gameport_measure_speed(struct gameport *gameport)
 {
-#ifdef __i386__
-
-	unsigned int i, t, t1, t2, t3, tx;
-	unsigned long flags;
-
-	if (gameport_open(gameport, NULL, GAMEPORT_MODE_RAW))
-		return 0;
-
-	tx = 1 << 30;
-
-	for(i = 0; i < 50; i++) {
-		local_irq_save(flags);
-		GET_TIME(t1);
-		for(t = 0; t < 50; t++) gameport_read(gameport);
-		GET_TIME(t2);
-		GET_TIME(t3);
-		local_irq_restore(flags);
-		udelay(i * 10);
-		if ((t = DELTA(t2,t1) - DELTA(t3,t2)) < tx) tx = t;
-	}
-
-	gameport_close(gameport);
-	return 59659 / (tx < 1 ? 1 : tx);
-
-#else
-
 	unsigned int j, t = 0;
 
 	j = jiffies; while (j == jiffies);
@@ -96,8 +48,6 @@
 
 	gameport_close(gameport);
 	return t * HZ / 1000;
-
-#endif
 }
 
 static void gameport_find_dev(struct gameport *gameport)
diff -ru ./linux-2.6.9-orig/drivers/input/joystick/analog.c ./linux-2.6.9/drivers/input/joystick/analog.c
--- ./linux-2.6.9-orig/drivers/input/joystick/analog.c	2005-03-31 16:26:57.000000000 +0400
+++ ./linux-2.6.9/drivers/input/joystick/analog.c	2005-03-31 17:24:09.000000000 +0400
@@ -140,25 +140,7 @@
  * Time macros.
  */
 
-#ifdef __i386__
-#define GET_TIME(x)	do { if (cpu_has_tsc) rdtscl(x); else x = get_time_pit(); } while (0)
-#define DELTA(x,y)	(cpu_has_tsc ? ((y) - (x)) : ((x) - (y) + ((x) < (y) ? CLOCK_TICK_RATE / HZ : 0)))
-#define TIME_NAME	(cpu_has_tsc?"TSC":"PIT")
-static unsigned int get_time_pit(void)
-{
-        extern spinlock_t i8253_lock;
-        unsigned long flags;
-        unsigned int count;
-
-        spin_lock_irqsave(&i8253_lock, flags);
-        outb_p(0x00, 0x43);
-        count = inb_p(0x40);
-        count |= inb_p(0x40) << 8;
-        spin_unlock_irqrestore(&i8253_lock, flags);
-
-        return count;
-}
-#elif defined(__x86_64__)
+#if defined(__x86_64__)
 #define GET_TIME(x)	rdtscl(x)
 #define DELTA(x,y)	((y)-(x))
 #define TIME_NAME	"TSC"
diff -ru ./linux-2.6.9-orig/drivers/input/keyboard/atkbd.c ./linux-2.6.9/drivers/input/keyboard/atkbd.c
--- ./linux-2.6.9-orig/drivers/input/keyboard/atkbd.c	2005-03-31 16:26:57.000000000 +0400
+++ ./linux-2.6.9/drivers/input/keyboard/atkbd.c	2005-03-31 17:23:19.000000000 +0400
@@ -38,7 +38,7 @@
 module_param_named(set, atkbd_set, int, 0);
 MODULE_PARM_DESC(set, "Select keyboard code set (2 = default, 3 = PS/2 native)");
 
-#if defined(__i386__) || defined(__x86_64__) || defined(__hppa__)
+#if defined(__x86_64__) || defined(__hppa__)
 static int atkbd_reset;
 #else
 static int atkbd_reset = 1;
@@ -258,7 +258,7 @@
 	printk(KERN_DEBUG "atkbd.c: Received %02x flags %02x\n", data, flags);
 #endif
 
-#if !defined(__i386__) && !defined (__x86_64__)
+#if !defined (__x86_64__)
 	if ((flags & (SERIO_FRAME | SERIO_PARITY)) && (~flags & SERIO_TIMEOUT) && !atkbd->resend && atkbd->write) {
 		printk(KERN_WARNING "atkbd.c: frame/parity error: %02x\n", flags);
 		serio_write(serio, ATKBD_CMD_RESEND);
diff -ru ./linux-2.6.9-orig/drivers/input/serio/i8042-x86ia64io.h ./linux-2.6.9/drivers/input/serio/i8042-x86ia64io.h
--- ./linux-2.6.9-orig/drivers/input/serio/i8042-x86ia64io.h	2005-03-31 16:26:57.000000000 +0400
+++ ./linux-2.6.9/drivers/input/serio/i8042-x86ia64io.h	2005-03-31 17:23:45.000000000 +0400
@@ -63,31 +63,6 @@
 	outb(val, I8042_COMMAND_REG);
 }
 
-#if defined(__i386__)
-
-#include <linux/dmi.h>
-
-static struct dmi_system_id __initdata i8042_dmi_table[] = {
-	{
-		.ident = "Compaq Proliant 8500",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
-			DMI_MATCH(DMI_PRODUCT_NAME , "ProLiant"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "8500"),
-		},
-	},
-	{
-		.ident = "Compaq Proliant DL760",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
-			DMI_MATCH(DMI_PRODUCT_NAME , "ProLiant"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "DL760"),
-		},
-	},
-	{ }
-};
-#endif
-
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
@@ -290,11 +265,6 @@
         i8042_reset = 1;
 #endif
 
-#if defined(__i386__)
-	if (dmi_check_system(i8042_dmi_table))
-		i8042_noloop = 1;
-#endif
-
 	return 0;
 }
 
diff -ru ./linux-2.6.9-orig/drivers/isdn/i4l/isdn_audio.c ./linux-2.6.9/drivers/isdn/i4l/isdn_audio.c
--- ./linux-2.6.9-orig/drivers/isdn/i4l/isdn_audio.c	2005-03-31 16:26:52.000000000 +0400
+++ ./linux-2.6.9/drivers/isdn/i4l/isdn_audio.c	2005-03-31 17:17:37.000000000 +0400
@@ -195,21 +195,8 @@
 static inline void
 isdn_audio_tlookup(const u_char *table, u_char *buff, unsigned long n)
 {
-#ifdef __i386__
-	unsigned long d0, d1, d2, d3;
-	__asm__ __volatile__(
-		"cld\n"
-		"1:\tlodsb\n\t"
-		"xlatb\n\t"
-		"stosb\n\t"
-		"loop 1b\n\t"
-	:	"=&b"(d0), "=&c"(d1), "=&D"(d2), "=&S"(d3)
-	:	"0"((long) table), "1"(n), "2"((long) buff), "3"((long) buff)
-	:	"memory", "ax");
-#else
 	while (n--)
 		*buff = table[*(unsigned char *)buff], buff++;
-#endif
 }
 
 void
diff -ru ./linux-2.6.9-orig/drivers/macintosh/apm_emu.c ./linux-2.6.9/drivers/macintosh/apm_emu.c
--- ./linux-2.6.9-orig/drivers/macintosh/apm_emu.c	2005-03-31 16:26:59.000000000 +0400
+++ ./linux-2.6.9/drivers/macintosh/apm_emu.c	2005-03-31 17:28:33.000000000 +0400
@@ -2,8 +2,7 @@
  * 
  * Copyright 2001 Benjamin Herrenschmidt (benh@kernel.crashing.org)
  *
- * Lots of code inherited from apm.c, see appropriate notice in
- *  arch/i386/kernel/apm.c
+ * Lots of code inherited from apm.c
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
diff -ru ./linux-2.6.9-orig/drivers/md/raid6algos.c ./linux-2.6.9/drivers/md/raid6algos.c
--- ./linux-2.6.9-orig/drivers/md/raid6algos.c	2005-03-31 16:26:59.000000000 +0400
+++ ./linux-2.6.9/drivers/md/raid6algos.c	2005-03-31 17:28:01.000000000 +0400
@@ -51,14 +51,6 @@
 	&raid6_intx16,
 	&raid6_intx32,
 #endif
-#if defined(__i386__)
-	&raid6_mmxx1,
-	&raid6_mmxx2,
-	&raid6_sse1x1,
-	&raid6_sse1x2,
-	&raid6_sse2x1,
-	&raid6_sse2x2,
-#endif
 #if defined(__x86_64__)
 	&raid6_sse2x1,
 	&raid6_sse2x2,
diff -ru ./linux-2.6.9-orig/drivers/media/video/zoran_driver.c ./linux-2.6.9/drivers/media/video/zoran_driver.c
--- ./linux-2.6.9-orig/drivers/media/video/zoran_driver.c	2005-03-31 16:26:43.000000000 +0400
+++ ./linux-2.6.9/drivers/media/video/zoran_driver.c	2005-03-31 16:54:09.000000000 +0400
@@ -4556,7 +4556,6 @@
 				pos =
 				    le32_to_cpu((unsigned long) fh->jpg_buffers.
 				    buffer[i].frag_tab[2 * j]);
-				/* should just be pos on i386 */
 				page = virt_to_phys(bus_to_virt(pos))
 								>> PAGE_SHIFT;
 				if (remap_pfn_range(vma, start, page,
diff -ru ./linux-2.6.9-orig/drivers/mtd/devices/docprobe.c ./linux-2.6.9/drivers/mtd/devices/docprobe.c
--- ./linux-2.6.9-orig/drivers/mtd/devices/docprobe.c	2005-03-31 16:26:55.000000000 +0400
+++ ./linux-2.6.9/drivers/mtd/devices/docprobe.c	2005-03-31 17:17:50.000000000 +0400
@@ -66,7 +66,7 @@
 MODULE_PARM_DESC(doc_config_location, "Physical memory address at which to probe for DiskOnChip");
 
 static unsigned long __initdata doc_locations[] = {
-#if defined (__alpha__) || defined(__i386__) || defined(__x86_64__)
+#if defined (__alpha__) || defined(__x86_64__)
 #ifdef CONFIG_MTD_DOCPROBE_HIGH
 	0xfffc8000, 0xfffca000, 0xfffcc000, 0xfffce000, 
 	0xfffd0000, 0xfffd2000, 0xfffd4000, 0xfffd6000,
diff -ru ./linux-2.6.9-orig/drivers/mtd/nand/diskonchip.c ./linux-2.6.9/drivers/mtd/nand/diskonchip.c
--- ./linux-2.6.9-orig/drivers/mtd/nand/diskonchip.c	2005-03-31 16:26:55.000000000 +0400
+++ ./linux-2.6.9/drivers/mtd/nand/diskonchip.c	2005-03-31 17:18:02.000000000 +0400
@@ -40,7 +40,7 @@
 #endif
 
 static unsigned long __initdata doc_locations[] = {
-#if defined (__alpha__) || defined(__i386__) || defined(__x86_64__)
+#if defined (__alpha__) || defined(__x86_64__)
 #ifdef CONFIG_MTD_DISKONCHIP_PROBE_HIGH
 	0xfffc8000, 0xfffca000, 0xfffcc000, 0xfffce000, 
 	0xfffd0000, 0xfffd2000, 0xfffd4000, 0xfffd6000,
diff -ru ./linux-2.6.9-orig/drivers/net/fealnx.c ./linux-2.6.9/drivers/net/fealnx.c
--- ./linux-2.6.9-orig/drivers/net/fealnx.c	2005-03-31 16:26:40.000000000 +0400
+++ ./linux-2.6.9/drivers/net/fealnx.c	2005-03-31 16:51:27.000000000 +0400
@@ -900,23 +900,6 @@
 //   np->bcrvalue=0x38;           /* little-endian, 256 burst length */
 	np->bcrvalue = 0x10;	/* little-endian, 8 burst length */
 	np->crvalue = 0xe00;	/* rx 128 burst length */
-#elif defined(__i386__)
-#if defined(MODULE)
-// 89/9/1 modify, 
-//   np->bcrvalue=0x38;           /* little-endian, 256 burst length */
-	np->bcrvalue = 0x10;	/* little-endian, 8 burst length */
-	np->crvalue = 0xe00;	/* rx 128 burst length */
-#else
-	/* When not a module we can work around broken '486 PCI boards. */
-#define x86 boot_cpu_data.x86
-// 89/9/1 modify, 
-//   np->bcrvalue=(x86 <= 4 ? 0x10 : 0x38);
-	np->bcrvalue = 0x10;
-	np->crvalue = (x86 <= 4 ? 0xa00 : 0xe00);
-	if (x86 <= 4)
-		printk(KERN_INFO "%s: This is a 386/486 PCI system, setting burst "
-		       "length to %x.\n", dev->name, (x86 <= 4 ? 0x10 : 0x38));
-#endif
 #else
 // 89/9/1 modify,
 //   np->bcrvalue=0x38;
diff -ru ./linux-2.6.9-orig/drivers/net/hamachi.c ./linux-2.6.9/drivers/net/hamachi.c
--- ./linux-2.6.9-orig/drivers/net/hamachi.c	2005-03-31 16:26:41.000000000 +0400
+++ ./linux-2.6.9/drivers/net/hamachi.c	2005-03-31 16:51:49.000000000 +0400
@@ -1757,35 +1757,6 @@
 	writel(2, ioaddr + RxCmd);
 	writew(2, ioaddr + TxCmd);
 
-#ifdef __i386__
-	if (hamachi_debug > 2) {
-		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",
-			   (int)hmp->tx_ring_dma);
-		for (i = 0; i < TX_RING_SIZE; i++)
-			printk(" %c #%d desc. %8.8x %8.8x.\n",
-				   readl(ioaddr + TxCurPtr) == (long)&hmp->tx_ring[i] ? '>' : ' ',
-				   i, hmp->tx_ring[i].status_n_length, hmp->tx_ring[i].addr);
-		printk("\n"KERN_DEBUG "  Rx ring %8.8x:\n",
-			   (int)hmp->rx_ring_dma);
-		for (i = 0; i < RX_RING_SIZE; i++) {
-			printk(KERN_DEBUG " %c #%d desc. %4.4x %8.8x\n",
-				   readl(ioaddr + RxCurPtr) == (long)&hmp->rx_ring[i] ? '>' : ' ',
-				   i, hmp->rx_ring[i].status_n_length, hmp->rx_ring[i].addr);
-			if (hamachi_debug > 6) {
-				if (*(u8*)hmp->rx_skbuff[i]->tail != 0x69) {
-					u16 *addr = (u16 *)
-						hmp->rx_skbuff[i]->tail;
-					int j;
-
-					for (j = 0; j < 0x50; j++)
-						printk(" %4.4x", addr[j]);
-					printk("\n");
-				}
-			}
-		}
-	}
-#endif /* __i386__ debugging only */
-
 	free_irq(dev->irq, dev);
 
 	del_timer_sync(&hmp->timer);
diff -ru ./linux-2.6.9-orig/drivers/net/hamradio/baycom_epp.c ./linux-2.6.9/drivers/net/hamradio/baycom_epp.c
--- ./linux-2.6.9-orig/drivers/net/hamradio/baycom_epp.c	2005-03-31 16:26:39.000000000 +0400
+++ ./linux-2.6.9/drivers/net/hamradio/baycom_epp.c	2005-03-31 16:50:27.000000000 +0400
@@ -727,16 +727,7 @@
 
 /* --------------------------------------------------------------------- */
 
-#ifdef __i386__
-#include <asm/msr.h>
-#define GETTICK(x)                                                \
-({                                                                \
-	if (cpu_has_tsc)                                          \
-		rdtscl(x);                                        \
-})
-#else /* __i386__ */
 #define GETTICK(x)
-#endif /* __i386__ */
 
 static void epp_bh(struct net_device *dev)
 {
diff -ru ./linux-2.6.9-orig/drivers/net/starfire.c ./linux-2.6.9/drivers/net/starfire.c
--- ./linux-2.6.9-orig/drivers/net/starfire.c	2005-03-31 16:26:41.000000000 +0400
+++ ./linux-2.6.9/drivers/net/starfire.c	2005-03-31 16:52:02.000000000 +0400
@@ -271,7 +271,7 @@
  * This SUCKS.
  * We need a much better method to determine if dma_addr_t is 64-bit.
  */
-#if (defined(__i386__) && defined(CONFIG_HIGHMEM) && (LINUX_VERSION_CODE > 0x20500 || defined(CONFIG_HIGHMEM64G))) || defined(__x86_64__) || defined (__ia64__) || defined(__mips64__) || (defined(__mips__) && defined(CONFIG_HIGHMEM) && defined(CONFIG_64BIT_PHYS_ADDR))
+#if (defined(CONFIG_HIGHMEM) && (LINUX_VERSION_CODE > 0x20500 || defined(CONFIG_HIGHMEM64G))) || defined(__x86_64__) || defined (__ia64__) || defined(__mips64__) || (defined(__mips__) && defined(CONFIG_HIGHMEM) && defined(CONFIG_64BIT_PHYS_ADDR))
 /* 64-bit dma_addr_t */
 #define ADDR_64BITS	/* This chip uses 64 bit addresses. */
 #define cpu_to_dma(x) cpu_to_le64(x)
diff -ru ./linux-2.6.9-orig/drivers/net/sundance.c ./linux-2.6.9/drivers/net/sundance.c
--- ./linux-2.6.9-orig/drivers/net/sundance.c	2005-03-31 16:26:40.000000000 +0400
+++ ./linux-2.6.9/drivers/net/sundance.c	2005-03-31 16:51:03.000000000 +0400
@@ -1689,24 +1689,6 @@
 	tasklet_kill(&np->rx_tasklet);
 	tasklet_kill(&np->tx_tasklet);
 
-#ifdef __i386__
-	if (netif_msg_hw(np)) {
-		printk("\n"KERN_DEBUG"  Tx ring at %8.8x:\n",
-			   (int)(np->tx_ring_dma));
-		for (i = 0; i < TX_RING_SIZE; i++)
-			printk(" #%d desc. %4.4x %8.8x %8.8x.\n",
-				   i, np->tx_ring[i].status, np->tx_ring[i].frag[0].addr,
-				   np->tx_ring[i].frag[0].length);
-		printk("\n"KERN_DEBUG "  Rx ring %8.8x:\n",
-			   (int)(np->rx_ring_dma));
-		for (i = 0; i < /*RX_RING_SIZE*/4 ; i++) {
-			printk(KERN_DEBUG " #%d desc. %4.4x %4.4x %8.8x\n",
-				   i, np->rx_ring[i].status, np->rx_ring[i].frag[0].addr,
-				   np->rx_ring[i].frag[0].length);
-		}
-	}
-#endif /* __i386__ debugging only */
-
 	free_irq(dev->irq, dev);
 
 	del_timer_sync(&np->timer);
diff -ru ./linux-2.6.9-orig/drivers/net/tulip/tulip_core.c ./linux-2.6.9/drivers/net/tulip/tulip_core.c
--- ./linux-2.6.9-orig/drivers/net/tulip/tulip_core.c	2005-03-31 16:26:36.000000000 +0400
+++ ./linux-2.6.9/drivers/net/tulip/tulip_core.c	2005-03-31 16:45:23.000000000 +0400
@@ -90,7 +90,7 @@
 
 #if defined(__alpha__) || defined(__ia64__)
 static int csr0 = 0x01A00000 | 0xE000;
-#elif defined(__i386__) || defined(__powerpc__) || defined(__x86_64__)
+#elif defined(__powerpc__) || defined(__x86_64__)
 static int csr0 = 0x01A00000 | 0x8000;
 #elif defined(__sparc__) || defined(__hppa__)
 /* The UltraSparc PCI controllers will disconnect at every 64-byte
@@ -1570,10 +1570,6 @@
 			    dev->dev_addr, 6);
 		}
 #endif
-#if defined(__i386__)		/* Patch up x86 BIOS bug. */
-		if (last_irq)
-			irq = last_irq;
-#endif
 	}
 
 	for (i = 0; i < 6; i++)
diff -ru ./linux-2.6.9-orig/drivers/net/tulip/tulip.h ./linux-2.6.9/drivers/net/tulip/tulip.h
--- ./linux-2.6.9-orig/drivers/net/tulip/tulip.h	2005-03-31 16:26:36.000000000 +0400
+++ ./linux-2.6.9/drivers/net/tulip/tulip.h	2005-03-31 16:45:38.000000000 +0400
@@ -294,11 +294,7 @@
 
 #define RUN_AT(x) (jiffies + (x))
 
-#if defined(__i386__)			/* AKA get_unaligned() */
-#define get_u16(ptr) (*(u16 *)(ptr))
-#else
 #define get_u16(ptr) (((u8*)(ptr))[0] + (((u8*)(ptr))[1]<<8))
-#endif
 
 struct medialeaf {
 	u8 type;
diff -ru ./linux-2.6.9-orig/drivers/net/tulip/winbond-840.c ./linux-2.6.9/drivers/net/tulip/winbond-840.c
--- ./linux-2.6.9-orig/drivers/net/tulip/winbond-840.c	2005-03-31 16:26:36.000000000 +0400
+++ ./linux-2.6.9/drivers/net/tulip/winbond-840.c	2005-03-31 16:45:04.000000000 +0400
@@ -926,16 +926,7 @@
 		8000	16 longwords		0200 2 longwords	2000 32 longwords
 		C000	32  longwords		0400 4 longwords */
 
-#if defined (__i386__) && !defined(MODULE)
-	/* When not a module we can work around broken '486 PCI boards. */
-	if (boot_cpu_data.x86 <= 4) {
-		i |= 0x4800;
-		printk(KERN_INFO "%s: This is a 386/486 PCI system, setting cache "
-			   "alignment to 8 longwords.\n", dev->name);
-	} else {
-		i |= 0xE000;
-	}
-#elif defined(__powerpc__) || defined(__i386__) || defined(__alpha__) || defined(__ia64__) || defined(__x86_64__)
+#if defined(__powerpc__) || defined(__alpha__) || defined(__ia64__) || defined(__x86_64__)
 	i |= 0xE000;
 #elif defined(__sparc__)
 	i |= 0x4800;
@@ -1552,26 +1543,6 @@
 	if (ioread32(ioaddr + NetworkConfig) != 0xffffffff)
 		np->stats.rx_missed_errors += ioread32(ioaddr + RxMissed) & 0xffff;
 
-#ifdef __i386__
-	if (debug > 2) {
-		int i;
-
-		printk(KERN_DEBUG"  Tx ring at %8.8x:\n",
-			   (int)np->tx_ring);
-		for (i = 0; i < TX_RING_SIZE; i++)
-			printk(KERN_DEBUG " #%d desc. %4.4x %4.4x %8.8x.\n",
-				   i, np->tx_ring[i].length,
-				   np->tx_ring[i].status, np->tx_ring[i].buffer1);
-		printk("\n"KERN_DEBUG "  Rx ring %8.8x:\n",
-			   (int)np->rx_ring);
-		for (i = 0; i < RX_RING_SIZE; i++) {
-			printk(KERN_DEBUG " #%d desc. %4.4x %4.4x %8.8x\n",
-				   i, np->rx_ring[i].length,
-				   np->rx_ring[i].status, np->rx_ring[i].buffer1);
-		}
-	}
-#endif /* __i386__ debugging only */
-
 	del_timer_sync(&np->timer);
 
 	free_rxtx_rings(np);
diff -ru ./linux-2.6.9-orig/drivers/net/tulip/xircom_tulip_cb.c ./linux-2.6.9/drivers/net/tulip/xircom_tulip_cb.c
--- ./linux-2.6.9-orig/drivers/net/tulip/xircom_tulip_cb.c	2005-03-31 16:26:36.000000000 +0400
+++ ./linux-2.6.9/drivers/net/tulip/xircom_tulip_cb.c	2005-03-31 16:43:49.000000000 +0400
@@ -82,9 +82,6 @@
 static int csr0 = 0x01B00000 | 0x8000;
 #elif defined(__sparc__)
 static int csr0 = 0x01B00080 | 0x8000;
-#elif defined(__i386__)
-static int csr0 = 0x01A00000 | 0x8000;
-#else
 #warning Processor architecture undefined!
 static int csr0 = 0x00A00000 | 0x4800;
 #endif
diff -ru ./linux-2.6.9-orig/drivers/net/wan/sbni.c ./linux-2.6.9/drivers/net/wan/sbni.c
--- ./linux-2.6.9-orig/drivers/net/wan/sbni.c	2005-03-31 16:26:38.000000000 +0400
+++ ./linux-2.6.9/drivers/net/wan/sbni.c	2005-03-31 16:49:42.000000000 +0400
@@ -148,10 +148,6 @@
 static int  emancipate( struct net_device * );
 #endif
 
-#ifdef __i386__
-#define ASM_CRC 1
-#endif
-
 static const char  version[] =
 	"Granch SBNI12 driver ver 5.0.1  Jun 22 2001  Denis I.Timofeev.\n";
 
diff -ru ./linux-2.6.9-orig/drivers/net/wireless/wl3501_cs.c ./linux-2.6.9/drivers/net/wireless/wl3501_cs.c
--- ./linux-2.6.9-orig/drivers/net/wireless/wl3501_cs.c	2005-03-31 16:26:37.000000000 +0400
+++ ./linux-2.6.9/drivers/net/wireless/wl3501_cs.c	2005-03-31 16:45:54.000000000 +0400
@@ -62,9 +62,7 @@
 
 #include "wl3501.h"
 
-#ifndef __i386__
 #define slow_down_io()
-#endif
 
 /* For rough constant delay */
 #define WL3501_NOPLOOP(n) { int x = 0; while (x++ < n) slow_down_io(); }
diff -ru ./linux-2.6.9-orig/drivers/net/yellowfin.c ./linux-2.6.9/drivers/net/yellowfin.c
--- ./linux-2.6.9-orig/drivers/net/yellowfin.c	2005-03-31 16:26:40.000000000 +0400
+++ ./linux-2.6.9/drivers/net/yellowfin.c	2005-03-31 16:50:49.000000000 +0400
@@ -1267,41 +1267,6 @@
 
 	del_timer(&yp->timer);
 
-#if defined(__i386__)
-	if (yellowfin_debug > 2) {
-		printk("\n"KERN_DEBUG"  Tx ring at %8.8llx:\n",
-				(unsigned long long)yp->tx_ring_dma);
-		for (i = 0; i < TX_RING_SIZE*2; i++)
-			printk(" %c #%d desc. %8.8x %8.8x %8.8x %8.8x.\n",
-				   ioread32(ioaddr + TxPtr) == (long)&yp->tx_ring[i] ? '>' : ' ',
-				   i, yp->tx_ring[i].dbdma_cmd, yp->tx_ring[i].addr,
-				   yp->tx_ring[i].branch_addr, yp->tx_ring[i].result_status);
-		printk(KERN_DEBUG "  Tx status %p:\n", yp->tx_status);
-		for (i = 0; i < TX_RING_SIZE; i++)
-			printk("   #%d status %4.4x %4.4x %4.4x %4.4x.\n",
-				   i, yp->tx_status[i].tx_cnt, yp->tx_status[i].tx_errs,
-				   yp->tx_status[i].total_tx_cnt, yp->tx_status[i].paused);
-
-		printk("\n"KERN_DEBUG "  Rx ring %8.8llx:\n",
-				(unsigned long long)yp->rx_ring_dma);
-		for (i = 0; i < RX_RING_SIZE; i++) {
-			printk(KERN_DEBUG " %c #%d desc. %8.8x %8.8x %8.8x\n",
-				   ioread32(ioaddr + RxPtr) == (long)&yp->rx_ring[i] ? '>' : ' ',
-				   i, yp->rx_ring[i].dbdma_cmd, yp->rx_ring[i].addr,
-				   yp->rx_ring[i].result_status);
-			if (yellowfin_debug > 6) {
-				if (get_unaligned((u8*)yp->rx_ring[i].addr) != 0x69) {
-					int j;
-					for (j = 0; j < 0x50; j++)
-						printk(" %4.4x",
-							   get_unaligned(((u16*)yp->rx_ring[i].addr) + j));
-					printk("\n");
-				}
-			}
-		}
-	}
-#endif /* __i386__ debugging only */
-
 	free_irq(dev->irq, dev);
 
 	/* Free all the skbuffs in the Rx queue. */
diff -ru ./linux-2.6.9-orig/drivers/parisc/iosapic.c ./linux-2.6.9/drivers/parisc/iosapic.c
--- ./linux-2.6.9-orig/drivers/parisc/iosapic.c	2005-03-31 16:26:59.000000000 +0400
+++ ./linux-2.6.9/drivers/parisc/iosapic.c	2005-03-31 17:28:15.000000000 +0400
@@ -713,7 +713,7 @@
  * PCI only supports level triggered in order to share IRQ lines.
  * ergo I/O SAPIC must always issue EOI on parisc.
  *
- * i386/ia64 support ISA devices and have to deal with
+ * ia64 support ISA devices and have to deal with
  * edge-triggered interrupts too.
  */
 static void iosapic_end_irq(unsigned int irq)
diff -ru ./linux-2.6.9-orig/drivers/pci/hotplug/pciehp_pci.c ./linux-2.6.9/drivers/pci/hotplug/pciehp_pci.c
--- ./linux-2.6.9-orig/drivers/pci/hotplug/pciehp_pci.c	2005-03-31 16:26:42.000000000 +0400
+++ ./linux-2.6.9/drivers/pci/hotplug/pciehp_pci.c	2005-03-31 16:53:25.000000000 +0400
@@ -37,10 +37,6 @@
 #include <linux/pci.h>
 #include "../pci.h"
 #include "pciehp.h"
-#ifndef CONFIG_IA64
-#include "../../../arch/i386/pci/pci.h"    /* horrible hack showing how processor dependant we are... */
-#endif
-
 
 int pciehp_configure_device (struct controller* ctrl, struct pci_func* func)  
 {
diff -ru ./linux-2.6.9-orig/drivers/pci/hotplug/shpchp_pci.c ./linux-2.6.9/drivers/pci/hotplug/shpchp_pci.c
--- ./linux-2.6.9-orig/drivers/pci/hotplug/shpchp_pci.c	2005-03-31 16:26:41.000000000 +0400
+++ ./linux-2.6.9/drivers/pci/hotplug/shpchp_pci.c	2005-03-31 16:53:09.000000000 +0400
@@ -37,9 +37,6 @@
 #include <linux/pci.h>
 #include "../pci.h"
 #include "shpchp.h"
-#ifndef CONFIG_IA64
-#include "../../../arch/i386/pci/pci.h"    /* horrible hack showing how processor dependant we are... */
-#endif
 
 int shpchp_configure_device (struct controller* ctrl, struct pci_func* func)  
 {
diff -ru ./linux-2.6.9-orig/drivers/pnp/manager.c ./linux-2.6.9/drivers/pnp/manager.c
--- ./linux-2.6.9-orig/drivers/pnp/manager.c	2005-03-31 16:26:58.000000000 +0400
+++ ./linux-2.6.9/drivers/pnp/manager.c	2005-03-31 17:26:09.000000000 +0400
@@ -124,7 +124,7 @@
 	unsigned long *start, *end, *flags;
 	int i;
 
-	/* IRQ priority: this table is good for i386 */
+	/* IRQ priority */
 	static unsigned short xtab[16] = {
 		5, 10, 11, 12, 9, 14, 15, 7, 3, 4, 13, 0, 1, 6, 8, 2
 	};
@@ -176,7 +176,7 @@
 	unsigned long *start, *end, *flags;
 	int i;
 
-	/* DMA priority: this table is good for i386 */
+	/* DMA priority */
 	static unsigned short xtab[8] = {
 		1, 3, 5, 6, 7, 0, 2, 4
 	};
diff -ru ./linux-2.6.9-orig/drivers/pnp/system.c ./linux-2.6.9/drivers/pnp/system.c
--- ./linux-2.6.9-orig/drivers/pnp/system.c	2005-03-31 16:26:58.000000000 +0400
+++ ./linux-2.6.9/drivers/pnp/system.c	2005-03-31 17:26:36.000000000 +0400
@@ -62,14 +62,6 @@
 			/* Do nothing */
 			continue;
 		if (pnp_port_start(dev, i) < 0x100)
-			/*
-			 * Below 0x100 is only standard PC hardware
-			 * (pics, kbd, timer, dma, ...)
-			 * We should not get resource conflicts there,
-			 * and the kernel reserves these anyway
-			 * (see arch/i386/kernel/setup.c).
-			 * So, do nothing
-			 */
 			continue;
 		if (pnp_port_end(dev, i) < pnp_port_start(dev, i))
 			/* invalid endpoint */
diff -ru ./linux-2.6.9-orig/drivers/sbus/char/bpp.c ./linux-2.6.9/drivers/sbus/char/bpp.c
--- ./linux-2.6.9-orig/drivers/sbus/char/bpp.c	2005-03-31 16:27:00.000000000 +0400
+++ ./linux-2.6.9/drivers/sbus/char/bpp.c	2005-03-31 17:29:10.000000000 +0400
@@ -25,10 +25,6 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-#if defined(__i386__)
-# include <asm/system.h>
-#endif
-
 #if defined(__sparc__)
 # include <linux/init.h>
 # include <linux/delay.h>         /* udelay() */
@@ -87,61 +83,6 @@
 
 static struct inst instances[BPP_NO];
 
-#if defined(__i386__)
-
-static const unsigned short base_addrs[BPP_NO] = { 0x278, 0x378, 0x3bc };
-
-/*
- * These are for data access.
- * Control lines accesses are hidden in set_bits() and get_bits().
- * The exception is the probe procedure, which is system-dependent.
- */
-#define bpp_outb_p(data, base)  outb_p((data), (base))
-#define bpp_inb(base)  inb(base)
-#define bpp_inb_p(base)  inb_p(base)
-
-/*
- * This method takes the pin values mask and sets the hardware pins to
- * the requested value: 1 == high voltage, 0 == low voltage. This
- * burries the annoying PC bit inversion and preserves the direction
- * flag.
- */
-static void set_pins(unsigned short pins, unsigned minor)
-{
-      unsigned char bits = instances[minor].direction;  /* == 0x20 */
-
-      if (! (pins & BPP_PP_nStrobe))   bits |= 1;
-      if (! (pins & BPP_PP_nAutoFd))   bits |= 2;
-      if (   pins & BPP_PP_nInit)      bits |= 4;
-      if (! (pins & BPP_PP_nSelectIn)) bits |= 8;
-
-      instances[minor].pp_state = bits;
-
-      outb_p(bits, base_addrs[minor]+2);
-}
-
-static unsigned short get_pins(unsigned minor)
-{
-      unsigned short bits = 0;
-
-      unsigned value = instances[minor].pp_state;
-      if (! (value & 0x01)) bits |= BPP_PP_nStrobe;
-      if (! (value & 0x02)) bits |= BPP_PP_nAutoFd;
-      if (value & 0x04)     bits |= BPP_PP_nInit;
-      if (! (value & 0x08)) bits |= BPP_PP_nSelectIn;
-
-      value = inb_p(base_addrs[minor]+1);
-      if (value & 0x08)     bits |= BPP_GP_nFault;
-      if (value & 0x10)     bits |= BPP_GP_Select;
-      if (value & 0x20)     bits |= BPP_GP_PError;
-      if (value & 0x40)     bits |= BPP_GP_nAck;
-      if (! (value & 0x80)) bits |= BPP_GP_Busy;
-
-      return bits;
-}
-
-#endif /* __i386__ */
-
 #if defined(__sparc__)
 
 /*
@@ -867,77 +808,6 @@
 	.release =	bpp_release,
 };
 
-#if defined(__i386__)
-
-#define collectLptPorts()  {}
-
-static void probeLptPort(unsigned idx)
-{
-      unsigned int testvalue;
-      const unsigned short lpAddr = base_addrs[idx];
-
-      instances[idx].present = 0;
-      instances[idx].enhanced = 0;
-      instances[idx].direction = 0;
-      instances[idx].mode = COMPATIBILITY;
-      instances[idx].wait_queue = 0;
-      instances[idx].run_length = 0;
-      instances[idx].run_flag = 0;
-      init_timer(&instances[idx].timer_list);
-      instances[idx].timer_list.function = bpp_wake_up;
-      if (!request_region(lpAddr,3, dev_name)) return;
-
-      /*
-       * First, make sure the instance exists. Do this by writing to
-       * the data latch and reading the value back. If the port *is*
-       * present, test to see if it supports extended-mode
-       * operation. This will be required for IEEE1284 reverse
-       * transfers.
-       */
-
-      outb_p(BPP_PROBE_CODE, lpAddr);
-      for (testvalue=0; testvalue<BPP_DELAY; testvalue++)
-            ;
-      testvalue = inb_p(lpAddr);
-      if (testvalue == BPP_PROBE_CODE) {
-            unsigned save;
-            instances[idx].present = 1;
-
-            save = inb_p(lpAddr+2);
-            for (testvalue=0; testvalue<BPP_DELAY; testvalue++)
-                  ;
-            outb_p(save|0x20, lpAddr+2);
-            for (testvalue=0; testvalue<BPP_DELAY; testvalue++)
-                  ;
-            outb_p(~BPP_PROBE_CODE, lpAddr);
-            for (testvalue=0; testvalue<BPP_DELAY; testvalue++)
-                  ;
-            testvalue = inb_p(lpAddr);
-            if ((testvalue&0xff) == (0xff&~BPP_PROBE_CODE))
-                  instances[idx].enhanced = 0;
-            else
-                  instances[idx].enhanced = 1;
-            outb_p(save, lpAddr+2);
-      }
-      else {
-            release_region(lpAddr,3);
-      }
-      /*
-       * Leave the port in compat idle mode.
-       */
-      set_pins(BPP_PP_nAutoFd|BPP_PP_nStrobe|BPP_PP_nInit, idx);
-
-      printk("bpp%d: Port at 0x%03x: Enhanced mode %s\n", idx, base_addrs[idx],
-            instances[idx].enhanced? "SUPPORTED" : "UNAVAILABLE");
-}
-
-static inline void freeLptPort(int idx)
-{
-      release_region(base_addrs[idx], 3);
-}
-
-#endif
-
 #if defined(__sparc__)
 
 static void __iomem *map_bpp(struct sbus_dev *dev, int idx)
diff -ru ./linux-2.6.9-orig/drivers/scsi/aic7xxx/aic79xx_osm.c ./linux-2.6.9/drivers/scsi/aic7xxx/aic79xx_osm.c
--- ./linux-2.6.9-orig/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-03-31 16:26:50.000000000 +0400
+++ ./linux-2.6.9/drivers/scsi/aic7xxx/aic79xx_osm.c	2005-03-31 17:09:14.000000000 +0400
@@ -713,17 +713,10 @@
 static int	   ahd_linux_slave_alloc(Scsi_Device *);
 static int	   ahd_linux_slave_configure(Scsi_Device *);
 static void	   ahd_linux_slave_destroy(Scsi_Device *);
-#if defined(__i386__)
-static int	   ahd_linux_biosparam(struct scsi_device*,
-				       struct block_device*, sector_t, int[]);
-#endif
 #else
 static int	   ahd_linux_release(struct Scsi_Host *);
 static void	   ahd_linux_select_queue_depth(struct Scsi_Host *host,
 						Scsi_Device *scsi_devs);
-#if defined(__i386__)
-static int	   ahd_linux_biosparam(Disk *, kdev_t, int[]);
-#endif
 #endif
 static int	   ahd_linux_bus_reset(Scsi_Cmnd *);
 static int	   ahd_linux_dev_reset(Scsi_Cmnd *);
@@ -1125,71 +1118,6 @@
 }
 #endif
 
-#if defined(__i386__)
-/*
- * Return the disk geometry for the given SCSI device.
- */
-static int
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-ahd_linux_biosparam(struct scsi_device *sdev, struct block_device *bdev,
-		    sector_t capacity, int geom[])
-{
-	uint8_t *bh;
-#else
-ahd_linux_biosparam(Disk *disk, kdev_t dev, int geom[])
-{
-	struct	scsi_device *sdev = disk->device;
-	u_long	capacity = disk->capacity;
-	struct	buffer_head *bh;
-#endif
-	int	 heads;
-	int	 sectors;
-	int	 cylinders;
-	int	 ret;
-	int	 extended;
-	struct	 ahd_softc *ahd;
-
-	ahd = *((struct ahd_softc **)sdev->host->hostdata);
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-	bh = scsi_bios_ptable(bdev);
-#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,17)
-	bh = bread(MKDEV(MAJOR(dev), MINOR(dev) & ~0xf), 0, block_size(dev));
-#else
-	bh = bread(MKDEV(MAJOR(dev), MINOR(dev) & ~0xf), 0, 1024);
-#endif
-
-	if (bh) {
-		ret = scsi_partsize(bh, capacity,
-				    &geom[2], &geom[0], &geom[1]);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-		kfree(bh);
-#else
-		brelse(bh);
-#endif
-		if (ret != -1)
-			return (ret);
-	}
-	heads = 64;
-	sectors = 32;
-	cylinders = aic_sector_div(capacity, heads, sectors);
-
-	if (aic79xx_extended != 0)
-		extended = 1;
-	else
-		extended = (ahd->flags & AHD_EXTENDED_TRANS_A) != 0;
-	if (extended && cylinders >= 1024) {
-		heads = 255;
-		sectors = 63;
-		cylinders = aic_sector_div(capacity, heads, sectors);
-	}
-	geom[0] = heads;
-	geom[1] = sectors;
-	geom[2] = cylinders;
-	return (0);
-}
-#endif
-
 /*
  * Abort the current SCSI command(s).
  */
@@ -1613,9 +1541,6 @@
 	.eh_abort_handler	= ahd_linux_abort,
 	.eh_device_reset_handler = ahd_linux_dev_reset,
 	.eh_bus_reset_handler	= ahd_linux_bus_reset,
-#if defined(__i386__)
-	.bios_param		= ahd_linux_biosparam,
-#endif
 	.can_queue		= AHD_MAX_QUEUE,
 	.this_id		= -1,
 	.cmd_per_lun		= 2,
diff -ru ./linux-2.6.9-orig/drivers/scsi/aic7xxx/aic7xxx_osm.c ./linux-2.6.9/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- ./linux-2.6.9-orig/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-03-31 16:26:50.000000000 +0400
+++ ./linux-2.6.9/drivers/scsi/aic7xxx/aic7xxx_osm.c	2005-03-31 17:08:18.000000000 +0400
@@ -732,18 +732,10 @@
 static int	   ahc_linux_slave_alloc(Scsi_Device *);
 static int	   ahc_linux_slave_configure(Scsi_Device *);
 static void	   ahc_linux_slave_destroy(Scsi_Device *);
-#if defined(__i386__)
-static int	   ahc_linux_biosparam(struct scsi_device*,
-				       struct block_device*,
-				       sector_t, int[]);
-#endif
 #else
 static int	   ahc_linux_release(struct Scsi_Host *);
 static void	   ahc_linux_select_queue_depth(struct Scsi_Host *host,
 						Scsi_Device *scsi_devs);
-#if defined(__i386__)
-static int	   ahc_linux_biosparam(Disk *, kdev_t, int[]);
-#endif
 #endif
 static int	   ahc_linux_bus_reset(Scsi_Cmnd *);
 static int	   ahc_linux_dev_reset(Scsi_Cmnd *);
@@ -1132,75 +1124,6 @@
 }
 #endif
 
-#if defined(__i386__)
-/*
- * Return the disk geometry for the given SCSI device.
- */
-static int
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-ahc_linux_biosparam(struct scsi_device *sdev, struct block_device *bdev,
-		    sector_t capacity, int geom[])
-{
-	uint8_t *bh;
-#else
-ahc_linux_biosparam(Disk *disk, kdev_t dev, int geom[])
-{
-	struct	scsi_device *sdev = disk->device;
-	u_long	capacity = disk->capacity;
-	struct	buffer_head *bh;
-#endif
-	int	 heads;
-	int	 sectors;
-	int	 cylinders;
-	int	 ret;
-	int	 extended;
-	struct	 ahc_softc *ahc;
-	u_int	 channel;
-
-	ahc = *((struct ahc_softc **)sdev->host->hostdata);
-	channel = sdev->channel;
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-	bh = scsi_bios_ptable(bdev);
-#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,17)
-	bh = bread(MKDEV(MAJOR(dev), MINOR(dev) & ~0xf), 0, block_size(dev));
-#else
-	bh = bread(MKDEV(MAJOR(dev), MINOR(dev) & ~0xf), 0, 1024);
-#endif
-
-	if (bh) {
-		ret = scsi_partsize(bh, capacity,
-				    &geom[2], &geom[0], &geom[1]);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-		kfree(bh);
-#else
-		brelse(bh);
-#endif
-		if (ret != -1)
-			return (ret);
-	}
-	heads = 64;
-	sectors = 32;
-	cylinders = aic_sector_div(capacity, heads, sectors);
-
-	if (aic7xxx_extended != 0)
-		extended = 1;
-	else if (channel == 0)
-		extended = (ahc->flags & AHC_EXTENDED_TRANS_A) != 0;
-	else
-		extended = (ahc->flags & AHC_EXTENDED_TRANS_B) != 0;
-	if (extended && cylinders >= 1024) {
-		heads = 255;
-		sectors = 63;
-		cylinders = aic_sector_div(capacity, heads, sectors);
-	}
-	geom[0] = heads;
-	geom[1] = sectors;
-	geom[2] = cylinders;
-	return (0);
-}
-#endif
-
 /*
  * Abort the current SCSI command(s).
  */
@@ -1262,9 +1185,6 @@
 	.eh_abort_handler	= ahc_linux_abort,
 	.eh_device_reset_handler = ahc_linux_dev_reset,
 	.eh_bus_reset_handler	= ahc_linux_bus_reset,
-#if defined(__i386__)
-	.bios_param		= ahc_linux_biosparam,
-#endif
 	.can_queue		= AHC_MAX_QUEUE,
 	.this_id		= -1,
 	.cmd_per_lun		= 2,
diff -ru ./linux-2.6.9-orig/drivers/scsi/aic7xxx/aic7xxx_osm.h ./linux-2.6.9/drivers/scsi/aic7xxx/aic7xxx_osm.h
--- ./linux-2.6.9-orig/drivers/scsi/aic7xxx/aic7xxx_osm.h	2005-03-31 16:26:50.000000000 +0400
+++ ./linux-2.6.9/drivers/scsi/aic7xxx/aic7xxx_osm.h	2005-03-31 17:08:32.000000000 +0400
@@ -809,7 +809,7 @@
 
 /**************************** VL/EISA Routines ********************************/
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0) \
-  && (defined(__i386__) || defined(__alpha__)) \
+  && defined(__alpha__) \
   && (!defined(CONFIG_EISA)))
 #define CONFIG_EISA
 #endif
diff -ru ./linux-2.6.9-orig/drivers/scsi/aic7xxx_old.c ./linux-2.6.9/drivers/scsi/aic7xxx_old.c
--- ./linux-2.6.9-orig/drivers/scsi/aic7xxx_old.c	2005-03-31 16:26:52.000000000 +0400
+++ ./linux-2.6.9/drivers/scsi/aic7xxx_old.c	2005-03-31 17:17:20.000000000 +0400
@@ -265,7 +265,7 @@
 #  define FALSE 0
 #endif
 
-#if defined(__powerpc__) || defined(__i386__) || defined(__x86_64__)
+#if defined(__powerpc__) || defined(__x86_64__)
 #  define MMAPIO
 #endif
 
@@ -6813,7 +6813,7 @@
  *   we #ifdef this entire function to avoid compiler warnings about
  *   an unused function.
  *-F*************************************************************************/
-#if defined(__i386__) || defined(__alpha__)
+#if defined(__alpha__)
 static int
 aic7xxx_probe(int slot, int base, ahc_flag_type *flags)
 {
@@ -6873,7 +6873,7 @@
 
   return (-1);
 }
-#endif /* (__i386__) || (__alpha__) */
+#endif /* (__alpha__) */
 
 
 /*+F*************************************************************************
@@ -8999,12 +8999,12 @@
   struct aic7xxx_host *current_p = NULL;
   struct aic7xxx_host *list_p = NULL;
   int found = 0;
-#if defined(__i386__) || defined(__alpha__)
+#if defined(__alpha__)
   ahc_flag_type flags = 0;
   int type;
 #endif
   unsigned char sxfrctl1;
-#if defined(__i386__) || defined(__alpha__)
+#if defined(__alpha__)
   unsigned char hcntrl, hostconf;
   unsigned int slot, base;
 #endif
@@ -9687,7 +9687,7 @@
   }
 #endif /* CONFIG_PCI */
 
-#if defined(__i386__) || defined(__alpha__)
+#if defined(__alpha__)
   /*
    * EISA/VL-bus card signature probe.
    */
@@ -9916,7 +9916,7 @@
     found++;
   }
 
-#endif /* defined(__i386__) || defined(__alpha__) */
+#endif /* defined(__alpha__) */
 
   /*
    * Now, we re-order the probed devices by BIOS address and BUS class.
diff -ru ./linux-2.6.9-orig/drivers/scsi/BusLogic.h ./linux-2.6.9/drivers/scsi/BusLogic.h
--- ./linux-2.6.9-orig/drivers/scsi/BusLogic.h	2005-03-31 16:26:51.000000000 +0400
+++ ./linux-2.6.9/drivers/scsi/BusLogic.h	2005-03-31 17:13:39.000000000 +0400
@@ -39,10 +39,8 @@
   CONFIG_PCI set.
 */
 
-#ifndef __i386__
 #undef CONFIG_SCSI_OMIT_FLASHPOINT
 #define CONFIG_SCSI_OMIT_FLASHPOINT
-#endif
 
 #ifndef CONFIG_PCI
 #undef CONFIG_SCSI_OMIT_FLASHPOINT
diff -ru ./linux-2.6.9-orig/drivers/scsi/dpt_i2o.c ./linux-2.6.9/drivers/scsi/dpt_i2o.c
--- ./linux-2.6.9-orig/drivers/scsi/dpt_i2o.c	2005-03-31 16:26:51.000000000 +0400
+++ ./linux-2.6.9/drivers/scsi/dpt_i2o.c	2005-03-31 17:14:17.000000000 +0400
@@ -83,9 +83,7 @@
  */
 static dpt_sig_S DPTI_sig = {
 	{'d', 'P', 't', 'S', 'i', 'G'}, SIG_VERSION,
-#ifdef __i386__
-	PROC_INTEL, PROC_386 | PROC_486 | PROC_PENTIUM | PROC_SEXIUM,
-#elif defined(__ia64__)
+#if defined(__ia64__)
 	PROC_INTEL, PROC_IA64,
 #elif defined(__sparc__)
 	PROC_ULTRASPARC, PROC_ULTRASPARC,
@@ -1831,9 +1829,7 @@
 	si.busType = SI_PCI_BUS;
 	si.processorFamily = DPTI_sig.dsProcessorFamily;
 
-#if defined __i386__ 
-	adpt_i386_info(&si);
-#elif defined (__ia64__)
+#if defined (__ia64__)
 	adpt_ia64_info(&si);
 #elif defined(__sparc__)
 	adpt_sparc_info(&si);
@@ -1881,32 +1877,6 @@
 }
 #endif
 
-#if defined __i386__
-
-static void adpt_i386_info(sysInfo_S* si)
-{
-	// This is all the info we need for now
-	// We will add more info as our new
-	// managmenent utility requires it
-	switch (boot_cpu_data.x86) {
-	case CPU_386:
-		si->processorType = PROC_386;
-		break;
-	case CPU_486:
-		si->processorType = PROC_486;
-		break;
-	case CPU_586:
-		si->processorType = PROC_PENTIUM;
-		break;
-	default:  // Just in case 
-		si->processorType = PROC_PENTIUM;
-		break;
-	}
-}
-
-#endif
-
-
 static int adpt_ioctl(struct inode *inode, struct file *file, uint cmd,
 	      ulong arg)
 {
diff -ru ./linux-2.6.9-orig/drivers/scsi/dpti.h ./linux-2.6.9/drivers/scsi/dpti.h
--- ./linux-2.6.9-orig/drivers/scsi/dpti.h	2005-03-31 16:26:50.000000000 +0400
+++ ./linux-2.6.9/drivers/scsi/dpti.h	2005-03-31 17:09:25.000000000 +0400
@@ -334,9 +334,6 @@
 #if defined __alpha__ 
 static void adpt_sparc_info(sysInfo_S* si);
 #endif
-#if defined __i386__
-static void adpt_i386_info(sysInfo_S* si);
-#endif
 
 #define PRINT_BUFFER_SIZE     512
 


