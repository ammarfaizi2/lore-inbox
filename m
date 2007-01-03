Return-Path: <linux-kernel-owner+w=401wt.eu-S1753638AbXACCZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbXACCZP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 21:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753690AbXACCZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 21:25:15 -0500
Received: from mail.pxnet.com ([195.227.45.3]:45536 "EHLO lx1.pxnet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753638AbXACCZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 21:25:13 -0500
Date: Wed, 3 Jan 2007 03:24:52 +0100
Message-Id: <200701030224.l032Oqgc022584@lx1.pxnet.com>
From: Tilman Schmidt <tilman@imap.cc>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix sparse warnings from {asm,net}/checksum.h
References: <45991971.90605@imap.cc> <20070101191015.GB20443@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the variable "sum" in the __range_ok macros to avoid name
collisions causing lots of "symbol shadows an earlier one" warnings
by sparse.

Signed-off-by: Tilman Schmidt <tilman@imap.cc>

---

 asm-arm/uaccess.h       |    4 ++--
 asm-arm26/uaccess-asm.h |    4 ++--
 asm-i386/uaccess.h      |    4 ++--
 asm-m32r/uaccess.h      |    4 ++--
 asm-x86_64/uaccess.h    |    4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff -pru linux-2.6.20-rc3-work/include/asm-arm/uaccess.h linux-2.6.20-rc3-new/include/asm-arm/uaccess.h
--- linux-2.6.20-rc3-work/include/asm-arm/uaccess.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.20-rc3-new/include/asm-arm/uaccess.h	2007-01-02 00:23:34.000000000 +0100
@@ -76,10 +76,10 @@ static inline void set_fs(mm_segment_t f
 
 /* We use 33-bit arithmetic here... */
 #define __range_ok(addr,size) ({ \
-	unsigned long flag, sum; \
+	unsigned long flag, roksum; \
 	__chk_user_ptr(addr);	\
 	__asm__("adds %1, %2, %3; sbcccs %1, %1, %0; movcc %0, #0" \
-		: "=&r" (flag), "=&r" (sum) \
+		: "=&r" (flag), "=&r" (roksum) \
 		: "r" (addr), "Ir" (size), "0" (current_thread_info()->addr_limit) \
 		: "cc"); \
 	flag; })
diff -pru linux-2.6.20-rc3-work/include/asm-arm26/uaccess-asm.h linux-2.6.20-rc3-new/include/asm-arm26/uaccess-asm.h
--- linux-2.6.20-rc3-work/include/asm-arm26/uaccess-asm.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.20-rc3-new/include/asm-arm26/uaccess-asm.h	2007-01-02 00:23:50.000000000 +0100
@@ -34,9 +34,9 @@ static inline void set_fs (mm_segment_t 
 }
 
 #define __range_ok(addr,size) ({					\
-	unsigned long flag, sum;					\
+	unsigned long flag, roksum;					\
 	__asm__ __volatile__("subs %1, %0, %3; cmpcs %1, %2; movcs %0, #0" \
-		: "=&r" (flag), "=&r" (sum)				\
+		: "=&r" (flag), "=&r" (roksum)				\
 		: "r" (addr), "Ir" (size), "0" (current_thread_info()->addr_limit)	\
 		: "cc");						\
 	flag; })
diff -pru linux-2.6.20-rc3-work/include/asm-i386/uaccess.h linux-2.6.20-rc3-new/include/asm-i386/uaccess.h
--- linux-2.6.20-rc3-work/include/asm-i386/uaccess.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.20-rc3-new/include/asm-i386/uaccess.h	2007-01-02 00:24:04.000000000 +0100
@@ -54,10 +54,10 @@ extern struct movsl_mask {
  * This needs 33-bit arithmetic. We have a carry...
  */
 #define __range_ok(addr,size) ({ \
-	unsigned long flag,sum; \
+	unsigned long flag,roksum; \
 	__chk_user_ptr(addr); \
 	asm("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; sbbl $0,%0" \
-		:"=&r" (flag), "=r" (sum) \
+		:"=&r" (flag), "=r" (roksum) \
 		:"1" (addr),"g" ((int)(size)),"rm" (current_thread_info()->addr_limit.seg)); \
 	flag; })
 
diff -pru linux-2.6.20-rc3-work/include/asm-m32r/uaccess.h linux-2.6.20-rc3-new/include/asm-m32r/uaccess.h
--- linux-2.6.20-rc3-work/include/asm-m32r/uaccess.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.20-rc3-new/include/asm-m32r/uaccess.h	2007-01-02 00:24:25.000000000 +0100
@@ -68,7 +68,7 @@ static inline void set_fs(mm_segment_t s
  * This needs 33-bit arithmetic. We have a carry...
  */
 #define __range_ok(addr,size) ({					\
-	unsigned long flag, sum; 					\
+	unsigned long flag, roksum; 					\
 	__chk_user_ptr(addr);						\
 	asm ( 								\
 		"	cmpu	%1, %1    ; clear cbit\n"		\
@@ -76,7 +76,7 @@ static inline void set_fs(mm_segment_t s
 		"	subx	%0, %0\n"				\
 		"	cmpu	%4, %1\n"				\
 		"	subx	%0, %5\n"				\
-		: "=&r" (flag), "=r" (sum)				\
+		: "=&r" (flag), "=r" (roksum)				\
 		: "1" (addr), "r" ((int)(size)), 			\
 		  "r" (current_thread_info()->addr_limit.seg), "r" (0)	\
 		: "cbit" );						\
diff -pru linux-2.6.20-rc3-work/include/asm-x86_64/uaccess.h linux-2.6.20-rc3-new/include/asm-x86_64/uaccess.h
--- linux-2.6.20-rc3-work/include/asm-x86_64/uaccess.h	2007-01-01 21:14:56.000000000 +0100
+++ linux-2.6.20-rc3-new/include/asm-x86_64/uaccess.h	2007-01-02 00:25:05.000000000 +0100
@@ -37,11 +37,11 @@
  * Uhhuh, this needs 65-bit arithmetic. We have a carry..
  */
 #define __range_not_ok(addr,size) ({ \
-	unsigned long flag,sum; \
+	unsigned long flag,roksum; \
 	__chk_user_ptr(addr); \
 	asm("# range_ok\n\r" \
 		"addq %3,%1 ; sbbq %0,%0 ; cmpq %1,%4 ; sbbq $0,%0"  \
-		:"=&r" (flag), "=r" (sum) \
+		:"=&r" (flag), "=r" (roksum) \
 		:"1" (addr),"g" ((long)(size)),"g" (current_thread_info()->addr_limit.seg)); \
 	flag; })
 
