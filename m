Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280580AbRKFVSH>; Tue, 6 Nov 2001 16:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280583AbRKFVQ4>; Tue, 6 Nov 2001 16:16:56 -0500
Received: from iris.ncsl.nist.gov ([129.6.57.209]:899 "EHLO iris.ncsl.nist.gov")
	by vger.kernel.org with ESMTP id <S280597AbRKFVQq>;
	Tue, 6 Nov 2001 16:16:46 -0500
Date: Tue, 6 Nov 2001 16:16:46 -0500
From: Martial MICHEL <martial@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 - loop.c uses "deactivate_page" that seems not to be defined
Message-ID: <20011106161644.A25835@iris.ncsl.nist.gov>
Reply-To: Martial MICHEL <martial@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I just  downloaded  2.4.14 and tried to   compile it (using  a
"make oldconfig"  out of the config  file from my old 2.4.8-ac12, then
"make menuconfig") and the kernel seems not to  be able to link ("make
install", after a normal "make dep") :

--------------------
ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/parport/driver.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o drivers/i2c/i2c.o \
        net/network.o \
        /usr/src/linux-2.4.14/arch/i386/lib/lib.a /usr/src/linux-2.4.14/lib/lib.a /usr/src/linux-2.4.14/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0x8843): undefined reference to `deactivate_page'
drivers/block/block.o(.text+0x88c8): undefined reference to `deactivate_page'
make: *** [vmlinux] Error 1
--------------------

After doing a little  research the only place  where `deactivate_page'
exists is inside the `./drivers/block/loop.c` file (lines 210 and 221)
and  is  not defined  anywhere  else (seems to  me  it may  have to be
defined in "kernel/ksyms.c", but it  is not). [For  now I does compile
without loopback device.]

My architecture is SMP PII, with 1Gb of memory. If asked I can provide
the .config file used (please  send me an e-mail directly  as I am not
on this ML).

					Hope this helps,

-- 
  Martial MICHEL
E-mail    : martial@users.sourceforge.net
Home page : http://www.loria.fr/~michel/
PBM       : http://pbm.sourceforge.net/
DLC       : http://dlc.sourceforge.net/
