Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVLVGxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVLVGxA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 01:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbVLVGxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 01:53:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:2516 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964841AbVLVGw7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 01:52:59 -0500
Date: Thu, 22 Dec 2005 01:52:58 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: [patch 1/5] mutex subsystem: fix asm-arm/atomic.h
In-reply-to: <20051221231218.GA6747@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512220117150.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051221155411.GA7243@elte.hu>
 <Pine.LNX.4.64.0512211735030.26663@localhost.localdomain>
 <20051221231218.GA6747@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The original patch added new definitions to include/asm-arm/atomic.h
inside the #if __LINUX_ARM_ARCH__ >= 6 and therefore they were
unavailable on non ARMv6 builds.  Move them outside that #if.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

Index: linux-2.6/include/asm-arm/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-arm/atomic.h
+++ linux-2.6/include/asm-arm/atomic.h
@@ -99,19 +99,6 @@ static inline int atomic_cmpxchg(atomic_
 	return oldval;
 }
 
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
-
-/*
- * Pull in the generic wrappers for atomic_dec_call_if_negative() and
- * atomic_inc_call_if_nonpositive().
- *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or use the ARCH_IMPLEMENTS_MUTEX_FASTPATH
- * mechanism to override the generic mutex_lock()/mutex_unlock()
- * functions.
- */
-#include <asm-generic/atomic-call-if.h>
-
 static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
 {
 	unsigned long tmp, tmp2;
@@ -188,6 +175,19 @@ static inline void atomic_clear_mask(uns
 
 #endif /* __LINUX_ARM_ARCH__ */
 
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+
+/*
+ * Pull in the generic wrappers for atomic_dec_call_if_negative() and
+ * atomic_inc_call_if_nonpositive().
+ *
+ * TODO: implement optimized primitives instead, or leave the generic
+ * implementation in place, or use the ARCH_IMPLEMENTS_MUTEX_FASTPATH
+ * mechanism to override the generic mutex_lock()/mutex_unlock()
+ * functions.
+ */
+#include <asm-generic/atomic-call-if.h>
+
 static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
