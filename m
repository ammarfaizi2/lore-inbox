Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319158AbSIJOx6>; Tue, 10 Sep 2002 10:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319159AbSIJOx6>; Tue, 10 Sep 2002 10:53:58 -0400
Received: from kim.it.uu.se ([130.238.12.178]:60076 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S319158AbSIJOx5>;
	Tue, 10 Sep 2002 10:53:57 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15742.2206.709234.102259@kim.it.uu.se>
Date: Tue, 10 Sep 2002 16:58:38 +0200
To: torvalds@transmeta.com
Subject: [PATCH] undo 2.5.34 ftape damage
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the 2.5.33->2.5.34 step someone removed "export-objs" from
drivers/char/ftape/lowlevel/Makefile, which makes it impossible to build
ftape as a module since is _does_ have a number of EXPORT_SYMBOL's.

The patch below reverts that change. Linus, please apply.

/Mikael

--- linux-2.5.34/drivers/char/ftape/lowlevel/Makefile.~1~	Mon Sep  9 21:15:28 2002
+++ linux-2.5.34/drivers/char/ftape/lowlevel/Makefile	Tue Sep 10 16:43:25 2002
@@ -23,6 +23,8 @@
 #      driver for Linux.
 #
 
+export-objs := ftape_syms.o
+
 obj-$(CONFIG_FTAPE) += ftape.o
 
 ftape-objs := ftape-init.o fdc-io.o fdc-isr.o \
