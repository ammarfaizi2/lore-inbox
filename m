Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290215AbSA3RG4>; Wed, 30 Jan 2002 12:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290103AbSA3RFZ>; Wed, 30 Jan 2002 12:05:25 -0500
Received: from bitmover.com ([192.132.92.2]:16038 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290102AbSA3RE1>;
	Wed, 30 Jan 2002 12:04:27 -0500
Date: Wed, 30 Jan 2002 09:04:26 -0800
From: Larry McVoy <lm@bitmover.com>
To: Josh MacDonald <jmacd@CS.Berkeley.EDU>
Cc: Rik van Riel <riel@conectiva.com.br>, Ingo Molnar <mingo@elte.hu>,
        Larry McVoy <lm@bitmover.com>, Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130090426.N23269@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Josh MacDonald <jmacd@CS.Berkeley.EDU>,
	Rik van Riel <riel@conectiva.com.br>, Ingo Molnar <mingo@elte.hu>,
	Larry McVoy <lm@bitmover.com>, Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>,
	Rob Landley <landley@trommello.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201301933390.11022-100000@localhost.localdomain> <Pine.LNX.4.33L.0201301445430.11594-100000@imladris.surriel.com> <20020130085902.C11593@helen.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020130085902.C11593@helen.CS.Berkeley.EDU>; from jmacd@CS.Berkeley.EDU on Wed, Jan 30, 2002 at 08:59:03AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 08:59:03AM -0800, Josh MacDonald wrote:
> Quoting Rik van Riel (riel@conectiva.com.br):
> > On Wed, 30 Jan 2002, Ingo Molnar wrote:
> > > On Wed, 30 Jan 2002, Larry McVoy wrote:
> > >
> > > > How much of the out order stuff goes away if you could send changes
> > > > out of order as long as they did not overlap (touch the same files)?
> > >
> > > could this be made: 'as long as they do not touch the same lines of
> > > code, taking 3 lines of context into account'? (ie. unified diff
> > > definition of 'collisions' context.)
> > 
> > That would be _wonderful_ and fix the last bitkeeper
> > problem I'm having once in a while.
> 
> This would seem to require a completely new tool for you to specify which 
> hunks within a certain file belong to which changeset.  I can see why
> Larry objects.  What's your solution?

We actually can go from any line to the changeset which created that line
relatively quickly (milliseconds in hot cache, second or so in cold cache).
And we have a design which has been proven to work in the past at HP which
would allow a fully general out of order, at the changeset level application
of changes.  It's a bit complex to describe here and it has been 6 months 
away from being done for 3 years, so don't hold your breath.  I think the
better short term answer is to fix the false dependency problem, use regular
diff/patch for the places where there really are dependencies, and then do
the completely general one.

We are doing the general solution, which we call lines of development, our
commercial customers want it as well.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
