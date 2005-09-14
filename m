Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965239AbVINPHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbVINPHo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbVINPHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:07:43 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:49241 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965239AbVINPHm (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 14 Sep 2005 11:07:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=4FbVJQMfctEjb4Q54fPLzBkhkBCxcTKRkAgHl4UE+BgeFSzfAZM0WAexY18bMVF+o9vdydEtxq8q9ab8veqC7KpznRq7t7YjiwZPox0iIw55tqqnCA837p/glyn8Fhm092dJTngv8ko1ldCQUF36ScAXxxnG3P1Mb2m3TTmDbjQ=  ;
Message-ID: <43283B66.8080005@yahoo.com.au>
Date: Thu, 15 Sep 2005 01:01:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
CC: Dipankar Sarma <dipankar@in.ibm.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5/5] remove HAVE_ARCH_CMPXCHG
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au> <432838E8.5030302@yahoo.com.au> <432839F1.5020907@yahoo.com.au>
In-Reply-To: <432839F1.5020907@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------070206040800080408020201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070206040800080408020201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Is there any point in keeping this around?

-- 
SUSE Labs, Novell Inc.


--------------070206040800080408020201
Content-Type: text/plain;
 name="remove-HAVE_ARCH_CMPXCHG.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove-HAVE_ARCH_CMPXCHG.patch"

Index: linux-2.6/include/asm-alpha/system.h
===================================================================
--- linux-2.6.orig/include/asm-alpha/system.h
+++ linux-2.6/include/asm-alpha/system.h
@@ -477,8 +477,6 @@ extern void __xchg_called_with_bad_point
  * we don't need any memory barrier as far I can tell.
  */
 
-#define __HAVE_ARCH_CMPXCHG 1
-
 static inline unsigned long
 __cmpxchg_u8(volatile char *m, long old, long new)
 {
Index: linux-2.6/include/asm-i386/system.h
===================================================================
--- linux-2.6.orig/include/asm-i386/system.h
+++ linux-2.6/include/asm-i386/system.h
@@ -257,10 +257,6 @@ static inline unsigned long __xchg(unsig
  * indicated by comparing RETURN with OLD.
  */
 
-#ifdef CONFIG_X86_CMPXCHG
-#define __HAVE_ARCH_CMPXCHG 1
-#endif
-
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 				      unsigned long new, int size)
 {
Index: linux-2.6/include/asm-m68k/system.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/system.h
+++ linux-2.6/include/asm-m68k/system.h
@@ -164,7 +164,6 @@ static inline unsigned long __xchg(unsig
  * indicated by comparing RETURN with OLD.
  */
 #ifdef CONFIG_RMW_INSNS
-#define __HAVE_ARCH_CMPXCHG	1
 
 static inline unsigned long __cmpxchg(volatile void *p, unsigned long old,
 				      unsigned long new, int size)
Index: linux-2.6/include/asm-m68knommu/system.h
===================================================================
--- linux-2.6.orig/include/asm-m68knommu/system.h
+++ linux-2.6/include/asm-m68knommu/system.h
@@ -195,7 +195,6 @@ static inline unsigned long __xchg(unsig
  * store NEW in MEM.  Return the initial value in MEM.  Success is
  * indicated by comparing RETURN with OLD.
  */
-#define __HAVE_ARCH_CMPXCHG	1
 
 static __inline__ unsigned long
 cmpxchg(volatile int *p, int old, int new)
Index: linux-2.6/include/asm-mips/system.h
===================================================================
--- linux-2.6.orig/include/asm-mips/system.h
+++ linux-2.6/include/asm-mips/system.h
@@ -277,8 +277,6 @@ static inline unsigned long __xchg(unsig
 #define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
 #define tas(ptr) (xchg((ptr),1))
 
-#define __HAVE_ARCH_CMPXCHG 1
-
 static inline unsigned long __cmpxchg_u32(volatile int * m, unsigned long old,
 	unsigned long new)
 {
Index: linux-2.6/include/asm-ppc/system.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/system.h
+++ linux-2.6/include/asm-ppc/system.h
@@ -155,8 +155,6 @@ extern inline void * xchg_ptr(void * m, 
 }
 
 
-#define __HAVE_ARCH_CMPXCHG	1
-
 static __inline__ unsigned long
 __cmpxchg_u32(volatile unsigned int *p, unsigned int old, unsigned int new)
 {
Index: linux-2.6/include/asm-ppc64/system.h
===================================================================
--- linux-2.6.orig/include/asm-ppc64/system.h
+++ linux-2.6/include/asm-ppc64/system.h
@@ -223,8 +223,6 @@ __xchg(volatile void *ptr, unsigned long
 
 #define tas(ptr) (xchg((ptr),1))
 
-#define __HAVE_ARCH_CMPXCHG	1
-
 static __inline__ unsigned long
 __cmpxchg_u32(volatile unsigned int *p, unsigned long old, unsigned long new)
 {
Index: linux-2.6/include/asm-s390/system.h
===================================================================
--- linux-2.6.orig/include/asm-s390/system.h
+++ linux-2.6/include/asm-s390/system.h
@@ -189,8 +189,6 @@ static inline unsigned long __xchg(unsig
  * indicated by comparing RETURN with OLD.
  */
 
-#define __HAVE_ARCH_CMPXCHG 1
-
 #define cmpxchg(ptr,o,n)\
 	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
 					(unsigned long)(n),sizeof(*(ptr))))
Index: linux-2.6/include/asm-sparc64/system.h
===================================================================
--- linux-2.6.orig/include/asm-sparc64/system.h
+++ linux-2.6/include/asm-sparc64/system.h
@@ -321,8 +321,6 @@ extern void die_if_kernel(char *str, str
  * indicated by comparing RETURN with OLD.
  */
 
-#define __HAVE_ARCH_CMPXCHG 1
-
 static __inline__ unsigned long
 __cmpxchg_u32(volatile int *m, int old, int new)
 {
Index: linux-2.6/include/asm-x86_64/system.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/system.h
+++ linux-2.6/include/asm-x86_64/system.h
@@ -237,8 +237,6 @@ static inline unsigned long __xchg(unsig
  * indicated by comparing RETURN with OLD.
  */
 
-#define __HAVE_ARCH_CMPXCHG 1
-
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 				      unsigned long new, int size)
 {
Index: linux-2.6/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/acpi/boot.c
+++ linux-2.6/arch/i386/kernel/acpi/boot.c
@@ -83,7 +83,7 @@ int acpi_skip_timer_override __initdata;
 static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
 #endif
 
-#ifndef __HAVE_ARCH_CMPXCHG
+#ifndef CONFIG_X86_CMPXCHG
 #warning ACPI uses CMPXCHG, i486 and later hardware
 #endif
 
Index: linux-2.6/include/asm-i386/mc146818rtc.h
===================================================================
--- linux-2.6.orig/include/asm-i386/mc146818rtc.h
+++ linux-2.6/include/asm-i386/mc146818rtc.h
@@ -13,7 +13,7 @@
 #define RTC_ALWAYS_BCD	1	/* RTC operates in binary mode */
 #endif
 
-#ifdef __HAVE_ARCH_CMPXCHG
+#ifdef CONFIG_X86_CMPXCHG
 /*
  * This lock provides nmi access to the CMOS/RTC registers.  It has some
  * special properties.  It is owned by a CPU and stores the index register
Index: linux-2.6/include/asm-ia64/intrinsics.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/intrinsics.h
+++ linux-2.6/include/asm-ia64/intrinsics.h
@@ -111,8 +111,6 @@ extern void ia64_xchg_called_with_bad_po
  * indicated by comparing RETURN with OLD.
  */
 
-#define __HAVE_ARCH_CMPXCHG 1
-
 /*
  * This function doesn't exist, so you'll get a linker error
  * if something tries to do an invalid cmpxchg().
Index: linux-2.6/include/asm-parisc/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-parisc/atomic.h
+++ linux-2.6/include/asm-parisc/atomic.h
@@ -98,8 +98,6 @@ static __inline__ unsigned long __xchg(u
 	((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
 
 
-#define __HAVE_ARCH_CMPXCHG	1
-
 /* bug catcher for when unsupported size is used - won't link */
 extern void __cmpxchg_called_with_bad_pointer(void);
 
Index: linux-2.6/include/asm-um/system-i386.h
===================================================================
--- linux-2.6.orig/include/asm-um/system-i386.h
+++ linux-2.6/include/asm-um/system-i386.h
@@ -3,6 +3,4 @@
 
 #include "asm/system-generic.h"
     
-#define __HAVE_ARCH_CMPXCHG 1
-
 #endif

--------------070206040800080408020201--
Send instant messages to your online friends http://au.messenger.yahoo.com 
