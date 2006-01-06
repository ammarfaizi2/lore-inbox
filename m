Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752546AbWAFU1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbWAFU1o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752544AbWAFU1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:27:13 -0500
Received: from mx.pathscale.com ([64.160.42.68]:58247 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752546AbWAFU1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:27:05 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
X-Mercurial-Node: d286502c3b3cd6bcec7be66742dca731ae842205
Message-Id: <d286502c3b3cd6bcec7b.1136579194@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1136579193@eng-12.pathscale.com>
Date: Fri,  6 Jan 2006 12:26:34 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This arch-independent routine copies data to a memory-mapped I/O region,
using 32-bit accesses.  It does not guarantee access ordering, nor does
it perform a memory barrier afterwards.  This style of access is required
by some devices.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r ddf8ff83e4ac -r d286502c3b3c include/asm-generic/raw_memcpy_toio32.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/include/asm-generic/raw_memcpy_toio32.h	Fri Jan  6 12:25:00 2006 -0800
@@ -0,0 +1,41 @@
+/*
+ * Copyright 2006 PathScale, Inc.  All Rights Reserved.
+ * 
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
+ */
+#ifndef _ASM_GENERIC_RAW_MEMCPYTOIO32_H
+#define _ASM_GENERIC_RAW_MEMCPYTOIO32_H
+
+/*
+ * __raw_memcpy_toio32 - copy data to MMIO space, in 32-bit units
+ *
+ * Order of access is not guaranteed, nor is a memory barrier performed
+ * afterwards.  This is an arch-independent generic implementation.
+ *
+ * @to: destination, in MMIO space (must be 32-bit aligned)
+ * @from: source (must be 32-bit aligned)
+ * @count: number of 32-bit quantities to copy
+ */
+static inline void __raw_memcpy_toio32(void __iomem *to, const void *from,
+				       size_t count)
+{
+	u32 __iomem *dst = d;
+	const u32 *src = s;
+	size_t i;
+
+	for (i = 0; i < count; i++)
+		__raw_writel(*src++, dst++);
+}
+
+#endif // _ASM_GENERIC_RAW_MEMCPYTOIO32_H
