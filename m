Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269436AbRHTVh0>; Mon, 20 Aug 2001 17:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269428AbRHTVhG>; Mon, 20 Aug 2001 17:37:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:60939 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269454AbRHTVgz>; Mon, 20 Aug 2001 17:36:55 -0400
Date: Mon, 20 Aug 2001 17:08:39 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.8/2.4.9 VM problems
In-Reply-To: <20010820213425Z16360-32383+586@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.21.0108201707520.538-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


~
On Mon, 20 Aug 2001, Daniel Phillips wrote:

> On August 20, 2001 09:12 pm, Marcelo Tosatti wrote:
> > On Mon, 20 Aug 2001, Daniel Phillips wrote:
> > > On August 20, 2001 09:14 pm, Mike Galbraith wrote:
> > > > We need to get the pages 'actioned' (the only thing that really matters)
> > > > off of the dirty list so that they are out of the equation.. that I'm
> > > > sure of.
> > > 
> > > Well, except when the page is only going to be used once, or not at all (in 
> > > the case of an unused readahead page).  Otherwise, no, we don't want to have 
> > > frequently used pages or pages we know nothing about dropping of the inactive 
> > > queue into the bit-bucket.  There's more work to do to make that come true.
> > 
> > Find riel's message with topic "VM tuning" to linux-mm, then take a look
> > at the 4th aging option.
> > 
> > That one _should_ be able to make us remove all kinds of "hacks" to do
> > drop behind, and also it should keep hot/warm active memory _in cache_
> > for more time. 
> 
> I looked at it yesterday.  The problem is, it loses the information about *how*
> a page is used: pagecache lookup via readahead has different implications than
> actual usage.  The other thing that looks a little problematic, which Rik also
> pointed out, is the potential long lag before the inactive page is detected.
> A lot of IO can take place in this time, filling up the active list with pages
> that we could have evicted much earlier.

We're using unlazy page activation on -ac so that is not an issue.


