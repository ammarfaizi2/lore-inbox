Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281172AbRKTRGh>; Tue, 20 Nov 2001 12:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281173AbRKTRG1>; Tue, 20 Nov 2001 12:06:27 -0500
Received: from burdell.cc.gatech.edu ([130.207.3.207]:28424 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S281172AbRKTRGT>; Tue, 20 Nov 2001 12:06:19 -0500
Date: Tue, 20 Nov 2001 12:06:15 -0500
From: Josh Fryman <fryman@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.15-pre7 bzImage fails
Message-Id: <20011120120615.0638b177.fryman@cc.gatech.edu>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.14 patched to 2.4.15-pre7, on "make bzImage", failed.  if anyone wants
additional details, let me know.  i'm not particularly interested in it, the
es1371 was enabled by accident in a new configuration.  i've already fixed
it and moved on.

---

ld -m elf_i386 -T /usr/src/linux-2.4.15-pre7/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/parport/driver.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o \
        net/network.o \
        /usr/src/linux-2.4.15-pre7/arch/i386/lib/lib.a /usr/src/linux-2.4.15-pre7/lib/lib.a /usr/src/linux-2.4.15-pre7/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/sound/sounddrivers.o: In function `es1371_probe':
drivers/sound/sounddrivers.o(.text+0x103d7): undefined reference to `gameport_register_port'
drivers/sound/sounddrivers.o: In function `es1371_remove':
drivers/sound/sounddrivers.o(.text+0x1051b): undefined reference to `gameport_unregister_port'
make: *** [vmlinux] Error 1

