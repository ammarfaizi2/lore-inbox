Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262212AbSKDRqT>; Mon, 4 Nov 2002 12:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbSKDRqT>; Mon, 4 Nov 2002 12:46:19 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:34483 "HELO atlrel8.hp.com")
	by vger.kernel.org with SMTP id <S262212AbSKDRqN>;
	Mon, 4 Nov 2002 12:46:13 -0500
Date: Mon, 4 Nov 2002 10:49:54 -0700
From: Matthew Wilcox <willy@debian.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove *_segments() dummy functions from all other architectures
Message-ID: <20021104174954.GC32425@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A supplement to manfred's patch; remove copy_segments, release_segments
and even forget_segments from all architectures (except x86-64 since
Andi wants to do that seperately):

===== include/asm-alpha/processor.h 1.6 vs edited =====
--- 1.6/include/asm-alpha/processor.h	Tue Jul 30 06:44:32 2002
+++ edited/include/asm-alpha/processor.h	Mon Nov  4 10:28:14 2002
@@ -55,9 +55,6 @@
 /* Create a kernel thread without removing it from tasklists.  */
 extern long kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 
-#define copy_segments(tsk, mm)		do { } while (0)
-#define release_segments(mm)		do { } while (0)
-
 unsigned long get_wchan(struct task_struct *p);
 
 /* See arch/alpha/kernel/ptrace.c for details.  */
===== include/asm-arm/processor.h 1.11 vs edited =====
--- 1.11/include/asm-arm/processor.h	Sun Oct 13 08:32:28 2002
+++ edited/include/asm-arm/processor.h	Mon Nov  4 10:28:26 2002
@@ -62,10 +62,6 @@
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
 
-/* Copy and release all segment info associated with a VM */
-#define copy_segments(tsk, mm)		do { } while (0)
-#define release_segments(mm)		do { } while (0)
-
 unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()			barrier()
===== include/asm-cris/processor.h 1.10 vs edited =====
--- 1.10/include/asm-cris/processor.h	Tue Jul 30 06:44:53 2002
+++ edited/include/asm-cris/processor.h	Mon Nov  4 10:28:32 2002
@@ -108,10 +108,6 @@
 
 #define KSTK_ESP(tsk)   ((tsk) == current ? rdusp() : (tsk)->thread.usp)
 
-#define copy_segments(tsk, mm)          do { } while (0)
-#define release_segments(mm)            do { } while (0)
-#define forget_segments()               do { } while (0)
- 
 /*
  * Free current thread data structures etc..
  */
===== include/asm-ia64/processor.h 1.26 vs edited =====
--- 1.26/include/asm-ia64/processor.h	Thu Oct 31 04:36:58 2002
+++ edited/include/asm-ia64/processor.h	Mon Nov  4 10:28:42 2002
@@ -362,10 +362,6 @@
  */
 extern int kernel_thread (int (*fn)(void *), void *arg, unsigned long flags);
 
-/* Copy and release all segment info associated with a VM */
-#define copy_segments(tsk, mm)			do { } while (0)
-#define release_segments(mm)			do { } while (0)
-
 /* Get wait channel for task P.  */
 extern unsigned long get_wchan (struct task_struct *p);
 
===== include/asm-m68k/processor.h 1.6 vs edited =====
--- 1.6/include/asm-m68k/processor.h	Tue Jul 30 06:45:23 2002
+++ edited/include/asm-m68k/processor.h	Mon Nov  4 10:28:50 2002
@@ -114,9 +114,6 @@
 
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-#define copy_segments(tsk, mm)		do { } while (0)
-#define release_segments(mm)		do { } while (0)
-
 /*
  * Free current thread data structures etc..
  */
===== include/asm-m68knommu/processor.h 1.1 vs edited =====
--- 1.1/include/asm-m68knommu/processor.h	Fri Nov  1 09:37:46 2002
+++ edited/include/asm-m68knommu/processor.h	Mon Nov  4 10:28:59 2002
@@ -104,10 +104,6 @@
 
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-#define copy_segments(tsk, mm)		do { } while (0)
-#define release_segments(mm)		do { } while (0)
-#define forget_segments()		do { } while (0)
-
 /*
  * Free current thread data structures etc..
  */
===== include/asm-mips/processor.h 1.7 vs edited =====
--- 1.7/include/asm-mips/processor.h	Tue Jul 30 06:45:33 2002
+++ edited/include/asm-mips/processor.h	Mon Nov  4 10:29:06 2002
@@ -210,10 +210,6 @@
 
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-/* Copy and release all segment info associated with a VM */
-#define copy_segments(p, mm) do { } while(0)
-#define release_segments(mm) do { } while(0)
-
 /*
  * Return saved PC of a blocked thread.
  */
===== include/asm-mips64/processor.h 1.5 vs edited =====
--- 1.5/include/asm-mips64/processor.h	Tue Jul 30 06:45:44 2002
+++ edited/include/asm-mips64/processor.h	Mon Nov  4 10:29:10 2002
@@ -233,10 +233,6 @@
 
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-/* Copy and release all segment info associated with a VM */
-#define copy_segments(p, mm) do { } while(0)
-#define release_segments(mm) do { } while(0)
-
 /*
  * Return saved PC of a blocked thread.
  */
===== include/asm-parisc/processor.h 1.6 vs edited =====
--- 1.6/include/asm-parisc/processor.h	Thu Oct 31 10:40:31 2002
+++ edited/include/asm-parisc/processor.h	Mon Nov  4 10:32:30 2002
@@ -295,12 +295,6 @@
 
 extern void map_hpux_gateway_page(struct task_struct *tsk, struct mm_struct *mm);
 
-#define copy_segments(tsk, mm)  do { \
-					if (tsk->personality == PER_HPUX)  \
-					    map_hpux_gateway_page(tsk,mm); \
-				} while (0)
-#define release_segments(mm)	do { } while (0)
-
 static inline unsigned long get_wchan(struct task_struct *p)
 {
 	return 0xdeadbeef; /* XXX */
===== include/asm-ppc/processor.h 1.19 vs edited =====
--- 1.19/include/asm-ppc/processor.h	Sun Sep 15 22:52:05 2002
+++ edited/include/asm-ppc/processor.h	Mon Nov  4 10:32:37 2002
@@ -736,9 +736,6 @@
 #define thread_saved_pc(tsk)	\
 	((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
 
-#define copy_segments(tsk, mm)		do { } while (0)
-#define release_segments(mm)		do { } while (0)
-
 unsigned long get_wchan(struct task_struct *p);
 
 #define KSTK_EIP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
===== include/asm-ppc64/processor.h 1.20 vs edited =====
--- 1.20/include/asm-ppc64/processor.h	Tue Oct  8 00:57:08 2002
+++ edited/include/asm-ppc64/processor.h	Mon Nov  4 10:32:42 2002
@@ -682,10 +682,6 @@
 #define thread_saved_pc(tsk)    \
         ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
 
-#define copy_segments(tsk, mm)		do { } while (0)
-#define release_segments(mm)		do { } while (0)
-#define forget_segments()		do { } while (0)
-
 unsigned long get_wchan(struct task_struct *p);
 
 #define KSTK_EIP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
===== include/asm-s390/processor.h 1.8 vs edited =====
--- 1.8/include/asm-s390/processor.h	Fri Oct  4 10:16:18 2002
+++ edited/include/asm-s390/processor.h	Mon Nov  4 10:32:47 2002
@@ -114,10 +114,6 @@
 extern void release_thread(struct task_struct *);
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-/* Copy and release all segment info associated with a VM */
-#define copy_segments(nr, mm)           do { } while (0)
-#define release_segments(mm)            do { } while (0)
-
 /*
  * Return saved PC of a blocked thread.
  */
===== include/asm-s390x/processor.h 1.7 vs edited =====
--- 1.7/include/asm-s390x/processor.h	Fri Oct  4 10:16:18 2002
+++ edited/include/asm-s390x/processor.h	Mon Nov  4 10:32:52 2002
@@ -131,10 +131,6 @@
 extern void release_thread(struct task_struct *);
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-/* Copy and release all segment info associated with a VM */
-#define copy_segments(nr, mm)           do { } while (0)
-#define release_segments(mm)            do { } while (0)
-
 /*
  * Return saved PC of a blocked thread.
  */
===== include/asm-sh/processor.h 1.8 vs edited =====
--- 1.8/include/asm-sh/processor.h	Tue Jul 30 06:46:09 2002
+++ edited/include/asm-sh/processor.h	Mon Nov  4 10:32:59 2002
@@ -147,11 +147,6 @@
 #define MCA_bus 0
 #define MCA_bus__is_a_macro /* for versions in ksyms.c */
 
-
-/* Copy and release all segment info associated with a VM */
-#define copy_segments(p, mm)	do { } while(0)
-#define release_segments(mm)	do { } while(0)
-
 /*
  * FPU lazy state save handling.
  */
===== include/asm-sparc/processor.h 1.8 vs edited =====
--- 1.8/include/asm-sparc/processor.h	Thu Aug  1 19:06:16 2002
+++ edited/include/asm-sparc/processor.h	Mon Nov  4 10:33:05 2002
@@ -140,10 +140,6 @@
 #define release_thread(tsk)		do { } while(0)
 extern pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-
-#define copy_segments(tsk, mm)		do { } while (0)
-#define release_segments(mm)		do { } while (0)
-
 #define get_wchan(__TSK) \
 ({	extern void scheduling_functions_start_here(void); \
 	extern void scheduling_functions_end_here(void); \
===== include/asm-sparc64/processor.h 1.11 vs edited =====
--- 1.11/include/asm-sparc64/processor.h	Tue Jul 30 06:57:17 2002
+++ edited/include/asm-sparc64/processor.h	Mon Nov  4 10:33:10 2002
@@ -188,9 +188,6 @@
 
 extern pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
-#define copy_segments(tsk, mm)		do { } while (0)
-#define release_segments(mm)		do { } while (0)
-
 #define get_wchan(__TSK) \
 ({	extern void scheduling_functions_start_here(void); \
 	extern void scheduling_functions_end_here(void); \
===== include/asm-um/processor-generic.h 1.1 vs edited =====
--- 1.1/include/asm-um/processor-generic.h	Fri Sep  6 11:29:29 2002
+++ edited/include/asm-um/processor-generic.h	Mon Nov  4 10:45:02 2002
@@ -92,17 +92,6 @@
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 extern void dump_thread(struct pt_regs *regs, struct user *u);
 
-static inline void release_segments(struct mm_struct *mm)
-{
-}
-
-static inline void copy_segments(struct task_struct *p, 
-				 struct mm_struct *new_mm)
-{
-}
-
-#define forget_segments() do ; while(0)
-
 extern unsigned long thread_saved_pc(struct task_struct *t);
 
 #define init_stack	(init_thread_union.stack)

-- 
It's always legal to use Linux (TM) systems
http://www.gnu.org/philosophy/why-free.html
