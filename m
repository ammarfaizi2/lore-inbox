Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290213AbSA3RBT>; Wed, 30 Jan 2002 12:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290102AbSA3Q7p>; Wed, 30 Jan 2002 11:59:45 -0500
Received: from bitmover.com ([192.132.92.2]:11174 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290206AbSA3Q7Y>;
	Wed, 30 Jan 2002 11:59:24 -0500
Date: Wed, 30 Jan 2002 08:59:23 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130085923.M23269@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
	Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020130080308.D18381@work.bitmover.com> <Pine.LNX.4.33L.0201301408540.11594-100000@imladris.surriel.com> <20020130083254.H23269@work.bitmover.com> <20020130164336.GO25973@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020130164336.GO25973@opus.bloom.county>; from trini@kernel.crashing.org on Wed, Jan 30, 2002 at 09:43:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 09:43:36AM -0700, Tom Rini wrote:
> On Wed, Jan 30, 2002 at 08:32:54AM -0800, Larry McVoy wrote:
> > On Wed, Jan 30, 2002 at 02:14:52PM -0200, Rik van Riel wrote:
> [snip]
> > > 2) the ability to send individual changes (for example, the
> > >    foo_net.c fixes from 1.324 and 1.350) in one nice unidiff
> > 
> > That's possible now but not a really good idea.
> 
> How is it possible and what can go wrong?  This will be a common thing I
> think, so it'd be a good thing to know (and have reliable and be a good
> idea in some form).

It's possible in that we can generate regular diffs for any range of
any files.  Cort used to do this all the time to send a subset of the
tree to Linus as a regular patch, talk to him about getting his scripts.
Or talk to Paul, I suspect he does it as well.

> > > 3) the ability for Linus to apply patches that are slightly
> > >    "out of order" - a direct consequence of (2)
> > 
> > This is really the main point.  There are two issues, one is out of order
> > and the other is what we call "false dependencies".  I think it is the 
> > latter that bites you most of the time.  The reason you want out of order
> > is because of the false dependencies, at least that is my belief, let
> > me tell you what they are and you tell me.
> 
> I think that sounds about right.  If changeset 1.123 and 1.124 are only
> related in that one got commited first (and for the sake of argument,
> isn't done just yet) and the other is ready to go, the second one is
> stuck.

Indeed.  We're painfully aware of this.

> > Suppose that you make 3 changes, a driver change, a vm change, and a 
> > networking change.  Suppose that you want to send the networking change
> > to Linus.  With patch, you just diff 'em and send and hope that patch
> > can put it together on the other end.  With BK as it stands today, there
> > is a linear dependency between all three changes and if you want to send
> > the networking change, you also have to send the other 2.
> > 
> > How much of the out order stuff goes away if you could send changes out
> > of order as long as they did not overlap (touch the same files)?
> 
> I think that'd help a good deal of the cases.

So here's the deal on this topic.  The out of order thing is a much
bigger deal for a large open source project than it is for our commercial
customers.  It's also hard to do correctly, it would take at least a
month.  Linus has flirted with using BitKeeper multiple times and then
gotten distracted.  If we had dropped everything and fixed the issues he
needs fixed rather than the issues our commercial customers need fixed,
we'd be out of business and you'd have the lovely task of trying to make
this work in the BitKeeper source.  You can believe me or not, but you'd
have very little chance of getting it to work, the BK source base is 
a lot larger and more complex than the generic part of the Linux kernel.

If enough of the kernel people start using BitKeeper and demanding the
out of order stuff, we'll do it.  The lead time is about a month, so
you have to deal with that.  On the other hand, if this turns into yet
another kernel "she loves, she loves me not, she loves me, she loves me
not" about BK, we're not going to fix the out of order stuff until it
is the most important issue for our commercial customers.

Hopefully, you'll take this in the spirit in which it is intended.
We want to help out the kernel team, that was the reason for writing
BitKeeper.  We have to survive, however, and that means paying attention
to the commercial needs as well.  If/when it looks like Linus & Co are
serious about using BK, I'll staff a couple of people to address the 
out of order stuff and commit to a delivery date.  It's clear that it
is the biggest "gotcha" about BK & the kernel work flow.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
