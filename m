Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267735AbTBKLE3>; Tue, 11 Feb 2003 06:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267769AbTBKLEN>; Tue, 11 Feb 2003 06:04:13 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:58372 "HELO k2.dsa-ac.de")
	by vger.kernel.org with SMTP id <S267735AbTBKLCc>;
	Tue, 11 Feb 2003 06:02:32 -0500
Date: Tue, 11 Feb 2003 12:12:15 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.60 linking error with IDE-DMA disabled
Message-ID: <Pine.LNX.4.33.0302111207080.1173-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

If I try to compile the kernel with IDE bus-mastering disabled (which,
IIRC, worked on 2.4.x), I get the following error:

  	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o
--start-group  usr/built-in.o  arch/i386/kernel/built-in.o
arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a
drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o
net/built-in.o --end-group  -o .tmp_vmlinux1
drivers/built-in.o: In function `init_dma_generic':
drivers/built-in.o(.text+0x28dce): undefined reference to `ide_setup_dma'
drivers/built-in.o: In function `ide_hwif_setup_dma':
drivers/built-in.o(.text+0x357c8): undefined reference to `ide_setup_dma'
make[1]: *** [.tmp_vmlinux1] Error 1

The relevant section of .config:

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_BLK_DEV_IDEDMA_PCI is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA is not set
# CONFIG_BLK_DEV_ADMA is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_IDE_CHIPSETS is not set

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

