Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312581AbSDXTxZ>; Wed, 24 Apr 2002 15:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312582AbSDXTxY>; Wed, 24 Apr 2002 15:53:24 -0400
Received: from alex.intersurf.net ([216.115.129.11]:9992 "HELO
	alex.intersurf.net") by vger.kernel.org with SMTP
	id <S312581AbSDXTxX>; Wed, 24 Apr 2002 15:53:23 -0400
Date: Wed, 24 Apr 2002 14:53:15 -0500
From: Mark Orr <markorr@intersurf.com>
To: linux-kernel@vger.kernel.org
Subject: IDE problem:  2.5.10 compiles but hangs during boot
Message-Id: <20020424145315.7331bef2.markorr@intersurf.com>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


System:  Pentium 100, 16mb, Neptune II chipset w/ RZ1000 IDE
         WD Caviar 2540 (540mb) HD,   NEC-260 IDE CD
         
Linux 2.5.10 compiles but doesnt complete boot due to some IDE
errors.    Previous working kernel was 2.5.8-pre3.

relevant bits from the boot messages:
---
ide0: disable chipset read-ahead (buggy RZ1000/RZ1001)
ide1: disable chipset read-ahead (buggy RZ1000/RZ1001)
hda: WDC AC2540H, ATA disk drive
hdc: NEC CD-ROM DRIVE:260, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide: unexpected interrupt 1 15
ide1 at 0x170-0x177,0x376 on irq 15
hda: 1056384 sectors (541Mb) w/128Kib cache CHS=1048/16/63
Partition check:
  hda: [PTBL] [524/32/64] hda1 hda2 hda3

(...some network stuff, then it runs fsck)

remounting root device with read-write enabled.
hda: task_mulout_intr: status=0x65 { DriveReady DriveFault CorrectedError Error}
hda: task_mulout_intr: error=0x04 {DriveStatusError}
ide: unexpected interrupt 0 14
ide0: reset: success

...and there it stops.
   
--

My kernel configuration is default, except IDE CDROM is modularized.


After receiving this error, I went back and disabled CMD640 and 
Generic PCI IDE support - which has compiled and worked in the past,
but it doesnt compile with this kernel version:

make[3]: Entering directory `/usr/src/linux/drivers/ide'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586   -DKBUILD_BASENAME=ide  -DEXPORT_SYMTAB -c ide.c
In file included from /usr/src/linux/include/linux/ide.h:238,
                 from ide.c:138:
/usr/src/linux/include/asm/ide.h: In function `ide_init_default_hwifs':
/usr/src/linux/include/asm/ide.h:84: warning: implicit declaration of function `ide_register_hw'
ide.c: In function `ide_unregister':
ide.c:2300: structure has no member named `pci_dev'
ide.c: In function `ide_teardown_commandlist':
ide.c:2845: structure has no member named `pci_dev'
make[3]: *** [ide.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/ide'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

--
