Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131662AbRAAIfm>; Mon, 1 Jan 2001 03:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131704AbRAAIfc>; Mon, 1 Jan 2001 03:35:32 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:3590 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S131662AbRAAIfU>;
	Mon, 1 Jan 2001 03:35:20 -0500
Date: Mon, 1 Jan 2001 10:04:46 +0200 (SAST)
From: Hans Grobler <grobh@sun.ac.za>
To: Pierfrancesco Caci <p.caci@tin.it>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-prerelease compile error in (maybe) mkiss
In-Reply-To: <87bstskv6z.fsf@penny.ik5pvx.ampr.org>
Message-ID: <Pine.LNX.4.30.0101010911590.769-100000@prime.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Jan 2001, Pierfrancesco Caci wrote:
> Hi there... first compilation error of 2001 (at least in my timezone :-)
>
> ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
>         --start-group \
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
>         drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o  drivers/char/drm/drm.o drivers/isdn/isdn.a drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o drivers/net/hamradio/hamradio.o drivers/acpi/acpi.o drivers/md/mddev.o \
>         net/network.o \
>         /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
> drivers/net/net.o: In function `network_ldisc_init':
> drivers/net/net.o(.text.init+0x135): undefined reference to `mkiss_init_ctrl_dev'
> make: *** [vmlinux] Error 1

Yes, this is a known problem (the patch below got lost). MKISS still has a few other
pending issues to resolve for 2.4 so I would recommend you use it with care.

Working on fixing it...

-- Hans


diff -u4Nr -X dontdiff linux-2.4.0-prerelease.orig/drivers/net/setup.c linux-2.4.0-prerelease/drivers/net/setup.c
--- linux-2.4.0-prerelease.orig/drivers/net/setup.c	Mon Dec 11 21:38:29 2000
+++ linux-2.4.0-prerelease/drivers/net/setup.c	Mon Jan  1 07:21:15 2001
@@ -8,9 +8,8 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/netlink.h>

-extern int mkiss_init_ctrl_dev(void);
 extern int slip_init_ctrl_dev(void);
 extern int strip_init_ctrl_dev(void);
 extern int x25_asy_init_ctrl_dev(void);

@@ -147,11 +146,8 @@
 	slip_init_ctrl_dev();
 #endif
 #if defined(CONFIG_X25_ASY)
 	x25_asy_init_ctrl_dev();
-#endif
-#if defined(CONFIG_MKISS)
-	mkiss_init_ctrl_dev();
 #endif
 #if defined(CONFIG_STRIP)
 	strip_init_ctrl_dev();
 #endif







-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
