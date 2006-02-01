Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWBAJT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWBAJT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWBAJTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:19:50 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:27722 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750781AbWBAJD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:27 -0500
Message-Id: <20060201090325.696670000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:37 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 13/44] generic ffs()
Content-Disposition: inline; filename=ffs-bitops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the C-language equivalent of the function:
int ffs(int x);

In include/asm-generic/bitops/ffs.h

This code largely copied from:
include/linux/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/ffs.h |   41 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+)

Index: 2.6-git/include/asm-generic/bitops/ffs.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/ffs.h
@@ -0,0 +1,41 @@
+#ifndef _ASM_GENERIC_BITOPS_FFS_H_
+#define _ASM_GENERIC_BITOPS_FFS_H_
+
+/**
+ * ffs - find first bit set
+ * @x: the word to search
+ *
+ * This is defined the same way as
+ * the libc and compiler builtin ffs routines, therefore
+ * differs in spirit from the above ffz (man ffs).
+ */
+static inline int ffs(int x)
+{
+	int r = 1;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff)) {
+		x >>= 16;
+		r += 16;
+	}
+	if (!(x & 0xff)) {
+		x >>= 8;
+		r += 8;
+	}
+	if (!(x & 0xf)) {
+		x >>= 4;
+		r += 4;
+	}
+	if (!(x & 3)) {
+		x >>= 2;
+		r += 2;
+	}
+	if (!(x & 1)) {
+		x >>= 1;
+		r += 1;
+	}
+	return r;
+}
+
+#endif /* _ASM_GENERIC_BITOPS_FFS_H_ */

--
