Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313254AbSEESKW>; Sun, 5 May 2002 14:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313258AbSEESKV>; Sun, 5 May 2002 14:10:21 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:28646 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S313254AbSEESKV>; Sun, 5 May 2002 14:10:21 -0400
Date: Sun, 5 May 2002 11:10:07 -0700 (PDT)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Tomas Szepe <szepe@pinerecords.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: IO stats in /proc/partitions
In-Reply-To: <200205051149.g45BnGX13620@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33.0205051027460.8663-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 May 2002, Denis Vlasenko wrote:

> And peppering code with cute little comments + feeding patches to Rusty's
> 'trivial' patchbot.
>
> BTW, are units consistent? Kilobytes? Pages? Sectors?

No. Here's a sample (2.2 kernel):

disk 25418854 0 0 0 <--- total "operations" = calls to a routine whose
name I've forgotten

disk_rio 6950521 0 0 0 <--- total reads = read calls to the routine

disk_wio 18468333 0 0 0 <--- total writes = write calls to the routine

disk_rblk 14410934 0 0 0 <--- total 512 byte "blocks" read

disk_wblk 37146264 0 0 0 <--- total 512 byte "blocks" written

page 30108037 50709997 <--- number of 1024 byte "pages" read and written
-- counted in another routine whose name I've forgotten

swap 532282 341062 <--- number of PAGESIZE chunks read and written to
swap space -- counted in yet another routine whose name I've forgotten.

The routine names are listed in a thread a few weeks back where I first
got these discoveries from someone who presumably had been down this
path before. I don't have a 2.4 kernel sample handy; the "disk" entries
changed to a bizarre format that required a whole new parser in my code
and some complicated logic to figure out whether it was dealing with 2.2
or 2.4 :(.

As you can probably guess, this sort of thing is one of the issues that
my "COUGAR" proposal corrects. I leave design issues to the designers,
but one thing I insist on is that there *be* requirements --
*documented* requirements -- and a *documented* and debated design
*before* hacking the code into the kernel and making implementation
decisions.

Of course, since I would be the designer of at least part of "COUGAR", I
would be making some of those decisions. Unfortunately, I have limited
time to work on "COUGAR" until maybe late July, so if someone wants to
pick up some of the balls and run with them, I'm willing to unload them.
(Apologies if my metaphor jars those of you who live where football is
played without the use of hands :).

This is a process I highly recommend for performance-determining parts
of Linux, like memory management and the scheduler. I know the memory
management and scheduler gurus -- Rik, Andrea, Ingo and others -- *have*
designs in their heads, *have* requirements that they're working to -- I
just think we should be sharing and debating *those* on the list instead
of just code and benchmark results.

-- 
M. Edward Borasky
znmeb@borasky-research.net

The COUGAR Project
http://www.borasky-research.com/Cougar.htm

