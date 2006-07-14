Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422752AbWGNUFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422752AbWGNUFu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422746AbWGNUFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:05:50 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:51140 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422745AbWGNUFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:05:23 -0400
Subject: [PATCH 02/02] remove set_wmb - arch removal
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       David Howells <dhowells@redhat.com>
In-Reply-To: <20060714105841.4490c0e2.akpm@osdl.org>
References: <1152882288.1883.30.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607140757080.5623@g5.osdl.org>
	 <Pine.LNX.4.64.0607141017520.5623@g5.osdl.org>
	 <1152898699.27135.20.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607141040550.5623@g5.osdl.org>
	 <20060714105841.4490c0e2.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 16:05:03 -0400
Message-Id: <1152907504.27135.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

set_wmb should not be used in the kernel because it just confuses the
code more and has no benefit.  Since it is not currently used in the
kernel this patch removes it so that new code does not include it.

All archs define set_wmb(var, value) to do { var = value; wmb(); }
while(0) except ia64 and sparc which use a mb() instead.  But this is
still moot since it is not used anyway.

Hasn't been tested on any archs but x86 and x86_64 (and only compiled
tested)

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.18-rc1/include/asm-alpha/barrier.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-alpha/barrier.h	2006-07-14 15:38:49.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-alpha/barrier.h	2006-07-14 15:39:01.000000000 -0400
@@ -30,7 +30,4 @@ __asm__ __volatile__("mb": : :"memory")
 #define set_mb(var, value) \
 do { var = value; mb(); } while (0)
 
-#define set_wmb(var, value) \
-do { var = value; wmb(); } while (0)
-
 #endif		/* __BARRIER_H */
Index: linux-2.6.18-rc1/include/asm-arm/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-arm/system.h	2006-07-14 15:38:49.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-arm/system.h	2006-07-14 15:39:05.000000000 -0400
@@ -176,7 +176,6 @@ extern unsigned int user_debug;
 #define wmb() mb()
 #define read_barrier_depends() do { } while(0)
 #define set_mb(var, value)  do { var = value; mb(); } while (0)
-#define set_wmb(var, value) do { var = value; wmb(); } while (0)
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
 /*
Index: linux-2.6.18-rc1/include/asm-arm26/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-arm26/system.h	2006-07-14 15:38:49.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-arm26/system.h	2006-07-14 15:39:13.000000000 -0400
@@ -90,7 +90,6 @@ extern unsigned int user_debug;
 
 #define read_barrier_depends() do { } while(0)
 #define set_mb(var, value)  do { var = value; mb(); } while (0)
-#define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
 /*
  * We assume knowledge of how
Index: linux-2.6.18-rc1/include/asm-cris/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-cris/system.h	2006-07-14 15:38:49.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-cris/system.h	2006-07-14 15:39:17.000000000 -0400
@@ -17,7 +17,6 @@ extern struct task_struct *resume(struct
 #define wmb() mb()
 #define read_barrier_depends() do { } while(0)
 #define set_mb(var, value)  do { var = value; mb(); } while (0)
-#define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
 #ifdef CONFIG_SMP
 #define smp_mb()        mb()
Index: linux-2.6.18-rc1/include/asm-frv/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-frv/system.h	2006-07-14 15:38:49.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-frv/system.h	2006-07-14 15:39:20.000000000 -0400
@@ -179,7 +179,6 @@ do {							\
 #define rmb()			asm volatile ("membar" : : :"memory")
 #define wmb()			asm volatile ("membar" : : :"memory")
 #define set_mb(var, value)	do { var = value; mb(); } while (0)
-#define set_wmb(var, value)	do { var = value; wmb(); } while (0)
 
 #define smp_mb()		mb()
 #define smp_rmb()		rmb()
Index: linux-2.6.18-rc1/include/asm-h8300/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-h8300/system.h	2006-07-14 15:38:49.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-h8300/system.h	2006-07-14 15:39:23.000000000 -0400
@@ -84,7 +84,6 @@ asmlinkage void resume(void);
 #define wmb()  asm volatile (""   : : :"memory")
 #define set_rmb(var, value)    do { xchg(&var, value); } while (0)
 #define set_mb(var, value)     set_rmb(var, value)
-#define set_wmb(var, value)    do { var = value; wmb(); } while (0)
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
Index: linux-2.6.18-rc1/include/asm-i386/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-i386/system.h	2006-07-14 15:38:49.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-i386/system.h	2006-07-14 15:39:27.000000000 -0400
@@ -454,8 +454,6 @@ static inline unsigned long long __cmpxc
 #define set_mb(var, value) do { var = value; barrier(); } while (0)
 #endif
 
-#define set_wmb(var, value) do { var = value; wmb(); } while (0)
-
 #include <linux/irqflags.h>
 
 /*
Index: linux-2.6.18-rc1/include/asm-ia64/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-ia64/system.h	2006-07-14 15:38:49.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-ia64/system.h	2006-07-14 15:39:43.000000000 -0400
@@ -98,12 +98,11 @@ extern struct ia64_boot_param {
 #endif
 
 /*
- * XXX check on these---I suspect what Linus really wants here is
+ * XXX check on this ---I suspect what Linus really wants here is
  * acquire vs release semantics but we can't discuss this stuff with
  * Linus just yet.  Grrr...
  */
 #define set_mb(var, value)	do { (var) = (value); mb(); } while (0)
-#define set_wmb(var, value)	do { (var) = (value); mb(); } while (0)
 
 #define safe_halt()         ia64_pal_halt_light()    /* PAL_HALT_LIGHT */
 
Index: linux-2.6.18-rc1/include/asm-m32r/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-m32r/system.h	2006-07-14 15:38:49.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-m32r/system.h	2006-07-14 15:39:47.000000000 -0400
@@ -336,7 +336,6 @@ __cmpxchg(volatile void *ptr, unsigned l
 #endif
 
 #define set_mb(var, value) do { xchg(&var, value); } while (0)
-#define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
 #define arch_align_stack(x) (x)
 
Index: linux-2.6.18-rc1/include/asm-m68k/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-m68k/system.h	2006-07-14 15:38:49.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-m68k/system.h	2006-07-14 15:39:52.000000000 -0400
@@ -80,7 +80,6 @@ static inline int irqs_disabled(void)
 #define wmb()		barrier()
 #define read_barrier_depends()	do { } while(0)
 #define set_mb(var, value)    do { xchg(&var, value); } while (0)
-#define set_wmb(var, value)    do { var = value; wmb(); } while (0)
 
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
Index: linux-2.6.18-rc1/include/asm-m68knommu/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-m68knommu/system.h	2006-07-14 15:38:49.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-m68knommu/system.h	2006-07-14 15:39:55.000000000 -0400
@@ -106,7 +106,6 @@ asmlinkage void resume(void);
 #define wmb()  asm volatile (""   : : :"memory")
 #define set_rmb(var, value)    do { xchg(&var, value); } while (0)
 #define set_mb(var, value)     set_rmb(var, value)
-#define set_wmb(var, value)    do { var = value; wmb(); } while (0)
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
Index: linux-2.6.18-rc1/include/asm-mips/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-mips/system.h	2006-07-14 15:38:49.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-mips/system.h	2006-07-14 15:39:59.000000000 -0400
@@ -143,9 +143,6 @@
 #define set_mb(var, value) \
 do { var = value; mb(); } while (0)
 
-#define set_wmb(var, value) \
-do { var = value; wmb(); } while (0)
-
 /*
  * switch_to(n) should switch tasks to task nr n, first
  * checking that n isn't the current task, in which case it does nothing.
Index: linux-2.6.18-rc1/include/asm-parisc/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-parisc/system.h	2006-07-14 15:38:49.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-parisc/system.h	2006-07-14 15:40:03.000000000 -0400
@@ -143,8 +143,6 @@ static inline void set_eiem(unsigned lon
 #define read_barrier_depends()		do { } while(0)
 
 #define set_mb(var, value)		do { var = value; mb(); } while (0)
-#define set_wmb(var, value)		do { var = value; wmb(); } while (0)
-
 
 #ifndef CONFIG_PA20
 /* Because kmalloc only guarantees 8-byte alignment for kmalloc'd data,
Index: linux-2.6.18-rc1/include/asm-powerpc/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-powerpc/system.h	2006-07-14 15:38:49.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-powerpc/system.h	2006-07-14 15:40:07.000000000 -0400
@@ -39,7 +39,6 @@
 #define read_barrier_depends()  do { } while(0)
 
 #define set_mb(var, value)	do { var = value; mb(); } while (0)
-#define set_wmb(var, value)	do { var = value; wmb(); } while (0)
 
 #ifdef __KERNEL__
 #ifdef CONFIG_SMP
Index: linux-2.6.18-rc1/include/asm-ppc/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-ppc/system.h	2006-07-14 15:38:49.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-ppc/system.h	2006-07-14 15:40:11.000000000 -0400
@@ -33,7 +33,6 @@
 #define read_barrier_depends()  do { } while(0)
 
 #define set_mb(var, value)	do { var = value; mb(); } while (0)
-#define set_wmb(var, value)	do { var = value; wmb(); } while (0)
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
Index: linux-2.6.18-rc1/include/asm-s390/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-s390/system.h	2006-07-14 15:38:49.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-s390/system.h	2006-07-14 15:40:15.000000000 -0400
@@ -299,7 +299,6 @@ __cmpxchg(volatile void *ptr, unsigned l
 
 
 #define set_mb(var, value)      do { var = value; mb(); } while (0)
-#define set_wmb(var, value)     do { var = value; wmb(); } while (0)
 
 #ifdef __s390x__
 
Index: linux-2.6.18-rc1/include/asm-sh/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-sh/system.h	2006-07-14 15:38:50.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-sh/system.h	2006-07-14 15:40:18.000000000 -0400
@@ -101,7 +101,6 @@ extern void __xchg_called_with_bad_point
 #endif
 
 #define set_mb(var, value) do { xchg(&var, value); } while (0)
-#define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
 /* Interrupt Control */
 static __inline__ void local_irq_enable(void)
Index: linux-2.6.18-rc1/include/asm-sh64/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-sh64/system.h	2006-07-14 15:38:50.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-sh64/system.h	2006-07-14 15:40:21.000000000 -0400
@@ -66,7 +66,6 @@ extern void __xchg_called_with_bad_point
 
 #define set_rmb(var, value) do { xchg(&var, value); } while (0)
 #define set_mb(var, value) set_rmb(var, value)
-#define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
 /* Interrupt Control */
 #ifndef HARD_CLI
Index: linux-2.6.18-rc1/include/asm-sparc/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-sparc/system.h	2006-07-14 15:38:50.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-sparc/system.h	2006-07-14 15:40:30.000000000 -0400
@@ -199,7 +199,6 @@ static inline unsigned long getipl(void)
 #define wmb()	mb()
 #define read_barrier_depends()	do { } while(0)
 #define set_mb(__var, __value)  do { __var = __value; mb(); } while(0)
-#define set_wmb(__var, __value) set_mb(__var, __value)
 #define smp_mb()	__asm__ __volatile__("":::"memory")
 #define smp_rmb()	__asm__ __volatile__("":::"memory")
 #define smp_wmb()	__asm__ __volatile__("":::"memory")
Index: linux-2.6.18-rc1/include/asm-sparc64/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-sparc64/system.h	2006-07-14 15:38:50.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-sparc64/system.h	2006-07-14 15:40:35.000000000 -0400
@@ -123,8 +123,6 @@ do {	__asm__ __volatile__("ba,pt	%%xcc, 
 #define read_barrier_depends()		do { } while(0)
 #define set_mb(__var, __value) \
 	do { __var = __value; membar_storeload_storestore(); } while(0)
-#define set_wmb(__var, __value) \
-	do { __var = __value; wmb(); } while(0)
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
Index: linux-2.6.18-rc1/include/asm-v850/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-v850/system.h	2006-07-14 15:38:50.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-v850/system.h	2006-07-14 15:40:39.000000000 -0400
@@ -68,7 +68,6 @@ static inline int irqs_disabled (void)
 #define read_barrier_depends()	((void)0)
 #define set_rmb(var, value)	do { xchg (&var, value); } while (0)
 #define set_mb(var, value)	set_rmb (var, value)
-#define set_wmb(var, value)	do { var = value; wmb (); } while (0)
 
 #define smp_mb()	mb ()
 #define smp_rmb()	rmb ()
Index: linux-2.6.18-rc1/include/asm-x86_64/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-x86_64/system.h	2006-07-14 15:38:50.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-x86_64/system.h	2006-07-14 15:40:42.000000000 -0400
@@ -240,7 +240,6 @@ static inline unsigned long __cmpxchg(vo
 #endif
 #define read_barrier_depends()	do {} while(0)
 #define set_mb(var, value) do { (void) xchg(&var, value); } while (0)
-#define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
 #define warn_if_not_ulong(x) do { unsigned long foo; (void) (&(x) == &foo); } while (0)
 
Index: linux-2.6.18-rc1/include/asm-xtensa/system.h
===================================================================
--- linux-2.6.18-rc1.orig/include/asm-xtensa/system.h	2006-07-14 15:38:50.000000000 -0400
+++ linux-2.6.18-rc1/include/asm-xtensa/system.h	2006-07-14 15:40:44.000000000 -0400
@@ -99,7 +99,6 @@ static inline void disable_coprocessor(i
 #endif
 
 #define set_mb(var, value)	do { var = value; mb(); } while (0)
-#define set_wmb(var, value)	do { var = value; wmb(); } while (0)
 
 #if !defined (__ASSEMBLY__)
 


