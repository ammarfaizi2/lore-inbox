Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283946AbRLEKSh>; Wed, 5 Dec 2001 05:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283942AbRLEKS2>; Wed, 5 Dec 2001 05:18:28 -0500
Received: from gra-lx1.iram.es ([150.214.224.41]:33541 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id <S283945AbRLEKSP>;
	Wed, 5 Dec 2001 05:18:15 -0500
Date: Wed, 5 Dec 2001 11:17:35 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: <linux-kernel@vger.kernel.org>, <sailer@ife.ee.ethz.ch>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: USB audio w/ "D" state
In-Reply-To: <200112050728.fB57SDO230728@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.33.0112051112001.19602-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Dec 2001, Albert D. Cahalan wrote:

>
> I did "cat /bin/sh >> /dev/audio" and hit ^C to stop the noise.
> The "cat" process gets stuck in "D" state with the WCHAN indicating
> that the process is stuck 1/3 the way through the usbout_stop()
> function.
>
> hardware:  Mac Cube and the normal spherical speakers
> kernel:    plain 2.4.16 from www.kernel.org
> compiler:  gcc version 2.95.4 20011006 (Debian prerelease)
>
> In case PPC assembly is useful to somebody, I've marked the instruction
> where the process gets stuck. The surrounding "bl" instructions look
> like infinite loops to me, but maybe I'm reading this wrong. The assembly
> is from:   objdump -dl --start-address=0x1728 audio.o

Please add --reloc to this kind of dump, it makes the code much easier to
follow in case you hit a compiler bug (this happens). Or directly
disassemble vmlinux if it's not a module.

[snipped]
>     1790:       38 60 00 01     li      r3,1
>     1794:       48 00 00 01     bl      1794 <usbout_stop+0x6c>
                     ^^^^^^^^
these bytes (and the 2 LSB  of the first byte) will be modified by the
linker or module loader.

> --> 1798:       7f a3 eb 78     mr      r3,r29
>     179c:       48 00 00 01     bl      179c <usbout_stop+0x74>
>     17a0:       48 00 00 01     bl      17a0 <usbout_stop+0x78>

	Regards,
	Gabriel.


