Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbVJYHfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbVJYHfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 03:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbVJYHfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 03:35:06 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:672 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751483AbVJYHfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 03:35:05 -0400
Message-ID: <435DE018.5000902@droids-corp.org>
Date: Tue, 25 Oct 2005 09:34:48 +0200
From: Olivier MATZ <zer0@droids-corp.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Makefile : can I use both "O=" and "M=" ?
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When compiling an external module, is it possible to use both 'O=...'
and 'M=...' in the make command line ?

Here is an example :

[matz@barracuda linux-2.6.13.4]$ pwd
/usr/local/src/linux-2.6.13.4
[matz@barracuda linux-2.6.13.4]$ make V=1 M=~/module_helloworld
mkdir -p /home/matz/module_helloworld/.tmp_versions
make -f scripts/Makefile.build obj=/home/matz/module_helloworld
   rm -f /home/matz/module_helloworld/built-in.o; ar rcs
/home/matz/module_helloworld/built-in.o
  gcc -m32 -Wp,-MD,/home/matz/module_helloworld/.helloworld.o.d
-nostdinc -isystem /usr/lib/gcc-lib/i386-redhat-linux/3.3.3/include
-D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs
-fno-strict-aliasing -fno-common -ffreestanding -O2 -fomit-frame-pointer
-g -pipe -msoft-float -mpreferred-stack-boundary=2  -march=i686
-mregparm=3 -Iinclude/asm-i386/mach-default
-Wdeclaration-after-statement    -DMODULE -DKBUILD_BASENAME=helloworld
-DKBUILD_MODNAME=helloworld -c -o
/home/matz/module_helloworld/helloworld.o
/home/matz/module_helloworld/helloworld.c
  Building modules, stage 2.
make -rR -f /usr/local/src/linux-2.6.13.4/scripts/Makefile.modpost
  scripts/mod/modpost   -i /usr/local/src/linux-2.6.13.4/Module.symvers
vmlinux /home/matz/module_helloworld/helloworld.o
  gcc -m32 -Wp,-MD,/home/matz/module_helloworld/.helloworld.mod.o.d
-nostdinc -isystem /usr/lib/gcc-lib/i386-redhat-linux/3.3.3/include
-D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs
-fno-strict-aliasing -fno-common -ffreestanding -O2 -fomit-frame-pointer
-g -pipe -msoft-float -mpreferred-stack-boundary=2  -march=i686
-mregparm=3 -Iinclude/asm-i386/mach-default
-Wdeclaration-after-statement     -DKBUILD_BASENAME=helloworld
-DKBUILD_MODNAME=helloworld -DMODULE -c -o
/home/matz/module_helloworld/helloworld.mod.o
/home/matz/module_helloworld/helloworld.mod.c
  ld -m elf_i386 -m elf_i386 -r -o
/home/matz/module_helloworld/helloworld.ko
/home/matz/module_helloworld/helloworld.o
/home/matz/module_helloworld/helloworld.mod.o


Now imagine /home/matz is read-only, and I want to generate the objects
file in /tmp :

[matz@barracuda linux-2.6.13.4]$ make V=1 M=~/module_helloworld O=/tmp
make -C /tmp            \
KBUILD_SRC=/usr/local/src/linux-2.6.13.4             KBUILD_VERBOSE=1   \
KBUILD_CHECK= KBUILD_EXTMOD="/home/matz/module_helloworld"      \
        -f /usr/local/src/linux-2.6.13.4/Makefile _all
/usr/local/src/linux-2.6.13.4/Makefile:485: .config: No such file or
directory
mkdir -p /home/matz/module_helloworld/.tmp_versions

  WARNING: Symbol version dump /tmp/Module.symvers
           is missing; modules will have no dependencies and modversions.

make -f /usr/local/src/linux-2.6.13.4/scripts/Makefile.build
obj=/home/matz/module_helloworld
  gcc -m32 -Wp,-MD,/home/matz/module_helloworld/.helloworld.o.d
-nostdinc -isystem /usr/lib/gcc-lib/i386-redhat-linux/3.3.3/include
-D__KERNEL__ -Iinclude -Iinclude2
-I/usr/local/src/linux-2.6.13.4/include  -I/home/matz/module_helloworld
-Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -ffreestanding -O2 -fomit-frame-pointer -pipe -msoft-float
-mpreferred-stack-boundary=2
-I/usr/local/src/linux-2.6.13.4/include/asm-i386/mach-default
-Iinclude/asm-i386/mach-default -Wdeclaration-after-statement -DMODULE
-DKBUILD_BASENAME=helloworld -DKBUILD_MODNAME=helloworld -c -o
/home/matz/module_helloworld/helloworld.o
/home/matz/module_helloworld/helloworld.c
/bin/sh: line 1: scripts/basic/fixdep: No such file or directory
make[2]: *** [/home/matz/module_helloworld/helloworld.o] Error 1
make[1]: *** [_module_/home/matz/module_helloworld] Error 2
make: *** [_all] Error 2

Is it a bug or this is not supposed to work ?

Thanks & regards
Olivier

