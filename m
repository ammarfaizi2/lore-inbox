Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbUBDQwX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 11:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbUBDQwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 11:52:23 -0500
Received: from mo03.iij4u.or.jp ([210.130.0.20]:44761 "EHLO mo03.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262683AbUBDQwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 11:52:16 -0500
Date: Thu, 5 Feb 2004 01:52:06 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: marcelo.tosatti@cyclades.com
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] Removed same processing for INITRD
Message-Id: <20040205015206.2676f774.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Both arch/mips/kernel/setup.c and following files have the same processing for initrd.
One of the processing for initrd should delete.

Please apply this patch to v2.4.

Yoichi

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1315  -> 1.1316 
#	arch/mips/vr41xx/casio-e55/setup.c	1.2     -> 1.3    
#	arch/mips/vr41xx/tanbac-tb0229/setup.c	1.2     -> 1.3    
#	arch/mips/vr41xx/ibm-workpad/setup.c	1.2     -> 1.3    
#	arch/mips/vr41xx/tanbac-tb0226/setup.c	1.2     -> 1.3    
#	arch/mips/vr41xx/nec-eagle/setup.c	1.3     -> 1.4    
#	arch/mips/vr41xx/zao-capcella/setup.c	1.3     -> 1.4    
#	arch/mips/vr41xx/victor-mpc30x/setup.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/05	yuasa@hh.iij4u.or.jp	1.1316
# removed same processing for INITRD
# --------------------------------------------
#
diff -Nru a/arch/mips/vr41xx/casio-e55/setup.c b/arch/mips/vr41xx/casio-e55/setup.c
--- a/arch/mips/vr41xx/casio-e55/setup.c	Thu Feb  5 01:40:03 2004
+++ b/arch/mips/vr41xx/casio-e55/setup.c	Thu Feb  5 01:40:03 2004
@@ -23,11 +23,6 @@
 #include <asm/time.h>
 #include <asm/vr41xx/e55.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
-
 void __init casio_e55_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
@@ -35,12 +30,6 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 	iomem_resource.start = IO_MEM_RESOURCE_START;
 	iomem_resource.end = IO_MEM_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
 
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
diff -Nru a/arch/mips/vr41xx/ibm-workpad/setup.c b/arch/mips/vr41xx/ibm-workpad/setup.c
--- a/arch/mips/vr41xx/ibm-workpad/setup.c	Thu Feb  5 01:40:03 2004
+++ b/arch/mips/vr41xx/ibm-workpad/setup.c	Thu Feb  5 01:40:03 2004
@@ -23,11 +23,6 @@
 #include <asm/time.h>
 #include <asm/vr41xx/workpad.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
-
 void __init ibm_workpad_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
@@ -35,12 +30,6 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 	iomem_resource.start = IO_MEM_RESOURCE_START;
 	iomem_resource.end = IO_MEM_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
 
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
diff -Nru a/arch/mips/vr41xx/nec-eagle/setup.c b/arch/mips/vr41xx/nec-eagle/setup.c
--- a/arch/mips/vr41xx/nec-eagle/setup.c	Thu Feb  5 01:40:03 2004
+++ b/arch/mips/vr41xx/nec-eagle/setup.c	Thu Feb  5 01:40:03 2004
@@ -50,11 +50,6 @@
 #include <asm/time.h>
 #include <asm/vr41xx/eagle.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
-
 extern void eagle_irq_init(void);
 
 #ifdef CONFIG_PCI
@@ -114,12 +109,6 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 	iomem_resource.start = IO_MEM1_RESOURCE_START;
 	iomem_resource.end = IO_MEM2_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
 
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
diff -Nru a/arch/mips/vr41xx/tanbac-tb0226/setup.c b/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- a/arch/mips/vr41xx/tanbac-tb0226/setup.c	Thu Feb  5 01:40:03 2004
+++ b/arch/mips/vr41xx/tanbac-tb0226/setup.c	Thu Feb  5 01:40:03 2004
@@ -23,11 +23,6 @@
 #include <asm/time.h>
 #include <asm/vr41xx/tb0226.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
-
 #ifdef CONFIG_PCI
 static struct resource vr41xx_pci_io_resource = {
 	"PCI I/O space",
@@ -82,12 +77,6 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 	iomem_resource.start = IO_MEM1_RESOURCE_START;
 	iomem_resource.end = IO_MEM2_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
 
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
diff -Nru a/arch/mips/vr41xx/tanbac-tb0229/setup.c b/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- a/arch/mips/vr41xx/tanbac-tb0229/setup.c	Thu Feb  5 01:40:03 2004
+++ b/arch/mips/vr41xx/tanbac-tb0229/setup.c	Thu Feb  5 01:40:03 2004
@@ -28,10 +28,6 @@
 #include <asm/time.h>
 #include <asm/vr41xx/tb0229.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern void * __rd_start, * __rd_end;
-#endif
-
 #ifdef CONFIG_PCI
 static struct resource vr41xx_pci_io_resource = {
 	.name	= "PCI I/O space",
@@ -94,12 +90,6 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 	iomem_resource.start = IO_MEM1_RESOURCE_START;
 	iomem_resource.end = IO_MEM2_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
 
 	_machine_restart = tanbac_tb0229_restart;
 	_machine_halt = vr41xx_halt;
diff -Nru a/arch/mips/vr41xx/victor-mpc30x/setup.c b/arch/mips/vr41xx/victor-mpc30x/setup.c
--- a/arch/mips/vr41xx/victor-mpc30x/setup.c	Thu Feb  5 01:40:03 2004
+++ b/arch/mips/vr41xx/victor-mpc30x/setup.c	Thu Feb  5 01:40:03 2004
@@ -24,11 +24,6 @@
 #include <asm/time.h>
 #include <asm/vr41xx/mpc30x.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
-
 #ifdef CONFIG_PCI
 static struct resource vr41xx_pci_io_resource = {
 	"PCI I/O space",
@@ -83,12 +78,6 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 	iomem_resource.start = IO_MEM1_RESOURCE_START;
 	iomem_resource.end = IO_MEM2_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
 
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
diff -Nru a/arch/mips/vr41xx/zao-capcella/setup.c b/arch/mips/vr41xx/zao-capcella/setup.c
--- a/arch/mips/vr41xx/zao-capcella/setup.c	Thu Feb  5 01:40:03 2004
+++ b/arch/mips/vr41xx/zao-capcella/setup.c	Thu Feb  5 01:40:03 2004
@@ -24,11 +24,6 @@
 #include <asm/time.h>
 #include <asm/vr41xx/capcella.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
-
 #ifdef CONFIG_PCI
 static struct resource vr41xx_pci_io_resource = {
 	"PCI I/O space",
@@ -83,12 +78,6 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 	iomem_resource.start = IO_MEM1_RESOURCE_START;
 	iomem_resource.end = IO_MEM2_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
 
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
