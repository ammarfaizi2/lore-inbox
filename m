Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132883AbRBRNfJ>; Sun, 18 Feb 2001 08:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132897AbRBRNe7>; Sun, 18 Feb 2001 08:34:59 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:32019 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132883AbRBRNeq>; Sun, 18 Feb 2001 08:34:46 -0500
Date: Sun, 18 Feb 2001 09:45:58 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
cc: Mike Galbraith <mikeg@wen-online.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.LNX.4.31.0102131340160.5111-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0102180913420.1877-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Feb 2001, Rik van Riel wrote:

> On Tue, 13 Feb 2001, Mike Galbraith wrote:
> > On Mon, 12 Feb 2001, Marcelo Tosatti wrote:
> >
> > > Could you please try the attached patch on top of latest Rik's patch?
> >
> > Sure thing.. (few minutes later) no change.
> 
> That's because your problem requires a change to the
> balancing between swap_out() and refill_inactive_scan()
> in refill_inactive()...
> 
> The big problem here is that no matter which magic
> proportion between the two functions we use, it'll always
> be wrong for a large proportion of the people out there.
> 
> This means we need to have a good way to auto-tune this
> thing. I'm thinking of letting swap_out() start out way
> less active than refill_inactive_scan() with extra calls
> to swapout being made from refill_inactive_scan when we
> think it's needed...
> 
> (... I'm writing a patch right now ...)


We're using nr_async_pages to calculate the number of pages which should
be flushed, but nr_async_pages counts on flight swap _readaheads_ (each
swapin increases nr_async_pages by (1 << page_cluster)) and writes, not
only writes.

That makes the "pageout free shortage and sleep" kswapd behaviour you
wanted a bit messy.



