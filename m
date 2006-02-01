Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWBAJXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWBAJXW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWBAJUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:20:03 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:13130 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932130AbWBAJD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:26 -0500
Message-Id: <20060201090323.100733000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:33 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, Yoshinori Sato <ysato@users.sourceforge.jp>,
       Hirokazu Takata <takata@linux-m32r.org>,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 09/44] generic fls()
Content-Disposition: inline; filename=fls-bitops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalent of the function:
int fls(int x);

In include/asm-generic/bitops/fls.h

This code largely copied from:
include/linux/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/fls.h |   41 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+)

Index: 2.6-git/include/asm-generic/bitops/fls.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/fls.h
@@ -0,0 +1,41 @@
+#ifndef _ASM_GENERIC_BITOPS_FLS_H_
+#define _ASM_GENERIC_BITOPS_FLS_H_
+
+/**
+ * fls - find last (most-significant) bit set
+ * @x: the word to search
+ *
+ * This is defined the same way as ffs.
+ * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
+ */
+
+static __inline__ int fls(int x)
+{
+	int r = 32;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff0000u)) {
+		x <<= 16;
+		r -= 16;
+	}
+	if (!(x & 0xff000000u)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xf0000000u)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xc0000000u)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x80000000u)) {
+		x <<= 1;
+		r -= 1;
+	}
+	return r;
+}
+
+#endif /* _ASM_GENERIC_BITOPS_FLS_H_ */

--
