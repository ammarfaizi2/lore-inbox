Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbUB2DW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 22:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbUB2DW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 22:22:27 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:41859 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261970AbUB2DVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 22:21:45 -0500
Subject: [patch] 3rd version, u64 cast avoidance
From: Albert Cahalan <albert@users.sf.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Jakub Jelinek <jakub@redhat.com>, "David S. Miller" <davem@redhat.com>,
       davidm@hpl.hp.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton OSDL <akpm@osdl.org>
In-Reply-To: <1078016927.904.17.camel@gaston>
References: <1077915522.2255.28.camel@cube>
	 <16447.56941.774257.925722@napali.hpl.hp.com>
	 <1077920213.2233.44.camel@cube>
	 <20040228104252.GG31589@devserv.devel.redhat.com>
	 <1077979564.2233.70.camel@cube>  <1078012722.905.11.camel@gaston>
	 <1078012762.905.13.camel@gaston>  <1078006870.2233.94.camel@cube>
	 <1078016927.904.17.camel@gaston>
Content-Type: text/plain
Organization: 
Message-Id: <1078016495.2233.149.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 Feb 2004 20:01:36 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is option 'b', which eliminates lots of
redundant code. Mult-width arch are handled.

User-space types are unchanged. For the kernel,
all u64 and related types are done with long long,
eliminating the need to lose type-safety with
casts all over the place.

 asm-alpha/types.h   |   30 ++----------------------------
 asm-arm/types.h     |   31 +------------------------------
 asm-arm26/types.h   |   31 +------------------------------
 asm-cris/types.h    |   31 +------------------------------
 asm-h8300/types.h   |   31 +------------------------------
 asm-i386/types.h    |   31 +------------------------------
 asm-ia64/types.h    |   30 ++----------------------------
 asm-m68k/types.h    |   31 +------------------------------
 asm-mips/types.h    |   49 ++-----------------------------------------------
 asm-parisc/types.h  |   31 +------------------------------
 asm-ppc/types.h     |   26 +-------------------------
 asm-ppc64/types.h   |   30 ++----------------------------
 asm-s390/types.h    |   42 +++---------------------------------------
 asm-sh/types.h      |   31 +------------------------------
 asm-sparc/types.h   |   24 +-----------------------
 asm-sparc64/types.h |   30 ++----------------------------
 asm-v850/types.h    |   31 +------------------------------
 asm-x86_64/types.h  |   29 +----------------------------
 linux/bit_types.h   |   37 +++++++++++++++++++++++++++++++++++++
 19 files changed, 62 insertions(+), 544 deletions(-)

diff -Naurd old/include/asm-alpha/types.h new/include/asm-alpha/types.h
--- old/include/asm-alpha/types.h	2004-02-21 03:25:04.000000000 -0500
+++ new/include/asm-alpha/types.h	2004-02-28 19:28:38.000000000 -0500
@@ -13,22 +13,8 @@
 
 typedef unsigned int umode_t;
 
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-typedef __signed__ long __s64;
-typedef unsigned long __u64;
+#define _BROKEN_U64_S64
+#include <linux/bit_types.h>
 
 #endif /* __ASSEMBLY__ */
 
@@ -41,18 +27,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long s64;
-typedef unsigned long u64;
-
 typedef u64 dma_addr_t;
 typedef u64 dma64_addr_t;
 
diff -Naurd old/include/asm-arm/types.h new/include/asm-arm/types.h
--- old/include/asm-arm/types.h	2004-02-21 03:19:13.000000000 -0500
+++ new/include/asm-arm/types.h	2004-02-28 19:30:06.000000000 -0500
@@ -5,24 +5,7 @@
 
 typedef unsigned short umode_t;
 
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
-#endif
+#include <linux/bit_types.h>
 
 #endif /* __ASSEMBLY__ */
 
@@ -35,18 +18,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long long s64;
-typedef unsigned long long u64;
-
 /* Dma addresses are 32-bits wide.  */
 
 typedef u32 dma_addr_t;
diff -Naurd old/include/asm-arm26/types.h new/include/asm-arm26/types.h
--- old/include/asm-arm26/types.h	2004-02-21 03:19:02.000000000 -0500
+++ new/include/asm-arm26/types.h	2004-02-28 19:30:44.000000000 -0500
@@ -5,24 +5,7 @@
 
 typedef unsigned short umode_t;
 
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
-#endif
+#include <linux/bit_types.h>
 
 #endif /* __ASSEMBLY__ */
 
@@ -35,18 +18,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long long s64;
-typedef unsigned long long u64;
-
 /* Dma addresses are 32-bits wide.  */
 
 typedef u32 dma_addr_t;
diff -Naurd old/include/asm-cris/types.h new/include/asm-cris/types.h
--- old/include/asm-cris/types.h	2004-02-21 03:23:34.000000000 -0500
+++ new/include/asm-cris/types.h	2004-02-28 19:31:13.000000000 -0500
@@ -5,24 +5,7 @@
 
 typedef unsigned short umode_t;
 
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
-#endif
+#include <linux/bit_types.h>
 
 #endif /* __ASSEMBLY__ */
 
@@ -35,18 +18,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long long s64;
-typedef unsigned long long u64;
-
 /* Dma addresses are 32-bits wide, just like our other addresses.  */
  
 typedef u32 dma_addr_t;
diff -Naurd old/include/asm-h8300/types.h new/include/asm-h8300/types.h
--- old/include/asm-h8300/types.h	2004-02-21 03:24:05.000000000 -0500
+++ new/include/asm-h8300/types.h	2004-02-28 19:31:50.000000000 -0500
@@ -13,42 +13,13 @@
 
 typedef unsigned short umode_t;
 
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
-#endif
+#include <linux/bit_types.h>
 
 /*
  * These aren't exported outside the kernel to avoid name space clashes
  */
 #ifdef __KERNEL__
 
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long long s64;
-typedef unsigned long long u64;
-
 #define BITS_PER_LONG 32
 
 /* Dma addresses are 32-bits wide.  */
diff -Naurd old/include/asm-i386/types.h new/include/asm-i386/types.h
--- old/include/asm-i386/types.h	2004-02-21 03:23:45.000000000 -0500
+++ new/include/asm-i386/types.h	2004-02-28 19:32:20.000000000 -0500
@@ -5,24 +5,7 @@
 
 typedef unsigned short umode_t;
 
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
-#endif
+#include <linux/bit_types.h>
 
 #endif /* __ASSEMBLY__ */
 
@@ -37,18 +20,6 @@
 
 #include <linux/config.h>
 
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long long s64;
-typedef unsigned long long u64;
-
 /* DMA addresses come in generic and 64-bit flavours.  */
 
 #ifdef CONFIG_HIGHMEM64G
diff -Naurd old/include/asm-ia64/types.h new/include/asm-ia64/types.h
--- old/include/asm-ia64/types.h	2004-02-21 03:20:17.000000000 -0500
+++ new/include/asm-ia64/types.h	2004-02-28 19:32:59.000000000 -0500
@@ -27,40 +27,14 @@
 
 typedef unsigned int umode_t;
 
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-typedef __signed__ long __s64;
-typedef unsigned long __u64;
+#define _BROKEN_U64_S64
+#include <linux/bit_types.h>
 
 /*
  * These aren't exported outside the kernel to avoid name space clashes
  */
 # ifdef __KERNEL__
 
-typedef __s8 s8;
-typedef __u8 u8;
-
-typedef __s16 s16;
-typedef __u16 u16;
-
-typedef __s32 s32;
-typedef __u32 u32;
-
-typedef __s64 s64;
-typedef __u64 u64;
-
 #define BITS_PER_LONG 64
 
 /* DMA addresses are 64-bits wide, in general.  */
diff -Naurd old/include/asm-m68k/types.h new/include/asm-m68k/types.h
--- old/include/asm-m68k/types.h	2004-02-21 03:18:50.000000000 -0500
+++ new/include/asm-m68k/types.h	2004-02-28 19:33:25.000000000 -0500
@@ -13,24 +13,7 @@
 
 typedef unsigned short umode_t;
 
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
-#endif
+#include <linux/bit_types.h>
 
 #endif /* __ASSEMBLY__ */
 
@@ -43,18 +26,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long long s64;
-typedef unsigned long long u64;
-
 /* DMA addresses are always 32-bits wide */
 
 typedef u32 dma_addr_t;
diff -Naurd old/include/asm-mips/types.h new/include/asm-mips/types.h
--- old/include/asm-mips/types.h	2004-02-21 03:19:29.000000000 -0500
+++ new/include/asm-mips/types.h	2004-02-28 19:34:58.000000000 -0500
@@ -20,33 +20,11 @@
 typedef unsigned int umode_t;
 #endif
 
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
 #if (_MIPS_SZLONG == 64)
-
-typedef __signed__ long __s64;
-typedef unsigned long __u64;
-
-#else
-
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#define _BROKEN_U64_S64
 #endif
+#include <linux/bit_types.h>
 
-#endif
 
 #endif /* __ASSEMBLY__ */
 
@@ -59,29 +37,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef __signed char s8;
-typedef unsigned char u8;
-
-typedef __signed short s16;
-typedef unsigned short u16;
-
-typedef __signed int s32;
-typedef unsigned int u32;
-
-#if (_MIPS_SZLONG == 64)
-
-typedef __signed__ long s64;
-typedef unsigned long u64;
-
-#else
-
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long s64;
-typedef unsigned long long u64;
-#endif
-
-#endif
-
 #if (defined(CONFIG_HIGHMEM) && defined(CONFIG_64BIT_PHYS_ADDR)) \
     || defined(CONFIG_MIPS64)
 typedef u64 dma_addr_t;
diff -Naurd old/include/asm-parisc/types.h new/include/asm-parisc/types.h
--- old/include/asm-parisc/types.h	2004-02-21 03:19:57.000000000 -0500
+++ new/include/asm-parisc/types.h	2004-02-28 19:35:48.000000000 -0500
@@ -5,24 +5,7 @@
 
 typedef unsigned short umode_t;
 
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
-#endif
+#include <linux/bit_types.h>
 
 #endif /* __ASSEMBLY__ */
 
@@ -39,18 +22,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long long s64;
-typedef unsigned long long u64;
-
 /* Dma addresses are 32-bits wide.  */
 
 typedef u32 dma_addr_t;
diff -Naurd old/include/asm-ppc/types.h new/include/asm-ppc/types.h
--- old/include/asm-ppc/types.h	2004-02-21 03:26:52.000000000 -0500
+++ new/include/asm-ppc/types.h	2004-02-28 19:36:19.000000000 -0500
@@ -3,19 +3,7 @@
 
 #ifndef __ASSEMBLY__
 
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
-#endif
+#include <linux/bit_types.h>
 
 typedef struct {
 	__u32 u[4];
@@ -37,18 +25,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long long s64;
-typedef unsigned long long u64;
-
 typedef __vector128 vector128;
 
 /* DMA addresses are 32-bits wide */
diff -Naurd old/include/asm-ppc64/types.h new/include/asm-ppc64/types.h
--- old/include/asm-ppc64/types.h	2004-02-21 03:21:11.000000000 -0500
+++ new/include/asm-ppc64/types.h	2004-02-28 19:36:57.000000000 -0500
@@ -18,22 +18,8 @@
 
 typedef unsigned int umode_t;
 
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-typedef __signed__ long __s64;
-typedef unsigned long __u64;
+#define _BROKEN_U64_S64
+#include <linux/bit_types.h>
 
 typedef struct {
 	__u32 u[4];
@@ -49,18 +35,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long s64;
-typedef unsigned long u64;
-
 typedef __vector128 vector128;
 
 typedef u32 dma_addr_t;
diff -Naurd old/include/asm-s390/types.h new/include/asm-s390/types.h
--- old/include/asm-s390/types.h	2004-02-21 03:22:57.000000000 -0500
+++ new/include/asm-s390/types.h	2004-02-28 19:38:14.000000000 -0500
@@ -13,29 +13,10 @@
 
 typedef unsigned short umode_t;
 
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-#ifndef __s390x__
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
-#endif
-#else /* __s390x__ */
-typedef __signed__ long __s64;
-typedef unsigned long __u64;
+#ifdef __s390x__
+#define _BROKEN_U64_S64
 #endif
+#include <linux/bit_types.h>
 
 /* A address type so that arithmetic can be done on it & it can be upgraded to
    64 bit when necessary 
@@ -58,23 +39,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-#ifndef __s390x__
-typedef signed long long s64;
-typedef unsigned long long u64;
-#else /* __s390x__ */
-typedef signed long s64;
-typedef unsigned  long u64;
-#endif /* __s390x__ */
-
 typedef u32 dma_addr_t;
 
 #ifndef __s390x__
diff -Naurd old/include/asm-sh/types.h new/include/asm-sh/types.h
--- old/include/asm-sh/types.h	2004-02-21 03:27:11.000000000 -0500
+++ new/include/asm-sh/types.h	2004-02-28 19:38:47.000000000 -0500
@@ -5,24 +5,7 @@
 
 typedef unsigned short umode_t;
 
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
-#endif
+#include <linux/bit_types.h>
 
 #endif /* __ASSEMBLY__ */
 
@@ -35,18 +18,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef __signed__ char s8;
-typedef unsigned char u8;
-
-typedef __signed__ short s16;
-typedef unsigned short u16;
-
-typedef __signed__ int s32;
-typedef unsigned int u32;
-
-typedef __signed__ long long s64;
-typedef unsigned long long u64;
-
 /* Dma addresses are 32-bits wide.  */
 
 typedef u32 dma_addr_t;
diff -Naurd old/include/asm-sparc/types.h new/include/asm-sparc/types.h
--- old/include/asm-sparc/types.h	2004-02-21 03:22:57.000000000 -0500
+++ new/include/asm-sparc/types.h	2004-02-28 19:39:25.000000000 -0500
@@ -19,17 +19,7 @@
 
 typedef unsigned short umode_t;
 
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
+#include <linux/bit_types.h>
 
 #endif /* __ASSEMBLY__ */
 
@@ -39,18 +29,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef __signed__ char s8;
-typedef unsigned char u8;
-
-typedef __signed__ short s16;
-typedef unsigned short u16;
-
-typedef __signed__ int s32;
-typedef unsigned int u32;
-
-typedef __signed__ long long s64;
-typedef unsigned long long u64;
-
 typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
diff -Naurd old/include/asm-sparc64/types.h new/include/asm-sparc64/types.h
--- old/include/asm-sparc64/types.h	2004-02-21 03:28:23.000000000 -0500
+++ new/include/asm-sparc64/types.h	2004-02-28 19:39:55.000000000 -0500
@@ -14,22 +14,8 @@
 
 typedef unsigned short umode_t;
 
-/*
- * _xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space.
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-typedef __signed__ long __s64;
-typedef unsigned long __u64;
+#define _BROKEN_U64_S64
+#include <linux/bit_types.h>
 
 #endif /* __ASSEMBLY__ */
 
@@ -39,18 +25,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef __signed__ char s8;
-typedef unsigned char u8;
-
-typedef __signed__ short s16;
-typedef unsigned short u16;
-
-typedef __signed__ int s32;
-typedef unsigned int u32;
-
-typedef __signed__ long s64;
-typedef unsigned long u64;
-
 /* Dma addresses come in generic and 64-bit flavours.  */
 
 typedef u32 dma_addr_t;
diff -Naurd old/include/asm-v850/types.h new/include/asm-v850/types.h
--- old/include/asm-v850/types.h	2004-02-21 03:26:16.000000000 -0500
+++ new/include/asm-v850/types.h	2004-02-28 19:40:34.000000000 -0500
@@ -13,24 +13,7 @@
 
 typedef unsigned short umode_t;
 
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
-#endif
+#include <linux/bit_types.h>
 
 #endif /* !__ASSEMBLY__ */
 
@@ -43,18 +26,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long long s64;
-typedef unsigned long long u64;
-
 /* Dma addresses are 32-bits wide.  */
 
 typedef u32 dma_addr_t;
diff -Naurd old/include/asm-x86_64/types.h new/include/asm-x86_64/types.h
--- old/include/asm-x86_64/types.h	2004-02-21 03:26:16.000000000 -0500
+++ new/include/asm-x86_64/types.h	2004-02-28 19:40:57.000000000 -0500
@@ -5,22 +5,7 @@
 
 typedef unsigned short umode_t;
 
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-typedef __signed__ long long __s64;
-typedef unsigned long long  __u64;
+#include <linux/bit_types.h>
 
 #endif /* __ASSEMBLY__ */
 
@@ -33,18 +18,6 @@
 
 #ifndef __ASSEMBLY__
 
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long long s64;
-typedef unsigned long long u64;
-
 typedef u64 dma64_addr_t;
 typedef u64 dma_addr_t;
 
diff -Naurd old/include/linux/bit_types.h new/include/linux/bit_types.h
--- old/include/linux/bit_types.h	1969-12-31 19:00:00.000000000 -0500
+++ new/include/linux/bit_types.h	2004-02-28 19:22:41.000000000 -0500
@@ -0,0 +1,37 @@
+#ifndef _LINUX_BIT_TYPES_H
+#define _LINUX_BIT_TYPES_H
+
+typedef __signed__ char  s8;
+typedef unsigned   char  u8;
+typedef __signed__ short s16;
+typedef unsigned   short u16;
+typedef __signed__ int   s32;
+typedef unsigned   int   u32;
+
+/*
+ * We want "long long" in the kernel to reduce the need for casts,
+ * but foul user-space C++ code might rely on this being "long". 
+ * (name mangling leads to a purely user-space ABI problem) 
+ */
+#if defined(_BROKEN_U64_S64) && !defined(__KERNEL__)
+typedef unsigned   long __u64;
+typedef __signed__ long __s64;
+#else
+#if defined(__GNUC__)
+__extension__ typedef unsigned   long long __u64;
+__extension__ typedef __signed__ long long __s64;
+endif
+#endif
+
+#ifdef __KERNEL__
+typedef __s8 s8;
+typedef __u8 u8;
+typedef __s16 s16;
+typedef __u16 u16;
+typedef __s32 s32;
+typedef __u32 u32;
+typedef __s64 s64;
+typedef __u64 u64;
+#endif
+
+#endif /* _LINUX_BIT_TYPES_H */



