Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277708AbRKFDDA>; Mon, 5 Nov 2001 22:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281440AbRKFDCv>; Mon, 5 Nov 2001 22:02:51 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:58833 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277700AbRKFDCh>;
	Mon, 5 Nov 2001 22:02:37 -0500
Date: Mon, 5 Nov 2001 22:02:35 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <Pine.LNX.4.33.0111051748250.1710-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0111052132360.27563-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Nov 2001, Linus Torvalds wrote:

> And you have to realize that _whatever_ we do, it will always be a
> heuristic. We don't know what the right behaviour is without being able to
> predict the future. Agreed?

No arguments.  While we are at it, let's just state once and forever:
	FFS allocator sucks for fast-growth case
Everyone agrees with that, including me, you _and_ Kirk.
 
> The question is: "what can we do to improve it?". Not "what arguments can
> we come up with to make excuses for a sucky algorithm that clearly does
> the wrong thing for real-life loads".

Obviously.
 
> One such improvement has already been put on the table: remove the
> algorithm, and make it purely greedy.
> 
> We know that works. And yes, we realize that it has downsides too. Which
> is why some kind of hybrid is probably called for. Come up with your own

Exactly.

> And maybe the fundamental problem is exactly that: because we're stuck
> with our decision forever, people felt that they couldn't afford to risk
> doing what was very obviously the right thing.
> 
> So I still claim that we should look for short-time profit, and then try
> to fix up the problems longer term. With, if required, some kind of
> rebalancing.

Whatever heuristics we use, it _must_ catch fast-growth scenario.  No
arguments on that.  The question being, what will minimize the problems
for other cases.

On-line defrag can be actually fairly nasty - that had been tried and
it ends up with a hell of tricky details.  Especially with page cache
in the game.  And "umount once a month" is not serious - think of a
_large_ disk on a department NFS server.  So I'd rather look for decent
heuristics before going for "let's defrag it once in a while" kind of
solution.

I definitely want to start with looking through relevant work - both
for the data and for information on _failed_ attempts to solve the
problem.

/me goes to dig through that stuff

