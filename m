Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVGFDF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVGFDF7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVGFDDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:03:43 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:8601 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262067AbVGFCT0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:26 -0400
Subject: [PATCH] [22/48] Suspend2 2.1.9.8 for 2.6.12: 560-Kconfig-and-Makefile-for-suspend2.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:41 +1000
Message-Id: <11206164413854@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 600-suspend-header.patch-old/include/linux/suspend2.h 600-suspend-header.patch-new/include/linux/suspend2.h
--- 600-suspend-header.patch-old/include/linux/suspend2.h	1970-01-01 10:00:00.000000000 +1000
+++ 600-suspend-header.patch-new/include/linux/suspend2.h	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,213 @@
+#ifndef _LINUX_SUSPEND2_H
+#define _LINUX_SUSPEND2_H
+
+#include <linux/dyn_pageflags.h>
+#include <linux/init.h>
+
+/* arch/i386/mm/init.c */
+extern char __nosave_begin, __nosave_end;
+
+extern char __nosavedata swsusp_pg_dir[PAGE_SIZE]
+                  __attribute__ ((aligned (PAGE_SIZE)));
+
+/* kernel/power/process.c */
+
+/* fs/buffer.c */
+extern unsigned int suspend_task;
+
+#define SUSPEND_KEY_KEYBOARD 1
+#define SUSPEND_KEY_SERIAL 2
+
+/* kernel/power/main.c */
+extern unsigned long suspend_result;
+
+/* kernel/power/process.c */
+extern unsigned long suspend_debug_state;
+
+/* arch/i386/power/suspend2.c */
+extern unsigned long suspend_action;
+extern int suspend_io_time[2][2];
+
+/* Pre and post lowlevel routines */
+//extern void suspend2_suspend_1 (void);
+//extern void suspend2_suspend_2 (void);
+//extern void suspend2_resume_1 (void);
+//extern void suspend2_resume_2 (void);
+
+extern dyn_pageflags_t pageset1_map;
+extern dyn_pageflags_t	pageset1_copy_map;
+
+#ifdef CONFIG_PM_DEBUG
+#define TEST_DEBUG_STATE(bit) (test_bit(bit, &suspend_debug_state))
+#else
+#define TEST_DEBUG_STATE(bit) (0)
+#endif
+
+#define TEST_RESULT_STATE(bit) (test_bit(bit, &suspend_result))
+
+/* 
+ * First status register - this is suspend's return code.
+ *
+ * All the rest are in kernel/power/suspend2_common.h
+ */
+#define SUSPEND_ABORTED			0
+
+/* Second status register - ditto */
+#define SUSPEND_RETRY_RESUME		0
+
+/* Debug sections  - if debugging compiled in */
+#define SUSPEND_ANY_SECTION	0
+#define SUSPEND_FREEZER		1
+#define SUSPEND_EAT_MEMORY 	2
+#define SUSPEND_PAGESETS	3
+#define SUSPEND_IO		4
+#define SUSPEND_BMAP		5
+#define SUSPEND_HEADER		6
+#define SUSPEND_WRITER		7
+#define SUSPEND_MEMORY		8
+#define SUSPEND_EXTENTS		9
+#define SUSPEND_SPINLOCKS	10
+#define SUSPEND_MEM_POOL	11
+#define SUSPEND_RANGE_PARANOIA	12
+#define SUSPEND_NOSAVE		13
+#define SUSPEND_INTEGRITY	14
+
+/* debugging levels. */
+#define SUSPEND_STATUS		0
+#define SUSPEND_ERROR		2
+#define SUSPEND_LOW	 	3
+#define SUSPEND_MEDIUM	 	4
+#define SUSPEND_HIGH	  	5
+#define SUSPEND_VERBOSE		6
+
+extern void __suspend_message(unsigned long section, unsigned long level, int log_normally,
+		const char *fmt, ...);
+
+#ifdef CONFIG_PM_DEBUG
+#define suspend_message(sn, lev, log, fmt, a...) \
+do { \
+	if (TEST_DEBUG_STATE(sn)) \
+		__suspend_message(sn, lev, log, fmt, ##a); \
+} while(0)
+#else /* CONFIG_PM_DEBUG */
+#define suspend_message(sn, lev, log, fmt, a...) \
+do { \
+	if (lev == 0) \
+		__suspend_message(sn, lev, log, fmt, ##a); \
+} while(0)
+#endif /* CONFIG_PM_DEBUG */
+  
+/* Suspend 2 */
+
+#define SUSPEND_DISABLED		0
+#define SUSPEND_RUNNING			1
+#define SUSPEND_RESUME_DEVICE_OK	2
+#define SUSPEND_NORESUME_SPECIFIED	3
+#define SUSPEND_COMMANDLINE_ERROR 	4
+#define SUSPEND_IGNORE_IMAGE		5
+#define SUSPEND_SANITY_CHECK_PROMPT	6
+#define SUSPEND_FREEZER_ON		7
+#define SUSPEND_DISABLE_SYNCING		8
+#define SUSPEND_BLOCK_PAGE_ALLOCATIONS	9
+#define SUSPEND_USE_MEMORY_POOL		10
+#define SUSPEND_STAGE2_CONTINUE		11
+#define SUSPEND_FREEZE_SMP		12
+#define SUSPEND_PAGESET2_NOT_LOADED	13
+#define SUSPEND_CONTINUE_REQ		14
+#define SUSPEND_RESUMED_BEFORE		15
+#define SUSPEND_RUNNING_INITRD		16
+#define SUSPEND_RESUME_NOT_DONE		17
+#define SUSPEND_BOOT_TIME		18
+#define SUSPEND_NOW_RESUMING		19
+#define SUSPEND_SLAB_ALLOC_FALLBACK	20
+#define SUSPEND_IGNORE_LOGLEVEL		21
+#define SUSPEND_TIMER_FREEZER_ON	22
+#define SUSPEND_ACT_USED		23
+#define SUSPEND_DBG_USED		24
+#define SUSPEND_LVL_USED		25
+#define SUSPEND_TRYING_TO_RESUME	27
+
+#define test_and_set_suspend_state(bit) \
+	(test_and_set_bit(bit, &software_suspend_state))
+
+#define get_suspend_state() 		(software_suspend_state)
+#define restore_suspend_state(saved_state) \
+	do { software_suspend_state = saved_state; } while(0)
+	
+/* Kernel threads are type 3 */
+#define FREEZER_ALL_THREADS 0
+#define FREEZER_KERNEL_THREADS 3
+
+/* --------------------------------------------------------------------- */
+#ifdef CONFIG_SUSPEND2
+
+/* Used in init dir files */
+extern unsigned long software_suspend_state;
+
+extern void suspend2_try_resume(void);
+extern int suspend_early_boot_message 
+	(int can_erase_image, int default_answer, char *warning_reason, ...);
+extern void suspend_handle_keypress(unsigned int keycode, int source);
+extern unsigned long suspend2_update_status (unsigned long value, unsigned long maximum,
+		const char *fmt, ...);
+extern void suspend2_prepare_status (int printalways, int clearbar, const char *fmt, ...);
+extern void suspend2_cleanup_finished_io(void);
+
+#define test_suspend_state(bit) \
+	(test_bit(bit, &software_suspend_state))
+
+#define clear_suspend_state(bit) \
+	(clear_bit(bit, &software_suspend_state))
+
+#define set_suspend_state(bit) \
+	(set_bit(bit, &software_suspend_state))
+
+#ifdef CONFIG_SMP
+void smp_pause(void);
+void smp_continue(void);
+void smp_suspend(void);
+#else
+#define smp_pause() do { } while(0)
+#define smp_continue() do { } while(0)
+#define smp_suspend() do { } while(0)
+#endif
+
+extern unsigned long suspend2_get_nonconflicting_page(void);
+extern unsigned long suspend2_get_nonconflicting_pages(int order);
+
+extern inline void suspend2_copyback_low(void);
+extern inline void suspend2_copyback_high(void);
+
+extern void suspend2_try_suspend(void);
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+int suspend_map_kernel_page(struct page * page, int enable);
+#else
+static inline int suspend_map_kernel_page(struct page * page, int enable)
+{
+	return (enable == 1);
+}
+#endif
+
+/* --------------------------------------------------------------------- */
+#else
+/* --------------------------------------------------------------------- */
+
+#define software_suspend_state		(0)
+#define clear_suspend_state(bit)	do { } while (0)
+#define test_suspend_state(bit) 	(0)
+#define set_suspend_state(bit)		do { } while(0)
+
+#define suspend2_try_resume()			do { } while(0)
+static inline int suspend_early_boot_message(int a, int b, char *c, ...)	{ return 0; }
+#define suspend_handle_keypress(a, b) 		do { } while(0)
+static inline unsigned long suspend2_update_status(unsigned long value, unsigned long maximum,
+		const char *fmt, ...)
+{
+	return maximum;
+}
+#define suspend2_cleanup_finished_io() do { } while(0)
+#define suspend2_prepare_status(a, ...)  do { } while(0)
+
+#endif /* CONFIG_SUSPEND2 */
+#endif /* _LINUX_SUSPEND2_H */
diff -ruNp 600-suspend-header.patch-old/include/linux/suspend.h 600-suspend-header.patch-new/include/linux/suspend.h
--- 600-suspend-header.patch-old/include/linux/suspend.h	2005-06-20 11:47:30.000000000 +1000
+++ 600-suspend-header.patch-new/include/linux/suspend.h	2005-07-04 23:14:19.000000000 +1000
@@ -9,6 +9,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pm.h>
+#include <linux/suspend2.h>
 
 /* page backup entry */
 typedef struct pbe {
@@ -58,18 +59,20 @@ static inline int software_suspend(void)
 }
 #endif
 
-#ifdef CONFIG_SMP
+void save_processor_state(void);
+void restore_processor_state(void);
+struct saved_context;
+void __save_processor_state(struct saved_context *ctxt);
+void __restore_processor_state(struct saved_context *ctxt);
+
+#ifdef CONFIG_HOTPLUG_CPU
 extern void disable_nonboot_cpus(void);
 extern void enable_nonboot_cpus(void);
 #else
-static inline void disable_nonboot_cpus(void) {}
+static inline int disable_nonboot_cpus(void) { return 0; }
 static inline void enable_nonboot_cpus(void) {}
 #endif
 
-void save_processor_state(void);
-void restore_processor_state(void);
-struct saved_context;
-void __save_processor_state(struct saved_context *ctxt);
-void __restore_processor_state(struct saved_context *ctxt);
+extern char resume2_file[256];
 
 #endif /* _LINUX_SWSUSP_H */

