Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266369AbTGJQZN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 12:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269417AbTGJQZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:25:13 -0400
Received: from are.twiddle.net ([64.81.246.98]:44728 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S266369AbTGJQZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:25:08 -0400
Date: Thu, 10 Jul 2003 09:39:18 -0700
From: Richard Henderson <rth@twiddle.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bernardo Innocenti <bernie@develer.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Peter Chubb <peter@chubb.wattle.id.au>, Andrew Morton <akpm@digeo.com>,
       Ian Molton <spyro@f2s.com>
Subject: Re: [PATCH] Fix do_div() for all architectures
Message-ID: <20030710163918.GB18697@twiddle.net>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Bernardo Innocenti <bernie@develer.com>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Peter Chubb <peter@chubb.wattle.id.au>,
	Andrew Morton <akpm@digeo.com>, Ian Molton <spyro@f2s.com>
References: <200307060133.15312.bernie@develer.com> <200307070626.08215.bernie@develer.com> <200307082027.26233.bernie@develer.com> <20030710154019.GA18697@twiddle.net> <20030710161859.GP16313@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030710161859.GP16313@dualathlon.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 06:18:59PM +0200, Andrea Arcangeli wrote:
> On Thu, Jul 10, 2003 at 08:40:19AM -0700, Richard Henderson wrote:
> > On Tue, Jul 08, 2003 at 08:27:26PM +0200, Bernardo Innocenti wrote:
> > > +extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor)
> > > __attribute_pure__;
> > ...
> > > +		__rem = __div64_32(&(n), __base);	\
> > 
> > The pure declaration is very incorrect.  You're writing to N.
> 
> now pure sounds more reasonable, I wondered how could gcc keep track of
> the stuff pointed by the parameters (especially if this stuff points to
> other stuff etc.. ;).

Bernardo mis-interpreted the documentation.

Define "local memory" as memory from the current stack frame.

Define "non-local memory" as anything else (including stack memory from
another function, or a different instantiation of the current function).

Any function can read/write local memory (since that is not visible to
anyone outside the function).

A "const" function cannot read or write to non-local memory.  There are
further constraints on not returning abnormally or not returning at all
that I'll not go into now.

A "pure" function can read non-local memory, but cannot write to it.

We use those conditions to determine if two invocations of a function
can be collapsed or moved or removed.



r~
