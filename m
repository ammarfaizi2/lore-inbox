Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269413AbRHTVef>; Mon, 20 Aug 2001 17:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269428AbRHTVeZ>; Mon, 20 Aug 2001 17:34:25 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:4370 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269413AbRHTVeN>; Mon, 20 Aug 2001 17:34:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.8/2.4.9 VM problems
Date: Mon, 20 Aug 2001 23:40:52 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0108201609190.538-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0108201609190.538-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010820213425Z16360-32383+586@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 20, 2001 09:12 pm, Marcelo Tosatti wrote:
> On Mon, 20 Aug 2001, Daniel Phillips wrote:
> > On August 20, 2001 09:14 pm, Mike Galbraith wrote:
> > > We need to get the pages 'actioned' (the only thing that really matters)
> > > off of the dirty list so that they are out of the equation.. that I'm
> > > sure of.
> > 
> > Well, except when the page is only going to be used once, or not at all (in 
> > the case of an unused readahead page).  Otherwise, no, we don't want to have 
> > frequently used pages or pages we know nothing about dropping of the inactive 
> > queue into the bit-bucket.  There's more work to do to make that come true.
> 
> Find riel's message with topic "VM tuning" to linux-mm, then take a look
> at the 4th aging option.
> 
> That one _should_ be able to make us remove all kinds of "hacks" to do
> drop behind, and also it should keep hot/warm active memory _in cache_
> for more time. 

I looked at it yesterday.  The problem is, it loses the information about *how*
a page is used: pagecache lookup via readahead has different implications than
actual usage.  The other thing that looks a little problematic, which Rik also
pointed out, is the potential long lag before the inactive page is detected.
A lot of IO can take place in this time, filling up the active list with pages
that we could have evicted much earlier.

--
Daniel
