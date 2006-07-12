Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWGLUqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWGLUqe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 16:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWGLUqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 16:46:34 -0400
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:17284 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751072AbWGLUqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 16:46:33 -0400
Date: Wed, 12 Jul 2006 16:41:15 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: system.h: remove extra semicolons and fix order
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200607121643_MC3-1-C4D3-2367@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/asm-i386/system.h has trailing semicolons in some of the
macros that cause legitimate code to fail compilation, so remove
them. Also remove extra blank lines within one group of macros.

And put stts() and clts() back together; they got separated somehow.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.18-rc1-nb.orig/include/asm-i386/system.h
+++ 2.6.18-rc1-nb/include/asm-i386/system.h
@@ -82,10 +82,6 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
 #define savesegment(seg, value) \
 	asm volatile("mov %%" #seg ",%0":"=rm" (value))
 
-/*
- * Clear and set 'TS' bit respectively
- */
-#define clts() __asm__ __volatile__ ("clts")
 #define read_cr0() ({ \
 	unsigned int __dummy; \
 	__asm__ __volatile__( \
@@ -94,7 +90,7 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
 	__dummy; \
 })
 #define write_cr0(x) \
-	__asm__ __volatile__("movl %0,%%cr0": :"r" (x));
+	__asm__ __volatile__("movl %0,%%cr0": :"r" (x))
 
 #define read_cr2() ({ \
 	unsigned int __dummy; \
@@ -104,7 +100,7 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
 	__dummy; \
 })
 #define write_cr2(x) \
-	__asm__ __volatile__("movl %0,%%cr2": :"r" (x));
+	__asm__ __volatile__("movl %0,%%cr2": :"r" (x))
 
 #define read_cr3() ({ \
 	unsigned int __dummy; \
@@ -114,7 +110,7 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
 	__dummy; \
 })
 #define write_cr3(x) \
-	__asm__ __volatile__("movl %0,%%cr3": :"r" (x));
+	__asm__ __volatile__("movl %0,%%cr3": :"r" (x))
 
 #define read_cr4() ({ \
 	unsigned int __dummy; \
@@ -123,7 +119,6 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
 		:"=r" (__dummy)); \
 	__dummy; \
 })
-
 #define read_cr4_safe() ({			      \
 	unsigned int __dummy;			      \
 	/* This could fault if %cr4 does not exist */ \
@@ -135,15 +130,19 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
 		: "=r" (__dummy): "0" (0));	      \
 	__dummy;				      \
 })
-
 #define write_cr4(x) \
-	__asm__ __volatile__("movl %0,%%cr4": :"r" (x));
+	__asm__ __volatile__("movl %0,%%cr4": :"r" (x))
+
+/*
+ * Clear and set 'TS' bit respectively
+ */
+#define clts() __asm__ __volatile__ ("clts")
 #define stts() write_cr0(8 | read_cr0())
 
 #endif	/* __KERNEL__ */
 
 #define wbinvd() \
-	__asm__ __volatile__ ("wbinvd": : :"memory");
+	__asm__ __volatile__ ("wbinvd": : :"memory")
 
 static inline unsigned long get_limit(unsigned long segment)
 {
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
