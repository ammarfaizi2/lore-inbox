Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWBAJEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWBAJEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWBAJEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:04:08 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:17995 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932405AbWBAJDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:36 -0500
Message-Id: <20060201090334.886957000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:03:02 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 38/44] x86_64: use generic bitops
Content-Disposition: inline; filename=x86_64.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove sched_find_first_bit()
- remove generic_hweight{64,32,16,8}()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-x86_64/bitops.h |   42 ++++++------------------------------------
 1 files changed, 6 insertions(+), 36 deletions(-)

Index: 2.6-git/include/asm-x86_64/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-x86_64/bitops.h
+++ 2.6-git/include/asm-x86_64/bitops.h
@@ -356,14 +356,7 @@ static __inline__ unsigned long __fls(un
 
 #ifdef __KERNEL__
 
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-	if (b[0])
-		return __ffs(b[0]);
-	if (b[1])
-		return __ffs(b[1]) + 64;
-	return __ffs(b[2]) + 128;
-}
+#include <asm-generic/bitops/sched.h>
 
 /**
  * ffs - find first bit set
@@ -412,43 +405,20 @@ static __inline__ int fls(int x)
 	return r+1;
 }
 
-/**
- * hweightN - returns the hamming weight of a N-bit word
- * @x: the word to weigh
- *
- * The Hamming Weight of a number is the total number of bits set in it.
- */
-
-#define hweight64(x) generic_hweight64(x)
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#include <asm-generic/bitops/hweight.h>
 
 #endif /* __KERNEL__ */
 
 #ifdef __KERNEL__
 
-#define ext2_set_bit(nr,addr) \
-	__test_and_set_bit((nr),(unsigned long*)addr)
+#include <asm-generic/bitops/ext2-non-atomic.h>
+
 #define ext2_set_bit_atomic(lock,nr,addr) \
 	        test_and_set_bit((nr),(unsigned long*)addr)
-#define ext2_clear_bit(nr, addr) \
-	__test_and_clear_bit((nr),(unsigned long*)addr)
 #define ext2_clear_bit_atomic(lock,nr,addr) \
 	        test_and_clear_bit((nr),(unsigned long*)addr)
-#define ext2_test_bit(nr, addr)      test_bit((nr),(unsigned long*)addr)
-#define ext2_find_first_zero_bit(addr, size) \
-	find_first_zero_bit((unsigned long*)addr, size)
-#define ext2_find_next_zero_bit(addr, size, off) \
-	find_next_zero_bit((unsigned long*)addr, size, off)
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,(void*)addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,(void*)addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,(void*)addr)
-#define minix_test_bit(nr,addr) test_bit(nr,(void*)addr)
-#define minix_find_first_zero_bit(addr,size) \
-	find_first_zero_bit((void*)addr,size)
+
+#include <asm-generic/bitops/minix.h>
 
 #endif /* __KERNEL__ */
 

--
