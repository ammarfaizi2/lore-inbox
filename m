Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135691AbRDXPuY>; Tue, 24 Apr 2001 11:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135688AbRDXPuO>; Tue, 24 Apr 2001 11:50:14 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:53520 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135684AbRDXPt5>; Tue, 24 Apr 2001 11:49:57 -0400
Date: Tue, 24 Apr 2001 08:49:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: David Howells <dhowells@warthog.cambridge.redhat.com>,
        David Howells <dhowells@cambridge.redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: rwsem benchmark [was Re: [PATCH] rw_semaphores, optimisations
 try #3]
In-Reply-To: <20010424124450.C1682@athlon.random>
Message-ID: <Pine.LNX.4.21.0104240844380.15642-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Apr 2001, Andrea Arcangeli wrote:
> 
> > > Again it's not a performance issue, the "+a" (sem) is a correctness issue
> > > because the slow path will clobber it.
> > 
> > There must be a performance issue too, otherwise our read up/down fastpaths
> > are the same. Which clearly they're not.
> 
> I guess I'm faster because I avoid the pipeline stall using "+m" (sem->count)
> that is written as a constant, that was definitely intentional idea.

Guys.

You're arguing over stalls that are (a) compiler-dependent and (b) in code
that doesn't hapeen _anywhere_ except in the specific benchmark you're
using.

Get over it.

 - The benchmark may use constant addresses. None of the kernel does. The
   benchmark is fairly meaningless in this regard.

 - the stalls will almost certainly depend on the code around the thing,
   and will also depend on the compiler version. If you're down to
   haggling about issues like that, then there is no real difference
   between the code.

So calm down guys. And improving the benchmark might not be a bad idea.

		Linus

