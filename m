Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVBJEtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVBJEtp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 23:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVBJEtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 23:49:45 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:49376 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262019AbVBJEtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 23:49:01 -0500
Date: Thu, 10 Feb 2005 15:48:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, ppc64-dev <linuxppc64-dev@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>, paulus@samba.org, anton@samba.org
Subject: [PATCH] distribute ppc64 EXPORT_SYMBOLs
Message-Id: <20050210154846.7f1b54f3.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__10_Feb_2005_15_48_46_+1100_Ghvw2BnjeUWi7wGn"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__10_Feb_2005_15_48_46_+1100_Ghvw2BnjeUWi7wGn
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi,

This patch just moves aas many as possible EXPORT_SYMBOL()s from
arch/ppc64/kernel/ppc_ksyms.c to where the symbols are defined.  This has
been compiled on pSeries, iSeries and pmac.

Please apply.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk/arch/ppc64/kernel/LparData.c linus-bk.sfr.1/arch/ppc64/kernel/LparData.c
--- linus-bk/arch/ppc64/kernel/LparData.c	2005-01-09 10:05:39.000000000 +1100
+++ linus-bk.sfr.1/arch/ppc64/kernel/LparData.c	2005-02-10 14:19:50.000000000 +1100
@@ -224,6 +224,7 @@
 };
 
 struct msChunks msChunks;
+EXPORT_SYMBOL(msChunks);
 
 /* Depending on whether this is called from iSeries or pSeries setup
  * code, the location of the msChunks struct may or may not have
diff -ruN linus-bk/arch/ppc64/kernel/cputable.c linus-bk.sfr.1/arch/ppc64/kernel/cputable.c
--- linus-bk/arch/ppc64/kernel/cputable.c	2004-06-28 14:30:54.000000000 +1000
+++ linus-bk.sfr.1/arch/ppc64/kernel/cputable.c	2005-02-10 14:46:05.000000000 +1100
@@ -17,9 +17,12 @@
 #include <linux/sched.h>
 #include <linux/threads.h>
 #include <linux/init.h>
+#include <linux/module.h>
+
 #include <asm/cputable.h>
 
 struct cpu_spec* cur_cpu_spec = NULL;
+EXPORT_SYMBOL(cur_cpu_spec);
 
 /* NOTE:
  * Unlike ppc32, ppc64 will only call this once for the boot CPU, it's
diff -ruN linus-bk/arch/ppc64/kernel/irq.c linus-bk.sfr.1/arch/ppc64/kernel/irq.c
--- linus-bk/arch/ppc64/kernel/irq.c	2005-01-22 06:09:00.000000000 +1100
+++ linus-bk.sfr.1/arch/ppc64/kernel/irq.c	2005-02-10 14:41:29.000000000 +1100
@@ -61,6 +61,7 @@
 #endif
 
 extern irq_desc_t irq_desc[NR_IRQS];
+EXPORT_SYMBOL(irq_desc);
 
 int distribute_irqs = 1;
 int __irq_offset_value;
diff -ruN linus-bk/arch/ppc64/kernel/pacaData.c linus-bk.sfr.1/arch/ppc64/kernel/pacaData.c
--- linus-bk/arch/ppc64/kernel/pacaData.c	2005-01-12 16:05:22.000000000 +1100
+++ linus-bk.sfr.1/arch/ppc64/kernel/pacaData.c	2005-02-10 14:44:19.000000000 +1100
@@ -216,3 +216,4 @@
 #endif
 #endif
 };
+EXPORT_SYMBOL(paca);
diff -ruN linus-bk/arch/ppc64/kernel/pci.c linus-bk.sfr.1/arch/ppc64/kernel/pci.c
--- linus-bk/arch/ppc64/kernel/pci.c	2005-01-22 06:09:00.000000000 +1100
+++ linus-bk.sfr.1/arch/ppc64/kernel/pci.c	2005-02-10 11:58:17.000000000 +1100
@@ -63,7 +63,9 @@
  * page is mapped and isa_io_limit prevents access to it.
  */
 unsigned long isa_io_base;	/* NULL if no ISA bus */
+EXPORT_SYMBOL(isa_io_base);
 unsigned long pci_io_base;
+EXPORT_SYMBOL(pci_io_base);
 
 void iSeries_pcibios_init(void);
 
diff -ruN linus-bk/arch/ppc64/kernel/ppc_ksyms.c linus-bk.sfr.1/arch/ppc64/kernel/ppc_ksyms.c
--- linus-bk/arch/ppc64/kernel/ppc_ksyms.c	2005-01-12 16:05:22.000000000 +1100
+++ linus-bk.sfr.1/arch/ppc64/kernel/ppc_ksyms.c	2005-02-10 15:08:06.000000000 +1100
@@ -8,49 +8,18 @@
  */
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/threads.h>
-#include <linux/smp.h>
-#include <linux/elfcore.h>
-#include <linux/sched.h>
 #include <linux/string.h>
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
 #include <linux/console.h>
-#include <linux/irq.h>
-#include <linux/pci.h>
-#include <linux/delay.h>
-#include <linux/smp_lock.h>
-#include <linux/syscalls.h>
-#include <linux/bitops.h>
+#include <net/checksum.h>
 
-#include <asm/page.h>
-#include <asm/semaphore.h>
 #include <asm/processor.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
-#include <asm/atomic.h>
-#include <asm/checksum.h>
-#include <asm/pgtable.h>
-#include <asm/prom.h>
 #include <asm/system.h>
-#include <asm/pci-bridge.h>
-#include <asm/irq.h>
-#include <asm/dma.h>
-#include <asm/machdep.h>
 #include <asm/hw_irq.h>
 #include <asm/abs_addr.h>
 #include <asm/cacheflush.h>
-#ifdef CONFIG_PPC_ISERIES
 #include <asm/iSeries/HvCallSc.h>
-#include <asm/iSeries/LparData.h>
-#endif
-
-extern int do_signal(sigset_t *, struct pt_regs *);
-
-EXPORT_SYMBOL(do_signal);
-
-EXPORT_SYMBOL(isa_io_base);
-EXPORT_SYMBOL(pci_io_base);
 
 EXPORT_SYMBOL(strcpy);
 EXPORT_SYMBOL(strncpy);
@@ -65,10 +34,6 @@
 EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strncmp);
 
-EXPORT_SYMBOL(__down_interruptible);
-EXPORT_SYMBOL(__up);
-EXPORT_SYMBOL(__down);
-
 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_generic);
 EXPORT_SYMBOL(ip_fast_csum);
@@ -79,11 +44,6 @@
 EXPORT_SYMBOL(__strncpy_from_user);
 EXPORT_SYMBOL(__strnlen_user);
 
-EXPORT_SYMBOL(clear_user_page);
-
-#ifdef CONFIG_MSCHUNKS
-EXPORT_SYMBOL(msChunks);
-#endif
 EXPORT_SYMBOL(reloc_offset);
 
 #ifdef CONFIG_PPC_ISERIES
@@ -107,11 +67,7 @@
 EXPORT_SYMBOL(_outsw_ns);
 EXPORT_SYMBOL(_insl_ns);
 EXPORT_SYMBOL(_outsl_ns);
-EXPORT_SYMBOL(ioremap);
-EXPORT_SYMBOL(__ioremap);
-EXPORT_SYMBOL(iounmap);
 
-EXPORT_SYMBOL(start_thread);
 EXPORT_SYMBOL(kernel_thread);
 
 EXPORT_SYMBOL(giveup_fpu);
@@ -119,8 +75,7 @@
 EXPORT_SYMBOL(giveup_altivec);
 #endif
 EXPORT_SYMBOL(flush_icache_range);
-EXPORT_SYMBOL(flush_icache_user_range);
-EXPORT_SYMBOL(flush_dcache_page);
+
 #ifdef CONFIG_SMP
 #ifdef CONFIG_PPC_ISERIES
 EXPORT_SYMBOL(local_get_flags);
@@ -129,19 +84,6 @@
 #endif
 #endif
 
-EXPORT_SYMBOL(ppc_md);
-
-#ifdef CONFIG_PPC_MULTIPLATFORM
-EXPORT_SYMBOL(find_devices);
-EXPORT_SYMBOL(find_type_devices);
-EXPORT_SYMBOL(find_compatible_devices);
-EXPORT_SYMBOL(find_path_device);
-EXPORT_SYMBOL(device_is_compatible);
-EXPORT_SYMBOL(machine_is_compatible);
-EXPORT_SYMBOL(find_all_nodes);
-EXPORT_SYMBOL(get_property);
-#endif
-
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memmove);
@@ -150,10 +92,4 @@
 EXPORT_SYMBOL(memchr);
 
 EXPORT_SYMBOL(timer_interrupt);
-EXPORT_SYMBOL(irq_desc);
-EXPORT_SYMBOL(get_wchan);
 EXPORT_SYMBOL(console_drivers);
-
-EXPORT_SYMBOL(tb_ticks_per_usec);
-EXPORT_SYMBOL(paca);
-EXPORT_SYMBOL(cur_cpu_spec);
diff -ruN linus-bk/arch/ppc64/kernel/process.c linus-bk.sfr.1/arch/ppc64/kernel/process.c
--- linus-bk/arch/ppc64/kernel/process.c	2005-01-29 06:05:47.000000000 +1100
+++ linus-bk.sfr.1/arch/ppc64/kernel/process.c	2005-02-10 14:42:24.000000000 +1100
@@ -469,6 +469,7 @@
 	current->thread.used_vr = 0;
 #endif /* CONFIG_ALTIVEC */
 }
+EXPORT_SYMBOL(start_thread);
 
 int set_fpexc_mode(struct task_struct *tsk, unsigned int val)
 {
@@ -607,6 +608,7 @@
 	} while (count++ < 16);
 	return 0;
 }
+EXPORT_SYMBOL(get_wchan);
 
 void show_stack(struct task_struct *p, unsigned long *_sp)
 {
diff -ruN linus-bk/arch/ppc64/kernel/prom.c linus-bk.sfr.1/arch/ppc64/kernel/prom.c
--- linus-bk/arch/ppc64/kernel/prom.c	2005-01-29 06:05:47.000000000 +1100
+++ linus-bk.sfr.1/arch/ppc64/kernel/prom.c	2005-02-10 14:39:22.000000000 +1100
@@ -32,6 +32,8 @@
 #include <linux/delay.h>
 #include <linux/initrd.h>
 #include <linux/bitops.h>
+#include <linux/module.h>
+
 #include <asm/prom.h>
 #include <asm/rtas.h>
 #include <asm/lmb.h>
@@ -1138,6 +1140,7 @@
 	*prevp = NULL;
 	return head;
 }
+EXPORT_SYMBOL(find_devices);
 
 /**
  * Construct and return a list of the device_nodes with a given type.
@@ -1157,6 +1160,7 @@
 	*prevp = NULL;
 	return head;
 }
+EXPORT_SYMBOL(find_type_devices);
 
 /**
  * Returns all nodes linked together
@@ -1174,6 +1178,7 @@
 	*prevp = NULL;
 	return head;
 }
+EXPORT_SYMBOL(find_all_nodes);
 
 /** Checks if the given "compat" string matches one of the strings in
  * the device's "compatible" property
@@ -1197,6 +1202,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(device_is_compatible);
 
 
 /**
@@ -1216,6 +1222,7 @@
 	}
 	return rc;
 }
+EXPORT_SYMBOL(machine_is_compatible);
 
 /**
  * Construct and return a list of the device_nodes with a given type
@@ -1239,6 +1246,7 @@
 	*prevp = NULL;
 	return head;
 }
+EXPORT_SYMBOL(find_compatible_devices);
 
 /**
  * Find the device_node with a given full_name.
@@ -1253,6 +1261,7 @@
 			return np;
 	return NULL;
 }
+EXPORT_SYMBOL(find_path_device);
 
 /*******
  *
@@ -1872,6 +1881,7 @@
 		}
 	return NULL;
 }
+EXPORT_SYMBOL(get_property);
 
 /*
  * Add a property to a node
diff -ruN linus-bk/arch/ppc64/kernel/prom_init.c linus-bk.sfr.1/arch/ppc64/kernel/prom_init.c
--- linus-bk/arch/ppc64/kernel/prom_init.c	2005-01-05 17:06:07.000000000 +1100
+++ linus-bk.sfr.1/arch/ppc64/kernel/prom_init.c	2005-02-10 14:57:18.000000000 +1100
@@ -151,7 +151,6 @@
 
 extern void __start(unsigned long r3, unsigned long r4, unsigned long r5);
 
-extern unsigned long reloc_offset(void);
 extern void enter_prom(struct prom_args *args, unsigned long entry);
 extern void copy_and_flush(unsigned long dest, unsigned long src,
 			   unsigned long size, unsigned long offset);
diff -ruN linus-bk/arch/ppc64/kernel/semaphore.c linus-bk.sfr.1/arch/ppc64/kernel/semaphore.c
--- linus-bk/arch/ppc64/kernel/semaphore.c	2004-04-13 09:25:09.000000000 +1000
+++ linus-bk.sfr.1/arch/ppc64/kernel/semaphore.c	2005-02-10 12:07:49.000000000 +1100
@@ -18,6 +18,8 @@
 
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/module.h>
+
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
 #include <asm/errno.h>
@@ -62,6 +64,7 @@
 	__sem_update_count(sem, 1);
 	wake_up(&sem->wait);
 }
+EXPORT_SYMBOL(__up);
 
 /*
  * Note that when we come in to __down or __down_interruptible,
@@ -99,6 +102,7 @@
 	 */
 	wake_up(&sem->wait);
 }
+EXPORT_SYMBOL(__down);
 
 int __sched __down_interruptible(struct semaphore * sem)
 {
@@ -129,3 +133,4 @@
 	wake_up(&sem->wait);
 	return retval;
 }
+EXPORT_SYMBOL(__down_interruptible);
diff -ruN linus-bk/arch/ppc64/kernel/setup.c linus-bk.sfr.1/arch/ppc64/kernel/setup.c
--- linus-bk/arch/ppc64/kernel/setup.c	2005-01-09 10:05:39.000000000 +1100
+++ linus-bk.sfr.1/arch/ppc64/kernel/setup.c	2005-02-10 14:34:06.000000000 +1100
@@ -129,6 +129,7 @@
 /* The main machine-dep calls structure
  */
 struct machdep_calls ppc_md;
+EXPORT_SYMBOL(ppc_md);
 
 #ifdef CONFIG_MAGIC_SYSRQ
 unsigned long SYSRQ_KEY;
diff -ruN linus-bk/arch/ppc64/kernel/signal.c linus-bk.sfr.1/arch/ppc64/kernel/signal.c
--- linus-bk/arch/ppc64/kernel/signal.c	2005-01-23 07:08:01.000000000 +1100
+++ linus-bk.sfr.1/arch/ppc64/kernel/signal.c	2005-02-10 12:04:45.000000000 +1100
@@ -27,6 +27,8 @@
 #include <linux/stddef.h>
 #include <linux/elf.h>
 #include <linux/ptrace.h>
+#include <linux/module.h>
+
 #include <asm/sigcontext.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
@@ -566,6 +568,4 @@
 
 	return 0;
 }
-
-
-
+EXPORT_SYMBOL(do_signal);
diff -ruN linus-bk/arch/ppc64/kernel/time.c linus-bk.sfr.1/arch/ppc64/kernel/time.c
--- linus-bk/arch/ppc64/kernel/time.c	2005-01-22 06:09:01.000000000 +1100
+++ linus-bk.sfr.1/arch/ppc64/kernel/time.c	2005-02-10 15:08:14.000000000 +1100
@@ -85,6 +85,7 @@
 
 unsigned long tb_ticks_per_jiffy;
 unsigned long tb_ticks_per_usec = 100; /* sane default */
+EXPORT_SYMBOL(tb_ticks_per_usec);
 unsigned long tb_ticks_per_sec;
 unsigned long next_xtime_sync_tb;
 unsigned long xtime_sync_interval;
diff -ruN linus-bk/arch/ppc64/mm/init.c linus-bk.sfr.1/arch/ppc64/mm/init.c
--- linus-bk/arch/ppc64/mm/init.c	2005-01-22 06:09:01.000000000 +1100
+++ linus-bk.sfr.1/arch/ppc64/mm/init.c	2005-02-10 14:30:18.000000000 +1100
@@ -38,6 +38,7 @@
 #include <linux/highmem.h>
 #include <linux/idr.h>
 #include <linux/nodemask.h>
+#include <linux/module.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
@@ -441,6 +442,10 @@
 
 #endif
 
+EXPORT_SYMBOL(ioremap);
+EXPORT_SYMBOL(__ioremap);
+EXPORT_SYMBOL(iounmap);
+
 void free_initmem(void)
 {
 	unsigned long addr;
@@ -758,6 +763,7 @@
 	if (test_bit(PG_arch_1, &page->flags))
 		clear_bit(PG_arch_1, &page->flags);
 }
+EXPORT_SYMBOL(flush_dcache_page);
 
 void clear_user_page(void *page, unsigned long vaddr, struct page *pg)
 {
@@ -775,6 +781,7 @@
 	if (test_bit(PG_arch_1, &pg->flags))
 		clear_bit(PG_arch_1, &pg->flags);
 }
+EXPORT_SYMBOL(clear_user_page);
 
 void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
 		    struct page *pg)
@@ -812,6 +819,7 @@
 	maddr = (unsigned long)page_address(page) + (addr & ~PAGE_MASK);
 	flush_icache_range(maddr, maddr + len);
 }
+EXPORT_SYMBOL(flush_icache_user_range);
 
 /*
  * This is called at the end of handling a user page fault, when the
diff -ruN linus-bk/include/asm-ppc64/lmb.h linus-bk.sfr.1/include/asm-ppc64/lmb.h
--- linus-bk/include/asm-ppc64/lmb.h	2004-09-24 15:23:09.000000000 +1000
+++ linus-bk.sfr.1/include/asm-ppc64/lmb.h	2005-02-10 14:58:09.000000000 +1100
@@ -16,8 +16,6 @@
 #include <linux/init.h>
 #include <asm/prom.h>
 
-extern unsigned long reloc_offset(void);
-
 #define MAX_LMB_REGIONS 128
 
 #define LMB_ALLOC_ANYWHERE	0

--Signature=_Thu__10_Feb_2005_15_48_46_+1100_Ghvw2BnjeUWi7wGn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCCuez4CJfqux9a+8RAnv+AJ4tFQqi0I5tZKGRPZ6pZopn7KDmRwCfbzYc
r34nw12C29XD9LhRexnSM1I=
=0tHV
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Feb_2005_15_48_46_+1100_Ghvw2BnjeUWi7wGn--
