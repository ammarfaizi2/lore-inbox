Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267705AbUJNWJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbUJNWJC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267553AbUJNWHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:07:53 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16364 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267374AbUJNVo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:44:59 -0400
Date: Thu, 14 Oct 2004 23:44:57 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] move spinlock definitions to spinlock_types.h
Message-ID: <Pine.LNX.4.61.0410142344410.29972@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This moves the definition and initializer of spinlock_t and rwlock_t to
spinlock_types.h.


 asm-alpha/spinlock.h           |   27 ----------------
 asm-alpha/spinlock_types.h     |   36 ++++++++++++++++++++++
 asm-arm/spinlock.h             |   13 -------
 asm-arm/spinlock_types.h       |   23 ++++++++++++++
 asm-arm26/spinlock_types.h     |    4 ++
 asm-cris/spinlock_types.h      |    4 ++
 asm-h8300/spinlock_types.h     |    4 ++
 asm-i386/rwlock.h              |    3 -
 asm-i386/spinlock.h            |   38 -----------------------
 asm-i386/spinlock_types.h      |   55 +++++++++++++++++++++++++++++++++
 asm-ia64/spinlock.h            |   14 --------
 asm-ia64/spinlock_types.h      |   23 ++++++++++++++
 asm-m68k/spinlock_types.h      |    4 ++
 asm-m68knommu/spinlock_types.h |    6 +++
 asm-mips/spinlock.h            |   16 ---------
 asm-mips/spinlock_types.h      |   24 ++++++++++++++
 asm-parisc/spinlock.h          |   23 --------------
 asm-parisc/spinlock_types.h    |   55 +++++++++++++++++++++++++++++++++
 asm-parisc/system.h            |   23 --------------
 asm-ppc/spinlock.h             |   34 --------------------
 asm-ppc/spinlock_types.h       |   43 ++++++++++++++++++++++++++
 asm-ppc64/spinlock.h           |   13 -------
 asm-ppc64/spinlock_types.h     |   24 ++++++++++++++
 asm-s390/spinlock.h            |   15 ---------
 asm-s390/spinlock_types.h      |   24 ++++++++++++++
 asm-sh/spinlock.h              |   16 ---------
 asm-sh/spinlock_types.h        |   25 +++++++++++++++
 asm-sh64/spinlock_types.h      |    4 ++
 asm-sparc/spinlock.h           |   26 ---------------
 asm-sparc/spinlock_types.h     |   45 +++++++++++++++++++++++++++
 asm-sparc64/spinlock.h         |   24 --------------
 asm-sparc64/spinlock_types.h   |   42 +++++++++++++++++++++++++
 asm-um/spinlock_types.h        |    6 +++
 asm-v850/spinlock_types.h      |    4 ++
 asm-x86_64/rwlock.h            |    3 -
 asm-x86_64/spinlock.h          |   38 -----------------------
 asm-x86_64/spinlock_types.h    |   49 +++++++++++++++++++++++++++++
 linux/spinlock.h               |   44 --------------------------
 linux/spinlock_types.h         |   67 +++++++++++++++++++++++++++++++++++++++++
 39 files changed, 572 insertions(+), 369 deletions(-)

Index: linux-2.6-inc/include/asm-ppc64/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-ppc64/spinlock_types.h	2004-10-13 21:32:39.278272985 +0200
@@ -0,0 +1,24 @@
+#ifndef __ASM_PPC64_SPINLOCK_TYPES_H
+#define __ASM_PPC64_SPINLOCK_TYPES_H
+
+#ifdef CONFIG_SMP
+
+typedef struct {
+	volatile unsigned int lock;
+} spinlock_t;
+
+#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
+
+#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
+
+typedef struct {
+	volatile signed int lock;
+} rwlock_t;
+
+#define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
+
+#define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+
+#endif /* CONFIG_SMP */
+
+#endif /* __ASM_PPC64_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-mips/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-mips/spinlock_types.h	2004-10-13 21:32:39.278272985 +0200
@@ -0,0 +1,24 @@
+#ifndef __ASM_MIPS_SPINLOCK_TYPES_H
+#define __ASM_MIPS_SPINLOCK_TYPES_H
+
+#ifdef CONFIG_SMP
+
+typedef struct {
+	volatile unsigned int lock;
+} spinlock_t;
+
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+
+#define spin_lock_init(x)	do { (x)->lock = 0; } while(0)
+
+typedef struct {
+	volatile unsigned int lock;
+} rwlock_t;
+
+#define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
+
+#define rwlock_init(x)  do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+
+#endif /* CONFIG_SMP */
+
+#endif /* __ASM_MIPS_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-s390/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-s390/spinlock_types.h	2004-10-13 21:32:39.278272985 +0200
@@ -0,0 +1,24 @@
+#ifndef __ASM_S390_SPINLOCK_TYPES_H
+#define __ASM_S390_SPINLOCK_TYPES_H
+
+#ifdef CONFIG_SMP
+
+typedef struct {
+	volatile unsigned int lock;
+} __attribute__ ((aligned (4))) spinlock_t;
+
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+#define spin_lock_init(lp) do { (lp)->lock = 0; } while(0)
+
+typedef struct {
+	volatile unsigned long lock;
+	volatile unsigned long owner_pc;
+} rwlock_t;
+
+#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
+
+#define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+
+#endif /* CONFIG_SMP */
+
+#endif /* __ASM_S390_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-i386/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-i386/spinlock_types.h	2004-10-13 21:32:39.278272985 +0200
@@ -0,0 +1,55 @@
+#ifndef __ASM_I386_SPINLOCK_TYPES_H
+#define __ASM_I386_SPINLOCK_TYPES_H
+
+#ifdef CONFIG_SMP
+
+typedef struct {
+	volatile unsigned int lock;
+#ifdef CONFIG_DEBUG_SPINLOCK
+	unsigned magic;
+#endif
+} spinlock_t;
+
+#define SPINLOCK_MAGIC	0xdead4ead
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define SPINLOCK_MAGIC_INIT	, SPINLOCK_MAGIC
+#else
+#define SPINLOCK_MAGIC_INIT	/* */
+#endif
+
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { 1 SPINLOCK_MAGIC_INIT }
+
+static inline void spin_lock_init(spinlock_t *lock)
+{
+	*lock = SPIN_LOCK_UNLOCKED;
+}
+
+typedef struct {
+	volatile unsigned int lock;
+#ifdef CONFIG_DEBUG_SPINLOCK
+	unsigned magic;
+#endif
+} rwlock_t;
+
+#define RW_LOCK_BIAS		 0x01000000
+#define RW_LOCK_BIAS_STR	"0x01000000"
+
+#define RWLOCK_MAGIC	0xdeaf1eed
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC
+#else
+#define RWLOCK_MAGIC_INIT	/* */
+#endif
+
+#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
+
+static inline void rwlock_init(rwlock_t *lock)
+{
+	*lock = RW_LOCK_UNLOCKED;
+}
+
+#endif /* CONFIG_SMP */
+
+#endif /* __ASM_I386_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-h8300/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-h8300/spinlock_types.h	2004-10-13 21:32:39.278272985 +0200
@@ -0,0 +1,4 @@
+#ifndef __ASM_H8300_SPINLOCK_TYPES_H
+#define __ASM_H8300_SPINLOCK_TYPES_H
+
+#endif /* __ASM_H8300_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-alpha/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-alpha/spinlock_types.h	2004-10-13 21:32:39.279272814 +0200
@@ -0,0 +1,36 @@
+#ifndef __ASM_ALPHA_SPINLOCK_TYPES_H
+#define __ASM_ALPHA_SPINLOCK_TYPES_H
+
+#ifdef CONFIG_SMP
+
+typedef struct {
+	volatile unsigned int lock /*__attribute__((aligned(32))) */;
+#ifdef CONFIG_DEBUG_SPINLOCK
+	int on_cpu;
+	int line_no;
+	void *previous;
+	struct task_struct * task;
+	const char *base_file;
+#endif
+} spinlock_t;
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define SPIN_LOCK_UNLOCKED (spinlock_t) {0, -1, 0, NULL, NULL, NULL}
+#define spin_lock_init(x)						\
+	((x)->lock = 0, (x)->on_cpu = -1, (x)->previous = NULL, (x)->task = NULL)
+#else
+#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
+#define spin_lock_init(x)	((x)->lock = 0)
+#endif
+
+typedef struct {
+	volatile int write_lock:1, read_counter:31;
+} /*__attribute__((aligned(32)))*/ rwlock_t;
+
+#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
+
+#define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+
+#endif /* CONFIG_SMP */
+
+#endif /* __ASM_ALPHA_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-sparc/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-sparc/spinlock_types.h	2004-10-13 21:32:39.279272814 +0200
@@ -0,0 +1,45 @@
+#ifndef __ASM_SPARC_SPINLOCK_TYPES_H
+#define __ASM_SPARC_SPINLOCK_TYPES_H
+
+#ifdef CONFIG_SMP
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+
+struct _spinlock_debug {
+	unsigned char lock;
+	unsigned long owner_pc;
+};
+typedef struct _spinlock_debug spinlock_t;
+
+#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0, 0 }
+#define spin_lock_init(lp)	do { *(lp)= SPIN_LOCK_UNLOCKED; } while(0)
+
+struct _rwlock_debug {
+	volatile unsigned int lock;
+	unsigned long owner_pc;
+	unsigned long reader_pc[NR_CPUS];
+};
+typedef struct _rwlock_debug rwlock_t;
+
+#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0, {0} }
+
+#define rwlock_init(lp)	do { *(lp)= RW_LOCK_UNLOCKED; } while(0)
+
+#else /* !CONFIG_DEBUG_SPINLOCK */
+
+typedef unsigned char spinlock_t;
+#define SPIN_LOCK_UNLOCKED	0
+
+#define spin_lock_init(lock)   (*((unsigned char *)(lock)) = 0)
+
+typedef struct { volatile unsigned int lock; } rwlock_t;
+
+#define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
+
+#define rwlock_init(lp)	do { *(lp)= RW_LOCK_UNLOCKED; } while(0)
+
+#endif /* !CONFIG_DEBUG_SPINLOCK */
+
+#endif /* CONFIG_SMP */
+
+#endif /* __ASM_SPARC_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/linux/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/linux/spinlock_types.h	2004-10-13 21:32:39.279272814 +0200
@@ -0,0 +1,67 @@
+#ifndef __LINUX_SPINLOCK_TYPES_H
+#define __LINUX_SPINLOCK_TYPES_H
+
+#include <asm/spinlock_types.h>
+
+#ifndef CONFIG_SMP
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+
+#define SPINLOCK_MAGIC	0x1D244B3C
+typedef struct {
+	unsigned long magic;
+	volatile unsigned long lock;
+	volatile unsigned int babble;
+	const char *module;
+	char *owner;
+	int oline;
+} spinlock_t;
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { SPINLOCK_MAGIC, 0, 10, __FILE__ , NULL, 0}
+
+static inline void __spin_lock_init(spinlock_t *lock, const char *module)
+{
+	lock->magic = SPINLOCK_MAGIC;
+	lock->lock = 0;
+	lock->babble = 5;
+	lock->module = __FILE__;
+	lock->owner = NULL;
+	lock->oline = 0;
+}
+#define spin_lock_init(lock) __spin_lock_init(lock, __FILE__)
+
+#else
+
+/*
+ * gcc versions before ~2.95 have a nasty bug with empty initializers.
+ */
+#if (__GNUC__ > 2)
+  typedef struct { } spinlock_t;
+  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
+#else
+  typedef struct { int gcc_is_buggy; } spinlock_t;
+  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+#endif
+
+static inline void spin_lock_init(spinlock_t *lock)
+{
+}
+
+#endif /* CONFIG_DEBUG_SPINLOCK */
+
+/* RW spinlocks: No debug version */
+
+#if (__GNUC__ > 2)
+  typedef struct { } rwlock_t;
+  #define RW_LOCK_UNLOCKED (rwlock_t) { }
+#else
+  typedef struct { int gcc_is_buggy; } rwlock_t;
+  #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
+#endif
+
+static inline void rwlock_init(rwlock_t *lock)
+{
+}
+
+#endif /* CONFIG_SMP */
+
+#endif /* __LINUX_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-v850/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-v850/spinlock_types.h	2004-10-13 21:32:39.279272814 +0200
@@ -0,0 +1,4 @@
+#ifndef __ASM_V850_SPINLOCK_TYPES_H
+#define __ASM_V850_SPINLOCK_TYPES_H
+
+#endif /* __ASM_V850_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-sparc64/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-sparc64/spinlock_types.h	2004-10-13 21:32:39.280272643 +0200
@@ -0,0 +1,42 @@
+#ifndef __ASM_SPARC64_SPINLOCK_TYPES_H
+#define __ASM_SPARC64_SPINLOCK_TYPES_H
+
+#ifdef CONFIG_SMP
+
+#ifndef CONFIG_DEBUG_SPINLOCK
+
+typedef unsigned char spinlock_t;
+#define SPIN_LOCK_UNLOCKED	0
+
+#define spin_lock_init(lock)	(*((unsigned char *)(lock)) = 0)
+
+typedef unsigned int rwlock_t;
+#define RW_LOCK_UNLOCKED	0
+#define rwlock_init(lp) do { *(lp) = RW_LOCK_UNLOCKED; } while(0)
+
+#else /* !(CONFIG_DEBUG_SPINLOCK) */
+
+typedef struct {
+	unsigned char lock;
+	unsigned int owner_pc, owner_cpu;
+} spinlock_t;
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0, 0, 0xff }
+#define spin_lock_init(__lock)	\
+do {	(__lock)->lock = 0; \
+	(__lock)->owner_pc = 0; \
+	(__lock)->owner_cpu = 0xff; \
+} while(0)
+
+typedef struct {
+	unsigned long lock;
+	unsigned int writer_pc, writer_cpu;
+	unsigned int reader_pc[NR_CPUS];
+} rwlock_t;
+#define RW_LOCK_UNLOCKED	(rwlock_t) { 0, 0, 0xff, { } }
+#define rwlock_init(lp) do { *(lp) = RW_LOCK_UNLOCKED; } while(0)
+
+#endif /* CONFIG_DEBUG_SPINLOCK */
+
+#endif /* CONFIG_SMP */
+
+#endif /* __ASM_SPARC64_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-um/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-um/spinlock_types.h	2004-10-13 21:32:39.280272643 +0200
@@ -0,0 +1,6 @@
+#ifndef __ASM_UM_SPINLOCK_TYPES_H
+#define __ASM_UM_SPINLOCK_TYPES_H
+
+#include "asm/arch/spinlock_types.h"
+
+#endif /* __ASM_UM_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-sh/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-sh/spinlock_types.h	2004-10-13 21:32:39.280272643 +0200
@@ -0,0 +1,25 @@
+#ifndef __ASM_SH_SPINLOCK_TYPES_H
+#define __ASM_SH_SPINLOCK_TYPES_H
+
+#ifdef CONFIG_SMP
+
+typedef struct {
+	volatile unsigned long lock;
+} spinlock_t;
+
+#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
+
+#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
+
+typedef struct {
+	spinlock_t lock;
+	atomic_t counter;
+} rwlock_t;
+
+#define RW_LOCK_BIAS		0x01000000
+#define RW_LOCK_UNLOCKED	(rwlock_t) { { 0 }, { RW_LOCK_BIAS } }
+#define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while (0)
+
+#endif /* CONFIG_SMP */
+
+#endif /* __ASM_SH_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-m68knommu/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-m68knommu/spinlock_types.h	2004-10-13 21:32:39.280272643 +0200
@@ -0,0 +1,6 @@
+#ifndef __ASM_M68KNOMMU_SPINLOCK_TYPES_H
+#define __ASM_M68KNOMMU_SPINLOCK_TYPES_H
+
+#include <asm-m68k/spinlock_types.h>
+
+#endif /* __ASM_M68KNOMMU_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-m68k/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-m68k/spinlock_types.h	2004-10-13 21:32:39.280272643 +0200
@@ -0,0 +1,4 @@
+#ifndef __ASM_M68K_SPINLOCK_TYPES_H
+#define __ASM_M68K_SPINLOCK_TYPES_H
+
+#endif /* __ASM_M68K_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-ia64/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-ia64/spinlock_types.h	2004-10-13 21:32:39.281272472 +0200
@@ -0,0 +1,23 @@
+#ifndef __ASM_IA64_SPINLOCK_TYPES_H
+#define __ASM_IA64_SPINLOCK_TYPES_H
+
+#ifdef CONFIG_SMP
+
+typedef struct {
+	volatile unsigned int lock;
+} spinlock_t;
+
+#define SPIN_LOCK_UNLOCKED			(spinlock_t) { 0 }
+#define spin_lock_init(x)			((x)->lock = 0)
+
+typedef struct {
+	volatile int read_counter	: 31;
+	volatile int write_lock		:  1;
+} rwlock_t;
+#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
+
+#define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+
+#endif /* CONFIG_SMP */
+
+#endif /* __ASM_IA64_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-cris/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-cris/spinlock_types.h	2004-10-13 21:32:39.281272472 +0200
@@ -0,0 +1,4 @@
+#ifndef __ASM_CRIS_SPINLOCK_TYPES_H
+#define __ASM_CRIS_SPINLOCK_TYPES_H
+
+#endif /* __ASM_CRIS_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/linux/spinlock.h
===================================================================
--- linux-2.6-inc.orig/include/linux/spinlock.h	2004-06-16 20:27:38.000000000 +0200
+++ linux-2.6-inc/include/linux/spinlock.h	2004-10-13 21:32:39.281272472 +0200
@@ -12,6 +12,7 @@
 #include <linux/thread_info.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
+#include <linux/spinlock_types.h>
 
 #include <asm/processor.h>	/* for cpu relax */
 #include <asm/system.h>
@@ -49,27 +50,6 @@
 
 #ifdef CONFIG_DEBUG_SPINLOCK
  
-#define SPINLOCK_MAGIC	0x1D244B3C
-typedef struct {
-	unsigned long magic;
-	volatile unsigned long lock;
-	volatile unsigned int babble;
-	const char *module;
-	char *owner;
-	int oline;
-} spinlock_t;
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { SPINLOCK_MAGIC, 0, 10, __FILE__ , NULL, 0}
-
-#define spin_lock_init(x) \
-	do { \
-		(x)->magic = SPINLOCK_MAGIC; \
-		(x)->lock = 0; \
-		(x)->babble = 5; \
-		(x)->module = __FILE__; \
-		(x)->owner = NULL; \
-		(x)->oline = 0; \
-	} while (0)
-
 #define CHECK_LOCK(x) \
 	do { \
 	 	if ((x)->magic != SPINLOCK_MAGIC) { \
@@ -145,21 +125,10 @@ typedef struct {
 		(x)->lock = 0; \
 	} while (0)
 #else
-/*
- * gcc versions before ~2.95 have a nasty bug with empty initializers.
- */
-#if (__GNUC__ > 2)
-  typedef struct { } spinlock_t;
-  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
-#else
-  typedef struct { int gcc_is_buggy; } spinlock_t;
-  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
-#endif
 
 /*
  * If CONFIG_SMP is unset, declare the _raw_* definitions as nops
  */
-#define spin_lock_init(lock)	do { (void)(lock); } while(0)
 #define _raw_spin_lock(lock)	do { (void)(lock); } while(0)
 #define spin_is_locked(lock)	((void)(lock), 0)
 #define _raw_spin_trylock(lock)	((void)(lock), 1)
@@ -167,17 +136,6 @@ typedef struct {
 #define _raw_spin_unlock(lock)	do { (void)(lock); } while(0)
 #endif /* CONFIG_DEBUG_SPINLOCK */
 
-/* RW spinlocks: No debug version */
-
-#if (__GNUC__ > 2)
-  typedef struct { } rwlock_t;
-  #define RW_LOCK_UNLOCKED (rwlock_t) { }
-#else
-  typedef struct { int gcc_is_buggy; } rwlock_t;
-  #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
-#endif
-
-#define rwlock_init(lock)	do { (void)(lock); } while(0)
 #define _raw_read_lock(lock)	do { (void)(lock); } while(0)
 #define _raw_read_unlock(lock)	do { (void)(lock); } while(0)
 #define _raw_write_lock(lock)	do { (void)(lock); } while(0)
Index: linux-2.6-inc/include/asm-sh64/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-sh64/spinlock_types.h	2004-10-13 21:32:39.281272472 +0200
@@ -0,0 +1,4 @@
+#ifndef __ASM_SH64_SPINLOCK_TYPES_H
+#define __ASM_SH64_SPINLOCK_TYPES_H
+
+#endif /* __ASM_SH64_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-parisc/system.h
===================================================================
--- linux-2.6-inc.orig/include/asm-parisc/system.h	2004-08-14 13:00:50.000000000 +0200
+++ linux-2.6-inc/include/asm-parisc/system.h	2004-10-13 21:32:39.282272301 +0200
@@ -159,29 +159,6 @@ static inline void set_eiem(unsigned lon
   (volatile unsigned int *) __ret;                                      \
 })
 
-#ifdef CONFIG_SMP
-/*
- * Your basic SMP spinlocks, allowing only a single CPU anywhere
- */
-
-typedef struct {
-	volatile unsigned int lock[4];
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned long magic;
-	volatile unsigned int babble;
-	const char *module;
-	char *bfile;
-	int bline;
-	int oncpu;
-	void *previous;
-	struct task_struct * task;
-#endif
-} spinlock_t;
-
-#define __lock_aligned __attribute__((__section__(".data.lock_aligned")))
-
-#endif
-
 #define KERNEL_START (0x10100000 - 0x1000)
 
 #endif
Index: linux-2.6-inc/include/asm-arm26/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-arm26/spinlock_types.h	2004-10-13 21:32:39.282272301 +0200
@@ -0,0 +1,4 @@
+#ifndef __ASM_ARM26_SPINLOCK_TYPES_H
+#define __ASM_ARM26_SPINLOCK_TYPES_H
+
+#endif /* __ASM_ARM26_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-i386/spinlock.h
===================================================================
--- linux-2.6-inc.orig/include/asm-i386/spinlock.h	2004-10-10 17:14:07.000000000 +0200
+++ linux-2.6-inc/include/asm-i386/spinlock.h	2004-10-13 21:32:39.282272301 +0200
@@ -14,25 +14,6 @@ asmlinkage int printk(const char * fmt, 
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  */
 
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned magic;
-#endif
-} spinlock_t;
-
-#define SPINLOCK_MAGIC	0xdead4ead
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define SPINLOCK_MAGIC_INIT	, SPINLOCK_MAGIC
-#else
-#define SPINLOCK_MAGIC_INIT	/* */
-#endif
-
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 1 SPINLOCK_MAGIC_INIT }
-
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
@@ -167,25 +148,6 @@ here:
  * irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
  */
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned magic;
-#endif
-} rwlock_t;
-
-#define RWLOCK_MAGIC	0xdeaf1eed
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC
-#else
-#define RWLOCK_MAGIC_INIT	/* */
-#endif
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
-
-#define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
-
 #define rwlock_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
 
 /*
Index: linux-2.6-inc/include/asm-x86_64/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-x86_64/spinlock_types.h	2004-10-13 21:50:10.417360732 +0200
@@ -0,0 +1,49 @@
+#ifndef __ASM_X86_64_SPINLOCK_TYPES_H
+#define __ASM_X86_64_SPINLOCK_TYPES_H
+
+#ifdef CONFIG_SMP
+
+typedef struct {
+	volatile unsigned int lock;
+#ifdef CONFIG_DEBUG_SPINLOCK
+	unsigned magic;
+#endif
+} spinlock_t;
+
+#define SPINLOCK_MAGIC	0xdead4ead
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define SPINLOCK_MAGIC_INIT	, SPINLOCK_MAGIC
+#else
+#define SPINLOCK_MAGIC_INIT	/* */
+#endif
+
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { 1 SPINLOCK_MAGIC_INIT }
+
+#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
+
+typedef struct {
+	volatile unsigned int lock;
+#ifdef CONFIG_DEBUG_SPINLOCK
+	unsigned magic;
+#endif
+} rwlock_t;
+
+#define RWLOCK_MAGIC	0xdeaf1eed
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC
+#else
+#define RWLOCK_MAGIC_INIT	/* */
+#endif
+
+#define RW_LOCK_BIAS		 0x01000000
+#define RW_LOCK_BIAS_STR	"0x01000000"
+
+#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
+
+#define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+
+#endif /* CONFIG_SMP */
+
+#endif /* __ASM_X86_64_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-ppc/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-ppc/spinlock_types.h	2004-10-13 21:32:39.282272301 +0200
@@ -0,0 +1,43 @@
+#ifndef __ASM_PPC_SPINLOCK_TYPES_H
+#define __ASM_PPC_SPINLOCK_TYPES_H
+
+#ifdef CONFIG_SMP
+
+typedef struct {
+	volatile unsigned long lock;
+#ifdef CONFIG_DEBUG_SPINLOCK
+	volatile unsigned long owner_pc;
+	volatile unsigned long owner_cpu;
+#endif
+} spinlock_t;
+
+#ifdef __KERNEL__
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define SPINLOCK_DEBUG_INIT     , 0, 0
+#else
+#define SPINLOCK_DEBUG_INIT     /* */
+#endif
+
+#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 SPINLOCK_DEBUG_INIT }
+
+#define spin_lock_init(x) 	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
+
+typedef struct {
+	volatile unsigned long lock;
+#ifdef CONFIG_DEBUG_SPINLOCK
+	volatile unsigned long owner_pc;
+#endif
+} rwlock_t;
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define RWLOCK_DEBUG_INIT     , 0
+#else
+#define RWLOCK_DEBUG_INIT     /* */
+#endif
+
+#define RW_LOCK_UNLOCKED (rwlock_t) { 0 RWLOCK_DEBUG_INIT }
+#define rwlock_init(lp) do { *(lp) = RW_LOCK_UNLOCKED; } while(0)
+
+#endif /* CONFIG_SMP */
+
+#endif /* __ASM_PPC_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-parisc/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-parisc/spinlock_types.h	2004-10-13 21:32:39.283272130 +0200
@@ -0,0 +1,55 @@
+#ifndef __ASM_PARISC_SPINLOCK_TYPES_H
+#define __ASM_PARISC_SPINLOCK_TYPES_H
+
+#ifdef CONFIG_SMP
+
+/*
+ * Your basic SMP spinlocks, allowing only a single CPU anywhere
+ */
+
+typedef struct {
+	volatile unsigned int lock[4];
+#ifdef CONFIG_DEBUG_SPINLOCK
+	unsigned long magic;
+	volatile unsigned int babble;
+	const char *module;
+	char *bfile;
+	int bline;
+	int oncpu;
+	void *previous;
+	struct task_struct * task;
+#endif
+} spinlock_t;
+
+#define __lock_aligned __attribute__((__section__(".data.lock_aligned")))
+
+#ifndef CONFIG_DEBUG_SPINLOCK
+
+#define __SPIN_LOCK_UNLOCKED	{ { 1, 1, 1, 1 } }
+#undef SPIN_LOCK_UNLOCKED
+#define SPIN_LOCK_UNLOCKED (spinlock_t) __SPIN_LOCK_UNLOCKED
+
+#else
+
+#define SPINLOCK_MAGIC	0x1D244B3C
+
+#define __SPIN_LOCK_UNLOCKED	{ { 1, 1, 1, 1 }, SPINLOCK_MAGIC, 10, __FILE__ , NULL, 0, -1, NULL, NULL }
+#undef SPIN_LOCK_UNLOCKED
+#define SPIN_LOCK_UNLOCKED (spinlock_t) __SPIN_LOCK_UNLOCKED
+
+#endif /* CONFIG_DEBUG_SPINLOCK */
+
+#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
+
+typedef struct {
+	spinlock_t lock;
+	volatile int counter;
+} rwlock_t;
+
+#define RW_LOCK_UNLOCKED (rwlock_t) { __SPIN_LOCK_UNLOCKED, 0 }
+
+#define rwlock_init(lp)	do { *(lp) = RW_LOCK_UNLOCKED; } while (0)
+
+#endif /* CONFIG_SMP */
+
+#endif /* __ASM_PARISC_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-arm/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-inc/include/asm-arm/spinlock_types.h	2004-10-13 21:32:39.283272130 +0200
@@ -0,0 +1,23 @@
+#ifndef __ASM_ARM_SPINLOCK_TYPES_H
+#define __ASM_ARM_SPINLOCK_TYPES_H
+
+#ifdef CONFIG_SMP
+
+typedef struct {
+	volatile unsigned int lock;
+} spinlock_t;
+
+#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
+
+#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while (0)
+
+typedef struct {
+	volatile unsigned int lock;
+} rwlock_t;
+
+#define RW_LOCK_UNLOCKED	(rwlock_t) { 0 }
+#define rwlock_init(x)		do { *(x) + RW_LOCK_UNLOCKED; } while (0)
+
+#endif /* CONFIG_SMP */
+
+#endif /* __ASM_ARM_SPINLOCK_TYPES_H */
Index: linux-2.6-inc/include/asm-i386/rwlock.h
===================================================================
--- linux-2.6-inc.orig/include/asm-i386/rwlock.h	2003-07-18 23:22:38.000000000 +0200
+++ linux-2.6-inc/include/asm-i386/rwlock.h	2004-10-13 21:32:39.283272130 +0200
@@ -17,9 +17,6 @@
 #ifndef _ASM_I386_RWLOCK_H
 #define _ASM_I386_RWLOCK_H
 
-#define RW_LOCK_BIAS		 0x01000000
-#define RW_LOCK_BIAS_STR	"0x01000000"
-
 #define __build_read_lock_ptr(rw, helper)   \
 	asm volatile(LOCK "subl $1,(%0)\n\t" \
 		     "js 2f\n" \
Index: linux-2.6-inc/include/asm-ppc/spinlock.h
===================================================================
--- linux-2.6-inc.orig/include/asm-ppc/spinlock.h	2004-10-10 19:11:45.000000000 +0200
+++ linux-2.6-inc/include/asm-ppc/spinlock.h	2004-10-13 21:32:39.284271959 +0200
@@ -7,24 +7,6 @@
  * Simple spin lock operations.
  */
 
-typedef struct {
-	volatile unsigned long lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	volatile unsigned long owner_pc;
-	volatile unsigned long owner_cpu;
-#endif
-} spinlock_t;
-
-#ifdef __KERNEL__
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define SPINLOCK_DEBUG_INIT     , 0, 0
-#else
-#define SPINLOCK_DEBUG_INIT     /* */
-#endif
-
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 SPINLOCK_DEBUG_INIT }
-
-#define spin_lock_init(x) 	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
 #define spin_is_locked(x)	((x)->lock != 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
@@ -78,22 +60,6 @@ extern int _raw_spin_trylock(spinlock_t 
  * irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
  */
-typedef struct {
-	volatile unsigned long lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	volatile unsigned long owner_pc;
-#endif
-} rwlock_t;
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define RWLOCK_DEBUG_INIT     , 0
-#else
-#define RWLOCK_DEBUG_INIT     /* */
-#endif
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0 RWLOCK_DEBUG_INIT }
-#define rwlock_init(lp) do { *(lp) = RW_LOCK_UNLOCKED; } while(0)
-
 #define rwlock_is_locked(x)	((x)->lock != 0)
 
 #ifndef CONFIG_DEBUG_SPINLOCK
Index: linux-2.6-inc/include/asm-sh/spinlock.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sh/spinlock.h	2004-10-10 19:11:45.000000000 +0200
+++ linux-2.6-inc/include/asm-sh/spinlock.h	2004-10-13 21:32:39.284271959 +0200
@@ -15,14 +15,6 @@
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  */
-typedef struct {
-	volatile unsigned long lock;
-} spinlock_t;
-
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
-
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-
 #define spin_is_locked(x)	((x)->lock != 0)
 #define spin_unlock_wait(x)	do { barrier(); } while (spin_is_locked(x))
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
@@ -65,14 +57,6 @@ static inline void _raw_spin_unlock(spin
  * needs to get a irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
  */
-typedef struct {
-	spinlock_t lock;
-	atomic_t counter;
-} rwlock_t;
-
-#define RW_LOCK_BIAS		0x01000000
-#define RW_LOCK_UNLOCKED	(rwlock_t) { { 0 }, { RW_LOCK_BIAS } }
-#define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while (0)
 #define rwlock_is_locked(x)	(atomic_read(&(x)->counter) != RW_LOCK_BIAS)
 
 static inline void _raw_read_lock(rwlock_t *rw)
Index: linux-2.6-inc/include/asm-alpha/spinlock.h
===================================================================
--- linux-2.6-inc.orig/include/asm-alpha/spinlock.h	2004-10-10 19:11:45.000000000 +0200
+++ linux-2.6-inc/include/asm-alpha/spinlock.h	2004-10-13 21:32:39.284271959 +0200
@@ -14,26 +14,6 @@
  * We make no fairness assumptions. They have a cost.
  */
 
-typedef struct {
-	volatile unsigned int lock /*__attribute__((aligned(32))) */;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	int on_cpu;
-	int line_no;
-	void *previous;
-	struct task_struct * task;
-	const char *base_file;
-#endif
-} spinlock_t;
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define SPIN_LOCK_UNLOCKED (spinlock_t) {0, -1, 0, NULL, NULL, NULL}
-#define spin_lock_init(x)						\
-	((x)->lock = 0, (x)->on_cpu = -1, (x)->previous = NULL, (x)->task = NULL)
-#else
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
-#define spin_lock_init(x)	((x)->lock = 0)
-#endif
-
 #define spin_is_locked(x)	((x)->lock != 0)
 #define spin_unlock_wait(x)	({ do { barrier(); } while ((x)->lock); })
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
@@ -94,13 +74,6 @@ static inline int _raw_spin_trylock(spin
 
 /***********************************************************/
 
-typedef struct {
-	volatile int write_lock:1, read_counter:31;
-} /*__attribute__((aligned(32)))*/ rwlock_t;
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
-
-#define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 #define rwlock_is_locked(x)	(*(volatile int *)(x) != 0)
 
 #ifdef CONFIG_DEBUG_RWLOCK
Index: linux-2.6-inc/include/asm-sparc/spinlock.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sparc/spinlock.h	2004-10-10 19:11:45.000000000 +0200
+++ linux-2.6-inc/include/asm-sparc/spinlock.h	2004-10-13 21:32:39.284271959 +0200
@@ -13,14 +13,7 @@
 #include <asm/psr.h>
 
 #ifdef CONFIG_DEBUG_SPINLOCK
-struct _spinlock_debug {
-	unsigned char lock;
-	unsigned long owner_pc;
-};
-typedef struct _spinlock_debug spinlock_t;
 
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0, 0 }
-#define spin_lock_init(lp)	do { *(lp)= SPIN_LOCK_UNLOCKED; } while(0)
 #define spin_is_locked(lp)  (*((volatile unsigned char *)(&((lp)->lock))) != 0)
 #define spin_unlock_wait(lp)	do { barrier(); } while(*(volatile unsigned char *)(&(lp)->lock))
 
@@ -32,16 +25,6 @@ extern void _do_spin_unlock(spinlock_t *
 #define _raw_spin_lock(lock)	_do_spin_lock(lock, "spin_lock")
 #define _raw_spin_unlock(lock)	_do_spin_unlock(lock)
 
-struct _rwlock_debug {
-	volatile unsigned int lock;
-	unsigned long owner_pc;
-	unsigned long reader_pc[NR_CPUS];
-};
-typedef struct _rwlock_debug rwlock_t;
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0, {0} }
-
-#define rwlock_init(lp)	do { *(lp)= RW_LOCK_UNLOCKED; } while(0)
 #define rwlock_is_locked(lp) ((lp)->lock != 0)
 
 extern void _do_read_lock(rwlock_t *rw, char *str);
@@ -79,10 +62,6 @@ do {	unsigned long flags; \
 
 #else /* !CONFIG_DEBUG_SPINLOCK */
 
-typedef unsigned char spinlock_t;
-#define SPIN_LOCK_UNLOCKED	0
-
-#define spin_lock_init(lock)   (*((unsigned char *)(lock)) = 0)
 #define spin_is_locked(lock)    (*((volatile unsigned char *)(lock)) != 0)
 
 #define spin_unlock_wait(lock) \
@@ -137,11 +116,6 @@ extern __inline__ void _raw_spin_unlock(
  * XXX This might create some problems with my dual spinlock
  * XXX scheme, deadlocks etc. -DaveM
  */
-typedef struct { volatile unsigned int lock; } rwlock_t;
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
-
-#define rwlock_init(lp)	do { *(lp)= RW_LOCK_UNLOCKED; } while(0)
 #define rwlock_is_locked(lp) ((lp)->lock != 0)
 
 
Index: linux-2.6-inc/include/asm-mips/spinlock.h
===================================================================
--- linux-2.6-inc.orig/include/asm-mips/spinlock.h	2004-10-10 19:11:45.000000000 +0200
+++ linux-2.6-inc/include/asm-mips/spinlock.h	2004-10-13 21:32:39.285271788 +0200
@@ -13,14 +13,6 @@
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  */
 
-typedef struct {
-	volatile unsigned int lock;
-} spinlock_t;
-
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
-
-#define spin_lock_init(x)	do { (x)->lock = 0; } while(0)
-
 #define spin_is_locked(x)	((x)->lock != 0)
 #define spin_unlock_wait(x)	do { barrier(); } while ((x)->lock)
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
@@ -90,14 +82,6 @@ static inline unsigned int _raw_spin_try
  * read-locks.
  */
 
-typedef struct {
-	volatile unsigned int lock;
-} rwlock_t;
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
-
-#define rwlock_init(x)  do { *(x) = RW_LOCK_UNLOCKED; } while(0)
-
 #define rwlock_is_locked(x) ((x)->lock)
 
 static inline void _raw_read_lock(rwlock_t *rw)
Index: linux-2.6-inc/include/asm-sparc64/spinlock.h
===================================================================
--- linux-2.6-inc.orig/include/asm-sparc64/spinlock.h	2004-10-10 19:11:45.000000000 +0200
+++ linux-2.6-inc/include/asm-sparc64/spinlock.h	2004-10-13 21:32:39.285271788 +0200
@@ -31,10 +31,6 @@
 
 #ifndef CONFIG_DEBUG_SPINLOCK
 
-typedef unsigned char spinlock_t;
-#define SPIN_LOCK_UNLOCKED	0
-
-#define spin_lock_init(lock)	(*((unsigned char *)(lock)) = 0)
 #define spin_is_locked(lock)	(*((volatile unsigned char *)(lock)) != 0)
 
 #define spin_unlock_wait(lock)	\
@@ -68,16 +64,6 @@ extern void _raw_spin_lock_flags(spinloc
 
 #else /* !(CONFIG_DEBUG_SPINLOCK) */
 
-typedef struct {
-	unsigned char lock;
-	unsigned int owner_pc, owner_cpu;
-} spinlock_t;
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0, 0, 0xff }
-#define spin_lock_init(__lock)	\
-do {	(__lock)->lock = 0; \
-	(__lock)->owner_pc = 0; \
-	(__lock)->owner_cpu = 0xff; \
-} while(0)
 #define spin_is_locked(__lock)	(*((volatile unsigned char *)(&((__lock)->lock))) != 0)
 #define spin_unlock_wait(__lock)	\
 do { \
@@ -99,9 +85,6 @@ extern int _spin_trylock (spinlock_t *lo
 
 #ifndef CONFIG_DEBUG_SPINLOCK
 
-typedef unsigned int rwlock_t;
-#define RW_LOCK_UNLOCKED	0
-#define rwlock_init(lp) do { *(lp) = RW_LOCK_UNLOCKED; } while(0)
 #define rwlock_is_locked(x) (*(x) != RW_LOCK_UNLOCKED)
 
 extern void __read_lock(rwlock_t *);
@@ -118,13 +101,6 @@ extern int __write_trylock(rwlock_t *);
 
 #else /* !(CONFIG_DEBUG_SPINLOCK) */
 
-typedef struct {
-	unsigned long lock;
-	unsigned int writer_pc, writer_cpu;
-	unsigned int reader_pc[NR_CPUS];
-} rwlock_t;
-#define RW_LOCK_UNLOCKED	(rwlock_t) { 0, 0, 0xff, { } }
-#define rwlock_init(lp) do { *(lp) = RW_LOCK_UNLOCKED; } while(0)
 #define rwlock_is_locked(x) ((x)->lock != 0)
 
 extern void _do_read_lock(rwlock_t *rw, char *str);
Index: linux-2.6-inc/include/asm-ia64/spinlock.h
===================================================================
--- linux-2.6-inc.orig/include/asm-ia64/spinlock.h	2004-10-10 19:11:45.000000000 +0200
+++ linux-2.6-inc/include/asm-ia64/spinlock.h	2004-10-13 21:32:39.285271788 +0200
@@ -17,13 +17,6 @@
 #include <asm/intrinsics.h>
 #include <asm/system.h>
 
-typedef struct {
-	volatile unsigned int lock;
-} spinlock_t;
-
-#define SPIN_LOCK_UNLOCKED			(spinlock_t) { 0 }
-#define spin_lock_init(x)			((x)->lock = 0)
-
 #ifdef ASM_SUPPORTED
 /*
  * Try to get the lock.  If we fail to get the lock, make a non-standard call to
@@ -113,13 +106,6 @@ do {											\
 #define _raw_spin_trylock(x)	(cmpxchg_acq(&(x)->lock, 0, 1) == 0)
 #define spin_unlock_wait(x)	do { barrier(); } while ((x)->lock)
 
-typedef struct {
-	volatile int read_counter	: 31;
-	volatile int write_lock		:  1;
-} rwlock_t;
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
-
-#define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 #define rwlock_is_locked(x)	(*(volatile int *) (x) != 0)
 
 #define _raw_read_lock(rw)								\
Index: linux-2.6-inc/include/asm-parisc/spinlock.h
===================================================================
--- linux-2.6-inc.orig/include/asm-parisc/spinlock.h	2004-10-10 19:11:45.000000000 +0200
+++ linux-2.6-inc/include/asm-parisc/spinlock.h	2004-10-13 21:32:39.285271788 +0200
@@ -10,12 +10,6 @@
 
 #ifndef CONFIG_DEBUG_SPINLOCK
 
-#define __SPIN_LOCK_UNLOCKED	{ { 1, 1, 1, 1 } }
-#undef SPIN_LOCK_UNLOCKED
-#define SPIN_LOCK_UNLOCKED (spinlock_t) __SPIN_LOCK_UNLOCKED
-
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-
 static inline int spin_is_locked(spinlock_t *x)
 {
 	volatile unsigned int *a = __ldcw_align(x);
@@ -48,14 +42,6 @@ static inline int _raw_spin_trylock(spin
 
 #else /* !(CONFIG_DEBUG_SPINLOCK) */
 
-#define SPINLOCK_MAGIC	0x1D244B3C
-
-#define __SPIN_LOCK_UNLOCKED	{ { 1, 1, 1, 1 }, SPINLOCK_MAGIC, 10, __FILE__ , NULL, 0, -1, NULL, NULL }
-#undef SPIN_LOCK_UNLOCKED
-#define SPIN_LOCK_UNLOCKED (spinlock_t) __SPIN_LOCK_UNLOCKED
-
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-
 #define CHECK_LOCK(x)							\
 	do {								\
 	 	if (unlikely((x)->magic != SPINLOCK_MAGIC)) {			\
@@ -125,15 +111,6 @@ do {									\
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
  */
-typedef struct {
-	spinlock_t lock;
-	volatile int counter;
-} rwlock_t;
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { __SPIN_LOCK_UNLOCKED, 0 }
-
-#define rwlock_init(lp)	do { *(lp) = RW_LOCK_UNLOCKED; } while (0)
-
 #define rwlock_is_locked(lp) ((lp)->counter != 0)
 
 /* read_lock, read_unlock are pretty straightforward.  Of course it somehow
Index: linux-2.6-inc/include/asm-s390/spinlock.h
===================================================================
--- linux-2.6-inc.orig/include/asm-s390/spinlock.h	2004-10-10 19:11:45.000000000 +0200
+++ linux-2.6-inc/include/asm-s390/spinlock.h	2004-10-13 21:32:39.286271617 +0200
@@ -34,12 +34,6 @@
  * We make no fairness assumptions. They have a cost.
  */
 
-typedef struct {
-	volatile unsigned int lock;
-} __attribute__ ((aligned (4))) spinlock_t;
-
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
-#define spin_lock_init(lp) do { (lp)->lock = 0; } while(0)
 #define spin_unlock_wait(lp)	do { barrier(); } while(((volatile spinlock_t *)(lp))->lock)
 #define spin_is_locked(x) ((x)->lock != 0)
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
@@ -102,15 +96,6 @@ extern inline void _raw_spin_unlock(spin
  * irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
  */
-typedef struct {
-	volatile unsigned long lock;
-	volatile unsigned long owner_pc;
-} rwlock_t;
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
-
-#define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
-
 #define rwlock_is_locked(x) ((x)->lock != 0)
 
 #ifndef __s390x__
Index: linux-2.6-inc/include/asm-arm/spinlock.h
===================================================================
--- linux-2.6-inc.orig/include/asm-arm/spinlock.h	2004-10-10 19:11:45.000000000 +0200
+++ linux-2.6-inc/include/asm-arm/spinlock.h	2004-10-13 21:32:39.286271617 +0200
@@ -15,13 +15,6 @@
  * Unlocked value: 0
  * Locked value: 1
  */
-typedef struct {
-	volatile unsigned int lock;
-} spinlock_t;
-
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
-
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while (0)
 #define spin_is_locked(x)	((x)->lock != 0)
 #define spin_unlock_wait(x)	do { barrier(); } while (spin_is_locked(x))
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
@@ -68,12 +61,6 @@ static inline void _raw_spin_unlock(spin
 /*
  * RWLOCKS
  */
-typedef struct {
-	volatile unsigned int lock;
-} rwlock_t;
-
-#define RW_LOCK_UNLOCKED	(rwlock_t) { 0 }
-#define rwlock_init(x)		do { *(x) + RW_LOCK_UNLOCKED; } while (0)
 
 /*
  * Write locks are easy - we just set bit 31.  When unlocking, we can
Index: linux-2.6-inc/include/asm-x86_64/spinlock.h
===================================================================
--- linux-2.6-inc.orig/include/asm-x86_64/spinlock.h	2004-10-10 19:11:45.000000000 +0200
+++ linux-2.6-inc/include/asm-x86_64/spinlock.h	2004-10-13 21:50:10.407362469 +0200
@@ -13,25 +13,6 @@ extern int printk(const char * fmt, ...)
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  */
 
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned magic;
-#endif
-} spinlock_t;
-
-#define SPINLOCK_MAGIC	0xdead4ead
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define SPINLOCK_MAGIC_INIT	, SPINLOCK_MAGIC
-#else
-#define SPINLOCK_MAGIC_INIT	/* */
-#endif
-
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 1 SPINLOCK_MAGIC_INIT }
-
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
-
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
@@ -136,25 +117,6 @@ printk("eip: %p\n", &&here);
  * irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
  */
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned magic;
-#endif
-} rwlock_t;
-
-#define RWLOCK_MAGIC	0xdeaf1eed
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC
-#else
-#define RWLOCK_MAGIC_INIT	/* */
-#endif
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
-
-#define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
-
 #define rwlock_is_locked(x) ((x)->lock != RW_LOCK_BIAS)
 
 /*
Index: linux-2.6-inc/include/asm-ppc64/spinlock.h
===================================================================
--- linux-2.6-inc.orig/include/asm-ppc64/spinlock.h	2004-10-10 19:11:45.000000000 +0200
+++ linux-2.6-inc/include/asm-ppc64/spinlock.h	2004-10-13 21:32:39.286271617 +0200
@@ -17,15 +17,9 @@
 #include <linux/config.h>
 #include <asm/paca.h>
 
-typedef struct {
-	volatile unsigned int lock;
-} spinlock_t;
-
 #ifdef __KERNEL__
-#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
 
 #define spin_is_locked(x)	((x)->lock != 0)
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
 
 static __inline__ void _raw_spin_unlock(spinlock_t *lock)
 {
@@ -140,13 +134,6 @@ static __inline__ void _raw_spin_lock_fl
  * irq-safe write-lock, but readers can get non-irqsafe
  * read-locks.
  */
-typedef struct {
-	volatile signed int lock;
-} rwlock_t;
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
-
-#define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 #define rwlock_is_locked(x)	((x)->lock)
 
 static __inline__ int is_read_locked(rwlock_t *rw)
Index: linux-2.6-inc/include/asm-x86_64/rwlock.h
===================================================================
--- linux-2.6-inc.orig/include/asm-x86_64/rwlock.h	2003-07-18 23:22:47.000000000 +0200
+++ linux-2.6-inc/include/asm-x86_64/rwlock.h	2004-10-13 21:50:10.405362816 +0200
@@ -20,9 +20,6 @@
 
 #include <linux/stringify.h>
 
-#define RW_LOCK_BIAS		 0x01000000
-#define RW_LOCK_BIAS_STR	"0x01000000"
-
 #define __build_read_lock_ptr(rw, helper)   \
 	asm volatile(LOCK "subl $1,(%0)\n\t" \
 		     "js 2f\n" \
