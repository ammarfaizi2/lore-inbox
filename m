Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263123AbVHEVdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263123AbVHEVdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVHEVdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:33:09 -0400
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:7569 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S263109AbVHEVbH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:31:07 -0400
Date: Fri, 5 Aug 2005 23:30:04 +0200 (CEST)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] remove support for gcc < 3.2
In-Reply-To: <20050805211410.GE7464@lug-owl.de>
Message-ID: <Pine.LNX.4.60.0508052328040.21975@kepler.fjfi.cvut.cz>
References: <20050731222606.GL3608@stusta.de> <21d7e99705080318347d6b58d5@mail.gmail.com>
 <20050804065447.GB25606@lug-owl.de> <20050804203831.GD4029@stusta.de>
 <20050805211410.GE7464@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Aug 2005, Jan-Benedict Glaw wrote:

> On Thu, 2005-08-04 22:38:31 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> > On Thu, Aug 04, 2005 at 08:54:47AM +0200, Jan-Benedict Glaw wrote:
> > >...
> > > Current GCC from CVS (plus minor configury patches) seems to work. We
> > > had -fno-unit-at-a-time missing in our arch Makefile which hides a bug
> > > in kernel's sources.
> > > 
> > > I guess that if you remove -fno-unit-at-a-time from i386 and use a
> > > current GCC, you'll run into that fun, too.
> > 
> > What bug exactly?
> 
> -fno-unit-at-a-time grounded:
> 
> jbglaw@d2:~/test_gcc/linux-2.6.13-rc5-git3$ grep fno-unit-at arch/i386/Makefile 
> # CFLAGS += $(call cc-option,-fno-unit-at-a-time)
> 
> For presenting it, I built a gcc right from CVS:
> 
> jbglaw@d2:~/test_gcc/linux-2.6.13-rc5-git3$ i486-linux-gcc -v
> Using built-in specs.
> Target: i486-linux
> Configured with: /home/jbglaw/vax-linux/scm/build-20050802-192552-i486-linux/src/gcc/configure --disable-multilib --with-newlib --disable-nls --enable-threads=no --disable-threads --enable-symvers=gnu --enable-__cxa_atexit --disable-shared --target=i486-linux --prefix=/home/jbglaw/vax-linux/scm/build-20050802-192552-i486-linux/install/usr --enable-languages=c
> Thread model: single
> gcc version 4.1.0 20050802 (experimental)
> 
> ...and here you can see it explode even on i386:
> 
> jbglaw@d2:~/test_gcc/linux-2.6.13-rc5-git3$ make CC=i486-linux-gcc V=1 bzImage
> [...]
>   CHK     include/asm-i386/asm_offsets.h
> make -f scripts/Makefile.build obj=init
>   i486-linux-gcc -Wp,-MD,init/.main.o.d  -nostdinc -isystem /home/jbglaw/vax-linux/scm/build-20050802-192552-i486-linux/install/usr/lib/gcc/i486-linux/4.1.0/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -O2     -fomit-frame-pointer -pipe -msoft-float -mpreferred-stack-boundary=2 -march=i686 -mtune=pentium4 -Iinclude/asm-i386/mach-default -Wdeclaration-after-statement -Wno-pointer-sign    -DKBUILD_BASENAME=main -DKBUILD_MODNAME=main -c -o init/main.o init/main.c
> init/main.c:415: error: tmp_cmdline causes a section type conflict
> init/main.c:414: error: done causes a section type conflict
> init/main.c:536: error: initcall_debug causes a section type conflict
> include/asm/bugs.h:35: error: __setup_str_no_halt causes a section type conflict
> include/asm/bugs.h:43: error: __setup_str_mca_pentium causes a section type conflict
> include/asm/bugs.h:52: error: __setup_str_no_387 causes a section type conflict
> init/main.c:146: error: __setup_str_nosmp causes a section type conflict
> init/main.c:154: error: __setup_str_maxcpus causes a section type conflict
> init/main.c:211: error: __setup_str_debug_kernel causes a section type conflict
> init/main.c:212: error: __setup_str_quiet_kernel causes a section type conflict
> init/main.c:220: error: __setup_str_loglevel causes a section type conflict
> init/main.c:298: error: __setup_str_init_setup causes a section type conflict
> init/main.c:543: error: __setup_str_initcall_debug_setup causes a section type conflict
> make[1]: *** [init/main.o] Error 1
> make: *** [init] Error 2

I guess kernel may not yet be ready to be compiled by the latest CVS GCC 
4.1.x (currently HEAD). But it should (at least works for me) do the 
latest CVS GCC 4.0.x.

Martin
