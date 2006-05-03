Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbWECJbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWECJbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 05:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbWECJbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 05:31:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:47269 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965032AbWECJbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 05:31:02 -0400
X-Authenticated: #14349625
Subject: Re: sched_clock() uses are broken
From: Mike Galbraith <efault@gmx.de>
To: Andi Kleen <ak@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christopher Friesen <cfriesen@nortel.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <200605031116.09428.ak@suse.de>
References: <20060502132953.GA30146@flint.arm.linux.org.uk>
	 <200605030940.20409.ak@suse.de> <1146647462.7440.12.camel@homer>
	 <200605031116.09428.ak@suse.de>
Content-Type: text/plain
Date: Wed, 03 May 2006 11:31:38 +0200
Message-Id: <1146648698.7440.23.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 11:16 +0200, Andi Kleen wrote:
> On Wednesday 03 May 2006 11:11, Mike Galbraith wrote:
> > On Wed, 2006-05-03 at 09:40 +0200, Andi Kleen wrote:
> > > On Wednesday 03 May 2006 09:09, Mike Galbraith wrote:
> > > 
> > > > Given that most people are going to end up using the pm_timer anyway, I
> > > > don't see the point of even having a sched_clock().  If it's jiffy
> > > > resolution, it's useless.  If it's wildly inaccurate (as it is in the
> > > > SMP case, monotonicity issues aside) it's more than useless.
> > > 
> > > For sched_clock TSC is always used and it's fine - sched_clock
> > > doesn't require the guarantees that make TSC often useless otherwise
> > 
> > Regrettable, that's not true.
> 
> Hmm, maybe I'm thinking too much x86-64. At least on x86-64 it's true.
> 
> I don't see a big reason to not do this on i386 either, except
> on systems that truly don't have a TSC (386/486)

It should be this way on any system that has a half way functional high
resolution source.  Without it, the starvation scenario which
sched_clock() was invented to solve returns.  Making that the default
wasn't (um um um) the most brilliant selection among available options.

> Ok i suppose if you don't want cruft you can always go to 64bit @)

Unemployed guys can't buy new toys without wives getting all grumpy ;-)

	-Mike

