Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267677AbTBRGMf>; Tue, 18 Feb 2003 01:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267680AbTBRGKG>; Tue, 18 Feb 2003 01:10:06 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:32753 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267716AbTBRGIL>; Tue, 18 Feb 2003 01:08:11 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Implement <asm/bug.h> for v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030218061508.A347837C4@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 18 Feb 2003 15:15:08 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.62-uc0.orig/include/asm-v850/bug.h linux-2.5.62-uc0/include/asm-v850/bug.h
--- linux-2.5.62-uc0.orig/include/asm-v850/bug.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.5.62-uc0/include/asm-v850/bug.h	2003-02-18 11:41:09.000000000 +0900
@@ -0,0 +1,21 @@
+/*
+ * include/asm-v850/bug.h -- Bug reporting
+ *
+ *  Copyright (C) 2003  NEC Electronics Corporation
+ *  Copyright (C) 2003  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#ifndef __V850_BUG_H__
+#define __V850_BUG_H__
+
+extern void __bug (void) __attribute__ ((noreturn));
+#define BUG()		__bug()
+#define PAGE_BUG(page)	__bug()
+
+#endif /* __V850_BUG_H__ */
diff -ruN -X../cludes linux-2.5.62-uc0.orig/include/asm-v850/page.h linux-2.5.62-uc0/include/asm-v850/page.h
--- linux-2.5.62-uc0.orig/include/asm-v850/page.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.5.62-uc0/include/asm-v850/page.h	2003-02-18 11:41:09.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/page.h -- VM ops
  *
- *  Copyright (C) 2001, 2002  NEC Corporation
- *  Copyright (C) 2001, 2002  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -94,10 +94,6 @@
 
 #ifndef __ASSEMBLY__
 
-extern void __bug (void) __attribute__ ((noreturn));
-#define BUG()		__bug()
-#define PAGE_BUG(page)	__bug()
-
 /* Pure 2^n version of get_order */
 extern __inline__ int get_order (unsigned long size)
 {
