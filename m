Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVLVPip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVLVPip (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVLVPip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:38:45 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:32664 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751156AbVLVPiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:38:19 -0500
Date: Thu, 22 Dec 2005 16:37:31 +0100
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
Subject: [patch 01/10] mutex subsystem, add atomic_xchg() to all arches
Message-ID: <20051222153730.GB6090@elte.hu>
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

add atomic_xchg() to all the architectures. Needed by the new mutex code.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/asm-alpha/atomic.h     |    1 +
 include/asm-arm/atomic.h       |    2 ++
 include/asm-arm26/atomic.h     |    2 ++
 include/asm-cris/atomic.h      |    2 ++
 include/asm-frv/atomic.h       |    1 +
 include/asm-h8300/atomic.h     |    2 ++
 include/asm-i386/atomic.h      |    1 +
 include/asm-ia64/atomic.h      |    1 +
 include/asm-m32r/atomic.h      |    1 +
 include/asm-m68k/atomic.h      |    1 +
 include/asm-m68knommu/atomic.h |    1 +
 include/asm-mips/atomic.h      |    1 +
 include/asm-parisc/atomic.h    |    1 +
 include/asm-powerpc/atomic.h   |    1 +
 include/asm-s390/atomic.h      |    1 +
 include/asm-sh/atomic.h        |    2 ++
 include/asm-sh64/atomic.h      |    2 ++
 include/asm-sparc/atomic.h     |    1 +
 include/asm-sparc64/atomic.h   |    1 +
 include/asm-v850/atomic.h      |    2 ++
 include/asm-x86_64/atomic.h    |    1 +
 include/asm-xtensa/atomic.h    |    1 +
 22 files changed, 29 insertions(+)

Index: linux/include/asm-alpha/atomic.h
===================================================================
--- linux.orig/include/asm-alpha/atomic.h
+++ linux/include/asm-alpha/atomic.h
@@ -176,6 +176,7 @@ static __inline__ long atomic64_sub_retu
 }
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 #define atomic_add_unless(v, a, u)				\
 ({								\
Index: linux/include/asm-arm/atomic.h
===================================================================
--- linux.orig/include/asm-arm/atomic.h
+++ linux/include/asm-arm/atomic.h
@@ -175,6 +175,8 @@ static inline void atomic_clear_mask(uns
 
 #endif /* __LINUX_ARM_ARCH__ */
 
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
Index: linux/include/asm-arm26/atomic.h
===================================================================
--- linux.orig/include/asm-arm26/atomic.h
+++ linux/include/asm-arm26/atomic.h
@@ -76,6 +76,8 @@ static inline int atomic_cmpxchg(atomic_
 	return ret;
 }
 
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
Index: linux/include/asm-cris/atomic.h
===================================================================
--- linux.orig/include/asm-cris/atomic.h
+++ linux/include/asm-cris/atomic.h
@@ -136,6 +136,8 @@ static inline int atomic_cmpxchg(atomic_
 	return ret;
 }
 
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
Index: linux/include/asm-frv/atomic.h
===================================================================
--- linux.orig/include/asm-frv/atomic.h
+++ linux/include/asm-frv/atomic.h
@@ -415,6 +415,7 @@ extern uint32_t __cmpxchg_32(uint32_t *v
 #endif
 
 #define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 #define atomic_add_unless(v, a, u)				\
 ({								\
Index: linux/include/asm-h8300/atomic.h
===================================================================
--- linux.orig/include/asm-h8300/atomic.h
+++ linux/include/asm-h8300/atomic.h
@@ -95,6 +95,8 @@ static inline int atomic_cmpxchg(atomic_
 	return ret;
 }
 
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
Index: linux/include/asm-i386/atomic.h
===================================================================
--- linux.orig/include/asm-i386/atomic.h
+++ linux/include/asm-i386/atomic.h
@@ -216,6 +216,7 @@ static __inline__ int atomic_sub_return(
 }
 
 #define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 /**
  * atomic_add_unless - add unless the number is a given value
Index: linux/include/asm-ia64/atomic.h
===================================================================
--- linux.orig/include/asm-ia64/atomic.h
+++ linux/include/asm-ia64/atomic.h
@@ -89,6 +89,7 @@ ia64_atomic64_sub (__s64 i, atomic64_t *
 }
 
 #define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 #define atomic_add_unless(v, a, u)				\
 ({								\
Index: linux/include/asm-m32r/atomic.h
===================================================================
--- linux.orig/include/asm-m32r/atomic.h
+++ linux/include/asm-m32r/atomic.h
@@ -243,6 +243,7 @@ static __inline__ int atomic_dec_return(
 #define atomic_add_negative(i,v) (atomic_add_return((i), (v)) < 0)
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 /**
  * atomic_add_unless - add unless the number is a given value
Index: linux/include/asm-m68k/atomic.h
===================================================================
--- linux.orig/include/asm-m68k/atomic.h
+++ linux/include/asm-m68k/atomic.h
@@ -140,6 +140,7 @@ static inline void atomic_set_mask(unsig
 }
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 #define atomic_add_unless(v, a, u)				\
 ({								\
Index: linux/include/asm-m68knommu/atomic.h
===================================================================
--- linux.orig/include/asm-m68knommu/atomic.h
+++ linux/include/asm-m68knommu/atomic.h
@@ -129,6 +129,7 @@ static inline int atomic_sub_return(int 
 }
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 #define atomic_add_unless(v, a, u)				\
 ({								\
Index: linux/include/asm-mips/atomic.h
===================================================================
--- linux.orig/include/asm-mips/atomic.h
+++ linux/include/asm-mips/atomic.h
@@ -289,6 +289,7 @@ static __inline__ int atomic_sub_if_posi
 }
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 /**
  * atomic_add_unless - add unless the number is a given value
Index: linux/include/asm-parisc/atomic.h
===================================================================
--- linux.orig/include/asm-parisc/atomic.h
+++ linux/include/asm-parisc/atomic.h
@@ -165,6 +165,7 @@ static __inline__ int atomic_read(const 
 
 /* exported interface */
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 /**
  * atomic_add_unless - add unless the number is a given value
Index: linux/include/asm-powerpc/atomic.h
===================================================================
--- linux.orig/include/asm-powerpc/atomic.h
+++ linux/include/asm-powerpc/atomic.h
@@ -165,6 +165,7 @@ static __inline__ int atomic_dec_return(
 }
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 /**
  * atomic_add_unless - add unless the number is a given value
Index: linux/include/asm-s390/atomic.h
===================================================================
--- linux.orig/include/asm-s390/atomic.h
+++ linux/include/asm-s390/atomic.h
@@ -199,6 +199,7 @@ atomic_compare_and_swap(int expected_old
 }
 
 #define atomic_cmpxchg(v, o, n) (atomic_compare_and_swap((o), (n), &((v)->counter)))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 #define atomic_add_unless(v, a, u)				\
 ({								\
Index: linux/include/asm-sh/atomic.h
===================================================================
--- linux.orig/include/asm-sh/atomic.h
+++ linux/include/asm-sh/atomic.h
@@ -101,6 +101,8 @@ static inline int atomic_cmpxchg(atomic_
 	return ret;
 }
 
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
Index: linux/include/asm-sh64/atomic.h
===================================================================
--- linux.orig/include/asm-sh64/atomic.h
+++ linux/include/asm-sh64/atomic.h
@@ -113,6 +113,8 @@ static inline int atomic_cmpxchg(atomic_
 	return ret;
 }
 
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
Index: linux/include/asm-sparc/atomic.h
===================================================================
--- linux.orig/include/asm-sparc/atomic.h
+++ linux/include/asm-sparc/atomic.h
@@ -20,6 +20,7 @@ typedef struct { volatile int counter; }
 
 extern int __atomic_add_return(int, atomic_t *);
 extern int atomic_cmpxchg(atomic_t *, int, int);
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 extern int atomic_add_unless(atomic_t *, int, int);
 extern void atomic_set(atomic_t *, int);
 
Index: linux/include/asm-sparc64/atomic.h
===================================================================
--- linux.orig/include/asm-sparc64/atomic.h
+++ linux/include/asm-sparc64/atomic.h
@@ -72,6 +72,7 @@ extern int atomic64_sub_ret(int, atomic6
 #define atomic64_add_negative(i, v) (atomic64_add_ret(i, v) < 0)
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 #define atomic_add_unless(v, a, u)				\
 ({								\
Index: linux/include/asm-v850/atomic.h
===================================================================
--- linux.orig/include/asm-v850/atomic.h
+++ linux/include/asm-v850/atomic.h
@@ -104,6 +104,8 @@ static inline int atomic_cmpxchg(atomic_
 	return ret;
 }
 
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
Index: linux/include/asm-x86_64/atomic.h
===================================================================
--- linux.orig/include/asm-x86_64/atomic.h
+++ linux/include/asm-x86_64/atomic.h
@@ -389,6 +389,7 @@ static __inline__ long atomic64_sub_retu
 #define atomic64_dec_return(v)  (atomic64_sub_return(1,v))
 
 #define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 /**
  * atomic_add_unless - add unless the number is a given value
Index: linux/include/asm-xtensa/atomic.h
===================================================================
--- linux.orig/include/asm-xtensa/atomic.h
+++ linux/include/asm-xtensa/atomic.h
@@ -224,6 +224,7 @@ static inline int atomic_sub_return(int 
 #define atomic_add_negative(i,v) (atomic_add_return((i),(v)) < 0)
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 /**
  * atomic_add_unless - add unless the number is a given value
