Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271664AbRHQO0w>; Fri, 17 Aug 2001 10:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271665AbRHQO0m>; Fri, 17 Aug 2001 10:26:42 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1664 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271664AbRHQO00>; Fri, 17 Aug 2001 10:26:26 -0400
Date: Fri, 17 Aug 2001 10:26:34 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Madore <david.madore@ens.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: broken memory chip -> software fix?
In-Reply-To: <20010817161505.A25194@clipper.ens.fr>
Message-ID: <Pine.LNX.3.95.1010817101952.256A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001, David Madore wrote:

> Hi all.
> 
> I have a broken bit in my memory - at address 0x04d5ae38 if you want
> to know the details (bit 29 of the double word there sometimes reads
> as 1 when it was written as 0, in particular if bit 15 is at 1).  I
> discovered this by observing a one-bit corruption of some files, and
> diagnosed it by running memtest86.
> 
> Now that I know the address, is there a way I can prevent Linux from
> using that region of memory in any way?  The simplest and cleanest
> way, would be, I guess, for a userland process I would write to ask of
> the kernel to map permanently and unswappably the page at physical
> location 0x04d5a000 to its virtual address space.  (Besides, that
> would let me play with that broken bit.)
> 
> So: is there a way for a userland process (running at euid 0) to
> request of the kernel an explicit physical address to virtual address
> translation?  If so, how?  I would prefer not to have to patch the
> kernel, if at all possible.
> 
> Thanks,
> 

mmap(0x04d5a000, PAGE_SIZE, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_FIXED, fd,
           ^^^^ page boundary
0);

'MAP_FIXED' is your friend. This will take the offending page size 
(0x1000) on x86, out of use and give it to you. 'fd' is initialized
by opening /dev/mem.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


