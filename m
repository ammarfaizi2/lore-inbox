Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286331AbRLJRkr>; Mon, 10 Dec 2001 12:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286330AbRLJRkh>; Mon, 10 Dec 2001 12:40:37 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:42703 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S286328AbRLJRka>; Mon, 10 Dec 2001 12:40:30 -0500
Date: Mon, 10 Dec 2001 12:38:38 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: mm question
In-Reply-To: <E16DUAv-0002hY-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.20.0112101230440.17940-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Alan Cox wrote:

> > "AGP addressable" memory which is ~64meg less than the total amount on my
> > machine. However, looking around in AGP driver or AGP specs does not seem
> > to indicate any restriction of the sort and, moreover, I do not need AGP
> > for this DMA transfer (it is PCI only).
> 
> Can the transfer go to pages mapped into the AGP gart, using their gart
> side mapping ?

Yes, but agpgart will not let more then one driver use it. So it will be
_either_ 3d or video capture with switching upon Xserver restart. Sucks !

> 
> > Better than giving up.. Unfortunately looking around in
> > linux/Documentation and drivers did not yield much in terms of
> > explanation. I know I can use mem_map_reserve to reserve a page but I
> > don't know how to get page struct from a physical address nor which lock
> > to use when messing with this.
> 
> You have to grab them at boot time via bootmem to get them in a range of

Does this imply that the driver must be compiled into the kernel ? In that
case I'll need to allocate at least 2meg of ram for each capture card..

> your choice. Otherwise you can use
> 
> 	get_free_page		-	grab a page
> 	virt_to_page		-	page struct of page
> 	virt_to_bus		-	bus addr of page
> 
> virt_to_bus isnt portable because real world pci bus mapping on non x86 is
> deeply murky and mysterious. But you probably want to worry about that
> after it works.

Yes, I almost went all the way rewriting the code in accordance with
DMA-mapping.txt thinking I am using "non-DMAable" memory or something 
until I noticed that all the functions are inlined to trivial for x86.

                           Vladimir Dergachev

> 
> Alan
> 

