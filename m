Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWBAJQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWBAJQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWBAJNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:13:38 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:58698 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932328AbWBAJD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:29 -0500
Message-Id: <20060201090326.484695000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:41 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dev-etrax@axis.com,
       David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 17/44] generic minix_{test,set,test_and_clear,test,find_first_zero}_bit()
Content-Disposition: inline; filename=minix-bitops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalents of the functions below:

int minix_test_and_set_bit(int nr, volatile unsigned long *addr);
int minix_set_bit(int nr, volatile unsigned long *addr);
int minix_test_and_clear_bit(int nr, volatile unsigned long *addr);
int minix_test_bit(int nr, const volatile unsigned long *addr);
unsigned long minix_find_first_zero_bit(const unsigned long *addr,
                                        unsigned long size);

In include/asm-generic/bitops/minix.h
   and include/asm-generic/bitops/minix-le.h

This code largely copied from:
include/asm-sparc/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/asm-generic/bitops/minix-le.h |   17 +++++++++++++++++
 include/asm-generic/bitops/minix.h    |   15 +++++++++++++++
 2 files changed, 32 insertions(+)

Index: 2.6-git/include/asm-generic/bitops/minix.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/minix.h
@@ -0,0 +1,15 @@
+#ifndef _ASM_GENERIC_BITOPS_MINIX_H_
+#define _ASM_GENERIC_BITOPS_MINIX_H_
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
+#endif /* _ASM_GENERIC_BITOPS_MINIX_H_ */
Index: 2.6-git/include/asm-generic/bitops/minix-le.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/minix-le.h
@@ -0,0 +1,17 @@
+#ifndef _ASM_GENERIC_BITOPS_MINIX_LE_H_
+#define _ASM_GENERIC_BITOPS_MINIX_LE_H_
+
+#include <asm-generic/bitops/le.h>
+
+#define minix_test_and_set_bit(nr,addr)	\
+	generic___test_and_set_le_bit((nr),(unsigned long *)(addr))
+#define minix_set_bit(nr,addr)		\
+	generic___set_le_bit((nr),(unsigned long *)(addr))
+#define minix_test_and_clear_bit(nr,addr) \
+	generic___test_and_clear_le_bit((nr),(unsigned long *)(addr))
+#define minix_test_bit(nr,addr)		\
+	generic_test_le_bit((nr),(unsigned long *)(addr))
+#define minix_find_first_zero_bit(addr,size) \
+	generic_find_first_zero_le_bit((unsigned long *)(addr),(size))
+
+#endif /* _ASM_GENERIC_BITOPS_MINIX_LE_H_ */

--
