Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129074AbQJaOpZ>; Tue, 31 Oct 2000 09:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbQJaOpR>; Tue, 31 Oct 2000 09:45:17 -0500
Received: from jhuml1.hcf.jhu.edu ([128.220.2.66]:44986 "EHLO jhuml3.jhu.edu")
	by vger.kernel.org with ESMTP id <S129074AbQJaOo7>;
	Tue, 31 Oct 2000 09:44:59 -0500
Date: Tue, 31 Oct 2000 09:43:21 -0500 (EST)
From: afei@jhu.edu
Subject: Re: kmalloc() allocation.
In-Reply-To: <20001031114851.D7204@nightmaster.csn.tu-chemnitz.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Message-id: <Pine.GSO.4.05.10010310940410.18461-100000@aa.eps.jhu.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Oct 2000, Ingo Oeser wrote:

> On Mon, Oct 30, 2000 at 02:40:16PM -0200, Rik van Riel wrote:
> > > There are 256 megabytes of SDRAM available. I don't think it's
> > > reasonable that a 1/2 megabyte allocation would fail, especially
> > > since it's the first module being installed.
> > If you write the defragmentation code for the VM, I'll
> > be happy to bump up the limit a bit ...
> 
> Should become easier once we start doing physical page scannings.
> 
> We could record physical continous freeable areas on the fly
> then. If someone asks for them later, we recheck whether they
> still exists and free (inactive_clean) or remap (active or
> inactive_dirty) the whole area, whether they are used or not. 

I am confused. Why cannot one simply audit the memory usage and always
have an up-to-date list of free memory pages? When a page is allocated,
the allocator should make a call to move that page outside of the
freelist; and when it is free, just move it back to the free list. Is it
because of the overhead? 

Fei
> 
> This could still be improved by using up smallest fit areas
> first for kmalloc() based on these areas.
> 
> But beware: We just have a good hint here, which needs to be
>    rechecked every time we allocate such areas to become
>    guarantee.
> 
> Rik: What do you think about this (physical cont. area cache) for 2.5?
> 
> Regards
> 
> Ingo Oeser
> -- 
> Feel the power of the penguin - run linux@your.pc
> <esc>:x
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux.eu.org/Linux-MM/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
