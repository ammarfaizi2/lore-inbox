Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWAZDjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWAZDjJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWAZDjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:39:08 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:47333 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932181AbWAZDjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:39:05 -0500
Date: Thu, 26 Jan 2006 12:39:11 +0900
To: Grant Grundler <iod00d@hp.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: [PATCH 12/12] generic minix_{test,set,test_and_clear,test,find_first_zero}_bit()
Message-ID: <20060126033910.GK11138@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060125205907.GF9995@esmail.cup.hp.com> <20060126032713.GA9984@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126032713.GA9984@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalents of the functions below:

HAVE_ARCH_MINIX_BITOPS is defined when the architecture has its own
version of these functions.

int minix_test_and_set_bit(int nr, volatile unsigned long *addr);
int minix_set_bit(int nr, volatile unsigned long *addr);
int minix_test_and_clear_bit(int nr, volatile unsigned long *addr);
int minix_test_bit(int nr, const volatile unsigned long *addr);
unsigned long minix_find_first_zero_bit(const unsigned long *addr,
                                        unsigned long size);

This code largely copied from:
include/asm-sparc/bitops.h

Index: 2.6-git/include/asm-generic/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-generic/bitops.h	2006-01-25 19:14:12.000000000 +0900
+++ 2.6-git/include/asm-generic/bitops.h	2006-01-25 19:14:12.000000000 +0900
@@ -667,6 +667,21 @@
 
 #endif /* HAVE_ARCH_EXT2_ATOMIC_BITOPS */
 
+#ifndef HAVE_ARCH_MINIX_BITOPS
+
+#define minix_test_and_set_bit(nr,addr)	\
+	__test_and_set_bit((nr),(unsigned long *)(addr))
+#define minix_set_bit(nr,addr)		\
+	__set_bit((nr),(unsigned long *)(addr))
+#define minix_test_and_clear_bit(nr,addr) \
+	__test_and_clear_bit((nr),(unsigned long *)(addr))
+#define minix_test_bit(nr,addr)		\
+	test_bit((nr),(unsigned long *)(addr))
+#define minix_find_first_zero_bit(addr,size) \
+	find_first_zero_bit((unsigned long *)(addr),(size))
+
+#endif /* HAVE_ARCH_MINIX_BITOPS */
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_GENERIC_BITOPS_H */
