Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269815AbRHTXT1>; Mon, 20 Aug 2001 19:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269817AbRHTXTS>; Mon, 20 Aug 2001 19:19:18 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:46341 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269815AbRHTXTB>; Mon, 20 Aug 2001 19:19:01 -0400
Date: Mon, 20 Aug 2001 18:50:50 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.8/2.4.9 VM problems
In-Reply-To: <20010820224802Z16009-32384+228@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.21.0108201839580.538-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Aug 2001, Daniel Phillips wrote:

> On August 20, 2001 10:16 pm, Marcelo Tosatti wrote:
> > On Mon, 20 Aug 2001, Marcelo Tosatti wrote:
> > > On Mon, 20 Aug 2001, Daniel Phillips wrote:
> > > > On Mon, 20 Aug 2001, Marcelo Tosatti wrote:
> > > > > Find riel's message with topic "VM tuning" to linux-mm, then take a look
> > > > > at the 4th aging option.
> > > > > 
> > > > > That one _should_ be able to make us remove all kinds of "hacks" to do
> > > > > drop behind, and also it should keep hot/warm active memory _in cache_
> > > > > for more time. 
> > > > 
> > > > I looked at it yesterday.  The problem is, it loses the information about *how*
> > > > a page is used: pagecache lookup via readahead has different implications than
> > > > actual usage.
> > 
> > And ah, I forgot something here. 
> > 
> > Your statement which says "pagecache lookup via readahead has different
> > implications than actual usage" is not really correct.
> > 
> > If you only consider "hot" pages as "pages which have been touched",
> > you're going to (potentially) fuck heavy streaming IO workloads.
> 
> "Hot" pages are pages that have been touched more than once.
>
> The idea of use-once (on the read side) is to retain the readahead
> pages just long enough to use them, and not a lot longer.
>
> If you've seen streaming IO pages getting evicted before being used,
> I'd like to know about it because something is broken in that case.

I've seen the first page read by "swapin_readahead()" (which is the actual
page we want to swapin) be evicted _before_ we could actually use it (so
the read_swap_cache_async() call had to read the same page _again_ from
disk).


