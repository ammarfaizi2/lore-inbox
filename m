Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWBAJT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWBAJT5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWBAJTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:19:44 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:37194 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751494AbWBAJD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:28 -0500
Message-Id: <20060201090326.300490000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:40 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
       Hirokazu Takata <takata@linux-m32r.org>, linux-mips@linux-mips.org,
       linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 16/44] generic ext2_{set,clear}_bit_atomic()
Content-Disposition: inline; filename=ext2-atomic-bitops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalents of the functions below:

int ext2_set_bit_atomic(int nr, volatile unsigned long *addr);
int ext2_clear_bit_atomic(int nr, volatile unsigned long *addr);

In include/asm-generic/bitops/ext2-atomic.h

This code largely copied from:
include/asm-sparc/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/ext2-atomic.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+)

Index: 2.6-git/include/asm-generic/bitops/ext2-atomic.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/ext2-atomic.h
@@ -0,0 +1,22 @@
+#ifndef _ASM_GENERIC_BITOPS_EXT2_ATOMIC_H_
+#define _ASM_GENERIC_BITOPS_EXT2_ATOMIC_H_
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
+#endif /* _ASM_GENERIC_BITOPS_EXT2_ATOMIC_H_ */

--
