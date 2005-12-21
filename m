Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVLUNNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVLUNNq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 08:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVLUNNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 08:13:46 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:14479 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932400AbVLUNNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 08:13:46 -0500
Date: Wed, 21 Dec 2005 08:13:16 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
cc: Ingo Molnar <mingo@elte.hu>, Christoph Lameter <christoph@lameter.com>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
In-Reply-To: <Pine.LNX.4.58.0512210909040.23799@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.58.0512210803280.28477@gandalf.stny.rr.com>
References: <1134860251.13138.193.camel@localhost.localdomain>
 <20051220133230.GC24408@elte.hu> <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
 <20051220135725.GA29392@elte.hu> <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
 <1135093460.13138.302.camel@localhost.localdomain> <20051220181921.GF3356@waste.org>
 <1135106124.13138.339.camel@localhost.localdomain>
 <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com>
 <1135114971.13138.396.camel@localhost.localdomain> <20051221065619.GC766@elte.hu>
 <Pine.LNX.4.58.0512210909040.23799@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Dec 2005, Pekka J Enberg wrote:
> Hi Ingo,
>
> Steven Rostedt <rostedt@goodmis.org> wrote:
> > > [...] Today's slab system is starting to become like the IDE where
> > > nobody, but a select few sado-masochis, dare to venture in. (I've CC'd
> > > them ;) [...]
>
> On Wed, 21 Dec 2005, Ingo Molnar wrote:
> > while it could possibly be cleaned up a bit, it's one of the
> > best-optimized subsystems Linux has. Most of the "unnecessary
> > complexity" in SLAB is related to a performance or a debugging feature.
> > Many times i have looked at the SLAB code in a disassembler, right next
> > to profile output from some hot workload, and have concluded: 'I couldnt
> > do this any better even with hand-coded assembly'.
> >
> > SLAB-bashing has become somewhat fashionable, but i really challenge
> > everyone to improve the SLAB code first (to make it more modular, easier
> > to read, etc.), before suggesting replacements.
>
> I dropped working on the replacement because I wanted to do just that. I
> sent my patch only because Matt and Steve talked about writing a
> replacement and thought they would be interested to see it.
>
> I am all for gradual improvements but after taking a stab at it, I
> starting to think rewriting would be easier, simply because the slab
> allocator has been clean-up resistant for so long.

And I think that what was done to SLAB is excellent. But like code I've
written, I've often thought, if I rewrote it again, I would do it cleaner
since I learned so much in doing it.

So the only way that I can feel that I can actually improve the current
system, is to write one from scratch (or start with one that is simple)
and try to make it as good as the current system.  But by the time I got
it there, it would be just as complex as it is today.  So only then,  I
could rewrite it to be better, since I learned why things were done the
way they were, and can have that in my mind as I rewrite.  So that means
writing it twice!

Unfortunately, it is probably the case that those that wrote slab.c are
too busy doing other things (or probably just don't want to), to rewite
the slab.c with the prior knowledge of what they wrote.

For the short time, I could just force myself to study the code and play
with it to see what I break, and figure out "Oh, that's whay that was
done!".

-- Steve
