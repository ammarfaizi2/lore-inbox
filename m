Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267408AbRGQCHV>; Mon, 16 Jul 2001 22:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267413AbRGQCHM>; Mon, 16 Jul 2001 22:07:12 -0400
Received: from web14304.mail.yahoo.com ([216.136.173.80]:24841 "HELO
	web14304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267408AbRGQCG7>; Mon, 16 Jul 2001 22:06:59 -0400
Message-ID: <20010717020702.19729.qmail@web14304.mail.yahoo.com>
Date: Mon, 16 Jul 2001 19:07:02 -0700 (PDT)
From: Kanoj Sarcar <kanojsarcar@yahoo.com>
Subject: Re: [PATCH] Separate global/perzone inactive/free shortage 
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>
Cc: Kanoj Sarcar <kanojsarcar@yahoo.com>, lkml <linux-kernel@vger.kernel.org>,
        Dirk Wetter <dirkw@rentec.com>, Mike Galbraith <mikeg@wen-online.de>,
        linux-mm@kvack.org, "Stephen C. Tweedie" <sct@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0107162125190.6689-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> 
> On Mon, 16 Jul 2001, Rik van Riel wrote:
> 
> > On Mon, 16 Jul 2001, Kanoj Sarcar wrote:
> > 
> > > Just a quick note. A per-zone page reclamation
> > > method like this was what I had advocated and
> sent
> > > patches to Linus for in the 2.3.43 time frame or
> so.
> > > I think later performance work ripped out that
> work.
> > 
> > Yes, the system ended up swapping as soon as the
> first zone
> > was filled up and after that would fill up the
> other zones;
> > the way the system stabilised was cycling through
> the pages
> > of one zone and leaving the lower zones alone.
> > 
> > This reduced the amount of available VM of a 1GB
> system
> > to 128MB, which is somewhat suboptimal ;)
> > 
> > What we learned from that is that we need to have
> some
> > way to auto-balance the reclaiming, keeping the
> objective
> > of evicting the least used page from RAM in mind.
> > 
> > > I guess the problem is that a lot of the
> different
> > > page reclamation schemes first of all do not
> know
> > > how to reclaim pages for a specific zone,
> > 
> > > try_to_swap_out is a good example, which can be
> solved
> > > by rmaps.
> > 
> > Indeed. Most of the time things go right, but the
> current
> > system cannot cope at all when things go wrong. I
> think we
> > really want things like rmaps and more sturdy
> reclaiming
> > mechanisms to cope with these worst cases (and
> also to make
> > the common case easier to get right).
> 
> As I said to Kanoj, I agree that we really want
> rmaps to fix that thing
> right.
> 
> Now I don't see any other way for fixing that on
> _2.4_ except something
> similar to the patch I posted. That patch can still
> have problems in
> practice, but fundamentally _it is the right thing_,
> IMO.

Yes, I agree with you, and that is why I had sent the
patch to Linus during 2.3 in the first place.  

What I am trying to point out is that you should talk
to Rik, and understand why it was removed previously.
Rik  obviously had his reasons at that point, but some
of those might not apply anymore, given that 2.4 is
quite different from 2.3.43.

Kanoj
 
> 
> 
> --
> To unsubscribe, send a message with 'unsubscribe
> linux-mm' in
> the body to majordomo@kvack.org.  For more info on
> Linux MM,
> see: http://www.linux-mm.org/


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
