Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbUDNBje (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 21:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbUDNBje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 21:39:34 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:61827 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S263593AbUDNBi5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 21:38:57 -0400
Subject: [PATCH] Minor __sched cleanups
From: Rusty Russell <rusty@rustcorp.com.au>
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: William Lee Irwin III <wli@holomorphy.com>
Content-Type: text/plain
Message-Id: <1081906686.22908.31.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Apr 2004 11:38:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fairly minor cleanups to wli's recent __sched implementation:

Name: Minor __sched Cleanups
Status: Tested on 2.6.5-mm4
Version: -mm

1) __sched_text_start and __sched_test_end are more normal section
   marker names, and can be used directly.

2) There is no comment and no reason for __sched to be in linux/init.h:
   linux/sched.h would be preferable.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/alpha/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/alpha/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/alpha/kernel/process.c	2004-04-13 10:36:41.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/alpha/kernel/process.c	2004-04-13 15:10:20.000000000 +1000
@@ -513,8 +513,8 @@ thread_saved_pc(task_t *t)
 /*
  * These bracket the sleeping functions..
  */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 unsigned long
 get_wchan(struct task_struct *p)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/arm/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/arm/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/arm/kernel/process.c	2004-04-13 10:36:41.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/arm/kernel/process.c	2004-04-13 15:10:20.000000000 +1000
@@ -414,8 +414,8 @@ pid_t kernel_thread(int (*fn)(void *), v
 /*
  * These bracket the sleeping functions..
  */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 unsigned long get_wchan(struct task_struct *p)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/arm26/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/arm26/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/arm26/kernel/process.c	2004-04-13 10:36:41.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/arm26/kernel/process.c	2004-04-13 15:10:21.000000000 +1000
@@ -400,8 +400,8 @@ pid_t kernel_thread(int (*fn)(void *), v
 /*
  * These bracket the sleeping functions..
  */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 unsigned long get_wchan(struct task_struct *p)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/cris/arch-v10/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/cris/arch-v10/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/cris/arch-v10/kernel/process.c	2004-04-13 10:36:41.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/cris/arch-v10/kernel/process.c	2004-04-13 15:10:21.000000000 +1000
@@ -217,8 +217,8 @@ asmlinkage int sys_execve(const char *fn
  * These bracket the sleeping functions..
  */
 
-#define first_sched     ((unsigned long) scheduling_functions_start_here)
-#define last_sched      ((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 unsigned long get_wchan(struct task_struct *p)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/h8300/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/h8300/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/h8300/kernel/process.c	2004-04-13 10:36:41.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/h8300/kernel/process.c	2004-04-13 15:10:21.000000000 +1000
@@ -264,8 +264,8 @@ out:
 /*
  * These bracket the sleeping functions..
  */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/i386/kernel/kgdb_stub.c .24943-linux-2.6.5-mm4.updated/arch/i386/kernel/kgdb_stub.c
--- .24943-linux-2.6.5-mm4/arch/i386/kernel/kgdb_stub.c	2004-04-13 10:36:42.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/i386/kernel/kgdb_stub.c	2004-04-13 15:10:21.000000000 +1000
@@ -654,8 +654,8 @@ gdb_regs_to_regs(int *gdb_regs, struct p
 #endif
 
 }				/* gdb_regs_to_regs */
-#define first_sched	scheduling_functions_start_here
-#define last_sched	scheduling_functions_end_here
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 int thread_list = 0;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/i386/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/i386/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/i386/kernel/process.c	2004-04-13 10:36:42.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/i386/kernel/process.c	2004-04-13 15:10:21.000000000 +1000
@@ -632,8 +632,8 @@ out:
 /*
  * These bracket the sleeping functions..
  */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 #define top_esp                (THREAD_SIZE - sizeof(unsigned long))
 #define top_ebp                (THREAD_SIZE - 2*sizeof(unsigned long))
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/ia64/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/ia64/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/ia64/kernel/process.c	2004-04-13 10:36:42.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/ia64/kernel/process.c	2004-04-13 15:10:21.000000000 +1000
@@ -660,8 +660,8 @@ get_wchan (struct task_struct *p)
 	/*
 	 * These bracket the sleeping functions..
 	 */
-#	define first_sched	((unsigned long) scheduling_functions_start_here)
-#	define last_sched	((unsigned long) scheduling_functions_end_here)
+#	define first_sched	((unsigned long)__sched_text_start)
+#	define last_sched	((unsigned long)__sched_text_end)
 
 	/*
 	 * Note: p may not be a blocked task (it could be current or
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/m68k/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/m68k/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/m68k/kernel/process.c	2004-04-13 10:36:42.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/m68k/kernel/process.c	2004-04-13 15:10:21.000000000 +1000
@@ -67,8 +67,8 @@ unsigned long thread_saved_pc(struct tas
 {
 	struct switch_stack *sw = (struct switch_stack *)tsk->thread.ksp;
 	/* Check whether the thread is blocked in resume() */
-	if (sw->retpc > (unsigned long)scheduling_functions_start_here &&
-	    sw->retpc < (unsigned long)scheduling_functions_end_here)
+	if (sw->retpc > (unsigned long)__sched_text_start &&
+	    sw->retpc < (unsigned long)__sched_text_end)
 		return ((unsigned long *)sw->a6)[1];
 	else
 		return sw->retpc;
@@ -385,8 +385,8 @@ out:
 /*
  * These bracket the sleeping functions..
  */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 unsigned long get_wchan(struct task_struct *p)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/m68knommu/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/m68knommu/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/m68knommu/kernel/process.c	2004-04-13 10:36:42.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/m68knommu/kernel/process.c	2004-04-13 15:10:21.000000000 +1000
@@ -407,8 +407,8 @@ out:
 /*
  * These bracket the sleeping functions..
  */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 unsigned long get_wchan(struct task_struct *p)
 {
@@ -440,8 +440,8 @@ unsigned long thread_saved_pc(struct tas
 	struct switch_stack *sw = (struct switch_stack *)tsk->thread.ksp;
 
 	/* Check whether the thread is blocked in resume() */
-	if (sw->retpc > (unsigned long)scheduling_functions_start_here &&
-	    sw->retpc < (unsigned long)scheduling_functions_end_here)
+	if (sw->retpc > (unsigned long)__sched_text_start &&
+	    sw->retpc < (unsigned long)__sched_text_end)
 		return ((unsigned long *)sw->a6)[1];
 	else
 		return sw->retpc;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/mips/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/mips/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/mips/kernel/process.c	2004-04-13 10:36:43.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/mips/kernel/process.c	2004-04-13 15:10:21.000000000 +1000
@@ -283,8 +283,8 @@ unsigned long thread_saved_pc(struct tas
 /*
  * These bracket the sleeping functions..
  */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 /* get_wchan - a maintenance nightmare^W^Wpain in the ass ...  */
 unsigned long get_wchan(struct task_struct *p)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/ppc/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/ppc/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/ppc/kernel/process.c	2004-04-13 10:36:43.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/ppc/kernel/process.c	2004-04-13 15:10:21.000000000 +1000
@@ -661,8 +661,8 @@ void __init ll_puts(const char *s)
 /*
  * These bracket the sleeping functions..
  */
-#define first_sched    ((unsigned long) scheduling_functions_start_here)
-#define last_sched     ((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 unsigned long get_wchan(struct task_struct *p)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/ppc64/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/ppc64/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/ppc64/kernel/process.c	2004-04-13 10:36:43.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/ppc64/kernel/process.c	2004-04-13 15:10:21.000000000 +1000
@@ -475,8 +475,8 @@ static inline int validate_sp(unsigned l
 /*
  * These bracket the sleeping functions..
  */
-#define first_sched    (*(unsigned long *)scheduling_functions_start_here)
-#define last_sched     (*(unsigned long *)scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 unsigned long get_wchan(struct task_struct *p)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/s390/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/s390/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/s390/kernel/process.c	2004-04-13 10:36:44.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/s390/kernel/process.c	2004-04-13 15:10:21.000000000 +1000
@@ -384,8 +384,8 @@ void dump_thread(struct pt_regs * regs, 
 /*
  * These bracket the sleeping functions..
  */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 unsigned long get_wchan(struct task_struct *p)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/sh/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/sh/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/sh/kernel/process.c	2004-04-13 10:36:44.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/sh/kernel/process.c	2004-04-13 15:10:21.000000000 +1000
@@ -464,8 +464,8 @@ out:
 /*
  * These bracket the sleeping functions..
  */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 unsigned long get_wchan(struct task_struct *p)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/sparc/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/sparc/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/sparc/kernel/process.c	2004-04-13 10:36:44.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/sparc/kernel/process.c	2004-04-13 15:10:21.000000000 +1000
@@ -715,8 +715,8 @@ unsigned long get_wchan(struct task_stru
 			break;
 		rw = (struct reg_window *) fp;
 		pc = rw->ins[7];
-		if (pc < ((unsigned long) scheduling_functions_start_here) ||
-                    pc >= ((unsigned long) scheduling_functions_end_here)) {
+		if (pc < ((unsigned long)__sched_text_start) ||
+                    pc >= ((unsigned long)__sched_text_end)) {
 			ret = pc;
 			goto out;
 		}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/sparc64/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/sparc64/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/sparc64/kernel/process.c	2004-04-13 10:36:44.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/sparc64/kernel/process.c	2004-04-13 15:10:21.000000000 +1000
@@ -847,8 +847,8 @@ unsigned long get_wchan(struct task_stru
 			break;
 		rw = (struct reg_window *) fp;
 		pc = rw->ins[7];
-		if (pc < ((unsigned long) scheduling_functions_start_here) ||
-		    pc >= ((unsigned long) scheduling_functions_end_here)) {
+		if (pc < ((unsigned long)__sched_text_start) ||
+		    pc >= ((unsigned long)__sched_text_end)) {
 			ret = pc;
 			goto out;
 		}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/v850/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/v850/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/v850/kernel/process.c	2004-04-13 10:36:44.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/v850/kernel/process.c	2004-04-13 15:10:21.000000000 +1000
@@ -203,8 +203,8 @@ int sys_execve (char *name, char **argv,
 /*
  * These bracket the sleeping functions..
  */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 unsigned long get_wchan (struct task_struct *p)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/x86_64/kernel/kgdb_stub.c .24943-linux-2.6.5-mm4.updated/arch/x86_64/kernel/kgdb_stub.c
--- .24943-linux-2.6.5-mm4/arch/x86_64/kernel/kgdb_stub.c	2004-04-13 10:36:46.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/x86_64/kernel/kgdb_stub.c	2004-04-13 15:10:21.000000000 +1000
@@ -667,8 +667,8 @@ gdb_regs_to_regs(unsigned long *gdb_regs
 #endif
 }				/* gdb_regs_to_regs */
 
-#define first_sched	scheduling_functions_start_here
-#define last_sched	scheduling_functions_end_here
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 int thread_list = 0;
 extern void thread_return(void);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/arch/x86_64/kernel/process.c .24943-linux-2.6.5-mm4.updated/arch/x86_64/kernel/process.c
--- .24943-linux-2.6.5-mm4/arch/x86_64/kernel/process.c	2004-04-13 10:36:46.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/arch/x86_64/kernel/process.c	2004-04-13 15:10:21.000000000 +1000
@@ -576,8 +576,8 @@ asmlinkage long sys_vfork(struct pt_regs
 /*
  * These bracket the sleeping functions..
  */
-#define first_sched	((unsigned long) scheduling_functions_start_here)
-#define last_sched	((unsigned long) scheduling_functions_end_here)
+#define first_sched	((unsigned long)__sched_text_start)
+#define last_sched	((unsigned long)__sched_text_end)
 
 unsigned long get_wchan(struct task_struct *p)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/include/asm-generic/vmlinux.lds.h .24943-linux-2.6.5-mm4.updated/include/asm-generic/vmlinux.lds.h
--- .24943-linux-2.6.5-mm4/include/asm-generic/vmlinux.lds.h	2004-04-13 10:37:08.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/include/asm-generic/vmlinux.lds.h	2004-04-13 15:10:21.000000000 +1000
@@ -53,6 +53,6 @@
 	}
 
 #define SCHED_TEXT							\
-		__scheduling_functions_start_here = .;			\
+		__sched_text_start = .;					\
 		*(.sched.text)						\
-		__scheduling_functions_end_here = .;
+		__sched_text_end = .;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/include/linux/init.h .24943-linux-2.6.5-mm4.updated/include/linux/init.h
--- .24943-linux-2.6.5-mm4/include/linux/init.h	2004-04-13 10:37:09.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/include/linux/init.h	2004-04-13 16:30:35.000000000 +1000
@@ -47,8 +47,6 @@
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
 #define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
 
-#define __sched		__attribute__((__section__(".sched.text")))
-
 #ifdef MODULE
 #define __exit		__attribute__ ((__section__(".exit.text")))
 #else
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/include/linux/sched.h .24943-linux-2.6.5-mm4.updated/include/linux/sched.h
--- .24943-linux-2.6.5-mm4/include/linux/sched.h	2004-04-13 10:37:12.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/include/linux/sched.h	2004-04-13 15:10:21.000000000 +1000
@@ -172,6 +172,12 @@ extern void update_one_process(struct ta
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
+
+/* Attach to any functions which should be ignored in wchan output. */
+#define __sched		__attribute__((__section__(".sched.text")))
+/* Linker adds these: start and end of __sched functions */
+extern char __sched_text_start[], __sched_text_end[];
+
 extern const unsigned long scheduling_functions_start_here;
 extern const unsigned long scheduling_functions_end_here;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24943-linux-2.6.5-mm4/kernel/sched.c .24943-linux-2.6.5-mm4.updated/kernel/sched.c
--- .24943-linux-2.6.5-mm4/kernel/sched.c	2004-04-13 10:37:13.000000000 +1000
+++ .24943-linux-2.6.5-mm4.updated/kernel/sched.c	2004-04-13 15:10:21.000000000 +1000
@@ -252,13 +252,6 @@ static DEFINE_PER_CPU(struct runqueue, r
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 
-extern unsigned long __scheduling_functions_start_here;
-extern unsigned long __scheduling_functions_end_here;
-const unsigned long scheduling_functions_start_here =
-			(unsigned long)&__scheduling_functions_start_here;
-const unsigned long scheduling_functions_end_here =
-			(unsigned long)&__scheduling_functions_end_here;
-
 /*
  * Default context-switch locking:
  */


-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

