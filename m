Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTFBOdf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 10:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbTFBOdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 10:33:35 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:12772 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262363AbTFBOd0
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 2 Jun 2003 10:33:26 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16091.25432.266850.902940@laputa.namesys.com>
Date: Mon, 2 Jun 2003 18:46:48 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Adrian Bunk <bunk@fs.tum.de>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Gianni Tedesco <gianni@scaramanga.co.uk>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Linus Torvalds <Torvalds@Transmeta.COM>, Andrew Morton <AKPM@Digeo.COM>
Subject: Re: const from include/asm-i386/byteorder.h
In-Reply-To: <20030602133705.GH29425@fs.tum.de>
References: <16088.47088.814881.791196@laputa.namesys.com>
	<1054406992.4837.0.camel@sherbert>
	<20030531185709.GK8978@holomorphy.com>
	<16091.14923.815819.792026@laputa.namesys.com>
	<20030602133705.GH29425@fs.tum.de>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta11) "cabbage" XEmacs Lucid
X-Zippy-Says: I want a WESSON OIL lease!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk writes:

[...]

 > 
 > gcc 2.95 is the oldest compiler supported in kernel 2.5, there's no need 
 > to be compatible with older compilers.

Here is new version.

Nikita.
===== include/asm-arm/current.h 1.3 vs edited =====
--- 1.3/include/asm-arm/current.h	Sat Dec 28 19:26:45 2002
+++ edited/include/asm-arm/current.h	Mon Jun  2 18:32:12 2003
@@ -2,8 +2,9 @@
 #define _ASMARM_CURRENT_H
 
 #include <linux/thread_info.h>
+#include <linux/compiler.h>
 
-static inline struct task_struct *get_current(void) __attribute__ (( __const__ ));
+static inline struct task_struct *get_current(void) __const_fn;
 
 static inline struct task_struct *get_current(void)
 {
===== include/asm-arm/thread_info.h 1.6 vs edited =====
--- 1.6/include/asm-arm/thread_info.h	Sat Dec 28 19:26:45 2002
+++ edited/include/asm-arm/thread_info.h	Mon Jun  2 18:32:11 2003
@@ -22,6 +22,8 @@
 #include <asm/ptrace.h>
 #include <asm/types.h>
 
+#include <linux/compiler.h>
+
 typedef unsigned long mm_segment_t;
 
 struct cpu_context_save {
@@ -74,7 +76,7 @@
 /*
  * how to get the thread information struct from C
  */
-static inline struct thread_info *current_thread_info(void) __attribute__ (( __const__ ));
+static inline struct thread_info *current_thread_info(void) __const_fn;
 
 static inline struct thread_info *current_thread_info(void)
 {
===== include/asm-cris/byteorder.h 1.1 vs edited =====
--- 1.1/include/asm-cris/byteorder.h	Tue Feb  5 20:56:43 2002
+++ edited/include/asm-cris/byteorder.h	Mon Jun  2 18:32:12 2003
@@ -7,19 +7,21 @@
 
 #ifdef __GNUC__
 
+#include <linux/compiler.h>
+
 /* we just define these two (as we can do the swap in a single
  * asm instruction in CRIS) and the arch-independent files will put
  * them together into ntohl etc.
  */
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __const_fn __u32 ___arch__swab32(__u32 x)
 {
 	__asm__ ("swapwb %0" : "=r" (x) : "0" (x));
   
 	return(x);
 }
 
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __const_fn __u16 ___arch__swab16(__u16 x)
 {
 	__asm__ ("swapb %0" : "=r" (x) : "0" (x));
 	
===== include/asm-i386/byteorder.h 1.2 vs edited =====
--- 1.2/include/asm-i386/byteorder.h	Fri Oct 11 21:15:35 2002
+++ edited/include/asm-i386/byteorder.h	Mon Jun  2 18:31:33 2003
@@ -10,7 +10,9 @@
 #include <linux/config.h>
 #endif
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+#include <linux/compiler.h>
+
+static __inline__ __const_fn __u32 ___arch__swab32(__u32 x) 
 {
 #ifdef CONFIG_X86_BSWAP
 	__asm__("bswap %0" : "=r" (x) : "0" (x));
@@ -26,7 +28,7 @@
 
 /* gcc should generate this for open coded C now too. May be worth switching to 
    it because inline assembly cannot be scheduled. -AK */
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __const_fn __u16 ___arch__swab16(__u16 x)
 {
 	__asm__("xchgb %b0,%h0"		/* swap bytes		*/
 		: "=q" (x)
@@ -35,7 +37,7 @@
 }
 
 
-static inline __u64 ___arch__swab64(__u64 val) 
+static inline __const_fn __u64 ___arch__swab64(__u64 val) 
 { 
 	union { 
 		struct { __u32 a,b; } s;
===== include/asm-ia64/byteorder.h 1.2 vs edited =====
--- 1.2/include/asm-ia64/byteorder.h	Tue Feb  5 10:39:14 2002
+++ edited/include/asm-ia64/byteorder.h	Mon Jun  2 18:32:12 2003
@@ -7,8 +7,9 @@
  */
 
 #include <asm/types.h>
+#include <linux/compiler.h>
 
-static __inline__ __const__ __u64
+static __inline__ __const_fn __u64
 __ia64_swab64 (__u64 x)
 {
 	__u64 result;
@@ -17,13 +18,13 @@
 	return result;
 }
 
-static __inline__ __const__ __u32
+static __inline__ __const_fn __u32
 __ia64_swab32 (__u32 x)
 {
 	return __ia64_swab64(x) >> 32;
 }
 
-static __inline__ __const__ __u16
+static __inline__ __const_fn __u16
 __ia64_swab16(__u16 x)
 {
 	return __ia64_swab64(x) >> 48;
===== include/asm-m68k/byteorder.h 1.1 vs edited =====
--- 1.1/include/asm-m68k/byteorder.h	Tue Feb  5 20:39:46 2002
+++ edited/include/asm-m68k/byteorder.h	Mon Jun  2 18:32:12 2003
@@ -5,7 +5,9 @@
 
 #ifdef __GNUC__
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 val)
+#include <linux/compiler.h>
+
+static __inline__ __const_fn __u32 ___arch__swab32(__u32 val)
 {
 	__asm__("rolw #8,%0; swap %0; rolw #8,%0" : "=d" (val) : "0" (val));
 	return val;
===== include/asm-parisc/byteorder.h 1.1 vs edited =====
--- 1.1/include/asm-parisc/byteorder.h	Tue Feb  5 20:39:57 2002
+++ edited/include/asm-parisc/byteorder.h	Mon Jun  2 18:32:12 2003
@@ -5,7 +5,9 @@
 
 #ifdef __GNUC__
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+#include <linux/compiler.h>
+
+static __inline__ __const_fn __u32 ___arch__swab32(__u32 x)
 {
 	unsigned int temp;
 	__asm__("shd %0, %0, 16, %1\n\t"	/* shift abcdabcd -> cdab */
@@ -28,7 +30,7 @@
 **      HSHR    67452301 -> *6*4*2*0 into %0
 **      OR      %0 | %1  -> 76543210 into %0 (all done!)
 */
-static __inline__ __const__ __u64 ___arch__swab64(__u64 x) {
+static __inline__ __const_fn __u64 ___arch__swab64(__u64 x) {
 	__u64 temp;
 	__asm__("permh 3210, %0, %0\n\t"
 		"hshl %0, 8, %1\n\t"
@@ -40,7 +42,7 @@
 }
 #define __arch__swab64(x) ___arch__swab64(x)
 #else
-static __inline__ __const__ __u64 ___arch__swab64(__u64 x)
+static __inline__ __const_fn __u64 ___arch__swab64(__u64 x)
 {
 	__u32 t1 = (__u32) x;
 	__u32 t2 = (__u32) ((x) >> 32);
@@ -51,7 +53,7 @@
 #endif
 
 
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __const_fn __u16 ___arch__swab16(__u16 x)
 {
 	__asm__("dep %0, 15, 8, %0\n\t"		/* deposit 00ab -> 0bab */
 		"shd %r0, %0, 8, %0"		/* shift 000000ab -> 00ba */
===== include/asm-ppc/byteorder.h 1.5 vs edited =====
--- 1.5/include/asm-ppc/byteorder.h	Mon Sep 16 08:52:03 2002
+++ edited/include/asm-ppc/byteorder.h	Mon Jun  2 18:30:27 2003
@@ -4,8 +4,11 @@
 #include <asm/types.h>
 
 #ifdef __GNUC__
+
 #ifdef __KERNEL__
 
+#include <linux/compiler.h>
+
 extern __inline__ unsigned ld_le16(const volatile unsigned short *addr)
 {
 	unsigned val;
@@ -32,7 +35,7 @@
 	__asm__ __volatile__ ("stwbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
 }
 
-static __inline__ __const__ __u16 ___arch__swab16(__u16 value)
+static __inline__ __const_fn __u16 ___arch__swab16(__u16 value)
 {
 	__u16 result;
 
@@ -40,7 +43,7 @@
 	return result;
 }
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 value)
+static __inline__ __const_fn __u32 ___arch__swab32(__u32 value)
 {
 	__u32 result;
 
===== include/asm-ppc64/byteorder.h 1.1 vs edited =====
--- 1.1/include/asm-ppc64/byteorder.h	Thu Feb 14 15:14:36 2002
+++ edited/include/asm-ppc64/byteorder.h	Mon Jun  2 18:32:12 2003
@@ -13,6 +13,8 @@
 #ifdef __GNUC__
 #ifdef __KERNEL__
 
+#include <linux/compiler.h>
+
 static __inline__ __u16 ld_le16(const volatile __u16 *addr)
 {
 	__u16 val;
@@ -40,7 +42,7 @@
 }
 
 #if 0
-static __inline__ __const__ __u16 ___arch__swab16(__u16 value)
+static __inline__ __const_fn __u16 ___arch__swab16(__u16 value)
 {
 	__u16 result;
 
@@ -50,7 +52,7 @@
 	return result;
 }
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 value)
+static __inline__ __const_fn __u32 ___arch__swab32(__u32 value)
 {
 	__u32 result;
 
@@ -62,7 +64,7 @@
 	return result;
 }
 
-static __inline__ __const__ __u64 ___arch__swab64(__u64 value)
+static __inline__ __const_fn __u64 ___arch__swab64(__u64 value)
 {
 	__u64 result;
 #error implement me
===== include/asm-s390/byteorder.h 1.4 vs edited =====
--- 1.4/include/asm-s390/byteorder.h	Mon Apr 14 23:11:58 2003
+++ edited/include/asm-s390/byteorder.h	Mon Jun  2 18:32:12 2003
@@ -13,8 +13,10 @@
 
 #ifdef __GNUC__
 
+#include <linux/compiler.h>
+
 #ifdef __s390x__
-static __inline__ __const__ __u64 ___arch__swab64p(__u64 *x)
+static __inline__ __const_fn __u64 ___arch__swab64p(__u64 *x)
 {
 	__u64 result;
 
@@ -24,7 +26,7 @@
 	return result;
 }
 
-static __inline__ __const__ __u64 ___arch__swab64(__u64 x)
+static __inline__ __const_fn __u64 ___arch__swab64(__u64 x)
 {
 	__u64 result;
 
@@ -40,7 +42,7 @@
 }
 #endif /* __s390x__ */
 
-static __inline__ __const__ __u32 ___arch__swab32p(__u32 *x)
+static __inline__ __const_fn __u32 ___arch__swab32p(__u32 *x)
 {
 	__u32 result;
 	
@@ -58,7 +60,7 @@
 	return result;
 }
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __const_fn __u32 ___arch__swab32(__u32 x)
 {
 #ifndef __s390x__
 	return ___arch__swab32p(&x);
@@ -77,7 +79,7 @@
 	*x = ___arch__swab32p(x);
 }
 
-static __inline__ __const__ __u16 ___arch__swab16p(__u16 *x)
+static __inline__ __const_fn __u16 ___arch__swab16p(__u16 *x)
 {
 	__u16 result;
 	
@@ -93,7 +95,7 @@
 	return result;
 }
 
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __const_fn __u16 ___arch__swab16(__u16 x)
 {
 	return ___arch__swab16p(&x);
 }
===== include/asm-sh/byteorder.h 1.1 vs edited =====
--- 1.1/include/asm-sh/byteorder.h	Tue Feb  5 20:39:53 2002
+++ edited/include/asm-sh/byteorder.h	Mon Jun  2 18:32:12 2003
@@ -6,8 +6,9 @@
  */
 
 #include <asm/types.h>
+#include <linux/compiler.h>
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __const_fn __u32 ___arch__swab32(__u32 x)
 {
 	__asm__("swap.b	%0, %0\n\t"
 		"swap.w %0, %0\n\t"
@@ -17,7 +18,7 @@
 	return x;
 }
 
-static __inline__ __const__ __u16 ___arch__swab16(__u16 x)
+static __inline__ __const_fn __u16 ___arch__swab16(__u16 x)
 {
 	__asm__("swap.b %0, %0"
 		: "=r" (x)
===== include/asm-v850/byteorder.h 1.1 vs edited =====
--- 1.1/include/asm-v850/byteorder.h	Fri Nov  1 19:38:12 2002
+++ edited/include/asm-v850/byteorder.h	Mon Jun  2 18:32:12 2003
@@ -18,14 +18,16 @@
 
 #ifdef __GNUC__
 
-static __inline__ __const__ __u32 ___arch__swab32 (__u32 word)
+#include <linux/compiler.h>
+
+static __inline__ __const_fn __u32 ___arch__swab32 (__u32 word)
 {
 	__u32 res;
 	__asm__ ("bsw %1, %0" : "=r" (res) : "r" (word));
 	return res;
 }
 
-static __inline__ __const__ __u16 ___arch__swab16 (__u16 half_word)
+static __inline__ __const_fn __u16 ___arch__swab16 (__u16 half_word)
 {
 	__u16 res;
 	__asm__ ("bsh %1, %0" : "=r" (res) : "r" (half_word));
===== include/asm-x86_64/byteorder.h 1.2 vs edited =====
--- 1.2/include/asm-x86_64/byteorder.h	Fri Apr  4 02:51:08 2003
+++ edited/include/asm-x86_64/byteorder.h	Mon Jun  2 18:32:12 2003
@@ -5,13 +5,15 @@
 
 #ifdef __GNUC__
 
-static __inline__ __const__ __u64 ___arch__swab64(__u64 x)
+#include <linux/compiler.h>
+
+static __inline__ __const_fn __u64 ___arch__swab64(__u64 x)
 {
 	__asm__("bswapq %0" : "=r" (x) : "0" (x));
 	return x;
 }
 
-static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
+static __inline__ __const_fn __u32 ___arch__swab32(__u32 x)
 {
 	__asm__("bswapl %0" : "=r" (x) : "0" (x));
 	return x;
===== include/linux/compiler.h 1.15 vs edited =====
--- 1.15/include/linux/compiler.h	Wed Apr  9 22:15:46 2003
+++ edited/include/linux/compiler.h	Mon Jun  2 18:11:06 2003
@@ -56,6 +56,19 @@
 #define __attribute_used__	__attribute__((__unused__))
 #endif
 
+/* The attribute `pure' is not implemented in GCC versions earlier than 2.96. */
+#if (__GNUC__ > 2) || (__GNUC__ == 2 && __GNUC_MINOR__ >= 96)
+#define __pure_fn __attribute__ ((__pure__))
+#else
+#define __pure_fn
+#endif
+
+/* The attribute `const' is not implemented in GCC versions earlier than
+   2.5. We are not interested in elder compilers. */
+/* Basically this is just slightly more strict class than the `pure'
+   attribute */
+#define __const_fn __attribute__ ((__const__))
+
 /* This macro obfuscates arithmetic on a variable address so that gcc
    shouldn't recognize the original var, and make assumptions about it */
 #define RELOC_HIDE(ptr, off)					\
===== include/linux/byteorder/swab.h 1.2 vs edited =====
--- 1.2/include/linux/byteorder/swab.h	Tue Feb  5 10:43:00 2002
+++ edited/include/linux/byteorder/swab.h	Mon Jun  2 18:32:12 2003
@@ -1,6 +1,8 @@
 #ifndef _LINUX_BYTEORDER_SWAB_H
 #define _LINUX_BYTEORDER_SWAB_H
 
+#include <linux/compiler.h>
+
 /*
  * linux/byteorder/swab.h
  * Byte-swapping, independently from CPU endianness
@@ -128,7 +130,7 @@
 #endif /* OPTIMIZE */
 
 
-static __inline__ __const__ __u16 __fswab16(__u16 x)
+static __inline__ __const_fn __u16 __fswab16(__u16 x)
 {
 	return __arch__swab16(x);
 }
@@ -141,7 +143,7 @@
 	__arch__swab16s(addr);
 }
 
-static __inline__ __const__ __u32 __fswab32(__u32 x)
+static __inline__ __const_fn __u32 __fswab32(__u32 x)
 {
 	return __arch__swab32(x);
 }
@@ -155,7 +157,7 @@
 }
 
 #ifdef __BYTEORDER_HAS_U64__
-static __inline__ __const__ __u64 __fswab64(__u64 x)
+static __inline__ __const_fn __u64 __fswab64(__u64 x)
 {
 #  ifdef __SWAB_64_THRU_32__
 	__u32 h = x >> 32;
===== include/linux/byteorder/swabb.h 1.2 vs edited =====
--- 1.2/include/linux/byteorder/swabb.h	Tue Feb  5 10:43:00 2002
+++ edited/include/linux/byteorder/swabb.h	Mon Jun  2 18:28:20 2003
@@ -1,6 +1,8 @@
 #ifndef _LINUX_BYTEORDER_SWABB_H
 #define _LINUX_BYTEORDER_SWABB_H
 
+#include <linux/compiler.h>
+
 /*
  * linux/byteorder/swabb.h
  * SWAp Bytes Bizarrely
@@ -92,7 +94,7 @@
 #endif /* OPTIMIZE */
 
 
-static __inline__ __const__ __u32 __fswahw32(__u32 x)
+static __inline__ __const_fn __u32 __fswahw32(__u32 x)
 {
 	return __arch__swahw32(x);
 }
@@ -106,7 +108,7 @@
 }
 
 
-static __inline__ __const__ __u32 __fswahb32(__u32 x)
+static __inline__ __const_fn __u32 __fswahb32(__u32 x)
 {
 	return __arch__swahb32(x);
 }
