Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267750AbRGQB6v>; Mon, 16 Jul 2001 21:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267749AbRGQB6b>; Mon, 16 Jul 2001 21:58:31 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:20755 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267748AbRGQB6S>; Mon, 16 Jul 2001 21:58:18 -0400
Date: Mon, 16 Jul 2001 21:27:02 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Kanoj Sarcar <kanojsarcar@yahoo.com>, lkml <linux-kernel@vger.kernel.org>,
        Dirk Wetter <dirkw@rentec.com>, Mike Galbraith <mikeg@wen-online.de>,
        linux-mm@kvack.org, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] Separate global/perzone inactive/free shortage 
In-Reply-To: <Pine.LNX.4.33L.0107161553090.5738-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0107162125190.6689-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Jul 2001, Rik van Riel wrote:

> On Mon, 16 Jul 2001, Kanoj Sarcar wrote:
> 
> > Just a quick note. A per-zone page reclamation
> > method like this was what I had advocated and sent
> > patches to Linus for in the 2.3.43 time frame or so.
> > I think later performance work ripped out that work.
> 
> Yes, the system ended up swapping as soon as the first zone
> was filled up and after that would fill up the other zones;
> the way the system stabilised was cycling through the pages
> of one zone and leaving the lower zones alone.
> 
> This reduced the amount of available VM of a 1GB system
> to 128MB, which is somewhat suboptimal ;)
> 
> What we learned from that is that we need to have some
> way to auto-balance the reclaiming, keeping the objective
> of evicting the least used page from RAM in mind.
> 
> > I guess the problem is that a lot of the different
> > page reclamation schemes first of all do not know
> > how to reclaim pages for a specific zone,
> 
> > try_to_swap_out is a good example, which can be solved
> > by rmaps.
> 
> Indeed. Most of the time things go right, but the current
> system cannot cope at all when things go wrong. I think we
> really want things like rmaps and more sturdy reclaiming
> mechanisms to cope with these worst cases (and also to make
> the common case easier to get right).

As I said to Kanoj, I agree that we really want rmaps to fix that thing
right.

Now I don't see any other way for fixing that on _2.4_ except something
similar to the patch I posted. That patch can still have problems in
practice, but fundamentally _it is the right thing_, IMO.


