Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbTCDXdi>; Tue, 4 Mar 2003 18:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTCDXdi>; Tue, 4 Mar 2003 18:33:38 -0500
Received: from mail.gmx.net ([213.165.65.60]:49532 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265097AbTCDXdg>;
	Tue, 4 Mar 2003 18:33:36 -0500
Message-ID: <3E6538EF.3060602@gmx.net>
Date: Wed, 05 Mar 2003 00:38:23 +0100
From: Christian <evilninja@gmx.net>
Reply-To: evilninja@gmx.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3b) Gecko/20030210
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: CONFIG_ALPHA_SRM not compiling on 2.5
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

recently i decided to make an Alpha EV45 / Avanti here as a testbed for 
the latest 2.5 kernels. but it always fails to compile the kernel with

CONFIG_ALPHA_SRM=y

set. currently 2.4.20 is running stable with this option activiated.

having 2.5 compiled without SRM support, it won't boot (when 
initializing memory, first step after boot-select via aboot is done, it 
will get stuck.)

when compiling with SRM i get the following errors:
------------------------------------
lila:/usr/src/linux-2.5.x# make vmlinux
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=arch/alpha/kernel 
arch/alpha/kernel/asm-offsets.s
make[1]: »arch/alpha/kernel/asm-offsets.s« is up to date.
   Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
make -f scripts/Makefile.build obj=init
   Generating include/linux/compile.h (unchanged)
make -f scripts/Makefile.build obj=usr
make -f scripts/Makefile.build obj=arch/alpha/kernel
[...and so on...]
make -f scripts/Makefile.build obj=arch/alpha/lib
echo '  Generating build number'
   Generating build number
. ./scripts/mkversion > .tmp_version
mv -f .tmp_version .version
make -f scripts/Makefile.build obj=init
   Generating include/linux/compile.h (updated)
   gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mno-fp-regs -ffixed-8 -mcpu=ev4 -Wa,-mev6 -fomit-frame-pointer 
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=version 
-DKBUILD_MODNAME=version -c -o init/version.o init/version.c
    ld   -r -o init/built-in.o init/main.o init/version.o 
init/do_mounts.o init/initramfs.o
   	ld  -static -N  -T arch/alpha/vmlinux.lds.s arch/alpha/kernel/head.o 
   init/built-in.o --start-group  usr/built-in.o 
arch/alpha/kernel/built-in.o  arch/alpha/mm/built-in.o 
arch/alpha/math-emu/built-in.o  kernel/built-in.o  mm/built-in.o 
fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o 
lib/lib.a  arch/alpha/lib/lib.a  drivers/built-in.o  sound/built-in.o 
net/built-in.o --end-group  -o vmlinux
arch/alpha/kernel/built-in.o: In function `common_shutdown_1':
arch/alpha/kernel/built-in.o(.text+0x2508): undefined reference to 
`dummy_con'
arch/alpha/kernel/built-in.o(.text+0x251c): undefined reference to 
`take_over_console'
arch/alpha/kernel/built-in.o(.text+0x2520): undefined reference to 
`take_over_console'
make: *** [vmlinux] Error 1
lila:/usr/src/linux-2.5.x#
------------------------------------

gcc  v2.95.4
make v3.79.1
binutils 2.12.90.0.1
(all taken from debian/stable)

i have tried this since 2.5.51 (?), and up to 2.5.60 the error is still 
there. what could be wrong?

Thank you,
Christian.
-- 
############ Christian ##############
########## c_kujau@web.de ###########
#####################################

