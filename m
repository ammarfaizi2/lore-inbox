Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSIHQlr>; Sun, 8 Sep 2002 12:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317081AbSIHQlr>; Sun, 8 Sep 2002 12:41:47 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:46092 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S317068AbSIHQlq>;
	Sun, 8 Sep 2002 12:41:46 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209081646.g88GkMX11656@oboe.it.uc3m.es>
Subject: Re: [RFC] mount flag "direct"
In-Reply-To: <20020908095933.GC24476@marowsky-bree.de> from Lars Marowsky-Bree
 at "Sep 8, 2002 11:59:33 am"
To: Lars Marowsky-Bree <lmb@suse.de>
Date: Sun, 8 Sep 2002 18:46:22 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
       linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Lars Marowsky-Bree wrote:"
> On 2002-09-08T11:23:39,
>    "Peter T. Breuer" <ptb@it.uc3m.es> said:
> 
> > > do it if you don't know what the node had been working on prior to its
> > > failure.
> > Yes we do. Its place in the topology of the network dictates what it was
> > working on, and anyway that's just a standard parallelism "barrier"
> > problem.
> 
> I meant wrt what is had been working on in the filesystem. You'll need to do a
> full fsck locally if it isn't journaled. Oh well.

Well, something like that anyway.

> Maybe it would help if you outlined your architecture as you see it right now.

I did in another post, I think.  A torus with local 4-way direct
connectivity with each node connected to three neigbours and exporting
one local resource and importing three more from neighbours.  All
shared.  Add raid to taste.

> > There is no risk, because, as you say, we can always use nfs or another off
> > the shelf solution. 
> 
> Oh, so the discussion is a purely academic mind experiment; it would have been

Puhleeese try not to go off the deep end at an innocent observation.
Take the novocaine or something. I am just pointing out that there are
obvious safe fallbacks, AND ...

> helpful if you told us in the beginning.
> 
> > But 10% better is 10% more experiment for each timeslot
> > for each group of investigators.

You see?

> > > you referring to?
> > Any X that is not a standard FS. Yes, I agree, not exact.
> 
> So, your extensions are going to be "more" mainstream than OpenGFS / OCFS etc?

Quite possibly/probably. Let's see how it goes, shall we?
Do you want to shoot down returning the index of the inode in get_block
in order that we can do a wlock on that index before the io to
the file takes place? Not sufficient in itself, but enough to be going
on with, and enough for FS's that are reasonable in what they do.
Then we need to drop the dcache entry nonlocally.

> What the hell have you been smoking?

Unfortunately nothing at all, let alone worthwhile. 

> It has become apparent in the discussion that you are optimizing for a very

To you, perhaps, not to me. What I am thinking about is a data analysis
farm, handling about 20GB/s of input data in real time, with numbers
of nodes measured in the thousands, and network raided internally. Well,
you'd need a thousand nodes on the first ring alone just to stream
to disk at 20MB/s per node, and that will generate three to six times
that amount of internal traffic just from the raid. So aggregate
bandwidth in the first analysis ring has to be order of 100GB/s.

If the needs are special, it's because of the magnitude of the numbers,
not because of any special quality.

> rare special case. OpenGFS, Lustre etc at least try to remain useable for
> generic filesystem operation.
> 
> That it won't be mainstream is wrong about _your_ approach, not about those
> "off the shelves" solutions.

I'm willing to look at everything.

> And your special "optimisations" (like, no caching, no journaling...) are
> supposed to be 10% _faster_ overall than these which are - to a certain extent

Yep.  Caching looks irrelevant because we read once and write once, by
and large.  You could argue that we write once and read once, which
would make caching sensible, but the data streams are so large to make
it likely that caches would be flooded out anyway.  Buffering would be
irrelevant except inasmuch as it allows for asynchronous operation.

And the network is so involved in this that I would really like to get
rid of the current VMS however I could (it causes pulsing behaviour,
which is most disagreeable).

> - from the ground up optimised for this case?
> 
> One of us isn't listening while clue is knocking. 

You have an interesting bedtime story manner.

> Now it might be me, but then I apologize for having wasted your time and will
> stand corrected as soon as you have produced working code.

Shrug.

> Until then, have fun. I feel like I am wasting both your and my time, and this
> isn't strictly necessary.

!!

There's no argument. I'm simply looking for entry points to the code. 
I've got a lot of good information, especially from Anton (and other
people!), that I can use straight off. My thanks for the insights.

Peter
