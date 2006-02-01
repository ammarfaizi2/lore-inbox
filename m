Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWBAJLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWBAJLW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWBAJIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:08:40 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:10571 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932399AbWBAJDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:34 -0500
Message-Id: <20060201090333.740090000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:56 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: linux390@de.ibm.com, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 32/44] s390: use generic bitops
Content-Disposition: inline; filename=s390.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove generic_ffs()
- remove generic_fls()
- remove generic_fls64()
- remove generic_hweight{64,32,16,8}()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-s390/bitops.h |   44 +++++---------------------------------------
 1 files changed, 5 insertions(+), 39 deletions(-)

Index: 2.6-git/include/asm-s390/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-s390/bitops.h
+++ 2.6-git/include/asm-s390/bitops.h
@@ -828,35 +828,12 @@ static inline int sched_find_first_bit(u
 	return find_first_bit(b, 140);
 }
 
-/*
- * ffs: find first bit set. This is defined the same way as
- * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
- */
-#define ffs(x) generic_ffs(x)
+#include <asm-generic/bitops/ffs.h>
 
-/*
- * fls: find last bit set.
- */
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-#define hweight64(x)						\
-({								\
-	unsigned long __x = (x);				\
-	unsigned int __w;					\
-	__w = generic_hweight32((unsigned int) __x);		\
-	__w += generic_hweight32((unsigned int) (__x>>32));	\
-	__w;							\
-})
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/fls64.h>
 
+#include <asm-generic/bitops/hweight.h>
 
 #ifdef __KERNEL__
 
@@ -1011,18 +988,7 @@ ext2_find_next_zero_bit(void *vaddr, uns
 	return offset + ext2_find_first_zero_bit(p, size);
 }
 
-/* Bitmap functions for the minix filesystem.  */
-/* FIXME !!! */
-#define minix_test_and_set_bit(nr,addr) \
-	__test_and_set_bit(nr,(unsigned long *)addr)
-#define minix_set_bit(nr,addr) \
-	__set_bit(nr,(unsigned long *)addr)
-#define minix_test_and_clear_bit(nr,addr) \
-	__test_and_clear_bit(nr,(unsigned long *)addr)
-#define minix_test_bit(nr,addr) \
-	test_bit(nr,(unsigned long *)addr)
-#define minix_find_first_zero_bit(addr,size) \
-	find_first_zero_bit(addr,size)
+#include <asm-generic/bitops/minix.h>
 
 #endif /* __KERNEL__ */
 

--
