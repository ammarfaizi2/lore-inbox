Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268971AbRIBU0v>; Sun, 2 Sep 2001 16:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269174AbRIBU0l>; Sun, 2 Sep 2001 16:26:41 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:29704 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268971AbRIBU0i>; Sun, 2 Sep 2001 16:26:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Date: Sun, 2 Sep 2001 22:33:41 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <20010902181905Z16091-32383+3020@humbolt.nl.linux.org> <1034195335.999462755@[169.254.198.40]>
In-Reply-To: <1034195335.999462755@[169.254.198.40]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010902202648Z16301-32383+3039@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 2, 2001 09:32 pm, Alex Bligh - linux-kernel wrote:
> Daniel,
> 
> > What do you do when a new module gets inserted, increasing the high order
> > load and requiring that the slab be expanded? I.e, the need for
> > dependable  handling of high order physical allocations doesn't go away
> > entirely.  The slab would help even out the situation with atomic allocs
> > because it can be expanded to a target size by a normal task, which can
> > wait.
> 
> Yes, chew away to disk as this allocation is non atomic.

What I meant was, the new module implements a network driver which proceeds 
to do atomic allocs.

> But this probably still needs something which goes and identifies
> kernel allocated pages with buddies which can be relocated / pushed to
> disk / freed etc.;
> 
> Alternatively something to temporarilly hold onto 'nearly freed'
> high-order areas is probably useful. IE if there's an order=3
> allocation stuck waiting for a suitable hole, and there's
> a bit of bitmap that looks like '00010000' (i.e. order 1 hole,
> order 0 hole, order 0 used, order 2 hole), I wonder if we can't
> think of some hueristic to avoid allocating the next order 0
> page request (atomic or not) from the order 0 hole even if
> it's at the front of the order (0) free area list.

One thing I am hearing from some developers is that we don't need to solve 
the high-order allocation problems because they are really driver issues - 
all drivers should be changed to use scatter-gather or some such.  I don't 
know if that's correct, this would require knowledge of all driver types and 
archs which I can't begin to claim.

I'm quite sure we can fix this up though, not to the point of being able to 
guarantee all high order allocations, but to the point where we have a high 
probability of success under all loads, as opposed to what we have now which 
is very fragile, and not just in the Linus tree.

--
Daniel
