Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbVL1LrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbVL1LrL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 06:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVL1LrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 06:47:11 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:63881 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932509AbVL1LrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 06:47:10 -0500
Date: Wed, 28 Dec 2005 12:46:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Matt Mackall <mpm@selenic.com>
Subject: [patch 01/2] allow gcc4 to control inlining
Message-ID: <20051228114653.GB3003@elte.hu>
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

allow gcc4 compilers to decide what to inline and what not - instead
of the kernel forcing gcc to inline all the time.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>
----

 include/linux/compiler-gcc4.h |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

Index: linux/include/linux/compiler-gcc4.h
===================================================================
--- linux.orig/include/linux/compiler-gcc4.h
+++ linux/include/linux/compiler-gcc4.h
@@ -3,14 +3,15 @@
 /* These definitions are for GCC v4.x.  */
 #include <linux/compiler-gcc.h>
 
-#define inline			inline		__attribute__((always_inline))
-#define __inline__		__inline__	__attribute__((always_inline))
-#define __inline		__inline	__attribute__((always_inline))
+#define inline			inline
+#define __inline__		__inline__
+#define __inline		__inline
 #define __deprecated		__attribute__((deprecated))
 #define __attribute_used__	__attribute__((__used__))
 #define __attribute_pure__	__attribute__((pure))
 #define __attribute_const__	__attribute__((__const__))
-#define  noinline		__attribute__((noinline))
+#define noinline		__attribute__((noinline))
+#define __always_inline		inline __attribute__((always_inline))
 #define __must_check 		__attribute__((warn_unused_result))
 #define __compiler_offsetof(a,b) __builtin_offsetof(a,b)
 
