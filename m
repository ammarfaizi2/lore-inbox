Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315984AbSEGVsn>; Tue, 7 May 2002 17:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315985AbSEGVsm>; Tue, 7 May 2002 17:48:42 -0400
Received: from quark.didntduck.org ([216.43.55.190]:59653 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S315984AbSEGVsm>; Tue, 7 May 2002 17:48:42 -0400
Message-ID: <3CD84BA9.95B3E482@didntduck.org>
Date: Tue, 07 May 2002 17:48:25 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: Adrian Bunk <bunk@fs.tum.de>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.14-dj1: misc.o: undefined reference to `__io_virt_debug'
In-Reply-To: <Pine.NEB.4.44.0205072137260.9347-100000@mimas.fachschaften.tu-muenchen.de> <278490000.1020811234@flay>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> > Compiling misc.c with -O0 gives a better error message:
> >
> > <--  snip  -->
> >
> > ...
> > ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o
> > piggy.o
> > misc.o: In function `outb_quad':
> > misc.o(.text+0x289c): undefined reference to `__io_virt_debug'
> > make[2]: *** [bvmlinux] Error 1
> > make[2]: Leaving directory
> > `/home/bunk/linux/kernel-2.5/linux-2.5.14-modular/arch/i386/boot/compressed'
> 
> Seems like you're not linking in lib/iodebug.c for some reason.
> 
> outb_quad calls readb, which calls __io_virt, which calls __io_virt_debug,
> which is defined in iodebug.c

It's in the boot decompression code, before any of that stuff is
available.  I'm working on a patch.

--

				Brian Gerst
