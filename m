Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312499AbSDEMWb>; Fri, 5 Apr 2002 07:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312505AbSDEMWM>; Fri, 5 Apr 2002 07:22:12 -0500
Received: from wombat.cs.rmit.edu.au ([131.170.24.41]:48875 "EHLO
	wombat.cs.rmit.edu.au") by vger.kernel.org with ESMTP
	id <S312499AbSDEMWH>; Fri, 5 Apr 2002 07:22:07 -0500
Date: Fri, 5 Apr 2002 22:22:05 +1000 (EST)
From: Brett Nuske <bnuske@cs.rmit.edu.au>
To: <linux-kernel@vger.kernel.org>
Subject: COMPILE BUG: SiS DRM Support
In-Reply-To: <20020405134641.B26709@free.fr>
Message-ID: <Pine.SOL.4.33.0204052211080.25614-100000@numbat.cs.rmit.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

   I have been trying to compile SiS DRM support
with the 2.4.18 kernel (have tried both module
and in the kernel) but to no avail. When built
as a module it compiles but when the module gets
loaded I get unresolved symbols.

   When trying to compile the support directly into
the kernel I get the following compilation errors:

<cut>

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/char/drm/drm.o: In function `sis_fb_alloc':
drivers/char/drm/drm.o(.text+0x6a26): undefined reference to `sis_malloc'
drivers/char/drm/drm.o(.text+0x6a6d): undefined reference to `sis_free'
drivers/char/drm/drm.o: In function `sis_fb_free':
drivers/char/drm/drm.o(.text+0x6bb2): undefined reference to `sis_free'
drivers/char/drm/drm.o: In function `sis_final_context':
drivers/char/drm/drm.o(.text+0x7066): undefined reference to `sis_free'
make: *** [vmlinux] Error 1

</cut>

sis_free appears to be in linux/drivers/video/sis/sis_main.c
with its prototype in linux/drivers/video/sis/sis_main.h

linux/drivers/video/sis/sis_mm.c seems to be where the sis_fb_alloc
and sis_fb_free function calls are made.

Is there any obvious reasons why this isn't compiling?

Thanks in advance

****************************************************
*   Brett Nuske                                    *
*   3nd Year B.APP.SCI.(Computer Science)          *
*   COSC1082/CS118 Tutor                           *
*   City Tech. Helpdesk Staff (Computer Science)   *
****************************************************

