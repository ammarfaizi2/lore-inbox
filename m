Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWBNFS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWBNFS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWBNFN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:13:27 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:33999 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030387AbWBNFFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:07 -0500
Message-Id: <20060214050448.058094000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:24 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linux390@de.ibm.com, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 33/47] s390: use generic bitops
Content-Disposition: inline; filename=s390.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove generic_ffs()
- remove generic_fls()
- remove generic_fls64()
- remove generic_hweight{64,32,16,8}()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 arch/s390/Kconfig         |    4 ++++
 include/asm-s390/bitops.h |   44 +++++---------------------------------------
 2 files changed, 9 insertions(+), 39 deletions(-)

Index: 2.6-rc/include/asm-s390/bitops.h
===================================================================
--- 2.6-rc.orig/include/asm-s390/bitops.h
+++ 2.6-rc/include/asm-s390/bitops.h
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
 
Index: 2.6-rc/arch/s390/Kconfig
===================================================================
--- 2.6-rc.orig/arch/s390/Kconfig
+++ 2.6-rc/arch/s390/Kconfig
@@ -14,6 +14,10 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config GENERIC_HWEIGHT
+	bool
+	default y
+
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y

--
