Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbREQK5F>; Thu, 17 May 2001 06:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbREQK4z>; Thu, 17 May 2001 06:56:55 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:31730 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261333AbREQK4n>;
	Thu, 17 May 2001 06:56:43 -0400
Date: Thu, 17 May 2001 06:56:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fixes to top-level Makefile (-pre3)
In-Reply-To: <Pine.LNX.4.33.0105171202430.4285-100000@chaos.tp1.ruhr-uni-bochum.de>
Message-ID: <Pine.GSO.4.21.0105170640060.27492-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 17 May 2001, Kai Germaschewski wrote:

> This part is not necessary. The ordering of subdir-y only has to do with
> compilation ordering, not with link order. The link order for
> drivers/char/* is set explicitly in the toplevel Makefile.

	Oh, crap. Right you are. OK, but it means that we need to change
toplevel Makefile to handle the changes done in -pre3. Thanks for spotting.

	Linus, could you please apply the following? That's _not_ for
i2c - this is what I ought to do in the patches that went into -pre3
instead of changing the order in drivers/Makefile.

	Self-LART applied.
								Al

--- 2.4.5-pre3/Makefile	Wed May 16 16:26:31 2001
+++ linux-test/Makefile	Thu May 17 06:47:44 2001
@@ -118,11 +118,7 @@
 
 CORE_FILES	=kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o
 NETWORKS	=net/network.o
-DRIVERS		=drivers/block/block.o \
-		 drivers/char/char.o \
-		 drivers/misc/misc.o \
-		 drivers/net/net.o \
-		 drivers/media/media.o
+
 LIBS		=$(TOPDIR)/lib/lib.a
 SUBDIRS		=kernel drivers mm fs net ipc lib
 
@@ -132,6 +128,11 @@
 DRIVERS-  :=
 
 DRIVERS-$(CONFIG_PARPORT) += drivers/parport/driver.o
+DRIVERS-y += drivers/char/char.o \
+	drivers/block/block.o \
+	drivers/misc/misc.o \
+	drivers/net/net.o \
+	drivers/media/media.o
 DRIVERS-$(CONFIG_AGP) += drivers/char/agp/agp.o
 DRIVERS-$(CONFIG_DRM) += drivers/char/drm/drm.o
 DRIVERS-$(CONFIG_NUBUS) += drivers/nubus/nubus.a
@@ -177,7 +178,7 @@
 DRIVERS-$(CONFIG_ACPI) += drivers/acpi/acpi.o
 DRIVERS-$(CONFIG_MD) += drivers/md/mddev.o
 
-DRIVERS += $(DRIVERS-y)
+DRIVERS := $(DRIVERS-y)
 
 
 # files removed with 'make clean'

