Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267246AbTBRAuC>; Mon, 17 Feb 2003 19:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267424AbTBRAuC>; Mon, 17 Feb 2003 19:50:02 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:59070 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267246AbTBRAt7>; Mon, 17 Feb 2003 19:49:59 -0500
Date: Mon, 17 Feb 2003 18:58:52 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.62: Cross-building broken
In-Reply-To: <20030218003410.A27937@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0302171854090.5217-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2003, Russell King wrote:

> Cross-building ARM from HPPA:
> 
> $ make config CROSS_COMPILE=/home/rmk/bin/arm-linux- ARCH=arm
> make: Entering directory `/home/rmk/v2.5/linux-rpc'
> make -f scripts/Makefile.build obj=scripts
>   gcc -Wp,-MD,scripts/.empty.o.d -D__KERNEL__ -Iinclude -Wall
>  -Wstrict-prototypes -Wno-trigraphs -Os -fno-strict-aliasing -fno-common
>  -mshort-load-bytes -msoft-float -Wa,-mno-fpu -Uarm -nostdinc -iwithprefix
>  include    -DKBUILD_BASENAME=empty -DKBUILD_MODNAME=empty -c -o
>  scripts/empty.o scripts/empty.c
> make: Leaving directory `/home/rmk/v2.5/linux-rpc'
> cc1: Invalid option `short-load-bytes'
> make[1]: *** [scripts/empty.o] Error 1
> make: *** [scripts] Error 2
> 
> We seem to be using the wrong compiler here, or the wrong CFLAGS.

That's indeed really weird, it's using the wrong compiler.

[kai@vaio linux-2.5.make]$ make config CROSS_COMPILE="ccache " arch=ARM
make -f scripts/Makefile.build obj=scripts
  ccache gcc -Wp,-MD,scripts/.empty.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2  -Iinclude/asm-i386/mach-default 
-nostdinc -iwithprefix include
   -DKBUILD_BASENAME=empty -DKBUILD_MODNAME=empty -c -o scripts/empty.o 
scripts/empty.c
  scripts/mk_elfconfig < scripts/empty.o > scripts/elfconfig.h
  gcc -Wp,-MD,scripts/.file2alias.o.d -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer   -c -o scripts/file2alias.o scripts/file2alias.c

That's not a true cross compiler, but as you can see, it uses
"ccache gcc" for empty.o, i.e. the target compiler, and 
"gcc" for the host program file2alias.o, and the right flags, 
respectively. So I'm lost - does it work if you explicitly set
make CC=/home/rmk/bin/arm-linux-gcc ...?

--Kai


