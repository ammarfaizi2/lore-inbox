Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVEXWjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVEXWjs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 18:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVEXWjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 18:39:42 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:37641 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261259AbVEXWhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 18:37:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jWXiKRiqmlIaWXaf0PbLeQbDX7ZuYcKGipBmQHcJY4+sNPlQw30sLa/Ns2d6LsM8GAbxmjMk5tEw3qp72t852jq1o+3gDJUuxKq7qYV/3UYTj3fhItIuwcmRHAtUNK7FU7ePEiB5cJs7emLmkuAXJnA8ZpjGMTpIb6RqS4P+oWg=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/2] Remove i386_ksyms.c. Almost.
Date: Wed, 25 May 2005 02:41:46 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505250241.46573.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* EXPORT_SYMBOL's moved to other files
* #include <linux/config.h>, <linux/module.h> where needed
* #include's in i386_ksyms.c cleaned up
* After copy-paste, redundant due to Makefiles rules preprocessor directives
  removed:

	#ifdef CONFIG_FOO
	EXPORT_SYMBOL(foo);
	#endif

	obj-$(CONFIG_FOO) += foo.o

* Tiny reformat to fit in 80 columns

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- linux-ksyms-001/arch/i386/kernel/i386_ksyms.c	2005-05-24 08:46:39.000000000 +0400
+++ linux-ksyms-002/arch/i386/kernel/i386_ksyms.c	2005-05-25 02:15:18.000000000 +0400
@@ -1,97 +1,17 @@
 #include <linux/config.h>
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
-#include <linux/time.h>
-
-#include <asm/semaphore.h>
-#include <asm/processor.h>
-#include <asm/i387.h>
-#include <asm/uaccess.h>
 #include <asm/checksum.h>
-#include <asm/io.h>
-#include <asm/delay.h>
-#include <asm/irq.h>
-#include <asm/mmx.h>
 #include <asm/desc.h>
-#include <asm/pgtable.h>
-#include <asm/tlbflush.h>
-#include <asm/nmi.h>
-#include <asm/ist.h>
-#include <asm/kdebug.h>
-
-extern void dump_thread(struct pt_regs *, struct user *);
-extern spinlock_t rtc_lock;
 
 /* This is definitely a GPL-only symbol */
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
-#ifdef CONFIG_DISCONTIGMEM
-EXPORT_SYMBOL(node_data);
-EXPORT_SYMBOL(physnode_map);
-#endif
-#ifdef CONFIG_X86_NUMAQ
-EXPORT_SYMBOL(xquad_portio);
-#endif
-EXPORT_SYMBOL(dump_thread);
-EXPORT_SYMBOL(dump_fpu);
-EXPORT_SYMBOL_GPL(kernel_fpu_begin);
-EXPORT_SYMBOL(__ioremap);
-EXPORT_SYMBOL(ioremap_nocache);
-EXPORT_SYMBOL(iounmap);
-EXPORT_SYMBOL(kernel_thread);
-EXPORT_SYMBOL(pm_idle);
-EXPORT_SYMBOL(pm_power_off);
-EXPORT_SYMBOL(get_cmos_time);
-EXPORT_SYMBOL(cpu_khz);
-EXPORT_SYMBOL(apm_info);
-
 EXPORT_SYMBOL(__down_failed);
 EXPORT_SYMBOL(__down_failed_interruptible);
 EXPORT_SYMBOL(__down_failed_trylock);
 EXPORT_SYMBOL(__up_wakeup);
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy_generic);
-/* Delay loops */
-EXPORT_SYMBOL(__ndelay);
-EXPORT_SYMBOL(__udelay);
-EXPORT_SYMBOL(__delay);
-EXPORT_SYMBOL(__const_udelay);
 
 EXPORT_SYMBOL(__get_user_1);
 EXPORT_SYMBOL(__get_user_2);
@@ -105,87 +25,11 @@ EXPORT_SYMBOL(__put_user_8);
 EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
 
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
 #ifdef CONFIG_SMP
-EXPORT_SYMBOL(cpu_data);
-EXPORT_SYMBOL(cpu_online_map);
-EXPORT_SYMBOL(cpu_callout_map);
+extern void FASTCALL( __write_lock_failed(rwlock_t *rw));
+extern void FASTCALL( __read_lock_failed(rwlock_t *rw));
 EXPORT_SYMBOL(__write_lock_failed);
 EXPORT_SYMBOL(__read_lock_failed);
-
-/* Global SMP stuff */
-EXPORT_SYMBOL(smp_call_function);
-
-/* TLB flushing */
-EXPORT_SYMBOL(flush_tlb_page);
-#endif
-
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
-EXPORT_SYMBOL_GPL(set_nmi_callback);
-EXPORT_SYMBOL_GPL(unset_nmi_callback);
-
-EXPORT_SYMBOL(register_die_notifier);
-#ifdef CONFIG_HAVE_DEC_LOCK
-EXPORT_SYMBOL(_atomic_dec_and_lock);
-#endif
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
-#if defined(CONFIG_X86_SPEEDSTEP_SMI) || defined(CONFIG_X86_SPEEDSTEP_SMI_MODULE)
-EXPORT_SYMBOL(ist_info);
 #endif
 
 EXPORT_SYMBOL(csum_partial);
--- linux-ksyms-001/arch/i386/kernel/i387.c	2005-05-24 08:46:39.000000000 +0400
+++ linux-ksyms-002/arch/i386/kernel/i387.c	2005-05-25 02:15:18.000000000 +0400
@@ -10,6 +10,7 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/module.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/math_emu.h>
@@ -79,6 +80,7 @@ void kernel_fpu_begin(void)
 	}
 	clts();
 }
+EXPORT_SYMBOL_GPL(kernel_fpu_begin);
 
 void restore_fpu( struct task_struct *tsk )
 {
@@ -526,6 +528,7 @@ int dump_fpu( struct pt_regs *regs, stru
 
 	return fpvalid;
 }
+EXPORT_SYMBOL(dump_fpu);
 
 int dump_task_fpu(struct task_struct *tsk, struct user_i387_struct *fpu)
 {
--- linux-ksyms-001/arch/i386/kernel/io_apic.c	2005-05-24 08:46:39.000000000 +0400
+++ linux-ksyms-002/arch/i386/kernel/io_apic.c	2005-05-25 02:15:18.000000000 +0400
@@ -31,7 +31,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/compiler.h>
 #include <linux/acpi.h>
-
+#include <linux/module.h>
 #include <linux/sysdev.h>
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -812,6 +812,7 @@ int IO_APIC_get_PCI_irq_vector(int bus, 
 	}
 	return best_guess;
 }
+EXPORT_SYMBOL(IO_APIC_get_PCI_irq_vector);
 
 /*
  * This function currently is only a helper for the i386 smp boot process where 
--- linux-ksyms-001/arch/i386/kernel/pci-dma.c	2005-05-24 08:46:39.000000000 +0400
+++ linux-ksyms-002/arch/i386/kernel/pci-dma.c	2005-05-25 02:15:18.000000000 +0400
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/pci.h>
+#include <linux/module.h>
 #include <asm/io.h>
 
 struct dma_coherent_mem {
@@ -54,6 +55,7 @@ void *dma_alloc_coherent(struct device *
 	}
 	return ret;
 }
+EXPORT_SYMBOL(dma_alloc_coherent);
 
 void dma_free_coherent(struct device *dev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle)
@@ -68,6 +70,7 @@ void dma_free_coherent(struct device *de
 	} else
 		free_pages((unsigned long)vaddr, order);
 }
+EXPORT_SYMBOL(dma_free_coherent);
 
 int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
 				dma_addr_t device_addr, size_t size, int flags)
--- linux-ksyms-001/arch/i386/kernel/process.c	2005-05-24 08:46:39.000000000 +0400
+++ linux-ksyms-002/arch/i386/kernel/process.c	2005-05-25 02:15:18.000000000 +0400
@@ -73,6 +73,7 @@ unsigned long thread_saved_pc(struct tas
  * Powermanagement idle function, if any..
  */
 void (*pm_idle)(void);
+EXPORT_SYMBOL(pm_idle);
 static DEFINE_PER_CPU(unsigned int, cpu_idle_state);
 
 void disable_hlt(void)
@@ -105,6 +106,9 @@ void default_idle(void)
 		cpu_relax();
 	}
 }
+#ifdef CONFIG_APM_MODULE
+EXPORT_SYMBOL(default_idle);
+#endif
 
 /*
  * On SMP it's slightly faster (but much more power-consuming!)
@@ -325,6 +329,7 @@ int kernel_thread(int (*fn)(void *), voi
 	/* Ok, create the new process.. */
 	return do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
 }
+EXPORT_SYMBOL(kernel_thread);
 
 /*
  * Free current thread data structures etc..
@@ -508,6 +513,7 @@ void dump_thread(struct pt_regs * regs, 
 
 	dump->u_fpvalid = dump_fpu (regs, &dump->i387);
 }
+EXPORT_SYMBOL(dump_thread);
 
 /* 
  * Capture the user space registers if the task is not running (in user space)
@@ -731,6 +737,7 @@ unsigned long get_wchan(struct task_stru
 	} while (count++ < 16);
 	return 0;
 }
+EXPORT_SYMBOL(get_wchan);
 
 /*
  * sys_alloc_thread_area: get a yet unused TLS descriptor index.
--- linux-ksyms-001/arch/i386/kernel/reboot.c	2005-05-24 08:46:39.000000000 +0400
+++ linux-ksyms-002/arch/i386/kernel/reboot.c	2005-05-25 02:15:18.000000000 +0400
@@ -2,6 +2,7 @@
  *  linux/arch/i386/kernel/reboot.c
  */
 
+#include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/delay.h>
@@ -19,6 +20,7 @@
  * Power off function, if any
  */
 void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
 
 static int reboot_mode;
 static int reboot_thru_bios;
@@ -295,6 +297,9 @@ void machine_real_restart(unsigned char 
 				:
 				: "i" ((void *) (0x1000 - sizeof (real_mode_switch) - 100)));
 }
+#ifdef CONFIG_APM_MODULE
+EXPORT_SYMBOL(machine_real_restart);
+#endif
 
 void machine_restart(char * __unused)
 {
--- linux-ksyms-001/arch/i386/kernel/setup.c	2005-05-24 08:46:39.000000000 +0400
+++ linux-ksyms-002/arch/i386/kernel/setup.c	2005-05-25 02:15:18.000000000 +0400
@@ -23,6 +23,7 @@
  * This file handles the architecture-dependent parts of initialization
  */
 
+#include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
@@ -73,6 +74,7 @@ EXPORT_SYMBOL(efi_enabled);
 struct cpuinfo_x86 new_cpu_data __initdata = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 /* common cpu data for all cpus */
 struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
+EXPORT_SYMBOL(boot_cpu_data);
 
 unsigned long mmu_cr4_features;
 
@@ -90,12 +92,18 @@ extern acpi_interrupt_flags	acpi_sci_fla
 
 /* for MCA, but anyone else can use it if they want */
 unsigned int machine_id;
+#ifdef CONFIG_MCA
+EXPORT_SYMBOL(machine_id);
+#endif
 unsigned int machine_submodel_id;
 unsigned int BIOS_revision;
 unsigned int mca_pentium_flag;
 
 /* For PCI or other memory-mapped resources */
 unsigned long pci_mem_start = 0x10000000;
+#ifdef CONFIG_PCI
+EXPORT_SYMBOL(pci_mem_start);
+#endif
 
 /* Boot loader ID as an integer, for the benefit of proc_dointvec */
 int bootloader_type;
@@ -107,14 +115,26 @@ static unsigned int highmem_pages = -1;
  * Setup options
  */
 struct drive_info_struct { char dummy[32]; } drive_info;
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_HD) || \
+    defined(CONFIG_BLK_DEV_IDE_MODULE) || defined(CONFIG_BLK_DEV_HD_MODULE)
+EXPORT_SYMBOL(drive_info);
+#endif
 struct screen_info screen_info;
+#ifdef CONFIG_VT
+EXPORT_SYMBOL(screen_info);
+#endif
 struct apm_info apm_info;
+EXPORT_SYMBOL(apm_info);
 struct sys_desc_table_struct {
 	unsigned short length;
 	unsigned char table[0];
 };
 struct edid_info edid_info;
 struct ist_info ist_info;
+#if defined(CONFIG_X86_SPEEDSTEP_SMI) || \
+	defined(CONFIG_X86_SPEEDSTEP_SMI_MODULE)
+EXPORT_SYMBOL(ist_info);
+#endif
 struct e820map e820;
 
 extern void early_cpu_init(void);
--- linux-ksyms-001/arch/i386/kernel/smp.c	2005-05-24 08:46:39.000000000 +0400
+++ linux-ksyms-002/arch/i386/kernel/smp.c	2005-05-25 02:15:18.000000000 +0400
@@ -19,6 +19,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/cache.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
@@ -452,6 +453,7 @@ void flush_tlb_page(struct vm_area_struc
 
 	preempt_enable();
 }
+EXPORT_SYMBOL(flush_tlb_page);
 
 static void do_flush_tlb_all(void* info)
 {
@@ -547,6 +549,7 @@ int smp_call_function (void (*func) (voi
 
 	return 0;
 }
+EXPORT_SYMBOL(smp_call_function);
 
 static void stop_this_cpu (void * dummy)
 {
--- linux-ksyms-001/arch/i386/kernel/smpboot.c	2005-05-24 08:46:39.000000000 +0400
+++ linux-ksyms-002/arch/i386/kernel/smpboot.c	2005-05-25 02:15:18.000000000 +0400
@@ -60,6 +60,9 @@ static int __initdata smp_b_stepping;
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
+#ifdef CONFIG_X86_HT
+EXPORT_SYMBOL(smp_num_siblings);
+#endif
 int phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
 EXPORT_SYMBOL(phys_proc_id);
 int cpu_core_id[NR_CPUS]; /* Core ID of each logical CPU */
@@ -67,13 +70,16 @@ EXPORT_SYMBOL(cpu_core_id);
 
 /* bitmap of online cpus */
 cpumask_t cpu_online_map;
+EXPORT_SYMBOL(cpu_online_map);
 
 cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
+EXPORT_SYMBOL(cpu_callout_map);
 static cpumask_t smp_commenced_mask;
 
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
+EXPORT_SYMBOL(cpu_data);
 
 u8 x86_cpu_to_apicid[NR_CPUS] =
 			{ [0 ... NR_CPUS-1] = 0xff };
@@ -885,8 +891,14 @@ static void smp_tune_scheduling (void)
 static int boot_cpu_logical_apicid;
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
 void *xquad_portio;
+#ifdef CONFIG_X86_NUMAQ
+EXPORT_SYMBOL(xquad_portio);
+#endif
 
 cpumask_t cpu_sibling_map[NR_CPUS] __cacheline_aligned;
+#ifdef CONFIG_X86_HT
+EXPORT_SYMBOL(cpu_sibling_map);
+#endif
 cpumask_t cpu_core_map[NR_CPUS] __cacheline_aligned;
 EXPORT_SYMBOL(cpu_core_map);
 
--- linux-ksyms-001/arch/i386/kernel/time.c	2005-05-24 08:46:39.000000000 +0400
+++ linux-ksyms-002/arch/i386/kernel/time.c	2005-05-25 02:15:18.000000000 +0400
@@ -78,10 +78,12 @@ u64 jiffies_64 = INITIAL_JIFFIES;
 EXPORT_SYMBOL(jiffies_64);
 
 unsigned long cpu_khz;	/* Detected as we calibrate the TSC */
+EXPORT_SYMBOL(cpu_khz);
 
 extern unsigned long wall_jiffies;
 
 DEFINE_SPINLOCK(rtc_lock);
+EXPORT_SYMBOL(rtc_lock);
 
 DEFINE_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
@@ -324,6 +326,8 @@ unsigned long get_cmos_time(void)
 
 	return retval;
 }
+EXPORT_SYMBOL(get_cmos_time);
+
 static void sync_cmos_clock(unsigned long dummy);
 
 static struct timer_list sync_cmos_timer =
--- linux-ksyms-001/arch/i386/kernel/traps.c	2005-05-24 08:46:39.000000000 +0400
+++ linux-ksyms-002/arch/i386/kernel/traps.c	2005-05-25 02:15:18.000000000 +0400
@@ -104,6 +104,7 @@ int register_die_notifier(struct notifie
 	spin_unlock_irqrestore(&die_notifier_lock, flags);
 	return err;
 }
+EXPORT_SYMBOL(register_die_notifier);
 
 static inline int valid_stack_ptr(struct thread_info *tinfo, void *p)
 {
@@ -636,11 +637,13 @@ void set_nmi_callback(nmi_callback_t cal
 {
 	nmi_callback = callback;
 }
+EXPORT_SYMBOL_GPL(set_nmi_callback);
 
 void unset_nmi_callback(void)
 {
 	nmi_callback = dummy_nmi_callback;
 }
+EXPORT_SYMBOL_GPL(unset_nmi_callback);
 
 #ifdef CONFIG_KPROBES
 fastcall void do_int3(struct pt_regs *regs, long error_code)
--- linux-ksyms-001/arch/i386/lib/dec_and_lock.c	2005-05-24 08:46:39.000000000 +0400
+++ linux-ksyms-002/arch/i386/lib/dec_and_lock.c	2005-05-25 02:35:57.000000000 +0400
@@ -8,6 +8,7 @@
  */
 
 #include <linux/spinlock.h>
+#include <linux/module.h>
 #include <asm/atomic.h>
 
 int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
@@ -38,3 +39,4 @@ slow_path:
 	spin_unlock(lock);
 	return 0;
 }
+EXPORT_SYMBOL(_atomic_dec_and_lock);
--- linux-ksyms-001/arch/i386/lib/delay.c	2005-05-24 08:46:39.000000000 +0400
+++ linux-ksyms-002/arch/i386/lib/delay.c	2005-05-25 02:15:18.000000000 +0400
@@ -13,6 +13,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
+#include <linux/module.h>
 #include <asm/processor.h>
 #include <asm/delay.h>
 #include <asm/timer.h>
@@ -47,3 +48,8 @@ void __ndelay(unsigned long nsecs)
 {
 	__const_udelay(nsecs * 0x00005);  /* 2**32 / 1000000000 (rounded up) */
 }
+
+EXPORT_SYMBOL(__delay);
+EXPORT_SYMBOL(__const_udelay);
+EXPORT_SYMBOL(__udelay);
+EXPORT_SYMBOL(__ndelay);
--- linux-ksyms-001/arch/i386/lib/mmx.c	2005-05-24 08:46:39.000000000 +0400
+++ linux-ksyms-002/arch/i386/lib/mmx.c	2005-05-25 02:15:18.000000000 +0400
@@ -3,6 +3,7 @@
 #include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/hardirq.h>
+#include <linux/module.h>
 
 #include <asm/i387.h>
 
@@ -397,3 +398,7 @@ void mmx_copy_page(void *to, void *from)
 	else
 		fast_copy_page(to, from);
 }
+
+EXPORT_SYMBOL(_mmx_memcpy);
+EXPORT_SYMBOL(mmx_clear_page);
+EXPORT_SYMBOL(mmx_copy_page);
--- linux-ksyms-001/arch/i386/lib/usercopy.c	2005-05-24 08:46:39.000000000 +0400
+++ linux-ksyms-002/arch/i386/lib/usercopy.c	2005-05-25 02:15:18.000000000 +0400
@@ -84,6 +84,7 @@ __strncpy_from_user(char *dst, const cha
 	__do_strncpy_from_user(dst, src, count, res);
 	return res;
 }
+EXPORT_SYMBOL(__strncpy_from_user);
 
 /**
  * strncpy_from_user: - Copy a NUL terminated string from userspace.
@@ -111,7 +112,7 @@ strncpy_from_user(char *dst, const char 
 		__do_strncpy_from_user(dst, src, count, res);
 	return res;
 }
-
+EXPORT_SYMBOL(strncpy_from_user);
 
 /*
  * Zero Userspace
@@ -157,6 +158,7 @@ clear_user(void __user *to, unsigned lon
 		__do_clear_user(to, n);
 	return n;
 }
+EXPORT_SYMBOL(clear_user);
 
 /**
  * __clear_user: - Zero a block of memory in user space, with less checking.
@@ -175,6 +177,7 @@ __clear_user(void __user *to, unsigned l
 	__do_clear_user(to, n);
 	return n;
 }
+EXPORT_SYMBOL(__clear_user);
 
 /**
  * strlen_user: - Get the size of a string in user space.
@@ -218,6 +221,7 @@ long strnlen_user(const char __user *s, 
 		:"cc");
 	return res & mask;
 }
+EXPORT_SYMBOL(strnlen_user);
 
 #ifdef CONFIG_X86_INTEL_USERCOPY
 static unsigned long
@@ -570,6 +574,7 @@ survive:
 		n = __copy_user_intel(to, from, n);
 	return n;
 }
+EXPORT_SYMBOL(__copy_to_user_ll);
 
 unsigned long
 __copy_from_user_ll(void *to, const void __user *from, unsigned long n)
@@ -581,6 +586,7 @@ __copy_from_user_ll(void *to, const void
 		n = __copy_user_zeroing_intel(to, from, n);
 	return n;
 }
+EXPORT_SYMBOL(__copy_from_user_ll);
 
 /**
  * copy_to_user: - Copy a block of data into user space.
--- linux-ksyms-001/arch/i386/mm/discontig.c	2005-05-24 08:46:40.000000000 +0400
+++ linux-ksyms-002/arch/i386/mm/discontig.c	2005-05-25 02:15:18.000000000 +0400
@@ -29,12 +29,14 @@
 #include <linux/highmem.h>
 #include <linux/initrd.h>
 #include <linux/nodemask.h>
+#include <linux/module.h>
 #include <asm/e820.h>
 #include <asm/setup.h>
 #include <asm/mmzone.h>
 #include <bios_ebda.h>
 
 struct pglist_data *node_data[MAX_NUMNODES];
+EXPORT_SYMBOL(node_data);
 bootmem_data_t node0_bdata;
 
 /*
@@ -59,6 +61,7 @@ bootmem_data_t node0_bdata;
  *     physnode_map[8- ] = -1;
  */
 s8 physnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
+EXPORT_SYMBOL(physnode_map);
 
 void memory_present(int nid, unsigned long start, unsigned long end)
 {
--- linux-ksyms-001/arch/i386/mm/highmem.c	2005-05-24 08:46:40.000000000 +0400
+++ linux-ksyms-002/arch/i386/mm/highmem.c	2005-05-25 02:38:41.000000000 +0400
@@ -1,4 +1,5 @@
 #include <linux/highmem.h>
+#include <linux/module.h>
 
 void *kmap(struct page *page)
 {
@@ -87,3 +88,8 @@ struct page *kmap_atomic_to_page(void *p
 	return pte_page(*pte);
 }
 
+EXPORT_SYMBOL(kmap);
+EXPORT_SYMBOL(kunmap);
+EXPORT_SYMBOL(kmap_atomic);
+EXPORT_SYMBOL(kunmap_atomic);
+EXPORT_SYMBOL(kmap_atomic_to_page);
--- linux-ksyms-001/arch/i386/mm/init.c	2005-05-24 08:46:40.000000000 +0400
+++ linux-ksyms-002/arch/i386/mm/init.c	2005-05-25 02:15:18.000000000 +0400
@@ -296,6 +296,7 @@ extern void set_highmem_pages_init(int);
 #endif /* CONFIG_HIGHMEM */
 
 unsigned long long __PAGE_KERNEL = _PAGE_KERNEL;
+EXPORT_SYMBOL(__PAGE_KERNEL);
 unsigned long long __PAGE_KERNEL_EXEC = _PAGE_KERNEL_EXEC;
 
 #ifndef CONFIG_DISCONTIGMEM
--- linux-ksyms-001/arch/i386/mm/ioremap.c	2005-05-24 08:46:40.000000000 +0400
+++ linux-ksyms-002/arch/i386/mm/ioremap.c	2005-05-25 02:15:18.000000000 +0400
@@ -11,6 +11,7 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 #include <asm/io.h>
 #include <asm/fixmap.h>
 #include <asm/cacheflush.h>
@@ -165,7 +166,7 @@ void __iomem * __ioremap(unsigned long p
 	}
 	return (void __iomem *) (offset + (char __iomem *)addr);
 }
-
+EXPORT_SYMBOL(__ioremap);
 
 /**
  * ioremap_nocache     -   map bus memory into CPU space
@@ -222,6 +223,7 @@ void __iomem *ioremap_nocache (unsigned 
 
 	return p;					
 }
+EXPORT_SYMBOL(ioremap_nocache);
 
 void iounmap(volatile void __iomem *addr)
 {
@@ -255,6 +257,7 @@ out_unlock:
 	write_unlock(&vmlist_lock);
 	kfree(p); 
 }
+EXPORT_SYMBOL(iounmap);
 
 void __init *bt_ioremap(unsigned long phys_addr, unsigned long size)
 {
--- linux-ksyms-001/arch/i386/pci/pcbios.c	2005-05-24 08:46:40.000000000 +0400
+++ linux-ksyms-002/arch/i386/pci/pcbios.c	2005-05-25 02:39:21.000000000 +0400
@@ -4,6 +4,7 @@
 
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include "pci.h"
 #include "pci-functions.h"
 
@@ -456,7 +457,7 @@ struct irq_routing_table * __devinit pci
 	free_page(page);
 	return rt;
 }
-
+EXPORT_SYMBOL(pcibios_get_irq_routing_table);
 
 int pcibios_set_irq_routing(struct pci_dev *dev, int pin, int irq)
 {
@@ -473,6 +474,7 @@ int pcibios_set_irq_routing(struct pci_d
 		  "S" (&pci_indirect));
 	return !(ret & 0xff00);
 }
+EXPORT_SYMBOL(pcibios_set_irq_routing);
 
 static int __init pci_pcbios_init(void)
 {
