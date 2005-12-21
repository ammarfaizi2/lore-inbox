Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVLUClh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVLUClh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 21:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVLUClh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 21:41:37 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:53752 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932267AbVLUClh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 21:41:37 -0500
Date: Tue, 20 Dec 2005 21:41:19 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Matt Mackall <mpm@selenic.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
In-Reply-To: <43A8BE2C.1080905@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0512202136080.15343@gandalf.stny.rr.com>
References: <dnu8ku$ie4$1@sea.gmane.org>  <1134790400.13138.160.camel@localhost.localdomain>
  <1134860251.13138.193.camel@localhost.localdomain>  <20051220133230.GC24408@elte.hu>
  <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>  <20051220135725.GA29392@elte.hu>
  <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com> 
 <1135093460.13138.302.camel@localhost.localdomain>  <20051220181921.GF3356@waste.org>
 <1135106124.13138.339.camel@localhost.localdomain> <43A8BE2C.1080905@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Dec 2005, Nick Piggin wrote:

> Steven Rostedt wrote:
>
> > That looks like quite an undertaking, but may be well worth it.  I think
> > Linux's memory management is starting to show it's age.  It's been
>
> What do you mean by this? ie. what parts of it are a problem, and why?
>
> I think that replacing the buddy allocator probably wouldn't be a good
> idea because it is really fast and simple for page sized allocations which
> are the most common, and it is good at naturally avoiding external
> fragmentation. Internal fragmentation is not much of a problem because it
> is handled by slab.

Actually, I wasn't talking about the buddy allocator, since it is probably
the best backend allocator to have.  I actually like it alot and it
doesn't seem to have a problem.

But the slab code has gotten more complex, and probably too feature full.
And I'm afraid that Christoph Lameter may be right, in that we could go to
another allocation scheme and after adding all the features that the slab
has, we would be just as complex.


>
> I can't see how replacing the buddy allocator with a completely agnostic
> range allocator could be a win at all.

That part I didn't agree with (replacing the buddy system I mean).

>
> Perhaps it would make more sense for bootmem, resources, vmalloc, etc. and
> I guess that is what Matt is suggesting.

I'd still add slab there, but as I said above, anything else may become
too complex.  Although, playing with this Magazine thingy is starting to
look interesting!

-- Steve

