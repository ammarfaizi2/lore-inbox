Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbTCEMv7>; Wed, 5 Mar 2003 07:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbTCEMv7>; Wed, 5 Mar 2003 07:51:59 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:30663 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S266161AbTCEMv5>;
	Wed, 5 Mar 2003 07:51:57 -0500
Date: Wed, 5 Mar 2003 14:02:22 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: 2.5.64 build doesn't abort on link failure
Message-ID: <Pine.GSO.4.21.0303051353350.23176-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In 2.5.64, the kernel build process doesn't abort if the linking stage fails:

|   	m68k-linux-ld -m m68kelf -T arch/m68k/vmlinux.lds.s arch/m68k/kernel/head.o   init/built-in.o --start-group  usr/built-in.o  arch/m68k/kernel/built-in.o  arch/m68k/mm/built-in.o  arch/m68k/q40/built-in.o  arch/m68k/amiga/built-in.o  arch/m68k/atari/built-in.o  arch/m68k/mac/built-in.o  arch/m68k/hp300/built-in.o  arch/m68k/apollo/built-in.o  arch/m68k/mvme147/built-in.o  arch/m68k/mvme16x/built-in.o  arch/m68k/bvme6000/built-in.o  arch/m68k/sun3x/built-in.o  arch/m68k/sun3/built-in.o  arch/m68k/fpsp040/built-in.o  arch/m68k/ifpsp060/built-in.o  arch/m68k/math-emu/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/m68k/lib/lib.a  drivers/built-in.o  sound/built-in.o  net/built-in.o --end-group  -o vmlinux
| drivers/built-in.o: In function `atari_scsi_queue_command':
| drivers/built-in.o(.text+0x5974c): undefined reference to `update_timeout'

In 2.5.63, the build process was aborted here, but in 2.5.64 it continues with:

| m68k-linux-nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw] \)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
| m68k-linux-nm: vmlinux: No such file or directory
| cp vmlinux vmlinux.tmp
| cp: cannot stat `vmlinux': No such file or directory
| make: *** [vmlinux.gz] Error 1
| tux$ 

which obviously fails.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

