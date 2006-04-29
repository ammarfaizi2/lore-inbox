Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWD2XnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWD2XnH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 19:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWD2XnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 19:43:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:42726 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750828AbWD2XnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 19:43:06 -0400
Message-Id: <20060429233919.497974000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
Date: Sun, 30 Apr 2006 01:28:13 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 01/13] cell: always build spu base into the kernel
Content-Disposition: inline; filename=spu-base-no-module-2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The spu_base module is rather deeply intermixed with the
core kernel, so it makes sense to have that built-in.
This will let us extend the base in the future without
having to export more core symbols just for it.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Index: linus-2.6/arch/powerpc/platforms/cell/Makefile
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/Makefile	2006-04-29 22:47:56.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/cell/Makefile	2006-04-29 22:53:41.000000000 +0200
@@ -2,15 +2,13 @@
 obj-y			+= pervasive.o
 
 obj-$(CONFIG_SMP)	+= smp.o
-obj-$(CONFIG_SPU_FS)	+= spu-base.o spufs/
-
-spu-base-y		+= spu_base.o spu_priv1.o
 
 # needed only when building loadable spufs.ko
 spufs-modular-$(CONFIG_SPU_FS) += spu_syscalls.o
 obj-y			+= $(spufs-modular-m)
 
 # always needed in kernel
-spufs-builtin-$(CONFIG_SPU_FS) += spu_callbacks.o
+spufs-builtin-$(CONFIG_SPU_FS) += spu_callbacks.o spu_base.o spu_priv1.o
 obj-y			+= $(spufs-builtin-y) $(spufs-builtin-m)
 
+obj-$(CONFIG_SPU_FS)	+= spufs/

--

