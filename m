Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWAZDii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWAZDii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWAZDih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:38:37 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:42981 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932183AbWAZDif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:38:35 -0500
Date: Thu, 26 Jan 2006 12:38:41 +0900
To: Grant Grundler <iod00d@hp.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: [PATCH 11/12] generic ext2_{set,clear}_bit_atomic()
Message-ID: <20060126033840.GJ11138@miraclelinux.com>
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
int ext2_set_bit_atomic(int nr, volatile unsigned long *addr);
int ext2_clear_bit_atomic(int nr, volatile unsigned long *addr);

HAVE_ARCH_EXT2_ATOMIC_BITOPS is defined when the architecture has its
own
version of these functions.

This code largely copied from:
include/asm-sparc/bitops.h

Index: 2.6-git/include/asm-generic/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-generic/bitops.h	2006-01-25 19:14:11.000000000 +0900
+++ 2.6-git/include/asm-generic/bitops.h	2006-01-25 19:14:12.000000000 +0900
@@ -645,6 +645,28 @@
 
 #endif /* HAVE_ARCH_EXT2_NON_ATOMIC_BITOPS */
 
+#ifndef HAVE_ARCH_EXT2_ATOMIC_BITOPS
+
+#define ext2_set_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_set_bit((nr), (unsigned long *)(addr)); \
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
+#define ext2_clear_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_clear_bit((nr), (unsigned long *)(addr)); \
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
+#endif /* HAVE_ARCH_EXT2_ATOMIC_BITOPS */
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_GENERIC_BITOPS_H */
