Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVGUKYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVGUKYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 06:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVGUKWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 06:22:10 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:48551 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261740AbVGUKVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 06:21:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Update ioremap return type and add ioread/iowrite functions
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20050721102121.966D93AB@mctpc71>
Date: Thu, 21 Jul 2005 19:21:21 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 include/asm-v850/io.h |   37 ++++++++++++++++++++++++-------------
 1 files changed, 24 insertions(+), 13 deletions(-)

diff -ruN -X../cludes linux-2.6.12-uc0/include/asm-v850/io.h linux-2.6.12-uc0-v850-20050721/include/asm-v850/io.h
--- linux-2.6.12-uc0/include/asm-v850/io.h	2005-06-21 16:11:50.083113000 +0900
+++ linux-2.6.12-uc0-v850-20050721/include/asm-v850/io.h	2005-07-21 16:30:57.677141000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/io.h -- Misc I/O operations
  *
- *  Copyright (C) 2001,02,03,04  NEC Electronics Corporation
- *  Copyright (C) 2001,02,03,04  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03,04,05  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03,04,05  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -27,12 +27,12 @@
 #define readw_relaxed(a) readw(a)
 #define readl_relaxed(a) readl(a)
 
-#define writeb(b, addr) \
-  (void)((*(volatile unsigned char *) (addr)) = (b))
-#define writew(b, addr) \
-  (void)((*(volatile unsigned short *) (addr)) = (b))
-#define writel(b, addr) \
-  (void)((*(volatile unsigned int *) (addr)) = (b))
+#define writeb(val, addr) \
+  (void)((*(volatile unsigned char *) (addr)) = (val))
+#define writew(val, addr) \
+  (void)((*(volatile unsigned short *) (addr)) = (val))
+#define writel(val, addr) \
+  (void)((*(volatile unsigned int *) (addr)) = (val))
 
 #define __raw_readb readb
 #define __raw_readw readw
@@ -96,11 +96,22 @@
 		outl (*p++, port);
 }
 
-#define iounmap(addr)				((void)0)
-#define ioremap(physaddr, size)			(physaddr)
-#define ioremap_nocache(physaddr, size)		(physaddr)
-#define ioremap_writethrough(physaddr, size)	(physaddr)
-#define ioremap_fullcache(physaddr, size)	(physaddr)
+
+/* Some places try to pass in an loff_t for PHYSADDR (?!), so we cast it to
+   long before casting it to a pointer to avoid compiler warnings.  */
+#define ioremap(physaddr, size)	((void __iomem *)(unsigned long)(physaddr))
+#define iounmap(addr)		((void)0)
+
+#define ioremap_nocache(physaddr, size)		ioremap (physaddr, size)
+#define ioremap_writethrough(physaddr, size)	ioremap (physaddr, size)
+#define ioremap_fullcache(physaddr, size)	ioremap (physaddr, size)
+
+#define ioread8(addr)		readb (addr)
+#define ioread16(addr)		readw (addr)
+#define ioread32(addr)		readl (addr)
+#define iowrite8(val, addr)	writeb (val, addr)
+#define iowrite16(val, addr)	writew (val, addr)
+#define iowrite32(val, addr)	writel (val, addr)
 
 #define mmiowb()
 
