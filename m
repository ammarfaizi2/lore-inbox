Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271767AbRH1Wur>; Tue, 28 Aug 2001 18:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271742AbRH1Wuh>; Tue, 28 Aug 2001 18:50:37 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:7111 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S271738AbRH1WuU>; Tue, 28 Aug 2001 18:50:20 -0400
Date: Wed, 29 Aug 2001 00:57:40 +0200 (CEST)
From: Pascal Schmidt <pleasure.and.pain@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: Can't compile HiSaX into 2.2.20pre9 kernel
Message-ID: <Pine.LNX.4.33.0108290052010.8607-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all!

I get an error message during 'make bzImage' when I try to compile
2.2.20pre9 with the HiSax ISDN driver included (it works with HiSax as
module):

ld -m elf_i386 -T /usr/src/linux-2.2.20pre9/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
        fs/filesystems.a \
        net/network.a \
        drivers/block/block.a drivers/char/char.o drivers/misc/misc.a
drivers/isdn/isdn.a drivers/net/net.a drivers/scsi/scsi.a
drivers/cdrom/cdrom.a drivers/sound/sounddrivers.o drivers/pci/pci.a
drivers/video/video.a \
        /usr/src/linux-2.2.20pre9/arch/i386/lib/lib.a
/usr/src/linux-2.2.20pre9/lib/lib.a
/usr/src/linux-2.2.20pre9/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
init/main.o(.data.init+0x39c): undefined reference to `HiSax_setup'
init/main.o(.data.init+0x3a4): undefined reference to `HiSax_setup'
make: *** [vmlinux] Error 1

The strange thing is, the drivers/isdn/isdn.a included above defines
the symbol:

/usr/src/linux-2.2.20pre9 # nm -a drivers/isdn/isdn.a | grep HiSax_setup
0000043c t HiSax_setup

I have no idea what goes wrong here. It works as expected with 2.2.19.

I did:
bzcat ../pre-patch-2.2.0-9.bz2 | patch -p1
make clean
make mrproper
cp ../linux-2.2.19/.config .
make oldconfig
make dep
make bzImage

-- 
Ciao, Pascal

-<[ pharao90@tzi.de, netmail 2:241/215.72, home http://cobol.cjb.net/) ]>-

