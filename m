Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbVLVXGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbVLVXGP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbVLVXGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:06:15 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:5595 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030358AbVLVXFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:05:49 -0500
Date: Fri, 23 Dec 2005 00:04:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 3/8] mutex subsystem, add per-arch mutex.h files
Message-ID: <20051222230456.GD13302@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add the per-arch mutex.h files. i386 and x86 provide their own
fastpath implementation already, the others default to
asm-generic/mutex-xchg.h.

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/asm-alpha/mutex.h     |   10 ++++
 include/asm-arm/mutex.h       |    8 +++
 include/asm-arm26/mutex.h     |    8 +++
 include/asm-cris/mutex.h      |   10 ++++
 include/asm-frv/mutex.h       |   10 ++++
 include/asm-h8300/mutex.h     |   10 ++++
 include/asm-i386/mutex.h      |   95 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-ia64/mutex.h      |   10 ++++
 include/asm-m32r/mutex.h      |   10 ++++
 include/asm-m68k/mutex.h      |   10 ++++
 include/asm-m68knommu/mutex.h |   10 ++++
 include/asm-mips/mutex.h      |   10 ++++
 include/asm-parisc/mutex.h    |   10 ++++
 include/asm-powerpc/mutex.h   |   10 ++++
 include/asm-s390/mutex.h      |   10 ++++
 include/asm-sh/mutex.h        |   10 ++++
 include/asm-sh64/mutex.h      |   10 ++++
 include/asm-sparc/mutex.h     |   10 ++++
 include/asm-sparc64/mutex.h   |   10 ++++
 include/asm-um/mutex.h        |   10 ++++
 include/asm-v850/mutex.h      |   10 ++++
 include/asm-x86_64/mutex.h    |   69 ++++++++++++++++++++++++++++++
 include/asm-xtensa/mutex.h    |   10 ++++
 23 files changed, 370 insertions(+)

Index: linux/include/asm-alpha/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-alpha/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-arm/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-arm/mutex.h
@@ -0,0 +1,8 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead
+ */
+
+#include <asm-generic/mutex-xchg.h>
Index: linux/include/asm-arm26/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-arm26/mutex.h
@@ -0,0 +1,8 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead
+ */
+
+#include <asm-generic/mutex-xchg.h>
Index: linux/include/asm-cris/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-cris/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-frv/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-frv/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-h8300/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-h8300/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-i386/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-i386/mutex.h
@@ -0,0 +1,95 @@
+/*
+ * Mutexes: blocking mutual exclusion locks
+ *
+ * started by Ingo Molnar:
+ *
+ *  Copyright (C) 2004, 2005 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ */
+
+/**
+ *  __mutex_fastpath_lock - try to take the lock by moving the count
+ *                          from 1 to a 0 value
+ *  @count: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fn> if it
+ * wasn't 1 originally. This function MUST leave the value lower than 1
+ * even when the "1" assertion wasn't true.
+ */
+#define __mutex_fastpath_lock(count, fn_name)				\
+do {									\
+	void fastcall (*__tmp)(atomic_t *) = fn_name;			\
+	unsigned int dummy;						\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, count);					\
+									\
+	__asm__ __volatile__(						\
+		LOCK "decl (%%eax)\n"  					\
+		"js 2f\n"						\
+		"1:\n"							\
+		LOCK_SECTION_START("")					\
+		"2: call "#fn_name"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:"=a"(dummy)						\
+		:"a" (count)						\
+		:"memory", "ecx", "edx");				\
+} while (0)
+
+
+/**
+ *  __mutex_fastpath_lock_retval - try to take the lock by moving the count
+ *                                 from 1 to a 0 value
+ *  @count: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fn> if it
+ * wasn't 1 originally. This function returns 0 if the fastpath succeeds,
+ * or anything the slow path function returns
+ */
+static inline int
+__mutex_fastpath_lock_retval(atomic_t *count,
+			     int fastcall (*fn_name)(atomic_t *))
+{
+	if (unlikely(atomic_dec_return(count) < 0))
+		return fn_name(count);
+	else
+		return 0;
+}
+
+/**
+ *  __mutex_fastpath_unlock - try to promote the mutex from 0 to 1
+ *  @count: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 1
+ *
+ * try to promote the mutex from 0 to 1. if it wasn't 0, call <function>
+ * In the failure case, this function is allowed to either set the value to
+ * 1, or to set it to a value lower than one.
+ * If the implementation sets it to a value of lower than one, the
+ * __mutex_slowpath_needs_to_unlock() macro needs to return 1, it needs
+ * to return 0 otherwise.
+ */
+#define __mutex_fastpath_unlock(count, fn_name)				\
+do {									\
+	void fastcall (*__tmp)(atomic_t *) = fn_name;			\
+	unsigned int dummy;						\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, count);					\
+									\
+	__asm__ __volatile__(						\
+		LOCK "incl (%%eax)\n"  					\
+		"jle 2f\n"						\
+		"1:\n"							\
+		LOCK_SECTION_START("")					\
+		"2: call "#fn_name"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:"=a" (dummy)						\
+		:"a" (count)						\
+		:"memory", "ecx", "edx");				\
+} while (0)
+
+#define __mutex_slowpath_needs_to_unlock()	1
+
Index: linux/include/asm-ia64/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-ia64/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-m32r/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-m32r/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-m68k/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-m68k/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-m68knommu/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-m68knommu/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-mips/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-mips/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-parisc/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-parisc/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-powerpc/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-powerpc/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-s390/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-s390/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-sh/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-sh/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-sh64/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-sh64/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-sparc/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-sparc/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-sparc64/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-sparc64/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-um/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-um/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-v850/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-v850/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
Index: linux/include/asm-x86_64/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-x86_64/mutex.h
@@ -0,0 +1,69 @@
+
+/*
+ * Mutexes: blocking mutual exclusion locks
+ *
+ * started by Ingo Molnar:
+ *
+ *  Copyright (C) 2004, 2005 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ */
+
+/**
+ * __mutex_fastpath_lock - decrement and call function if negative
+ * @v: pointer of type atomic_t
+ * @fn: function to call if the result is negative
+ *
+ * Atomically decrements @v and calls a function if the result is negative.
+ */
+#define __mutex_fastpath_lock(v, fn_name)				\
+do {									\
+	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
+	unsigned long dummy;						\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, v);					\
+									\
+	__asm__ __volatile__(						\
+		LOCK "decl (%%rdi)\n"  					\
+		"js 2f\n"						\
+		"1:\n"							\
+		LOCK_SECTION_START("")					\
+		"2: call "#fn_name"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:"=D" (dummy)						\
+		:"D" (v)						\
+		:"rax", "rsi", "rdx", "rcx",				\
+		 "r8", "r9", "r10", "r11", "memory");			\
+} while (0)
+
+/**
+ * __mutex_fastpath_unlock - increment and call function if nonpositive
+ * @v: pointer of type atomic_t
+ * @fn: function to call if the result is nonpositive
+ *
+ * Atomically increments @v and calls a function if the result is nonpositive.
+ */
+#define __mutex_fastpath_unlock(v, fn_name)			\
+do {									\
+	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
+	unsigned long dummy;						\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, v);					\
+									\
+	__asm__ __volatile__(						\
+		LOCK "incl (%%rdi)\n"  					\
+		"jle 2f\n"						\
+		"1:\n"							\
+		LOCK_SECTION_START("")					\
+		"2: call "#fn_name"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:"=D" (dummy)						\
+		:"D" (v)						\
+		:"rax", "rsi", "rdx", "rcx",				\
+		 "r8", "r9", "r10", "r11", "memory");			\
+} while (0)
+
+
+#define __mutex_slowpath_needs_to_unlock() 1
Index: linux/include/asm-xtensa/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-xtensa/mutex.h
@@ -0,0 +1,10 @@
+/*
+ * Pull in the generic wrappers for __mutex_fastpath_lock() and
+ * __mutex_fastpath_unlock().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or pick the atomic_xchg() based
+ * generic implementation.
+ */
+
+#include <asm-generic/mutex-dec.h>
