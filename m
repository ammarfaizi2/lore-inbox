Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318204AbSGQDuK>; Tue, 16 Jul 2002 23:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318205AbSGQDuJ>; Tue, 16 Jul 2002 23:50:09 -0400
Received: from mirapoint2.brutele.be ([212.68.193.7]:53803 "EHLO
	mirapoint2.brutele.be") by vger.kernel.org with ESMTP
	id <S318204AbSGQDuJ>; Tue, 16 Jul 2002 23:50:09 -0400
Date: Wed, 17 Jul 2002 05:52:56 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Error in 2.5.26 : xquad_portio
Message-Id: <20020717055256.761c90bb.stephane.wirtel@belgacom.net>
X-Mailer: Sylpheed version 0.8.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiler : gcc-3.1
CPU : Athlon-XP 2100+
-----------------------------------
CC = gcc-3.1
CFLAGS += "-mcpu=athlon-xp -march=athlon-xp"

I have found a small error in those 2 files :

The first file is arch/i386/boot/compressed/misc.c at line 124

123            #ifdef CONFIG_MULTIQUAD
124            static void * const xquad_portio = NULL;
125            #endif

And the second file is include/asm/io.h at line 306 

305            #ifdef CONFIG_MULTIQUAD
306            extern void * xquad_portio;    /* Where the IO area was mapped */
307            #endif /* CONFIG_MULTIQUAD */

i have a different declaration in the 2 files. and i have this error.

---------------------------------------------------------------------------------------------------

make[1]: Quitte le répertoire `/root/linux-test/linux-2.5.26/init'
  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o --start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o /root/linux-test/linux-2.5.26/arch/i386/lib/lib.a lib/lib.a /root/linux-test/linux-2.5.26/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
make[1]: Entre dans le répertoire `/root/linux-test/linux-2.5.26/arch/i386/boot'
  gcc-3.1 -Wp,-MD,./.setup.o.d -D__ASSEMBLY__ -D__KERNEL__ -I/root/linux-test/linux-2.5.26/include -nostdinc -iwithprefix include  -traditional -DSVGA_MODE=NORMAL_VGA  -D__BIG_KERNEL__  -c -o setup.o setup.S
/tmp/cc8Zc2qj.s: Messages de l'assembleur:
/tmp/cc8Zc2qj.s:1497: AVERTISSEMENT:value 0x37ffffff truncated to 0x37ffffff
  ld -m elf_i386  -Ttext 0x0 -s --oformat binary -e begtext setup.o -o setup 
make[2]: Entre dans le répertoire `/root/linux-test/linux-2.5.26/arch/i386/boot/compressed'
  gcc-3.1 -Wp,-MD,./.misc.o.d -D__KERNEL__ -I/root/linux-test/linux-2.5.26/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -nostdinc -iwithprefix include    -DKBUILD_BASENAME=misc   -c -o misc.o misc.c
misc.c:124: types conflictuels pour « xquad_portio »
/root/linux-test/linux-2.5.26/include/asm/io.h:306: déclaration précédente de « xquad_portio »
make[2]: *** [misc.o] Erreur 1
make[2]: Quitte le répertoire `/root/linux-test/linux-2.5.26/arch/i386/boot/compressed'
make[1]: *** [compressed/vmlinux] Erreur 2
make[1]: Quitte le répertoire `/root/linux-test/linux-2.5.26/arch/i386/boot'
make: *** [bzImage] Erreur 2
bash-2.05a# 
---------------------------------------------------------------------------------------------------

Bye

Stephane Wirtel
