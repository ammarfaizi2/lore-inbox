Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317915AbSFNOBx>; Fri, 14 Jun 2002 10:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317916AbSFNOBw>; Fri, 14 Jun 2002 10:01:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4480 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317915AbSFNOBv>; Fri, 14 Jun 2002 10:01:51 -0400
Date: Fri, 14 Jun 2002 10:02:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Robert Schwebel <robert@schwebel.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Accessing odd bytes
In-Reply-To: <20020614143140.A7467@schwebel.de>
Message-ID: <Pine.LNX.3.95.1020614094431.389A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2002, Robert Schwebel wrote:

> I have a strange effect on an embedded system (AMD Elan SC410,
> Linux-2.4.18) while accessing a static RAM.  The RAM is mapped to the bus
> at 0x0200'0000. If I map it to user space this way: 
> 
>   pSRAM  = (unsigned short *)mmap(0, 0x00040000, PROT_READ + PROT_WRITE, MAP_SHARED, FD, 0x2000000);
> 
> and fill it like this: 
> 
>   pByte=(char*)pSRAM;
>   for (i=0; i<10; i++) {
>     *pByte++=(char)i;
>   }
> 
>   pByte=(char*)pSRAM;
>   for (i=0; i<10; i++) {
>     printf("i: %02i -> %03i\n", i, *pByte++);
>   }
> 
> I see a mirroring effect: 
> 
>   i: 00 -> 001
>   i: 01 -> 001
>   i: 02 -> 003
>   i: 03 -> 003
>   i: 04 -> 005
>   i: 05 -> 005
>   i: 06 -> 007
>   i: 07 -> 007
>   i: 08 -> 009
>   i: 09 -> 009
> 
> Now I'm wondering how the kernel/processor handles odd byte access
> exceptions. Can anybody give me a pointer where I could search or what my
> problem could be? 
> 
> Robert

There are no odd-byte access exceptions in the SC410 or in any Intel
ix86 emulation. Word accesses at odd-byte boundaries may (not always)
simply take longer. You can access any size element at any alignment.
The only time you will get an exception is if you attempt to access
0xffffffff as a Word (and similar boundary errors).

>     printf("i: %02i -> %03i\n", i, *pByte++);

Now, I'm not smart enough to understand what this code is supposed
to show so I can't offer any suggestions. But, with all Intel machines,
the lowest byte is in the lowest memory address and the lowest word
is in the lowest memory address, etc.

Given:   0xdeadface

Memory:
<-- Low         High -->
0xce, 0xfa, 0xad, 0xde


Also, in 32-bit code, if you are going to pass a byte to a function,
the rest of the 32-bit value passed may be junk since you can't
push bytes onto the stack.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

