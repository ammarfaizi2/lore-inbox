Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290953AbSAaGDV>; Thu, 31 Jan 2002 01:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290962AbSAaGDM>; Thu, 31 Jan 2002 01:03:12 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32183 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290953AbSAaGDC>;
	Thu, 31 Jan 2002 01:03:02 -0500
Date: Thu, 31 Jan 2002 01:02:53 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Larry McVoy <lm@bitmover.com>
cc: Rob Landley <landley@trommello.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Eli Carter <eli.carter@inet.com>,
        Georg Nikodym <georgn@somanetworks.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020130210835.F21235@work.bitmover.com>
Message-ID: <Pine.GSO.4.21.0201310039340.15689-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 Jan 2002, Larry McVoy wrote:

> On Wed, Jan 30, 2002 at 11:58:11PM -0500, Alexander Viro wrote:
> > Suppose I have 5 deltas - A, B, C, D, E.  I want to kill A.
> 
> If you just want to make A's changes go away, that's trivial:
> 
> 	bk get -e -xA foo.c
> 	bk delta -y"kill A's changes"
> 
> all done.
> 
> If you want to make A go away out of the graph, that's only possible if
> you have the only copy of the graph containing A.  Since BK replicates
> the history, you only get to do what you want before you push your changes
> to someone else.  No surgery after you let the cat out of the bag.
> 
> You have a repository and you haven't propogated all this stuff to
> someplace else, then this is easy, we'll just rebuild the history minus A.
> You or I could write a shell script using BK commands to do it in about
> 10 minutes.
> 
> It's a distributed, replicated file system which uses the revision history
> to propogate changes.  If you don't care about talking to anyone else,
> you can do whatever you want.  If you want to give someone your history
> and then change it, no way.  That's rewriting what happened.
> 
> Now does it make more sense?

Sigh...  OK, let me try to put it in a different way.

I don't want A (or entire old path) to disappear.  What I want is ability
to have two paths leading to the same point + ability to mark one of
them as "more interesting".

I.e. the result I want is _two_ sets of changesets with the same compositions.

And _that_ is compatible with replication - I simply want the new path in
revision graph to be propagated.  Along with the "this path is more
interesting" being written on the new one.

Can that be done?  I want a way to re-split the set of deltas.  I'm perfectly
happy with old one staying around, as long as we remember that results of
old and new are the same object and that new is a prefered way to look at
the damn thing.

I suspect that it could be doable with with something as simple as "if you
ask to merge two identical nodes, I'll just mark them as such and ask which
is more interesting".  IIRC, BK doesn't require tree topology on the graph -
it can have converging branches.

_If_ that is feasible - the rest can be scripted around it.

