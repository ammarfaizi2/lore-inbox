Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSIDXH1>; Wed, 4 Sep 2002 19:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSIDXH0>; Wed, 4 Sep 2002 19:07:26 -0400
Received: from hermes.domdv.de ([193.102.202.1]:15883 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S316070AbSIDXGp>;
	Wed, 4 Sep 2002 19:06:45 -0400
Message-ID: <3D769371.6000009@domdv.de>
Date: Thu, 05 Sep 2002 01:12:49 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux.nics@intel.com, linux-kernel@vger.kernel.org
Subject: 2.4.20pre5 e100 build error + trivial fix
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030701030106080401020601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030701030106080401020601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
the e100 driver in 2.4.20pre5 fails to build due to a static procedure 
declaration with an unresolved symbol (see below), trivial patch to fix 
this is attached.

ld -m elf_i386 -T 
/usr/src/ARCHIVE/kernel-2.4.20pre5/linux/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
         --start-group \
         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o 
mm/mm.o fs/fs.o ipc/ipc.o \
          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o 
drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o 
drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o \
         net/network.o \
          \
         /usr/src/ARCHIVE/kernel-2.4.20pre5/linux/arch/i386/lib/lib.a 
/usr/src/ARCHIVE/kernel-2.4.20pre5/linux/lib/lib.a 
/usr/src/ARCHIVE/kernel-2.4.20pre5/linux/arch/i386/lib/lib.a \
         --end-group \
         -o vmlinux
drivers/net/net.o: In function `e100_diag_config_loopback':
drivers/net/net.o(.text+0x8a74): undefined reference to 
`e100_force_speed_duplex'

-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--------------030701030106080401020601
Content-Type: text/plain;
 name="e100_phy.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e100_phy.diff"

--- drivers/net/e100/e100_phy.c.orig	2002-09-05 00:35:38.000000000 +0200
+++ drivers/net/e100/e100_phy.c	2002-09-05 01:03:32.000000000 +0200
@@ -622,7 +622,7 @@
  * Returns: void
  *
  */
-static void
+void
 e100_force_speed_duplex(struct e100_private *bdp)
 {
 	u16 control;

--------------030701030106080401020601--

