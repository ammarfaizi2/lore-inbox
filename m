Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315646AbSECL6w>; Fri, 3 May 2002 07:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315647AbSECL6v>; Fri, 3 May 2002 07:58:51 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:10024 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S315646AbSECL6u>;
	Fri, 3 May 2002 07:58:50 -0400
Date: Fri, 3 May 2002 13:58:49 +0200 (CEST)
From: Krzysiek Taraszka <dzimi@ep09.kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: PPC and 2.2.21rc3 with modular ide subsystem
Message-ID: <Pine.LNX.4.44.0205031339430.24354-100000@ep09.kernel.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried compile 2.2.21rc3 with modular ide subsystem and i got that 
messages:

ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic 
arch/ppc/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o 
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        fs/filesystems.a \
        net/network.a \
        drivers/block/block.a drivers/char/char.o drivers/misc/misc.a 
drivers/net/net.a drivers/cdrom/cdrom.a drivers/pci/pci.a 
drivers/net/fc/fc.a drivers/macintosh/macintosh.o drivers/video/video.a 
drivers/net/hamradio/hamradio.a drivers/usb/usbdrv.o \
        /home/users/dzimi/rpm/BUILD/linux/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/kernel/kernel.o: In function `ide_pmac_init':
arch/ppc/kernel/kernel.o(.text+0x7d58): undefined reference to `ide_init'
arch/ppc/kernel/kernel.o(.text+0x7d58): relocation truncated to fit: 
R_PPC_REL24 ide_init
arch/ppc/kernel/kernel.o: In function `pmac_ide_default_io_base':
arch/ppc/kernel/kernel.o(.text+0x7eb0): undefined reference to 
`pmac_ide_get_base'
arch/ppc/kernel/kernel.o(.text+0x7eb0): relocation truncated to fit: 
R_PPC_REL24 pmac_ide_get_base
arch/ppc/kernel/kernel.o: In function `find_ide_boot':
arch/ppc/kernel/kernel.o(.text.init+0x10dc): undefined reference to 
`pmac_find_ide_boot'
arch/ppc/kernel/kernel.o(.text.init+0x10dc): relocation truncated to fit: 
R_PPC_REL24 pmac_find_ide_boot
arch/ppc/kernel/kernel.o: In function `pmac_init':
arch/ppc/kernel/kernel.o(.text.init+0x12d2): undefined reference to 
`pmac_ide_init_hwif_ports'
arch/ppc/kernel/kernel.o(.text.init+0x12fe): undefined reference to 
`pmac_ide_init_hwif_ports'
make: *** [vmlinux] Error 1arch/ppc/kernel/kernel.o: In function 
`ide_pmac_init':
arch/ppc/kernel/kernel.o(.text+0x7d58): undefined reference to `ide_init'
arch/ppc/kernel/kernel.o(.text+0x7d58): relocation truncated to fit: 
R_PPC_REL24 ide_init
arch/ppc/kernel/kernel.o: In function `pmac_ide_default_io_base':
arch/ppc/kernel/kernel.o(.text+0x7eb0): undefined reference to 
`pmac_ide_get_base'
arch/ppc/kernel/kernel.o(.text+0x7eb0): relocation truncated to fit: 
R_PPC_REL24 pmac_ide_get_base
arch/ppc/kernel/kernel.o: In function `find_ide_boot':
arch/ppc/kernel/kernel.o(.text.init+0x10dc): undefined reference to 
`pmac_find_ide_boot'
arch/ppc/kernel/kernel.o(.text.init+0x10dc): relocation truncated to fit: 
R_PPC_REL24 pmac_find_ide_boot
arch/ppc/kernel/kernel.o: In function `pmac_init':
arch/ppc/kernel/kernel.o(.text.init+0x12d2): undefined reference to 
`pmac_ide_init_hwif_ports'
arch/ppc/kernel/kernel.o(.text.init+0x12fe): undefined reference to 
`pmac_ide_init_hwif_ports'
make: *** [vmlinux] Error 1

Config have:

#
# Platform support
#
CONFIG_PPC=y
CONFIG_6xx=y
# CONFIG_8xx is not set
CONFIG_PMAC=y
# CONFIG_PREP is not set
# CONFIG_CHRP is not set
# CONFIG_ALL_PPC is not set
# CONFIG_APUS is not set
# CONFIG_GEMINI is not set
# CONFIG_MBX is not set
# CONFIG_SMP is not set
CONFIG_ALTIVEC=y
CONFIG_MACH_SPECIFIC=y
CONFIG_POWERMAC=y

[......]

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_IDE=m
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_VIA82C586 is not set
# CONFIG_BLK_DEV_CMD646 is not set
# CONFIG_BLK_DEV_CS5530 is not set
CONFIG_BLK_DEV_SL82C105=y
CONFIG_BLK_DEV_IDE_PMAC=y
CONFIG_BLK_DEV_IDEDMA_PMAC=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_PMAC_IDEDMA_AUTO is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_STRIPED=m
CONFIG_MD_MIRRORING=m
CONFIG_MD_RAID5=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_BLK_DEV_XD is not set
CONFIG_BLK_DEV_DAC960=m
CONFIG_PARIDE_PARPORT=m
# CONFIG_PARIDE is not set
CONFIG_BLK_CPQ_DA=m
CONFIG_BLK_CPQ_CISS_DA=m
# CONFIG_BLK_DEV_HD is not set

[....]


Hmm, i don't known so much with ide subsystems, but if i can build modular 
subsystem on x86 i also could build it on ppc.

I also tried with ide.2.2.21.04022002.tar.gz. I must patched it because 
there was two unresolved symbols. One of them i fix, but second i can't. 

/usr/lib/modules/2.2.21-rc3/misc/ide-mod.o
depmod:       ide_init_hwif_ports

anyone compile it successful it on 2.2 ?

Krzysiek Taraszka

