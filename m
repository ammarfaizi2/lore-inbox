Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290636AbSA3V5k>; Wed, 30 Jan 2002 16:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290639AbSA3V5b>; Wed, 30 Jan 2002 16:57:31 -0500
Received: from bitmover.com ([192.132.92.2]:17066 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290636AbSA3V50>;
	Wed, 30 Jan 2002 16:57:26 -0500
Date: Wed, 30 Jan 2002 13:57:24 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Georg Nikodym <georgn@somanetworks.com>, Larry McVoy <lm@bitmover.com>,
        Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130135724.E22323@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Georg Nikodym <georgn@somanetworks.com>,
	Larry McVoy <lm@bitmover.com>, Ingo Molnar <mingo@elte.hu>,
	Rik van Riel <riel@conectiva.com.br>,
	Tom Rini <trini@kernel.crashing.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>,
	Rob Landley <landley@trommello.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1012419503.1460.68.camel@keller> <Pine.LNX.4.33.0201301258180.2449-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201301258180.2449-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jan 30, 2002 at 01:17:25PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 01:17:25PM -0800, Linus Torvalds wrote:
> 
> On 30 Jan 2002, Georg Nikodym wrote:
> >
> > The thing that's missing here is that 'g' (or 1.7) doesn't just refer to
> > the change that is 'g'.  It's actually a label that implies a point in
> > time as well as all the change that came before it.  Stated differently,
> > it is a set.
> 
> I disagree.
> 
> "g" is really just one thing: it is "the changes".

In some system that you are imagining, you are correct.  In BK, you are
flat wrong and you've missed an important point.

In BK, "g" means two things: the diffs and the stuff that has no diffs.
In other words, both what changed and exactly what was in the tree at
the time the change was created.

In your mind, "g" is just the diffs applied to any tree which allows
the diffs to apply cleanly by patch, and even more trees where they
don't apply cleanly but you can fix up the patch rejects by hand.

The BK "g" is a more pwoerful statement than the Linus "g".  
The Linus "g" is a more flexible thing than the BK "g".

The BK "g" is more powerful because when I say "I've tested g", I'm
saying one hell of a lot more exact statement then when you say "I've
tested g".  The BK "g" is reproducible, without exception.  Your "g"
is reproducible if and only if I happen to have exactly the same tree
that you had when you applied the "g" patch.

The real power of the BK way is that testing builds up incrementally,
one on top of the other, but in your way, each time you apply the 
patch in some other context, the testing is invalidate.  You can
swear up and down all you want that it doesn't make any difference
and every time you do I will come up with a different example where
a whole team of Linus types said the same thing and were wrong.  If
you apply the patch to a different context, you have to start the
testing process over.  No ifs, ands, or buts.  If I can't run cmp(1)
on the object and get no diffs, it's not the same object.

> One context is simply the "when in time" context, which is interesting, as
> when you serialize all changesets you see the time-wise development. And
> this is really the _only_ context that BK (and most other source control
> tools) really think about.

If that's what you believe about BK, you haven't the faintest idea of
how it works.  BK has, right now, in the bits that you have on your
disk, the ability to recreate any change with all, some, or none of the
previous changes.  bk help sccscat.  You can create a version of the 
file which has only the odd numbered changes in it if that is what you
want.  Try that in other systems or with your patches.

> However, in another sense, the "when in time" context is completely
> meaningless. Should you care what the _temporal_ relationship between two
> independent patches is? I say "Absolutely not!".

And I (and the entire release management and software support world)
say  "you're wrong".  I'll grant you are right a lot, but lots of times
you'll be wrong.  I've seen enough changes like "remove all the trailing
whitespace, it can't hurt anything" and it breaks the product.  

> I'd say that most (maybe all) of the complaints about not being able to
> apply changesets in any random order comes exactly from the fact that
> developers _know_ that temporal relationships are often not relevant.

Phooey.  They _think_ they know.  You, Linus, are better than average
on this topic but you make mistakes too.  Any the point you are missing
is that in the face of a random set of inputs, any time you change
anything, you need to restart the test cycle.  The BK way lets you
isolate exactly what caused the problem.  We can, and do, run binary
search over changes to figure out what caused the problem.  As outlined
in Documentation/bug-hunting.txt.  The difference is that we track
it down to exactly the change that caused the problem and you can't,
you are varying more variables than BK does.  I'm not saying that you
shouldn't be able to vary things, I'm saying that it has a cost, just
like not being able to vary it has a cost.  You are painting a picture
that says you can vary the order and it won't matter.  That's flat out
wrong and I think you know it.

> So what I'm saying is that from a patch revision standpoint, temporal
> information is useless. You still have enough information to recreate the
> tree "at time 'g'" by just doing the equivalent of "bk get -c<date-of-g>".
> 
> See?

No, I don't.  It's a distributed system and there is lots of parallel
development and date-of-g may have many matches.  And it's relatively
meaningless since you are applying g in multiple contexts.  In BK as
it stands, "g" is an invariant.  It means one thing: the state of the
tree immediately after "g" was checked in.  What does your "g" mean?
Some diffs.  Where do they work?  You don't know.  You have to go try
it to find out.

That's all fine, just admit that you have lost something before you
throw it away.  There is no way we'll change BK to allow what you are
asking for until you get it.  I understand what you want, I understand
the implications, I need you to really understand what it is that you
are asking.

I also think we need some face time, I'd like to draw you some pictures
and I find the keyboard just too slow for that.  I think this would be
a lot faster in person.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
