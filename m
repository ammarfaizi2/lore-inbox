Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSEGWFD>; Tue, 7 May 2002 18:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSEGWFC>; Tue, 7 May 2002 18:05:02 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:49389 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314278AbSEGWEe>; Tue, 7 May 2002 18:04:34 -0400
Date: Tue, 07 May 2002 16:00:56 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: Adrian Bunk <bunk@fs.tum.de>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.14-dj1: misc.o: undefined reference to `__io_virt_debug'
Message-ID: <281270000.1020812456@flay>
In-Reply-To: <3CD84BA9.95B3E482@didntduck.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Compiling misc.c with -O0 gives a better error message:
>> > 
>> > <--  snip  -->
>> > 
>> > ...
>> > ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o
>> > piggy.o
>> > misc.o: In function `outb_quad':
>> > misc.o(.text+0x289c): undefined reference to `__io_virt_debug'
>> > make[2]: *** [bvmlinux] Error 1
>> > make[2]: Leaving directory
>> > `/home/bunk/linux/kernel-2.5/linux-2.5.14-modular/arch/i386/boot/compressed'
>> 
>> Seems like you're not linking in lib/iodebug.c for some reason.
>> 
>> outb_quad calls readb, which calls __io_virt, which calls __io_virt_debug,
>> which is defined in iodebug.c
> 
> It's in the boot decompression code, before any of that stuff is
> available.  I'm working on a patch.

Is this arch/i386/boot/compressed/misc.c ?
I can't see how it would be doing outb_quad, and even if it was, it
would be totally pointless, as xquad_portio isn't set yet ....

M.

