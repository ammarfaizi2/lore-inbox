Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSJARZA>; Tue, 1 Oct 2002 13:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262498AbSJARYq>; Tue, 1 Oct 2002 13:24:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34029 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262502AbSJARYV>; Tue, 1 Oct 2002 13:24:21 -0400
Date: Tue, 1 Oct 2002 19:29:43 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
In-Reply-To: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com>
Message-ID: <Pine.NEB.4.44.0210011924070.10143-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.39 to v2.5.40
> ============================================
>...
> Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
>...
>   o kbuild: Make KBUILD_VERBOSE=0 work better under emacs
>...

This change is broken, it has the effect that compilation no longer stops
when the compilation of a .c file fails, kbuild doesn't stop the
compilation until it misses the .o when linking, e.g. (the directory is
still called "2.5.39" because I forgot to change the name after applying
patch-2.5.40 but this is 2.5.40):

<--  snip  -->

...
  gcc -Wp,-MD,./.idt77252.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2
.5.39-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -I/home/bunk/linux/kernel-2.5/linux-2.5.39-full/arch/i386/mach-generic
-nostdinc -iwithprefix include  -g  -DKBUILD_BASENAME=idt77252   -c -o
idt77252.o idt77252.c
drivers/atm/idt77252.c: In function `alloc_scq':
drivers/atm/idt77252.c:669: warning: unsigned int format, different type arg (arg 5)
drivers/atm/idt77252.c: In function `idt77252_interrupt':
drivers/atm/idt77252.c:2899: warning: implicit declaration of function `queue_task'
drivers/atm/idt77252.c:2899: `tq_immediate' undeclared (first use in this function)
drivers/atm/idt77252.c:2899: (Each undeclared identifier is reported only once
drivers/atm/idt77252.c:2899: for each function it appears in.)
drivers/atm/idt77252.c:2900: warning: implicit declaration of function `mark_bh'
drivers/atm/idt77252.c:2900: `IMMEDIATE_BH' undeclared (first use in this function)
  gcc -Wp,-MD,./.idt77105.o.d -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2
.5.39-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=k6
-I/home/bunk/linux/kernel-2.5/linux-2.5.39-full/arch/i386/mach-generic
-nostdinc -iwithprefix include  -g  -DKBUILD_BASENAME=idt77105   -c -o
idt77105.o idt77105.c
...
  gcc -Wp,-MD,./.fore200e_pca_fw.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/
linux-2.5.39-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=k6
-I/home/bunk/linux/kernel-2.5/linux-2.5.39-full/arch/i386/mach-generic
 -nostdinc -iwithprefix include  -g  -DKBUILD_BASENAME=fore200e_pca_fw
-c -o fore200e_pca_fw.o fore200e_pca_fw.c
  ld -m elf_i386  -r -o fore_200e.o fore200e.o fore200e_pca_fw.o
   ld -m elf_i386  -r -o built-in.o atmdev_init.o eni.o suni.o zatm.o
uPD98402.o
 nicstar.o idt77252.o idt77105.o horizon.o ambassador.o atmtcp.o iphase.o
firestream.o lanai.o fore_200e.o
ld: cannot open idt77252.o: No such file or directory
make[2]: *** [built-in.o] Error 1
make[2]: Leaving directory `/home/bunk/linux/kernel-2.5/linux-2.5.39-full/drivers/atm'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

