Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSGMOQ7>; Sat, 13 Jul 2002 10:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSGMOQ6>; Sat, 13 Jul 2002 10:16:58 -0400
Received: from pl312.nas911.n-yokohama.nttpc.ne.jp ([210.139.38.56]:39108 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S313638AbSGMOQ5>;
	Sat, 13 Jul 2002 10:16:57 -0400
Message-ID: <3D303700.5030002@yk.rim.or.jp>
Date: Sat, 13 Jul 2002 23:19:44 +0900
From: Chiaki <ishikawa@yk.rim.or.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Q: boot time memory region recognition and clearing.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I have found that the particular motherboard (and memory sticks)
>> that I use at home tends to generate bogus memory problem 
>> warning messages when I use ecc module.
>> Motherboard is Gigabyte 7XIE4 that uses AMD751.
>> (Yes, AMD has now provides AMD76x series chipset for
>> newer CPUs.)
>> 
>> I say "bogus" because I have tested the hardware
>> many times using memtest86 and found that it doesn't
>> detect any memory errors even 
>
>memtest86 isnt (except on the very very latest versions) aware of ECC.
>It sees the memory after the ECC rescues minor errors so if the RAM has
>
>errors but ECC just about saves you it will show up clean
>
Thank you for the info on the latest memtest86.
I will check out.

It might as well be the case that memtest86 (previous versions)
was not quite ECC-aware.

I was not clear on the type of error messages
I received from ecc.o module.
I got both SBE (single bit error detected and corrected)
and MBE (multiple bits error detected,
which presumably was not correctable!).

My point was that there is something amiss
if memtest86 doesn't report errors due to
underlying (hardware) ECC fix,
but the why ecc.o module does.

In any case, I will run memtest86 (the latest version).
Thank you again for the info.

In the meantime, after posting the previous message
I read the Documentation/i386/boot.txt, etc..

It seems that by the time setup.c was called
the kernel was already 32bit linear addressing mode.
The table I mentioned as BIOS-supplied was not
quite directly supplied by BIOS.
The table was supplied by the routines that collect
BIOS data and the routines are in setup.S.
The collected information is placed in a memory area
which is passed from the early boot code to the
following boot pass: it seems that the triplet-table
I metioned is placed in the so called zero-page during
the whole boot process.

What I would probably need is to hack boot/setup.S and
if that may have a danger of making setup.S too large (and
I think so considering what setup.c does to clean up
bogus BIOS-supplied memory info), I would need to
tinker with one of the two hooks mentioned in the boot.txt
by letting loader (my case being loadlin.exe under DOS )
to prepare a hook to do the kind of writing I have in mind.

But this is not going to be a weekend job that I hope it would
be. I would need to tinker with two different programs: loader and
kernel startup code.

But any comment to my original post and other avenue
to achieve similar result welcome.
(Maybe  the high reliability computing people
have a better idea short of replacement BIOS  or
even have some prototype code working on this?
Hmm. Come to think of it, maybe I can take
the part of free BIOS and see if it will not
enlarge setup.S too large, etc.. But thinking of
various proprietary chipsets, I would hope that
I can insert a short C routine somewhere in the
boot chain, preferably on the kernel side, to
accomplish my objective.)


