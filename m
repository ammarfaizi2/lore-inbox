Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315956AbSEGTtc>; Tue, 7 May 2002 15:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315957AbSEGTtb>; Tue, 7 May 2002 15:49:31 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:46074 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315956AbSEGTtb>; Tue, 7 May 2002 15:49:31 -0400
Date: Tue, 7 May 2002 21:44:41 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.14-dj1: misc.o: undefined reference to `__io_virt_debug'
In-Reply-To: <20020507205523.D12134@suse.de>
Message-ID: <Pine.NEB.4.44.0205072137260.9347-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2002, Dave Jones wrote:

> On Tue, May 07, 2002 at 08:36:09PM +0200, Adrian Bunk wrote:
>
>  > misc.o: In function `puts':
>  > misc.o(.text+0x1c46): undefined reference to `__io_virt_debug'
>  > misc.o(.text+0x1c7c): undefined reference to `__io_virt_debug'
>  > misc.o(.text+0x1ca9): undefined reference to `__io_virt_debug'
>  > misc.o(.text+0x1cde): undefined reference to `__io_virt_debug'
>
> Odd. Repeatable after a make distclean ?

Yes, it's repeatable with a clean kernel source.

> I always build my test kernels with CONFIG_DEBUG_IOVIRT=y, and I
> haven't seen this happen.

But you build without CONFIG_MULTIQUAD?

Compiling misc.c with -O0 gives a better error message:

<--  snip  -->

...
ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o
piggy.o
misc.o: In function `outb_quad':
misc.o(.text+0x289c): undefined reference to `__io_virt_debug'
make[2]: *** [bvmlinux] Error 1
make[2]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.14-modular/arch/i386/boot/compressed'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

