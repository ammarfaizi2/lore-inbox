Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286303AbRLJQHe>; Mon, 10 Dec 2001 11:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286299AbRLJQHZ>; Mon, 10 Dec 2001 11:07:25 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:32162 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S286301AbRLJQHP>; Mon, 10 Dec 2001 11:07:15 -0500
Date: Mon, 10 Dec 2001 11:05:22 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: mm question
In-Reply-To: <E16DSFZ-0002KX-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.20.0112101041020.17406-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Alan Cox wrote:

> > Right, but then my card refuses to dma into anything with address smaller
> > than 04000000.
> 
> What was your board designer on when they decided to bar DMA below 64Mb ?

Not mine (unfortunately ?). The card in question is ATI All-in-Wonder
Radeon - and I am trying to get video capture working. Unfortunately the
documentation is quite terse - for example the dma table register
description mentions its width, offset and "No description is provided".

Additionally I have to tiptoe my way around DRI driver which also uses
busmastering.

At the moment I have a working driver with one bug: DMA transfer just does
not happen into pages with address less than 0x4000000 which is the same
value as physical address of the ring buffer.

I suspect that this is somehow connected with the amount of available 
"AGP addressable" memory which is ~64meg less than the total amount on my
machine. However, looking around in AGP driver or AGP specs does not seem
to indicate any restriction of the sort and, moreover, I do not need AGP
for this DMA transfer (it is PCI only).

> 
> > amount) but this would place a big load on the system during buffer
> > allocation.
> 
> And might never terminate

I thought of establishing a timeout and giving up after a while. The
buffer is allocated once for each open on /dev/videoX so it is not too
critical - though I would not want to cause and OOM condition.

> 
> > I was hoping for something more elegant, but I am not adverse to writing
> > my own get_free_page_from_range().
> 
> Thats not a trivial task.
> 

Better than giving up.. Unfortunately looking around in
linux/Documentation and drivers did not yield much in terms of
explanation. I know I can use mem_map_reserve to reserve a page but I
don't know how to get page struct from a physical address nor which lock
to use when messing with this.

                     thanks

                         Vladimir Dergachev

