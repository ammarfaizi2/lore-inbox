Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131446AbRCSLlD>; Mon, 19 Mar 2001 06:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131458AbRCSLkm>; Mon, 19 Mar 2001 06:40:42 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:5385 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131446AbRCSLkb>;
	Mon, 19 Mar 2001 06:40:31 -0500
Date: Mon, 19 Mar 2001 12:39:42 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gettimeofday question
Message-ID: <20010319123941.A18699@pcep-jamie.cern.ch>
In-Reply-To: <200103031249.f23Cn4R01208@flint.arm.linux.org.uk> <20010319073356.A16622@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010319073356.A16622@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Mon, Mar 19, 2001 at 07:33:56AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> > I've noticed that one of my machines here suffers from the "time going
> > backwards problem" and so started thinking about the x86 solution.
> > 
> > I've come to the conclusion that it has a hole which could cause it
> > to return the wrong time in one specific case:
> > 
> > - in do_gettimeofday(), we disable irqs (read_lock_irqsave)
> > - the ISA timer wraps, but we've got interrupts disabled, so no update
> >   of xtime or jiffies occurs
> > - in do_slow_gettimeoffset(), we read the timer, which has wrapped
> > - since jiffies_p != jiffies, we do not apply any correction
> > - our idea of time is now one jiffy slow.
> 
> I never heard any response to this.  Could some knowledgeable person please
> take a look at it?

do_slow_gettimeoffset() is supposed to correct for wrapping.
But where it says:

	#define BUGGY_NEPTUN_TIMER

		if( jiffies_t == jiffies_p ) {
		    if( count > count_p ) {
			      /* the nutcase */

Shouldn't that say "count < count_p"?

-- Jamie
