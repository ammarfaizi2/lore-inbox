Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261896AbSJDW5Q>; Fri, 4 Oct 2002 18:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261772AbSJDWyB>; Fri, 4 Oct 2002 18:54:01 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:34635 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261780AbSJDWtm>; Fri, 4 Oct 2002 18:49:42 -0400
Date: Fri, 4 Oct 2002 16:03:40 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210042303.g94N3eS10028@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.40: lkcd (4/9): additional kernel symbols
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the symbols required for various changes to the
kernel to allow for dumping to complete properly.

diff -urN -X /home/bharata/dontdiff linux-2.5.40/arch/i386/kernel/i386_ksyms.c linux-2.5.40+lkcd/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.40/arch/i386/kernel/i386_ksyms.c	Tue Oct  1 12:36:59 2002
+++ linux-2.5.40+lkcd/arch/i386/kernel/i386_ksyms.c	Thu Oct  3 07:18:07 2002
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/tty.h>
+#include <linux/dump.h>
 
 #include <asm/semaphore.h>
 #include <asm/processor.h>
@@ -164,6 +165,24 @@
 
 EXPORT_SYMBOL(rtc_lock);
 
+#if defined(CONFIG_X86) || defined(CONFIG_ALPHA)
+EXPORT_SYMBOL(page_is_ram);
+#endif
+#ifdef CONFIG_SMP
+extern irq_desc_t irq_desc[];
+extern unsigned long irq_affinity[];
+EXPORT_SYMBOL(irq_affinity);
+EXPORT_SYMBOL(irq_desc);
+extern void dump_send_ipi(void);
+EXPORT_SYMBOL(dump_send_ipi);
+extern int (*dump_ipi_function_ptr)(struct pt_regs *);
+EXPORT_SYMBOL(dump_ipi_function_ptr);
+extern void (*dump_trace_ptr)(struct pt_regs *);
+EXPORT_SYMBOL(dump_trace_ptr);
+extern void show_this_cpu_state(int, struct pt_regs *, struct task_struct *);
+EXPORT_SYMBOL(show_this_cpu_state);
+#endif
+
 #undef memcpy
 #undef memset
 extern void * memset(void *,int,__kernel_size_t);
diff -urN -X /home/bharata/dontdiff linux-2.5.40/kernel/ksyms.c linux-2.5.40+lkcd/kernel/ksyms.c
--- linux-2.5.40/kernel/ksyms.c	Tue Oct  1 12:35:49 2002
+++ linux-2.5.40+lkcd/kernel/ksyms.c	Thu Oct  3 07:18:07 2002
@@ -34,6 +34,7 @@
 #include <linux/ctype.h>
 #include <linux/file.h>
 #include <linux/iobuf.h>
+#include <linux/dump.h>
 #include <linux/console.h>
 #include <linux/poll.h>
 #include <linux/mmzone.h>
@@ -68,6 +69,7 @@
 extern void *sys_call_table;
 
 extern struct timezone sys_tz;
+extern int panic_timeout;
 
 #ifdef CONFIG_MODVERSIONS
 const struct module_symbol __export_Using_Versions
@@ -388,6 +390,17 @@
 EXPORT_SYMBOL(proc_doulongvec_ms_jiffies_minmax);
 EXPORT_SYMBOL(proc_doulongvec_minmax);
 
+/* dump symbols and other symbols needed by dump functionality */
+EXPORT_SYMBOL(get_blkfops);
+EXPORT_SYMBOL(dump_function_ptr);
+EXPORT_SYMBOL(dump_in_progress);
+EXPORT_SYMBOL(dumping_cpu);
+EXPORT_SYMBOL(panic_timeout);
+EXPORT_SYMBOL(register_dump_notifier);
+EXPORT_SYMBOL(unregister_dump_notifier);
+EXPORT_SYMBOL(dump_notifier_list);
+EXPORT_SYMBOL(dump_device_register_ptr);
+
 /* interrupt handling */
 EXPORT_SYMBOL(add_timer);
 EXPORT_SYMBOL(del_timer);
