Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbUKBNxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbUKBNxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 08:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUKBNxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 08:53:33 -0500
Received: from [212.209.10.221] ([212.209.10.221]:28372 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S262923AbUKBNFB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 08:05:01 -0500
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: [PATCH 1/10] CRIS architecture update - Configuration and build
Date: Tue, 2 Nov 2004 14:04:30 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C7485@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01CB_01C4C0E4.DFDD8650"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_01CB_01C4C0E4.DFDD8650
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch contains changes to configuration and build system to make CRIS
up to date with 2.6.9. 

Signed-Off-By: starvik@axis.com

/Mikael

------=_NextPart_000_01CB_01C4C0E4.DFDD8650
Content-Type: application/octet-stream;
	name="cris269_1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cris269_1.patch"

diff -urNP --exclude=3D'*.cvsignore' ../linux/arch/cris/Kconfig.debug =
lx25/arch/cris/Kconfig.debug=0A=
--- ../linux/arch/cris/Kconfig.debug	Mon Oct 18 23:55:36 2004=0A=
+++ lx25/arch/cris/Kconfig.debug	Tue Oct 19 15:07:34 2004=0A=
@@ -1,15 +1,11 @@=0A=
 menu "Kernel hacking"=0A=
 =0A=
-source "lib/Kconfig.debug"=0A=
-=0A=
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC=0A=
-config PROFILE=0A=
+config PROFILING=0A=
 	bool "Kernel profiling support"=0A=
 =0A=
-config PROFILE_SHIFT=0A=
-	int "Profile shift count"=0A=
-	depends on PROFILE=0A=
-	default "2"=0A=
+config SYSTEM_PROFILER=0A=
+        bool "System profiling support"=0A=
 =0A=
 config ETRAX_KGDB=0A=
 	bool "Use kernel GDB debugger"=0A=
@@ -25,4 +21,21 @@=0A=
 	  didn't before).  The kernel halts when it boots, waiting for gdb if=0A=
 	  this option is turned on!=0A=
 =0A=
+=0A=
+config DEBUG_INFO=0A=
+        bool "Compile the kernel with debug info"=0A=
+        help=0A=
+          If you say Y here the resulting kernel image will include=0A=
+          debugging info resulting in a larger kernel image.=0A=
+          Say Y here only if you plan to use gdb to debug the kernel.=0A=
+          If you don't debug the kernel, you can say N.=0A=
+=0A=
+config FRAME_POINTER=0A=
+        bool "Compile the kernel with frame pointers"=0A=
+        help=0A=
+          If you say Y here the resulting kernel image will be slightly =
larger=0A=
+          and slower, but it will give very useful debugging =
information.=0A=
+          If you don't debug the kernel, you can say N, but we may not =
be able=0A=
+          to solve problems without frame pointers.=0A=
+=0A=
 endmenu=0A=
diff -urNP --exclude=3D'*.cvsignore' ../linux/arch/cris/Makefile =
lx25/arch/cris/Makefile=0A=
--- ../linux/arch/cris/Makefile	Mon Oct 18 23:54:07 2004=0A=
+++ lx25/arch/cris/Makefile	Tue Oct 19 15:07:34 2004=0A=
@@ -1,4 +1,4 @@=0A=
-# $Id: Makefile,v 1.20 2004/05/14 14:35:58 orjanf Exp $=0A=
+# $Id: Makefile,v 1.23 2004/10/19 13:07:34 starvik Exp $=0A=
 # cris/Makefile=0A=
 #=0A=
 # This file is included by the global makefile so that you can add your =
own=0A=
@@ -80,7 +81,7 @@=0A=
 archmrproper:=0A=
 archclean:=0A=
 	$(Q)$(MAKE) $(clean)=3Darch/$(ARCH)/boot=0A=
-	rm -f timage vmlinux.bin cramfs.img=0A=
+	rm -f timage vmlinux.bin decompress.bin rescue.bin cramfs.img=0A=
 	rm -rf $(LD_SCRIPT).tmp=0A=
 =0A=
 prepare: arch/$(ARCH)/.links include/asm-$(ARCH)/.arch \=0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/drivers/Kconfig =
lx25/arch/cris/arch-v10/drivers/Kconfig=0A=
--- ../linux/arch/cris/arch-v10/drivers/Kconfig	Mon Oct 18 23:53:43 2004=0A=
+++ lx25/arch/cris/arch-v10/drivers/Kconfig	Tue Oct 12 09:55:08 2004=0A=
@@ -549,44 +549,17 @@=0A=
 =0A=
 config ETRAX_IDE=0A=
 	bool "ATA/IDE support"=0A=
-	help=0A=
+	select IDE=0A=
+	select BLK_DEV_IDE=0A=
+	select BLK_DEV_IDEDISK=0A=
+	select BLK_DEV_IDECD=0A=
+	select BLK_DEV_IDEDMA=0A=
+	select DMA_NONPCI=0A=
+	help =0A=
 	  Enable this to get support for ATA/IDE.=0A=
 	  You can't use parallell ports or SCSI ports=0A=
 	  at the same time.=0A=
 =0A=
-# here we should add the CONFIG_'s necessary to enable the basic=0A=
-# general ide drivers so the common case does not need to go=0A=
-# into that config submenu. enable disk and CD support. others=0A=
-# need to go fiddle in the submenu..=0A=
-config IDE=0A=
-	tristate=0A=
-	depends on ETRAX_IDE=0A=
-	default y=0A=
-=0A=
-config BLK_DEV_IDE=0A=
-	tristate=0A=
-	depends on ETRAX_IDE=0A=
-	default y=0A=
-=0A=
-config BLK_DEV_IDEDISK=0A=
-	tristate=0A=
-	depends on ETRAX_IDE=0A=
-	default y=0A=
-=0A=
-config BLK_DEV_IDECD=0A=
-	tristate=0A=
-	depends on ETRAX_IDE=0A=
-	default y=0A=
-=0A=
-config BLK_DEV_IDEDMA=0A=
-	bool=0A=
-	depends on ETRAX_IDE=0A=
-	default y=0A=
-=0A=
-config DMA_NONPCI=0A=
-	bool=0A=
-	depends on ETRAX_IDE=0A=
-	default y=0A=
 =0A=
 config ETRAX_IDE_DELAY=0A=
 	int "Delay for drives to regain consciousness"=0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/kernel/Makefile =
lx25/arch/cris/arch-v10/kernel/Makefile=0A=
--- ../linux/arch/cris/arch-v10/kernel/Makefile	Mon Oct 18 23:53:05 2004=0A=
+++ lx25/arch/cris/arch-v10/kernel/Makefile	Wed Jun  2 10:24:38 2004=0A=
@@ -1,4 +1,4 @@=0A=
-# $Id: Makefile,v 1.4 2003/07/04 12:57:13 tobiasa Exp $=0A=
+# $Id: Makefile,v 1.5 2004/06/02 08:24:38 starvik Exp $=0A=
 #=0A=
 # Makefile for the linux kernel.=0A=
 #=0A=
@@ -11,6 +11,7 @@=0A=
 =0A=
 obj-$(CONFIG_ETRAX_KGDB) +=3D kgdb.o=0A=
 obj-$(CONFIG_ETRAX_FAST_TIMER) +=3D fasttimer.o=0A=
+obj-$(CONFIG_MODULES)    +=3D crisksyms.o=0A=
 =0A=
 clean:=0A=
 =0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/vmlinux.lds.S =
lx25/arch/cris/arch-v10/vmlinux.lds.S=0A=
--- ../linux/arch/cris/arch-v10/vmlinux.lds.S	Mon Oct 18 23:53:51 2004=0A=
+++ lx25/arch/cris/arch-v10/vmlinux.lds.S	Tue Oct 19 15:07:36 2004=0A=
@@ -26,6 +26,7 @@=0A=
 	.text : {=0A=
 		*(.text)=0A=
 		SCHED_TEXT=0A=
+		LOCK_TEXT=0A=
 		*(.fixup)=0A=
 		*(.text.__*)=0A=
 	}=0A=

------=_NextPart_000_01CB_01C4C0E4.DFDD8650--

