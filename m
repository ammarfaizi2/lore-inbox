Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWFNN5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWFNN5y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWFNN5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:57:54 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:29067 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S964940AbWFNN5x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:57:53 -0400
Date: Wed, 14 Jun 2006 15:57:45 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch 1/24] s390: cleanup bitops.h.
Message-ID: <20060614135745.GB9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] cleanup bitops.h.

Encapsulate complete bitops.h with #ifdef __KERNEL__ and remove the now
superfluous ALIGN_CS define and its users.
This patch is needed for compiling klibc.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/bitops.h |   42 +++---------------------------------------
 1 files changed, 3 insertions(+), 39 deletions(-)

diff -urpN linux-2.6/include/asm-s390/bitops.h linux-2.6-patched/include/asm-s390/bitops.h
--- linux-2.6/include/asm-s390/bitops.h	2006-06-14 14:29:24.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/bitops.h	2006-06-14 14:29:31.000000000 +0200
@@ -12,6 +12,9 @@
  *    Copyright (C) 1992, Linus Torvalds
  *
  */
+
+#ifdef __KERNEL__
+
 #include <linux/config.h>
 #include <linux/compiler.h>
 
@@ -51,19 +54,6 @@
  * with operation of the form "set_bit(bitnr, flags)".
  */
 
-/* set ALIGN_CS to 1 if the SMP safe bit operations should
- * align the address to 4 byte boundary. It seems to work
- * without the alignment. 
- */
-#ifdef __KERNEL__
-#define ALIGN_CS 0
-#else
-#define ALIGN_CS 1
-#ifndef CONFIG_SMP
-#error "bitops won't work without CONFIG_SMP"
-#endif
-#endif
-
 /* bitmap tables from arch/S390/kernel/bitmap.S */
 extern const char _oi_bitmap[];
 extern const char _ni_bitmap[];
@@ -122,10 +112,6 @@ static inline void set_bit_cs(unsigned l
         unsigned long addr, old, new, mask;
 
 	addr = (unsigned long) ptr;
-#if ALIGN_CS == 1
-	nr += (addr & __BITOPS_ALIGN) << 3;    /* add alignment to bit number */
-	addr ^= addr & __BITOPS_ALIGN;	       /* align address to 8 */
-#endif
 	/* calculate address for CS */
 	addr += (nr ^ (nr & (__BITOPS_WORDSIZE - 1))) >> 3;
 	/* make OR mask */
@@ -142,10 +128,6 @@ static inline void clear_bit_cs(unsigned
         unsigned long addr, old, new, mask;
 
 	addr = (unsigned long) ptr;
-#if ALIGN_CS == 1
-	nr += (addr & __BITOPS_ALIGN) << 3;    /* add alignment to bit number */
-	addr ^= addr & __BITOPS_ALIGN;	       /* align address to 8 */
-#endif
 	/* calculate address for CS */
 	addr += (nr ^ (nr & (__BITOPS_WORDSIZE - 1))) >> 3;
 	/* make AND mask */
@@ -162,10 +144,6 @@ static inline void change_bit_cs(unsigne
         unsigned long addr, old, new, mask;
 
 	addr = (unsigned long) ptr;
-#if ALIGN_CS == 1
-	nr += (addr & __BITOPS_ALIGN) << 3;    /* add alignment to bit number */
-	addr ^= addr & __BITOPS_ALIGN;	       /* align address to 8 */
-#endif
 	/* calculate address for CS */
 	addr += (nr ^ (nr & (__BITOPS_WORDSIZE - 1))) >> 3;
 	/* make XOR mask */
@@ -183,10 +161,6 @@ test_and_set_bit_cs(unsigned long nr, vo
         unsigned long addr, old, new, mask;
 
 	addr = (unsigned long) ptr;
-#if ALIGN_CS == 1
-	nr += (addr & __BITOPS_ALIGN) << 3;    /* add alignment to bit number */
-	addr ^= addr & __BITOPS_ALIGN;	       /* align address to 8 */
-#endif
 	/* calculate address for CS */
 	addr += (nr ^ (nr & (__BITOPS_WORDSIZE - 1))) >> 3;
 	/* make OR/test mask */
@@ -206,10 +180,6 @@ test_and_clear_bit_cs(unsigned long nr, 
         unsigned long addr, old, new, mask;
 
 	addr = (unsigned long) ptr;
-#if ALIGN_CS == 1
-	nr += (addr & __BITOPS_ALIGN) << 3;    /* add alignment to bit number */
-	addr ^= addr & __BITOPS_ALIGN;	       /* align address to 8 */
-#endif
 	/* calculate address for CS */
 	addr += (nr ^ (nr & (__BITOPS_WORDSIZE - 1))) >> 3;
 	/* make AND/test mask */
@@ -229,10 +199,6 @@ test_and_change_bit_cs(unsigned long nr,
         unsigned long addr, old, new, mask;
 
 	addr = (unsigned long) ptr;
-#if ALIGN_CS == 1
-	nr += (addr & __BITOPS_ALIGN) << 3;  /* add alignment to bit number */
-	addr ^= addr & __BITOPS_ALIGN;	     /* align address to 8 */
-#endif
 	/* calculate address for CS */
 	addr += (nr ^ (nr & (__BITOPS_WORDSIZE - 1))) >> 3;
 	/* make XOR/test mask */
@@ -835,8 +801,6 @@ static inline int sched_find_first_bit(u
 
 #include <asm-generic/bitops/hweight.h>
 
-#ifdef __KERNEL__
-
 /*
  * ATTENTION: intel byte ordering convention for ext2 and minix !!
  * bit 0 is the LSB of addr; bit 31 is the MSB of addr;
