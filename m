Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284726AbRLJV3U>; Mon, 10 Dec 2001 16:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284710AbRLJV3K>; Mon, 10 Dec 2001 16:29:10 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:20416 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S284704AbRLJV3E>; Mon, 10 Dec 2001 16:29:04 -0500
Date: Mon, 10 Dec 2001 16:27:11 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: mm question
In-Reply-To: <E16DV8N-0002vK-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.20.0112101623110.18429-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Alan Cox wrote:

> > > This makes it rather hard to go around trying to free pages
> > > within a certain physical range.
> > 
> > Well, what does kernel do when it runs out of memory ? For example when I
> > mmap a large file and start reading it back and force ?
> 
> It doesn't care which physical page it gets. Processes being freeing
> up/swapping pages they have mappings to. The map counts hit zero and the 
> page is discarded.

Right, but instead of trying to balance cache available memory and swap
my swapper will only be concerned whether the page can be evicted and
whether it is from the address range I want.

The scheme is like:

  open -> request buffer allocation -> start region_swapper  ->
     -> wait for freed memory to accumulate and reserve as it appears -> 
     -> when enough is available stop swapper and declare allocation finished

                                Vladimir Dergachev

> 
> Alan
> 

