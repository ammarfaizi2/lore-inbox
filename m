Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310112AbSCKOLt>; Mon, 11 Mar 2002 09:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310114AbSCKOLk>; Mon, 11 Mar 2002 09:11:40 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:11277 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S310112AbSCKOL0>; Mon, 11 Mar 2002 09:11:26 -0500
Message-Id: <200203111408.g2BE8pq05486@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Trivial compile fix
Date: Mon, 11 Mar 2002 16:08:01 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ld -m elf_i386 -T /.share/usr/src/linux-2.5.6-pre2/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	/.share/usr/src/linux-2.5.6-pre2/arch/i386/lib/lib.a /.share/usr/src/linux-2.5.6-pre2/lib/lib.a /.share/usr/src/linux-2.5.6-pre2/arch/i386/lib/lib.a \
	 drivers/base/base.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o drivers/md/mddev.o \
	net/network.o \
	--end-group \
	-o vmlinux
drivers/net/net.o: In function `__cp_set_rx_mode':
drivers/net/net.o(.text+0x15162): undefined reference to `ether_crc'
make: *** [vmlinux] Error 1


--- linux-2.5.6-pre2/drivers/net/8139cp.c.orig	Mon Mar 11 13:17:59 2002
+++ linux-2.5.6-pre2/drivers/net/8139cp.c	Mon Mar 11 15:44:48 2002
@@ -47,7 +47,6 @@
 #define DRV_VERSION		"0.0.7"
 #define DRV_RELDATE		"Feb 27, 2002"
 
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
@@ -59,6 +58,7 @@
 #include <linux/mii.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
+#include <linux/crc32.h>
 
 /* These identify the driver base version and may not be removed. */
 static char version[] __devinitdata =
