Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTJRRkP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 13:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbTJRRkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 13:40:15 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:3457
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S261744AbTJRRkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 13:40:11 -0400
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: 'drivers/block/swim3.c' fails to compile under 2.6.0-test8 [Bug #1370]
Message-Id: <E1AAv3q-0000wq-00@penngrove.fdns.net>
Date: Sat, 18 Oct 2003 10:40:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also fails at least back to 'test3'.  It seems at least to be missing
some #include files.  I've not had a chance to test the actual driver
as the framebuffer console won't sync for me under '2.6.0-test8' and
currently fails to come up far enough to allow 'ssh' access.  Attached
is a possible patch, which still gets a couple of warnings.  See

    http://bugzilla.kernel.org/attachment.cgi?id=1090

for .config file.
			   -- JM

-------------------------------------------------------------------------------
--- drivers/block/swim3.c.orig	2003-10-17 14:43:02.000000000 -0700
+++ drivers/block/swim3.c	2003-10-18 07:36:48.000000000 -0700
@@ -25,6 +25,8 @@
 #include <linux/fd.h>
 #include <linux/ioctl.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/blkdev.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>
 #include <asm/dbdma.h>
 #include <asm/prom.h>
-------------------------------------------------------------------------------
	...
  CHK     include/linux/compile.h
  CC      drivers/block/swim3.o
drivers/block/swim3.c: In function `swim3_add_device':
drivers/block/swim3.c:1086: warning: passing arg 2 of `request_irq' from incompatible pointer type
drivers/block/swim3.c: At top level:
drivers/block/swim3.c:964: warning: `floppy_off' defined but not used
  LD      drivers/block/built-in.o
	...

===============================================================================
