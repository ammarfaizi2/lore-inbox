Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277083AbRJKXv5>; Thu, 11 Oct 2001 19:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277084AbRJKXvs>; Thu, 11 Oct 2001 19:51:48 -0400
Received: from daytona.gci.com ([205.140.80.57]:25348 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S277083AbRJKXvg>;
	Thu, 11 Oct 2001 19:51:36 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA31506146916@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@redhat.com>
Subject: [BUG] Linux-2.4.12 does not build (Sparc-64 & DRM)
Date: Thu, 11 Oct 2001 15:52:01 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a quick bug report -- I haven't had time
to track this one down yet.

Enabling DRM/DRI support on a Sparc64 kernel
with Creator/Creator3D graphics does not build
correctly:

ld -m elf64_sparc -T arch/sparc64/vmlinux.lds arch/sparc64/kernel/head.o
arch/sparc64/kernel/init_task.o init/main.o init/version.o \
	--start-group \
	arch/sparc64/kernel/kernel.o arch/sparc64/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o arch/sparc64/math-emu/math-emu.o \
	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o
drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o
drivers/sbus/sbus_all.o drivers/video/video.o drivers/input/inputdrv.o \
	net/network.o \
	/usr/src/linux/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/sparc64/prom/promlib.a
/usr/src/linux/arch/sparc64/lib/lib.a \
	--end-group \
	-o vmlinux
drivers/char/drm/drm.o: In function `ffb_vm_shm_nopage':
drivers/char/drm/drm.o(.text+0x4ba8): undefined reference to
`virt_to_bus_not_defined_use_pci_map'
drivers/char/drm/drm.o: In function `ffb_vm_dma_nopage':
drivers/char/drm/drm.o(.text+0x4e4c): undefined reference to
`virt_to_bus_not_defined_use_pci_map'
make: *** [vmlinux] Error 1

This makes correctly on 2.4.10 and earlier.
