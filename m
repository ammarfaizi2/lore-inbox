Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWBAJFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWBAJFA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWBAJEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:04:01 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:21067 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932404AbWBAJDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:36 -0500
Message-Id: <20060201090335.276333000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:03:04 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Theodore Tso <tytso@mit.edu>, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 40/44] update include/asm-generic/bitops.h
Content-Disposition: inline; filename=generic.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently include/asm-generic/bitops.h is not referenced from anywhere.
But it will be the benefit of those who are trying to port Linux to
another architecture.

So update it by same manner

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops.h |   78 +++++++------------------------------------
 1 files changed, 14 insertions(+), 64 deletions(-)

Index: 2.6-git/include/asm-generic/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-generic/bitops.h
+++ 2.6-git/include/asm-generic/bitops.h
@@ -5,77 +5,27 @@
  * For the benefit of those who are trying to port Linux to another
  * architecture, here are some C-language equivalents.  You should
  * recode these in the native assembly language, if at all possible.
- * To guarantee atomicity, these routines call cli() and sti() to
- * disable interrupts while they operate.  (You have to provide inline
- * routines to cli() and sti().)
- *
- * Also note, these routines assume that you have 32 bit longs.
- * You will have to change this if you are trying to port Linux to the
- * Alpha architecture or to a Cray.  :-)
  * 
  * C language equivalents written by Theodore Ts'o, 9/26/92
  */
 
-extern __inline__ int set_bit(int nr,long * addr)
-{
-	int	mask, retval;
-
-	addr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	cli();
-	retval = (mask & *addr) != 0;
-	*addr |= mask;
-	sti();
-	return retval;
-}
-
-extern __inline__ int clear_bit(int nr, long * addr)
-{
-	int	mask, retval;
-
-	addr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	cli();
-	retval = (mask & *addr) != 0;
-	*addr &= ~mask;
-	sti();
-	return retval;
-}
-
-extern __inline__ int test_bit(int nr, const unsigned long * addr)
-{
-	int	mask;
-
-	addr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	return ((mask & *addr) != 0);
-}
-
-/*
- * fls: find last bit set.
- */
-
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
+#include <asm-generic/bitops/atomic.h>
+#include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/__ffs.h>
+#include <asm-generic/bitops/ffz.h>
+#include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/find.h>
 
 #ifdef __KERNEL__
 
-/*
- * ffs: find first bit set. This is defined the same way as
- * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
- */
-
-#define ffs(x) generic_ffs(x)
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/ffs.h>
+#include <asm-generic/bitops/hweight.h>
+
+#include <asm-generic/bitops/ext2-non-atomic.h>
+#include <asm-generic/bitops/ext2-atomic.h>
+#include <asm-generic/bitops/minix.h>
 
 #endif /* __KERNEL__ */
 

--
