Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269822AbRHTXeV>; Mon, 20 Aug 2001 19:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269894AbRHTXeK>; Mon, 20 Aug 2001 19:34:10 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:46598 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269822AbRHTXeD>; Mon, 20 Aug 2001 19:34:03 -0400
Date: Mon, 20 Aug 2001 19:05:47 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.8/2.4.9 VM problems
In-Reply-To: <20010820232242Z16361-32385+84@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.21.0108201857400.538-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Aug 2001, Daniel Phillips wrote:

> On August 20, 2001 11:50 pm, Marcelo Tosatti wrote:
> > On Tue, 21 Aug 2001, Daniel Phillips wrote:
> 
> > > If you've seen streaming IO pages getting evicted before being used,
> > > I'd like to know about it because something is broken in that case.
> > 
> > I've seen the first page read by "swapin_readahead()" (which is the actual
> > page we want to swapin) be evicted _before_ we could actually use it (so
> > the read_swap_cache_async() call had to read the same page _again_ from
> > disk).
> 
> It's not streaming IO, but whoops, 

It does not matter. It just tells you that you're dropping pages too
early. That is even more valid for streaming IO.

I understand that having readahead pages to apply too much pressure
on really used pages is bad.

However, considering readaheaded pages as a "special case" (and drop them
previously, or whatever) will _always_ potentially fuckup streaming IO (so
yes, I think the old drop behind code is bad too).

> is that even with yesterday's SetPageReferenced patch to do_swap_page?

No. It will not help: the call to read_swap_cache_async() is before the
SetPageReferenced call.


