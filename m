Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315982AbSEGVnx>; Tue, 7 May 2002 17:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315983AbSEGVnw>; Tue, 7 May 2002 17:43:52 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:56032 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315982AbSEGVnv>; Tue, 7 May 2002 17:43:51 -0400
Date: Tue, 07 May 2002 15:40:35 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Adrian Bunk <bunk@fs.tum.de>, Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.14-dj1: misc.o: undefined reference to `__io_virt_debug'
Message-ID: <278490000.1020811234@flay>
In-Reply-To: <Pine.NEB.4.44.0205072137260.9347-100000@mimas.fachschaften.tu-muenchen.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Compiling misc.c with -O0 gives a better error message:
> 
> <--  snip  -->
> 
> ...
> ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o
> piggy.o
> misc.o: In function `outb_quad':
> misc.o(.text+0x289c): undefined reference to `__io_virt_debug'
> make[2]: *** [bvmlinux] Error 1
> make[2]: Leaving directory
> `/home/bunk/linux/kernel-2.5/linux-2.5.14-modular/arch/i386/boot/compressed'

Seems like you're not linking in lib/iodebug.c for some reason.

outb_quad calls readb, which calls __io_virt, which calls __io_virt_debug,
which is defined in iodebug.c

M.

