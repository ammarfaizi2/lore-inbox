Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbRIBSTR>; Sun, 2 Sep 2001 14:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268691AbRIBSS5>; Sun, 2 Sep 2001 14:18:57 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:44804 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267534AbRIBSSr>; Sun, 2 Sep 2001 14:18:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Date: Sun, 2 Sep 2001 20:26:01 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <200109020226.f822QCS18912@maile.telia.com> <1013623912.999442119@[169.254.198.40]>
In-Reply-To: <1013623912.999442119@[169.254.198.40]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010902181905Z16091-32383+3020@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 2, 2001 03:48 pm, Alex Bligh - linux-kernel wrote:
> > Or/and we could remove the sources of higher order allocs, as an example:
> > why is the SCSI layer allowed to allocate order 3 allocs (32 kB) several
> > times per second? Will we really get a performance hit by not allowing
> > higher order allocs in active driver code?
> 
> Or put them in some slab like code, the slab for which gets allocated
> early on when memory is not fragmented, and (nearly) never gets released.

What do you do when a new module gets inserted, increasing the high order
load and requiring that the slab be expanded?  I.e, the need for dependable 
handling of high order physical allocations doesn't go away entirely.  The
slab would help even out the situation with atomic allocs because it can
be expanded to a target size by a normal task, which can wait.

> Most of the stuff that actually NEEDS atomic allocation (as opposed
> to some of the requirements that are bogus) are for packets / data
> in flight. There is probably a finite amount of this at any given time.

There is no bound, but yes it tends to stay limited to a given, small amount 
over long periods of time.  Hoarding schemes are appropriate.  The only 
problem with slab allocation is, it has more overhead than __alloc_pages 
allocation.  For high-performance networking this may be a measurable hit.

--
Daniel
