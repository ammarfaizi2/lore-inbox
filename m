Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315375AbSEGH1L>; Tue, 7 May 2002 03:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315378AbSEGH1K>; Tue, 7 May 2002 03:27:10 -0400
Received: from spike.i-lan.nl ([62.12.29.156]:14852 "EHLO spike.i-lan.nl")
	by vger.kernel.org with ESMTP id <S315375AbSEGH1I>;
	Tue, 7 May 2002 03:27:08 -0400
Date: Tue, 7 May 2002 19:05:10 +0200 (CEST)
From: Ben Castricum <root@cia.c64.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre8 doesn't compile (missing skip_ioapic_setup)
Message-ID: <Pine.LNX.4.21.0205071902260.3449-100000@spike.i-lan.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Having a go at 2.4.19-pre8 gives me this error:

ld -m elf_i386 -T /usr/src/linux-2.4.19-pre8/arch/i386/vmlinux.lds -e
stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o
drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o
drivers/video/video.o \
        net/network.o \
        /usr/src/linux-2.4.19-pre8/arch/i386/lib/lib.a
/usr/src/linux-2.4.19-pre8/lib/lib.a
/usr/src/linux-2.4.19-pre8/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
init/main.o: In function `smp_init':
init/main.o(.text.init+0x59e): undefined reference to `skip_ioapic_setup'
arch/i386/kernel/kernel.o: In function `broken_pirq':
arch/i386/kernel/kernel.o(.text.init+0x3096): undefined reference to
`skip_ioapic_setup'
make: *** [vmlinux] Error 1


Not using local io-apic makes the problem (and the feature) go away. This
is on a uni-processor system with SMP disabled. Full .config at

http://spike.i-lan.nl/.config

Cheers,
Ben


