Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbTBENku>; Wed, 5 Feb 2003 08:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbTBENku>; Wed, 5 Feb 2003 08:40:50 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:9103 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S261286AbTBENkd>; Wed, 5 Feb 2003 08:40:33 -0500
Message-ID: <3E41168C.4030305@quark.didntduck.org>
Date: Wed, 05 Feb 2003 08:50:04 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Break up i386_ksyms.c
Content-Type: multipart/mixed;
 boundary="------------070401030907080006090403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070401030907080006090403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

With the new scheme of exporting symbols to modules, it is no longer 
necessary to keep these jumbo symbol export modules around.  This patch 
breaks up i386_ksyms.c and puts the EXPORT_SYMBOL declarations with the 
functions, leaving only symbols from asm files.

--
				Brian Gerst

--------------070401030907080006090403
Content-Type: text/plain;
 name="ksyms-i386"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksyms-i386"

diff -urN linux-2.5.59-bk1/arch/i386/kernel/dmi_scan.c linux/arch/i386/kernel/dmi_scan.c
--- linux-2.5.59-bk1/arch/i386/kernel/dmi_scan.c	2002-12-24 00:20:03.000000000 -0500
+++ linux/arch/i386/kernel/dmi_scan.c	2003-02-04 16:09:19.000000000 -0500
@@ -9,9 +9,11 @@
 #include <linux/pm.h>
 #include <asm/system.h>
 #include <linux/bootmem.h>
+#include <linux/module.h>
 
 unsigned long dmi_broken;
 int is_sony_vaio_laptop;
+EXPORT_SYMBOL(is_sony_vaio_laptop);
 int is_unsafe_smbus;
 
 struct dmi_header
diff -urN linux-2.5.59-bk1/arch/i386/kernel/i386_ksyms.c linux/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.59-bk1/arch/i386/kernel/i386_ksyms.c	2003-01-13 16:20:57.000000000 -0500
+++ linux/arch/i386/kernel/i386_ksyms.c	2003-02-04 16:08:36.000000000 -0500
@@ -1,216 +1,16 @@
-#include <linux/config.h>
 #include <linux/module.h>
-#include <linux/smp.h>
-#include <linux/user.h>
-#include <linux/elfcore.h>
-#include <linux/mca.h>
-#include <linux/sched.h>
-#include <linux/in6.h>
-#include <linux/interrupt.h>
-#include <linux/smp_lock.h>
-#include <linux/pm.h>
-#include <linux/pci.h>
-#include <linux/apm_bios.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/tty.h>
-#include <linux/highmem.h>
 
-#include <asm/semaphore.h>
-#include <asm/processor.h>
-#include <asm/i387.h>
-#include <asm/uaccess.h>
-#include <asm/checksum.h>
-#include <asm/io.h>
-#include <asm/hardirq.h>
-#include <asm/delay.h>
-#include <asm/irq.h>
-#include <asm/mmx.h>
 #include <asm/desc.h>
-#include <asm/pgtable.h>
-#include <asm/pgalloc.h>
-#include <asm/tlbflush.h>
-#include <asm/nmi.h>
-#include <asm/edd.h>
-
-extern void dump_thread(struct pt_regs *, struct user *);
-extern spinlock_t rtc_lock;
-
-/* This is definitely a GPL-only symbol */
 EXPORT_SYMBOL_GPL(cpu_gdt_table);
 
-#if defined(CONFIG_APM_MODULE)
-extern void machine_real_restart(unsigned char *, int);
-EXPORT_SYMBOL(machine_real_restart);
-extern void default_idle(void);
-EXPORT_SYMBOL(default_idle);
-#endif
-
-#ifdef CONFIG_SMP
-extern void FASTCALL( __write_lock_failed(rwlock_t *rw));
-extern void FASTCALL( __read_lock_failed(rwlock_t *rw));
-#endif
-
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_HD) || defined(CONFIG_BLK_DEV_IDE_MODULE) || defined(CONFIG_BLK_DEV_HD_MODULE)
-extern struct drive_info_struct drive_info;
-EXPORT_SYMBOL(drive_info);
-#endif
-
-extern unsigned long cpu_khz;
-extern unsigned long get_cmos_time(void);
-
-/* platform dependent support */
-EXPORT_SYMBOL(boot_cpu_data);
-#ifdef CONFIG_EISA
-EXPORT_SYMBOL(EISA_bus);
-#endif
-EXPORT_SYMBOL(MCA_bus);
-#ifdef CONFIG_DISCONTIGMEM
-EXPORT_SYMBOL(node_data);
-EXPORT_SYMBOL(pfn_to_nid);
-#endif
-#ifdef CONFIG_X86_NUMAQ
-EXPORT_SYMBOL(xquad_portio);
-#endif
-#ifndef CONFIG_X86_WP_WORKS_OK
-EXPORT_SYMBOL(__verify_write);
-#endif
-EXPORT_SYMBOL(dump_thread);
-EXPORT_SYMBOL(dump_fpu);
-EXPORT_SYMBOL(dump_extended_fpu);
-EXPORT_SYMBOL(__ioremap);
-EXPORT_SYMBOL(ioremap_nocache);
-EXPORT_SYMBOL(iounmap);
-EXPORT_SYMBOL(enable_irq);
-EXPORT_SYMBOL(disable_irq);
-EXPORT_SYMBOL(disable_irq_nosync);
-EXPORT_SYMBOL(probe_irq_mask);
-EXPORT_SYMBOL(kernel_thread);
-EXPORT_SYMBOL(pm_idle);
-EXPORT_SYMBOL(pm_power_off);
-EXPORT_SYMBOL(get_cmos_time);
-EXPORT_SYMBOL(cpu_khz);
-EXPORT_SYMBOL(apm_info);
-
-#ifdef CONFIG_DEBUG_IOVIRT
-EXPORT_SYMBOL(__io_virt_debug);
-#endif
-
-EXPORT_SYMBOL_NOVERS(__down_failed);
-EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
-EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
-EXPORT_SYMBOL_NOVERS(__up_wakeup);
-/* Networking helper routines. */
+#include <asm/checksum.h>
 EXPORT_SYMBOL(csum_partial_copy_generic);
-/* Delay loops */
-EXPORT_SYMBOL(__udelay);
-EXPORT_SYMBOL(__delay);
-EXPORT_SYMBOL(__const_udelay);
 
+#include <asm/uaccess.h>
 EXPORT_SYMBOL_NOVERS(__get_user_1);
 EXPORT_SYMBOL_NOVERS(__get_user_2);
 EXPORT_SYMBOL_NOVERS(__get_user_4);
 
+#include <linux/string.h>
 EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
-
-EXPORT_SYMBOL(strncpy_from_user);
-EXPORT_SYMBOL(__strncpy_from_user);
-EXPORT_SYMBOL(clear_user);
-EXPORT_SYMBOL(__clear_user);
-EXPORT_SYMBOL(__copy_from_user_ll);
-EXPORT_SYMBOL(__copy_to_user_ll);
-EXPORT_SYMBOL(strnlen_user);
-
-EXPORT_SYMBOL(dma_alloc_coherent);
-EXPORT_SYMBOL(dma_free_coherent);
-
-#ifdef CONFIG_PCI
-EXPORT_SYMBOL(pcibios_penalize_isa_irq);
-EXPORT_SYMBOL(pci_mem_start);
-#endif
-
-#ifdef CONFIG_PCI_BIOS
-EXPORT_SYMBOL(pcibios_set_irq_routing);
-EXPORT_SYMBOL(pcibios_get_irq_routing_table);
-#endif
-
-#ifdef CONFIG_X86_USE_3DNOW
-EXPORT_SYMBOL(_mmx_memcpy);
-EXPORT_SYMBOL(mmx_clear_page);
-EXPORT_SYMBOL(mmx_copy_page);
-#endif
-
-#ifdef CONFIG_X86_HT
-EXPORT_SYMBOL(smp_num_siblings);
-EXPORT_SYMBOL(cpu_sibling_map);
-#endif
-
-#ifdef CONFIG_SMP
-EXPORT_SYMBOL(cpu_data);
-EXPORT_SYMBOL(cpu_online_map);
-EXPORT_SYMBOL(cpu_callout_map);
-EXPORT_SYMBOL_NOVERS(__write_lock_failed);
-EXPORT_SYMBOL_NOVERS(__read_lock_failed);
-
-/* Global SMP stuff */
-EXPORT_SYMBOL(synchronize_irq);
-EXPORT_SYMBOL(smp_call_function);
-
-/* TLB flushing */
-EXPORT_SYMBOL(flush_tlb_page);
-#endif
-
-#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_PM)
-EXPORT_SYMBOL_GPL(set_nmi_pm_callback);
-EXPORT_SYMBOL_GPL(unset_nmi_pm_callback);
-#endif
-#ifdef CONFIG_X86_IO_APIC
-EXPORT_SYMBOL(IO_APIC_get_PCI_irq_vector);
-#endif
-
-#ifdef CONFIG_MCA
-EXPORT_SYMBOL(machine_id);
-#endif
-
-#ifdef CONFIG_VT
-EXPORT_SYMBOL(screen_info);
-#endif
-
-EXPORT_SYMBOL(get_wchan);
-
-EXPORT_SYMBOL(rtc_lock);
-
-EXPORT_SYMBOL_GPL(register_profile_notifier);
-EXPORT_SYMBOL_GPL(unregister_profile_notifier);
-EXPORT_SYMBOL_GPL(set_nmi_callback);
-EXPORT_SYMBOL_GPL(unset_nmi_callback);
- 
-#undef memcpy
-#undef memset
-extern void * memset(void *,int,__kernel_size_t);
-extern void * memcpy(void *,const void *,__kernel_size_t);
-EXPORT_SYMBOL_NOVERS(memcpy);
-EXPORT_SYMBOL_NOVERS(memset);
-
-#ifdef CONFIG_HAVE_DEC_LOCK
-EXPORT_SYMBOL(atomic_dec_and_lock);
-#endif
-
-extern int is_sony_vaio_laptop;
-EXPORT_SYMBOL(is_sony_vaio_laptop);
-
-EXPORT_SYMBOL(__PAGE_KERNEL);
-
-#ifdef CONFIG_HIGHMEM
-EXPORT_SYMBOL(kmap);
-EXPORT_SYMBOL(kunmap);
-EXPORT_SYMBOL(kmap_atomic);
-EXPORT_SYMBOL(kunmap_atomic);
-EXPORT_SYMBOL(kmap_atomic_to_page);
-#endif
-
-#ifdef CONFIG_EDD_MODULE
-EXPORT_SYMBOL(edd);
-EXPORT_SYMBOL(eddnr);
-#endif
diff -urN linux-2.5.59-bk1/arch/i386/kernel/i387.c linux/arch/i386/kernel/i387.c
--- linux-2.5.59-bk1/arch/i386/kernel/i387.c	2002-12-24 00:21:36.000000000 -0500
+++ linux/arch/i386/kernel/i387.c	2003-02-04 16:09:11.000000000 -0500
@@ -11,6 +11,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/module.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/math_emu.h>
@@ -523,6 +524,7 @@
 
 	return fpvalid;
 }
+EXPORT_SYMBOL(dump_fpu);
 
 int dump_extended_fpu( struct pt_regs *regs, struct user_fxsr_struct *fpu )
 {
@@ -538,6 +540,7 @@
 
 	return fpvalid;
 }
+EXPORT_SYMBOL(dump_extended_fpu);
 
 int dump_task_fpu(struct task_struct *tsk, struct user_i387_struct *fpu)
 {
diff -urN linux-2.5.59-bk1/arch/i386/kernel/io_apic.c linux/arch/i386/kernel/io_apic.c
--- linux-2.5.59-bk1/arch/i386/kernel/io_apic.c	2003-01-17 00:26:23.000000000 -0500
+++ linux/arch/i386/kernel/io_apic.c	2003-02-04 16:12:31.000000000 -0500
@@ -31,6 +31,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/compiler.h>
 #include <linux/acpi.h>
+#include <linux/module.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -415,6 +416,7 @@
 	}
 	return best_guess;
 }
+EXPORT_SYMBOL(IO_APIC_get_PCI_irq_vector);
 
 /*
  * EISA Edge/Level control register, ELCR
diff -urN linux-2.5.59-bk1/arch/i386/kernel/irq.c linux/arch/i386/kernel/irq.c
--- linux-2.5.59-bk1/arch/i386/kernel/irq.c	2003-02-04 15:58:52.000000000 -0500
+++ linux/arch/i386/kernel/irq.c	2003-02-04 16:07:28.000000000 -0500
@@ -32,6 +32,7 @@
 #include <linux/irq.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/module.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -189,6 +190,7 @@
 	while (irq_desc[irq].status & IRQ_INPROGRESS)
 		cpu_relax();
 }
+EXPORT_SYMBOL(synchronize_irq);
 #endif
 
 /*
@@ -248,6 +250,7 @@
 	}
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
+EXPORT_SYMBOL(disable_irq_nosync);
 
 /**
  *	disable_irq - disable an irq and wait for completion
@@ -267,6 +270,7 @@
 	disable_irq_nosync(irq);
 	synchronize_irq(irq);
 }
+EXPORT_SYMBOL(disable_irq);
 
 /**
  *	enable_irq - enable handling of an irq
@@ -305,6 +309,7 @@
 	}
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
+EXPORT_SYMBOL(enable_irq);
 
 /*
  * do_IRQ handles all normal device IRQ's (the special
@@ -677,6 +682,7 @@
 
 	return mask & val;
 }
+EXPORT_SYMBOL(probe_irq_mask);
 
 /*
  * Return the one interrupt that triggered (this can
diff -urN linux-2.5.59-bk1/arch/i386/kernel/nmi.c linux/arch/i386/kernel/nmi.c
--- linux-2.5.59-bk1/arch/i386/kernel/nmi.c	2003-01-13 16:20:50.000000000 -0500
+++ linux/arch/i386/kernel/nmi.c	2003-02-04 16:12:52.000000000 -0500
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/module.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -180,12 +181,14 @@
 	apic_pm_unregister(nmi_pmdev);
 	return apic_pm_register(PM_SYS_DEV, 0, callback);
 }
+EXPORT_SYMBOL_GPL(set_nmi_pm_callback);
 
 void unset_nmi_pm_callback(struct pm_dev * dev)
 {
 	apic_pm_unregister(dev);
 	nmi_pmdev = apic_pm_register(PM_SYS_DEV, 0, nmi_pm_callback);
 }
+EXPORT_SYMBOL_GPL(unset_nmi_pm_callback);
  
 static void nmi_pm_init(void)
 {
diff -urN linux-2.5.59-bk1/arch/i386/kernel/numaq.c linux/arch/i386/kernel/numaq.c
--- linux-2.5.59-bk1/arch/i386/kernel/numaq.c	2002-12-24 00:21:00.000000000 -0500
+++ linux/arch/i386/kernel/numaq.c	2003-02-04 16:13:09.000000000 -0500
@@ -27,6 +27,7 @@
 #include <linux/mm.h>
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
+#include <linux/module.h>
 #include <asm/numaq.h>
 
 /* These are needed before the pgdat's are created */
@@ -95,6 +96,7 @@
 
 	return nid;
 }
+EXPORT_SYMBOL(pfn_to_nid);
 
 /*
  * for each node mark the regions
diff -urN linux-2.5.59-bk1/arch/i386/kernel/pci-dma.c linux/arch/i386/kernel/pci-dma.c
--- linux-2.5.59-bk1/arch/i386/kernel/pci-dma.c	2003-01-14 02:18:18.000000000 -0500
+++ linux/arch/i386/kernel/pci-dma.c	2003-02-04 16:08:16.000000000 -0500
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/pci.h>
+#include <linux/module.h>
 #include <asm/io.h>
 
 void *dma_alloc_coherent(struct device *dev, size_t size,
@@ -30,9 +31,11 @@
 	}
 	return ret;
 }
+EXPORT_SYMBOL(dma_alloc_coherent);
 
 void dma_free_coherent(struct device *dev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle)
 {
 	free_pages((unsigned long)vaddr, get_order(size));
 }
+EXPORT_SYMBOL(dma_free_coherent);
diff -urN linux-2.5.59-bk1/arch/i386/kernel/process.c linux/arch/i386/kernel/process.c
--- linux-2.5.59-bk1/arch/i386/kernel/process.c	2003-01-13 16:20:53.000000000 -0500
+++ linux/arch/i386/kernel/process.c	2003-02-04 16:50:10.000000000 -0500
@@ -69,6 +69,7 @@
  * Powermanagement idle function, if any..
  */
 void (*pm_idle)(void);
+EXPORT_SYMBOL(pm_idle);
 
 void disable_hlt(void)
 {
@@ -94,6 +95,7 @@
 			local_irq_enable();
 	}
 }
+EXPORT_SYMBOL(default_idle);
 
 /*
  * On SMP it's slightly faster (but much more power-consuming!)
@@ -230,6 +232,7 @@
 	p = do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
+EXPORT_SYMBOL(kernel_thread);
 
 /*
  * Free current thread data structures etc..
@@ -372,6 +375,7 @@
 
 	dump->u_fpvalid = dump_fpu (regs, &dump->i387);
 }
+EXPORT_SYMBOL(dump_thread);
 
 /* 
  * Capture the user space registers if the task is not running (in user space)
@@ -593,6 +597,7 @@
 	} while (count++ < 16);
 	return 0;
 }
+EXPORT_SYMBOL(get_wchan);
 #undef last_sched
 #undef first_sched
 
diff -urN linux-2.5.59-bk1/arch/i386/kernel/profile.c linux/arch/i386/kernel/profile.c
--- linux-2.5.59-bk1/arch/i386/kernel/profile.c	2002-12-24 00:21:10.000000000 -0500
+++ linux/arch/i386/kernel/profile.c	2003-02-04 16:50:33.000000000 -0500
@@ -9,6 +9,7 @@
 #include <linux/spinlock.h>
 #include <linux/notifier.h>
 #include <linux/irq.h>
+#include <linux/module.h>
 #include <asm/hw_irq.h> 
  
 static struct notifier_block * profile_listeners;
@@ -22,6 +23,7 @@
 	write_unlock_irq(&profile_lock);
 	return err;
 }
+EXPORT_SYMBOL_GPL(register_profile_notifier);
 
 
 int unregister_profile_notifier(struct notifier_block * nb)
@@ -32,6 +34,7 @@
 	write_unlock_irq(&profile_lock);
 	return err;
 }
+EXPORT_SYMBOL_GPL(unregister_profile_notifier);
 
 
 void x86_profile_hook(struct pt_regs * regs)
diff -urN linux-2.5.59-bk1/arch/i386/kernel/reboot.c linux/arch/i386/kernel/reboot.c
--- linux-2.5.59-bk1/arch/i386/kernel/reboot.c	2002-12-24 00:19:53.000000000 -0500
+++ linux/arch/i386/kernel/reboot.c	2003-02-04 16:09:50.000000000 -0500
@@ -7,12 +7,14 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
+#include <linux/module.h>
 #include <asm/uaccess.h>
 
 /*
  * Power off function, if any
  */
 void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
 
 static long no_idt[2];
 static int reboot_mode;
@@ -220,6 +222,7 @@
 				:
 				: "i" ((void *) (0x1000 - sizeof (real_mode_switch) - 100)));
 }
+EXPORT_SYMBOL(machine_real_restart);
 
 void machine_restart(char * __unused)
 {
diff -urN linux-2.5.59-bk1/arch/i386/kernel/semaphore.c linux/arch/i386/kernel/semaphore.c
--- linux-2.5.59-bk1/arch/i386/kernel/semaphore.c	2002-12-24 00:20:07.000000000 -0500
+++ linux/arch/i386/kernel/semaphore.c	2003-02-04 16:57:12.000000000 -0500
@@ -15,6 +15,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/err.h>
+#include <linux/module.h>
 #include <asm/semaphore.h>
 
 /*
@@ -208,6 +209,7 @@
 #endif
 	"ret"
 );
+EXPORT_SYMBOL(__down_failed);
 
 asm(
 ".text\n"
@@ -229,6 +231,7 @@
 #endif
 	"ret"
 );
+EXPORT_SYMBOL(__down_failed_interruptible);
 
 asm(
 ".text\n"
@@ -250,6 +253,7 @@
 #endif
 	"ret"
 );
+EXPORT_SYMBOL(__down_failed_trylock);
 
 asm(
 ".text\n"
@@ -265,6 +269,7 @@
 	"popl %eax\n\t"
 	"ret"
 );
+EXPORT_SYMBOL(__up_wakeup);
 
 /*
  * rw spinlock fallbacks
@@ -283,6 +288,7 @@
 	"jnz	__write_lock_failed\n\t"
 	"ret"
 );
+EXPORT_SYMBOL(__write_lock_failed);
 
 asm(
 ".text\n"
@@ -297,4 +303,5 @@
 	"js	__read_lock_failed\n\t"
 	"ret"
 );
+EXPORT_SYMBOL(__read_lock_failed);
 #endif
diff -urN linux-2.5.59-bk1/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- linux-2.5.59-bk1/arch/i386/kernel/setup.c	2002-12-24 00:20:16.000000000 -0500
+++ linux/arch/i386/kernel/setup.c	2003-02-04 16:07:51.000000000 -0500
@@ -34,6 +34,7 @@
 #include <linux/console.h>
 #include <linux/root_dev.h>
 #include <linux/highmem.h>
+#include <linux/module.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
 #include <asm/edd.h>
@@ -54,20 +55,26 @@
 struct cpuinfo_x86 new_cpu_data __initdata = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 /* common cpu data for all cpus */
 struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
+EXPORT_SYMBOL(boot_cpu_data);
 
 unsigned long mmu_cr4_features;
 
 int acpi_disabled __initdata = 0;
 
 int MCA_bus;
+EXPORT_SYMBOL(MCA_bus);
+
 /* for MCA, but anyone else can use it if they want */
 unsigned int machine_id;
+EXPORT_SYMBOL(machine_id);
+
 unsigned int machine_submodel_id;
 unsigned int BIOS_revision;
 unsigned int mca_pentium_flag;
 
 /* For PCI or other memory-mapped resources */
 unsigned long pci_mem_start = 0x10000000;
+EXPORT_SYMBOL(pci_mem_start);
 
 /* user-defined highmem size */
 static unsigned int highmem_pages = -1;
@@ -76,8 +83,14 @@
  * Setup options
  */
 struct drive_info_struct { char dummy[32]; } drive_info;
+EXPORT_SYMBOL(drive_info);
+
 struct screen_info screen_info;
+EXPORT_SYMBOL(screen_info);
+
 struct apm_info apm_info;
+EXPORT_SYMBOL(apm_info);
+
 struct sys_desc_table_struct {
 	unsigned short length;
 	unsigned char table[0];
@@ -474,7 +487,11 @@
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 unsigned char eddnr;
+EXPORT_SYMBOL(eddnr);
+
 struct edd_info edd[EDDNR];
+EXPORT_SYMBOL(edd);
+
 /**
  * copy_edd() - Copy the BIOS EDD information
  *              from empty_zero_page into a safe place.
diff -urN linux-2.5.59-bk1/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux-2.5.59-bk1/arch/i386/kernel/smpboot.c	2003-01-17 00:26:23.000000000 -0500
+++ linux/arch/i386/kernel/smpboot.c	2003-02-04 17:01:43.000000000 -0500
@@ -42,6 +42,7 @@
 #include <linux/smp_lock.h>
 #include <linux/irq.h>
 #include <linux/bootmem.h>
+#include <linux/module.h>
 
 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
@@ -59,17 +60,22 @@
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
+EXPORT_SYMBOL(smp_num_siblings);
+
 int phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
 
 /* Bitmask of currently online CPUs */
 unsigned long cpu_online_map;
+EXPORT_SYMBOL(cpu_online_map);
 
 static volatile unsigned long cpu_callin_map;
 volatile unsigned long cpu_callout_map;
+EXPORT_SYMBOL(cpu_callout_map);
 static unsigned long smp_commenced_mask;
 
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
+EXPORT_SYMBOL(cpu_data);
 
 /* Set when the idlers are all forked */
 int smp_threads_ready;
@@ -942,8 +948,10 @@
 static int boot_cpu_logical_apicid;
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
 void *xquad_portio;
+EXPORT_SYMBOL(xquad_portio);
 
 int cpu_sibling_map[NR_CPUS] __cacheline_aligned;
+EXPORT_SYMBOL(cpu_sibling_map);
 
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
diff -urN linux-2.5.59-bk1/arch/i386/kernel/smp.c linux/arch/i386/kernel/smp.c
--- linux-2.5.59-bk1/arch/i386/kernel/smp.c	2003-01-17 00:26:23.000000000 -0500
+++ linux/arch/i386/kernel/smp.c	2003-02-04 17:02:00.000000000 -0500
@@ -19,6 +19,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/cache.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
 
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
@@ -435,6 +436,7 @@
 
 	preempt_enable();
 }
+EXPORT_SYMBOL(flush_tlb_page);
 
 static inline void do_flush_tlb_all_local(void)
 {
@@ -544,6 +546,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(smp_call_function);
 
 static void stop_this_cpu (void * dummy)
 {
diff -urN linux-2.5.59-bk1/arch/i386/kernel/time.c linux/arch/i386/kernel/time.c
--- linux-2.5.59-bk1/arch/i386/kernel/time.c	2003-02-04 15:58:52.000000000 -0500
+++ linux/arch/i386/kernel/time.c	2003-02-04 17:02:08.000000000 -0500
@@ -69,11 +69,13 @@
 u64 jiffies_64;
 
 unsigned long cpu_khz;	/* Detected as we calibrate the TSC */
+EXPORT_SYMBOL(cpu_khz);
 
 extern rwlock_t xtime_lock;
 extern unsigned long wall_jiffies;
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
+EXPORT_SYMBOL(rtc_lock);
 
 spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
 EXPORT_SYMBOL(i8253_lock);
@@ -366,6 +368,7 @@
 		year += 100;
 	return mktime(year, mon, day, hour, min, sec);
 }
+EXPORT_SYMBOL(get_cmos_time);
 
 /* XXX this driverfs stuff should probably go elsewhere later -john */
 static struct sys_device device_i8253 = {
diff -urN linux-2.5.59-bk1/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- linux-2.5.59-bk1/arch/i386/kernel/traps.c	2003-01-13 16:20:57.000000000 -0500
+++ linux/arch/i386/kernel/traps.c	2003-02-04 17:02:22.000000000 -0500
@@ -478,11 +478,13 @@
 {
 	nmi_callback = callback;
 }
+EXPORT_SYMBOL_GPL(set_nmi_callback);
 
 void unset_nmi_callback(void)
 {
 	nmi_callback = dummy_nmi_callback;
 }
+EXPORT_SYMBOL_GPL(unset_nmi_callback);
 
 /*
  * Our handling of the processor debug registers is non-trivial.
@@ -813,6 +815,7 @@
 
 #ifdef CONFIG_EISA
 int EISA_bus;
+EXPORT_SYMBOL(EISA_bus);
 static struct resource eisa_id = { "EISA ID", 0xc80, 0xc83, IORESOURCE_BUSY };
 #endif
 
diff -urN linux-2.5.59-bk1/arch/i386/lib/dec_and_lock.c linux/arch/i386/lib/dec_and_lock.c
--- linux-2.5.59-bk1/arch/i386/lib/dec_and_lock.c	2002-12-24 00:19:49.000000000 -0500
+++ linux/arch/i386/lib/dec_and_lock.c	2003-02-04 16:24:58.000000000 -0500
@@ -8,6 +8,7 @@
  */
 
 #include <linux/spinlock.h>
+#include <linux/module.h>
 #include <asm/atomic.h>
 
 int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
@@ -38,3 +39,4 @@
 	spin_unlock(lock);
 	return 0;
 }
+EXPORT_SYMBOL(atomic_dec_and_lock);
diff -urN linux-2.5.59-bk1/arch/i386/lib/delay.c linux/arch/i386/lib/delay.c
--- linux-2.5.59-bk1/arch/i386/lib/delay.c	2003-01-14 02:18:18.000000000 -0500
+++ linux/arch/i386/lib/delay.c	2003-02-04 16:24:43.000000000 -0500
@@ -13,6 +13,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
+#include <linux/module.h>
 #include <asm/processor.h>
 #include <asm/delay.h>
 #include <asm/timer.h>
@@ -27,6 +28,7 @@
 {
 	timer->delay(loops);
 }
+EXPORT_SYMBOL(__delay);
 
 inline void __const_udelay(unsigned long xloops)
 {
@@ -36,8 +38,10 @@
 		:"1" (xloops),"0" (current_cpu_data.loops_per_jiffy));
         __delay(xloops * HZ);
 }
+EXPORT_SYMBOL(__const_udelay);
 
 void __udelay(unsigned long usecs)
 {
 	__const_udelay(usecs * 0x000010c6);  /* 2**32 / 1000000 */
 }
+EXPORT_SYMBOL(__udelay);
diff -urN linux-2.5.59-bk1/arch/i386/lib/iodebug.c linux/arch/i386/lib/iodebug.c
--- linux-2.5.59-bk1/arch/i386/lib/iodebug.c	2002-12-24 00:21:13.000000000 -0500
+++ linux/arch/i386/lib/iodebug.c	2003-02-04 17:02:55.000000000 -0500
@@ -1,3 +1,4 @@
+#include <linux/module.h>
 #include <asm/io.h>
 
 void * __io_virt_debug(unsigned long x, const char *file, int line)
@@ -8,4 +9,5 @@
 	}
 	return (void *)x;
 }
+EXPORT_SYMBOL(__io_virt_debug);
 
diff -urN linux-2.5.59-bk1/arch/i386/lib/memcpy.c linux/arch/i386/lib/memcpy.c
--- linux-2.5.59-bk1/arch/i386/lib/memcpy.c	2002-12-24 00:21:17.000000000 -0500
+++ linux/arch/i386/lib/memcpy.c	2003-02-04 16:24:51.000000000 -0500
@@ -1,5 +1,6 @@
 #include <linux/config.h>
 #include <linux/string.h>
+#include <linux/module.h>
 
 #undef memcpy
 #undef memset
@@ -12,8 +13,10 @@
 	return __memcpy(to, from, n);
 #endif
 }
+EXPORT_SYMBOL_NOVERS(memcpy);
 
 void * memset(void * s, int c, size_t count)
 {
 	return __memset(s, c, count);
 }
+EXPORT_SYMBOL_NOVERS(memset);
diff -urN linux-2.5.59-bk1/arch/i386/lib/mmx.c linux/arch/i386/lib/mmx.c
--- linux-2.5.59-bk1/arch/i386/lib/mmx.c	2002-12-24 00:20:27.000000000 -0500
+++ linux/arch/i386/lib/mmx.c	2003-02-04 16:24:55.000000000 -0500
@@ -2,6 +2,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/sched.h>
+#include <linux/module.h>
 
 #include <asm/i387.h>
 #include <asm/hardirq.h> 
@@ -120,6 +121,7 @@
 	kernel_fpu_end();
 	return p;
 }
+EXPORT_SYMBOL(_mmx_memcpy);
 
 #ifdef CONFIG_MK7
 
@@ -377,6 +379,7 @@
 	else
 		fast_clear_page(page);
 }
+EXPORT_SYMBOL(mmx_clear_page);
 
 static void slow_copy_page(void *to, void *from)
 {
@@ -397,3 +400,4 @@
 	else
 		fast_copy_page(to, from);
 }
+EXPORT_SYMBOL(mmx_copy_page);
diff -urN linux-2.5.59-bk1/arch/i386/lib/usercopy.c linux/arch/i386/lib/usercopy.c
--- linux-2.5.59-bk1/arch/i386/lib/usercopy.c	2003-01-13 16:20:57.000000000 -0500
+++ linux/arch/i386/lib/usercopy.c	2003-02-04 16:24:48.000000000 -0500
@@ -6,6 +6,7 @@
  * Copyright 1997 Linus Torvalds
  */
 #include <linux/config.h>
+#include <linux/module.h>
 #include <asm/uaccess.h>
 #include <asm/mmx.h>
 
@@ -57,6 +58,7 @@
 	__do_strncpy_from_user(dst, src, count, res);
 	return res;
 }
+EXPORT_SYMBOL(__strncpy_from_user);
 
 long
 strncpy_from_user(char *dst, const char *src, long count)
@@ -66,6 +68,7 @@
 		__do_strncpy_from_user(dst, src, count, res);
 	return res;
 }
+EXPORT_SYMBOL(strncpy_from_user);
 
 
 /*
@@ -100,6 +103,7 @@
 		__do_clear_user(to, n);
 	return n;
 }
+EXPORT_SYMBOL(clear_user);
 
 unsigned long
 __clear_user(void *to, unsigned long n)
@@ -107,6 +111,7 @@
 	__do_clear_user(to, n);
 	return n;
 }
+EXPORT_SYMBOL(__clear_user);
 
 /*
  * Return the size of a string (including the ending 0)
@@ -143,6 +148,7 @@
 		:"cc");
 	return res & mask;
 }
+EXPORT_SYMBOL(strnlen_user);
 
 #ifdef CONFIG_X86_INTEL_USERCOPY
 static unsigned long
@@ -425,6 +431,7 @@
 		n = __copy_user_intel(to, from, n);
 	return n;
 }
+EXPORT_SYMBOL(__copy_to_user_ll);
 
 unsigned long __copy_from_user_ll(void *to, const void *from, unsigned long n)
 {
@@ -434,3 +441,4 @@
 		n = __copy_user_zeroing_intel(to, from, n);
 	return n;
 }
+EXPORT_SYMBOL(__copy_from_user_ll);
diff -urN linux-2.5.59-bk1/arch/i386/mach-visws/pci-visws.c linux/arch/i386/mach-visws/pci-visws.c
--- linux-2.5.59-bk1/arch/i386/mach-visws/pci-visws.c	2002-12-24 00:21:01.000000000 -0500
+++ linux/arch/i386/mach-visws/pci-visws.c	2003-02-04 17:00:28.000000000 -0500
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/module.h>
 
 #include <asm/smp.h>
 #include <asm/lithium.h>
@@ -139,3 +140,4 @@
 void __init pcibios_penalize_isa_irq(irq)
 {
 }
+EXPORT_SYMBOL(pcibios_penalize_isa_irq);
diff -urN linux-2.5.59-bk1/arch/i386/mach-voyager/voyager_basic.c linux/arch/i386/mach-voyager/voyager_basic.c
--- linux-2.5.59-bk1/arch/i386/mach-voyager/voyager_basic.c	2003-01-13 16:20:50.000000000 -0500
+++ linux/arch/i386/mach-voyager/voyager_basic.c	2003-02-04 17:00:52.000000000 -0500
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/sysrq.h>
+#include <linux/module.h>
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 #include <asm/voyager.h>
@@ -35,6 +36,7 @@
  * Power off function, if any
  */
 void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
 
 int reboot_thru_bios;
 
diff -urN linux-2.5.59-bk1/arch/i386/mach-voyager/voyager_smp.c linux/arch/i386/mach-voyager/voyager_smp.c
--- linux-2.5.59-bk1/arch/i386/mach-voyager/voyager_smp.c	2003-01-13 16:20:53.000000000 -0500
+++ linux/arch/i386/mach-voyager/voyager_smp.c	2003-02-04 17:01:09.000000000 -0500
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/bootmem.h>
 #include <linux/completion.h>
+#include <linux/module.h>
 #include <asm/desc.h>
 #include <asm/voyager.h>
 #include <asm/vic.h>
@@ -48,6 +49,7 @@
 /* per CPU data structure (for /proc/cpuinfo et al), visible externally
  * indexed physically */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
+EXPORT_SYMBOL(cpu_data);
 
 /* physical ID of the CPU used to boot the system */
 unsigned char boot_cpu_id;
@@ -80,6 +82,7 @@
 /* Bitmask of currently online CPUs - used by setup.c for
    /proc/cpuinfo, visible externally but still physical */
 unsigned long cpu_online_map = 0;
+EXPORT_SYMBOL(cpu_online_map);
 
 /* Bitmask of CPUs present in the system - exported by i386_syms.c, used
  * by scheduler but indexed physically */
@@ -248,6 +251,7 @@
 /* This is for the new dynamic CPU boot code */
 volatile unsigned long cpu_callin_map = 0;
 unsigned long cpu_callout_map = 0;
+EXPORT_SYMBOL(cpu_callout_map);
 
 /* The per processor IRQ masks (these are usually kept in sync) */
 static __u16 vic_irq_mask[NR_CPUS] __cacheline_aligned;
@@ -1005,6 +1009,7 @@
 
 	preempt_enable();
 }
+EXPORT_SYMBOL(flush_tlb_page);
 
 /* enable the requested IRQs */
 asmlinkage void
diff -urN linux-2.5.59-bk1/arch/i386/mm/discontig.c linux/arch/i386/mm/discontig.c
--- linux-2.5.59-bk1/arch/i386/mm/discontig.c	2002-12-24 00:20:31.000000000 -0500
+++ linux/arch/i386/mm/discontig.c	2003-02-04 17:03:35.000000000 -0500
@@ -30,10 +30,12 @@
 #ifdef CONFIG_BLK_DEV_RAM
 #include <linux/blk.h>
 #endif
+#include <linux/module.h>
 #include <asm/e820.h>
 #include <asm/setup.h>
 
 struct pglist_data *node_data[MAX_NUMNODES];
+EXPORT_SYMBOL(node_data);
 bootmem_data_t node0_bdata;
 
 extern unsigned long find_max_low_pfn(void);
diff -urN linux-2.5.59-bk1/arch/i386/mm/fault.c linux/arch/i386/mm/fault.c
--- linux-2.5.59-bk1/arch/i386/mm/fault.c	2003-01-13 16:20:57.000000000 -0500
+++ linux/arch/i386/mm/fault.c	2003-02-04 17:04:02.000000000 -0500
@@ -108,6 +108,7 @@
 	}
 	goto bad_area;
 }
+EXPORT_SYMBOL(__verify_write);
 #endif
 
 /*
diff -urN linux-2.5.59-bk1/arch/i386/mm/highmem.c linux/arch/i386/mm/highmem.c
--- linux-2.5.59-bk1/arch/i386/mm/highmem.c	2002-12-24 00:20:29.000000000 -0500
+++ linux/arch/i386/mm/highmem.c	2003-02-04 17:08:25.000000000 -0500
@@ -1,4 +1,5 @@
 #include <linux/highmem.h>
+#include <linux/module.h>
 
 void *kmap(struct page *page)
 {
@@ -8,6 +9,7 @@
 		return page_address(page);
 	return kmap_high(page);
 }
+EXPORT_SYMBOL(kmap);
 
 void kunmap(struct page *page)
 {
@@ -17,6 +19,7 @@
 		return;
 	kunmap_high(page);
 }
+EXPORT_SYMBOL(kunmap);
 
 /*
  * kmap_atomic/kunmap_atomic is significantly faster than kmap/kunmap because
@@ -46,6 +49,7 @@
 
 	return (void*) vaddr;
 }
+EXPORT_SYMBOL(kmap_atomic);
 
 void kunmap_atomic(void *kvaddr, enum km_type type)
 {
@@ -71,6 +75,7 @@
 
 	dec_preempt_count();
 }
+EXPORT_SYMBOL(kunmap_atomic);
 
 struct page *kmap_atomic_to_page(void *ptr)
 {
@@ -84,4 +89,5 @@
 	pte = kmap_pte - (idx - FIX_KMAP_BEGIN);
 	return pte_page(*pte);
 }
+EXPORT_SYMBOL(kmap_atomic_to_page);
 
diff -urN linux-2.5.59-bk1/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-2.5.59-bk1/arch/i386/mm/init.c	2003-02-04 15:58:52.000000000 -0500
+++ linux/arch/i386/mm/init.c	2003-02-04 16:10:14.000000000 -0500
@@ -27,6 +27,7 @@
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -251,6 +252,7 @@
 #endif /* CONFIG_HIGHMEM */
 
 unsigned long __PAGE_KERNEL = _PAGE_KERNEL;
+EXPORT_SYMBOL(__PAGE_KERNEL);
 
 #ifndef CONFIG_DISCONTIGMEM
 #define remap_numa_kva() do {} while (0)
diff -urN linux-2.5.59-bk1/arch/i386/mm/ioremap.c linux/arch/i386/mm/ioremap.c
--- linux-2.5.59-bk1/arch/i386/mm/ioremap.c	2002-12-24 00:19:50.000000000 -0500
+++ linux/arch/i386/mm/ioremap.c	2003-02-04 16:10:19.000000000 -0500
@@ -11,6 +11,7 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 #include <asm/fixmap.h>
@@ -164,6 +165,7 @@
 	}
 	return (void *) (offset + (char *)addr);
 }
+EXPORT_SYMBOL(__ioremap);
 
 
 /**
@@ -209,6 +211,7 @@
 
 	return p;					
 }
+EXPORT_SYMBOL(ioremap_nocache);
 
 void iounmap(void *addr)
 {
@@ -229,6 +232,7 @@
 	} 
 	kfree(p); 
 }
+EXPORT_SYMBOL(iounmap);
 
 void __init *bt_ioremap(unsigned long phys_addr, unsigned long size)
 {
diff -urN linux-2.5.59-bk1/arch/i386/pci/irq.c linux/arch/i386/pci/irq.c
--- linux-2.5.59-bk1/arch/i386/pci/irq.c	2002-12-24 00:21:34.000000000 -0500
+++ linux/arch/i386/pci/irq.c	2003-02-04 16:22:39.000000000 -0500
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/module.h>
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/io_apic.h>
@@ -800,6 +801,7 @@
 	 */
 	pirq_penalty[irq] += 100;
 }
+EXPORT_SYMBOL(pcibios_penalize_isa_irq);
 
 int pirq_enable_irq(struct pci_dev *dev)
 {
diff -urN linux-2.5.59-bk1/arch/i386/pci/pcbios.c linux/arch/i386/pci/pcbios.c
--- linux-2.5.59-bk1/arch/i386/pci/pcbios.c	2002-12-24 00:19:31.000000000 -0500
+++ linux/arch/i386/pci/pcbios.c	2003-02-04 16:22:19.000000000 -0500
@@ -4,6 +4,7 @@
 
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include "pci.h"
 
 
@@ -476,6 +477,7 @@
 	free_page(page);
 	return rt;
 }
+EXPORT_SYMBOL(pcibios_get_irq_routing_table);
 
 
 int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq)
@@ -493,6 +495,7 @@
 		  "S" (&pci_indirect));
 	return !(ret & 0xff00);
 }
+EXPORT_SYMBOL(pcibios_set_irq_routing);
 
 static int __init pci_pcbios_init(void)
 {
diff -urN linux-2.5.59-bk1/include/asm-i386/spinlock.h linux/include/asm-i386/spinlock.h
--- linux-2.5.59-bk1/include/asm-i386/spinlock.h	2002-12-24 00:19:49.000000000 -0500
+++ linux/include/asm-i386/spinlock.h	2003-02-04 16:55:23.000000000 -0500
@@ -171,6 +171,7 @@
  */
 /* the spinlock helpers are in arch/i386/kernel/semaphore.c */
 
+asmlinkage void __read_lock_failed(void);
 static inline void _raw_read_lock(rwlock_t *rw)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
@@ -180,6 +181,7 @@
 	__build_read_lock(rw, "__read_lock_failed");
 }
 
+asmlinkage void __write_lock_failed(void);
 static inline void _raw_write_lock(rwlock_t *rw)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK

--------------070401030907080006090403--

