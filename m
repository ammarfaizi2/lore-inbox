Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265981AbSKDIAJ>; Mon, 4 Nov 2002 03:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbSKDIAJ>; Mon, 4 Nov 2002 03:00:09 -0500
Received: from gzp11.gzp.hu ([212.40.96.53]:65296 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id <S265981AbSKDIAH>;
	Mon, 4 Nov 2002 03:00:07 -0500
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: Re: 2.4.20-rc1 [SCSI] local symbols in discarded section .text.exit
References: <acb.3dc624fd.65ec7@gzp1.gzp.hu>
Organization: Who, me?
User-Agent: tin/1.5.15-20021023 ("Soil") (UNIX) (Linux/2.4.20-rc1 (i686))
Message-ID: <1155.3dc62a8f.b93b4@gzp1.gzp.hu>
Date: Mon, 04 Nov 2002 08:06:39 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Gabor Z. Papp <gzp@myhost.mynet>:

| Linux 2.4.20-rc1
| glibc 2.2.5
| gcc 2.95.4
| GNU ld version 2.13.90.0.10 20021010
| 
| make[1]: Leaving directory `/usr/src/linux-2.4.20-rc1-ibm/arch/i386/lib'
| ld -m elf_i386 -T /usr/src/linux-2.4.20-rc1-ibm/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o init/do_mounts.o \
|        --start-group \
|        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
|         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/scsi/scsidrv.o drivers/pci/driver.o drivers/video/video.o \
|        net/network.o \
|        /usr/src/linux-2.4.20-rc1-ibm/arch/i386/lib/lib.a /usr/src/linux-2.4.20-rc1-ibm/lib/lib.a /usr/src/linux-2.4.20-rc1-ibm/arch/i386/lib/lib.a \
|        --end-group \
|        -o vmlinux
| drivers/scsi/scsidrv.o(.data+0x3ad4): undefined reference to `local symbols in discarded section .text.exit'
| drivers/scsi/scsidrv.o(.data+0x3b14): undefined reference to `local symbols in discarded section .text.exit'
| drivers/scsi/scsidrv.o(.data+0x3b54): undefined reference to `local symbols in discarded section .text.exit'
| make: *** [vmlinux] Error 1
| 
| #
| # Automatically generated make config: don't edit
| #
| CONFIG_X86=y
[...]
| CONFIG_SCSI_IPS=y
[...]

Keith Owens wrote a nice perl script to debug, found on http://kernelnewbies.org/scripts/

$ reference_discarded.pl 
Finding objects, 396 objects, ignoring 0 module(s)
Finding conglomerates, ignoring 31 conglomerate(s)
Scanning objects
Error: ./drivers/scsi/ips.o .data refers to 000000d4 R_386_32          .text.exit
Error: ./drivers/scsi/ips.o .data refers to 00000114 R_386_32          .text.exit
Error: ./drivers/scsi/ips.o .data refers to 00000154 R_386_32          .text.exit
Done

Seems like its the IBM ServeRAID support.

