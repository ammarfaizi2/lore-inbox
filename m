Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267898AbTAMNtG>; Mon, 13 Jan 2003 08:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267809AbTAMNtG>; Mon, 13 Jan 2003 08:49:06 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:12480 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S267898AbTAMNtD>; Mon, 13 Jan 2003 08:49:03 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: patch for errno-issue (with soundcore)
Date: Mon, 13 Jan 2003 14:57:53 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Message-Id: <200301131457.24264.thomas.schlichter@web.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_H4ON3OVJ0IBRF2BNFRYK"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_H4ON3OVJ0IBRF2BNFRYK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Hi,

here is a simple patch to export the errno-symbol from the /lib/errno.c file. 
This solves the problem with the soundcore module and works perfectly for 
me...

   Thomas Schlichter

P.S.: This patch is made against the 2.5.56 tree


--------------Boundary-00=_H4ON3OVJ0IBRF2BNFRYK
Content-Type: text/x-diff;
  charset="us-ascii";
  name="errno_patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="errno_patch.diff"

diff -urP linux-2.5.56/lib/Makefile linux-2.5.56_patched/lib/Makefile
--- linux-2.5.56/lib/Makefile	Fri Jan 10 21:11:20 2003
+++ linux-2.5.56_patched/lib/Makefile	Mon Jan 13 13:15:41 2003
@@ -9,7 +9,7 @@
 L_TARGET := lib.a

 export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o \
-	       crc32.o rbtree.o radix-tree.o kobject.o
+	       crc32.o rbtree.o radix-tree.o kobject.o errno.o

 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
diff -urP linux-2.5.56/lib/errno.c linux-2.5.56_patched/lib/errno.c
--- linux-2.5.56/lib/errno.c	Fri Jan 10 21:11:40 2003
+++ linux-2.5.56_patched/lib/errno.c	Mon Jan 13 13:17:21 2003
@@ -4,4 +4,8 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */

+#include <linux/module.h>
+
 int errno;
+
+EXPORT_SYMBOL(errno);

--------------Boundary-00=_H4ON3OVJ0IBRF2BNFRYK--

