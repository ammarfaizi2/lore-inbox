Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQKDXHW>; Sat, 4 Nov 2000 18:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129040AbQKDXHM>; Sat, 4 Nov 2000 18:07:12 -0500
Received: from [216.151.155.116] ([216.151.155.116]:49934 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S129030AbQKDXHE>; Sat, 4 Nov 2000 18:07:04 -0500
To: linux-kernel@vger.kernel.org
Subject: Applying crypto patch to recent 2.2.18pre
From: Doug McNaught <doug@wireboard.com>
Date: 04 Nov 2000 18:07:03 -0500
Message-ID: <m3r94rnxpk.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to get an up-to-date stable kernel (2.2.18pre19, with
PowerPC changes, downloaded from the PowerPC BitKeeper archive)
compiled with the international patch (patch-int-2.2.17-9 which is the 
latest in the crypto/ directory).  The patch applies fine (with some
offsets, but all hunks succeed) but when linking vmlinux, I get the
following: 

ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head.o init/main.o init/version.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        fs/filesystems.a \
        net/network.a \
        drivers/block/block.a drivers/char/char.o drivers/misc/misc.a
drivers/net/net.a drivers/cdrom/cdrom.a drivers/sound/sounddrivers.o
drivers/pci/pci.a drivers/macintosh/macintosh.o drivers/video/video.a
\
        /usr/src/linuxppc_2_2/lib/lib.a \
        --end-group \
        -o vmlinux
init/main.o: In function `do_basic_setup':
init/main.o(.text.init+0x9f0): undefined reference to `cryptoapi_init'
init/main.o(.text.init+0x9f0): relocation truncated to fit: R_PPC_REL24 cryptoapi_init
drivers/block/block.a(loop_gen.o): In function `loop_gen_init2':
loop_gen.o(.text+0x104): undefined reference to `find_transform_by_id'
loop_gen.o(.text+0x104): relocation truncated to fit: R_PPC_REL24 find_transform_by_id
make: *** [vmlinux] Error 1

This happened somewhere between 2.2.18pre3 (which compiles
successfully with the 2.2.17 crypto patch) and vanilla (from
people/alan) pre9, which fails with the same error as above.

I'm guessing something changed in the conventions for subsystem
initialization.  If someone can give me a quick summary of what to
change, I'll try to fix it.  Otherwise I'll grovel through the
2.2.18pre patches and try to figure out what to do myself, but I'm not 
looking forward to that option...

Thanks in advance,
Doug
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
