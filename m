Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbSLIIyk>; Mon, 9 Dec 2002 03:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSLIIyk>; Mon, 9 Dec 2002 03:54:40 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:49308 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264699AbSLIIyi>; Mon, 9 Dec 2002 03:54:38 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Explicitly include sched.h in fs/ext2/ioctl.c
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20021209090213.2963D370D@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon,  9 Dec 2002 18:02:13 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It previously seemed to have depended on getting sched.h via asm/uaccess.h.
This patch just makes it explicit.

diff -ruN -X../cludes -xm68knommu -xasm-m68knommu -xmm ../orig/linux-2.5.50/fs/ext2/ioctl.c fs/ext2/ioctl.c
--- ../orig/linux-2.5.50/fs/ext2/ioctl.c	2002-09-18 09:59:20.000000000 +0900
+++ fs/ext2/ioctl.c	2002-11-28 14:55:33.000000000 +0900
@@ -9,8 +9,10 @@
 
 #include "ext2.h"
 #include <linux/time.h>
+#include <linux/capability.h>
+#include <linux/sched.h>
 #include <asm/uaccess.h>
-
+#include <asm/current.h>
 
 int ext2_ioctl (struct inode * inode, struct file * filp, unsigned int cmd,
 		unsigned long arg)
