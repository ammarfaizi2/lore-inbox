Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316891AbSFVUHr>; Sat, 22 Jun 2002 16:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316892AbSFVUHq>; Sat, 22 Jun 2002 16:07:46 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:41707 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316891AbSFVUHp>; Sat, 22 Jun 2002 16:07:45 -0400
Date: Sat, 22 Jun 2002 15:07:46 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: sean darcy <seandarcy@hotmail.com>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: piggy broken in 2.5.24 build
In-Reply-To: <3D14B6DA.7090609@hotmail.com>
Message-ID: <Pine.LNX.4.44.0206221501430.7338-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2002, sean darcy wrote:

> At the end of make bzImage I get:
> 
> > make[2]: Entering directory `/opt/kernel/linux-2.5.24/arch/i386/boot/compressed'
> > tmppiggy=_tmp_$$piggy; \
> > rm -f $tmppiggy $tmppiggy.gz $tmppiggy.lnk; \
> > objcopy -O binary -R .note -R .comment -S /opt/kernel/linux-2.5.24/vmlinux $tmppiggy; \
> > gzip -f -9 < $tmppiggy > $tmppiggy.gz; \
> > echo "SECTIONS { .data : { input_len = .; LONG(input_data_end - input_data) input_data = .; *(.data) input_data_end = .; }}" > $tmppiggy.lnk; \
> > ld -m elf_i386 -r -o piggy.o -b binary $tmppiggy.gz -b elf32-i386 -T $tmppiggy.lnk; \
> > rm -f $tmppiggy $tmppiggy.gz $tmppiggy.lnk
> > /bin/sh: _tmp_18313piggy: No such file or directory
> > ld: cannot open _tmp_18313piggy.gz: No such file or directory
> > gcc -D__ASSEMBLY__ -D__KERNEL__ -I/opt/kernel/linux-2.5.24/include -traditional -c head.S
> > gcc -D__KERNEL__ -I/opt/kernel/linux-2.5.24/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DKBUILD_BASENAME=misc -c misc.c
> > ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o piggy.o
> > ld: cannot open piggy.o: No such file or directory
> > make[2]: *** [bvmlinux] Error 1
> > make[2]: Leaving directory `/opt/kernel/linux-2.5.24/arch/i386/boot/compressed'
> > make[1]: *** [compressed/bvmlinux] Error 2
> > make[1]: Leaving directory `/opt/kernel/linux-2.5.24/arch/i386/boot'
> > make: *** [bzImage] Error 2

At least I didn't break it, for a change. For all I can tell, the link of
piggy.o fails, since the _tmp_xx.gz doesn't exist. That again doesn't 
exist since the _tmp_xx does not exist when gzipping it.

So the question is why does the objcopy ... line not generate the tmp_xx
file. I don't see it spitting out any error either, but could you check
the obvious, like remaining free space on that filesystem and /tmp?

BTW: I just rewrote that part so that it would at least properly stop at 
the place where the error occurs, but that still leaves the question as to
what the actual error in your case is.

> Can I boot with just vmlinux?

Not unless you have a bootloader which supports that (i.e.: No.)

--Kai



