Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSKHEUW>; Thu, 7 Nov 2002 23:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbSKHEUW>; Thu, 7 Nov 2002 23:20:22 -0500
Received: from crack.them.org ([65.125.64.184]:55561 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S261587AbSKHEUV>;
	Thu, 7 Nov 2002 23:20:21 -0500
Date: Thu, 7 Nov 2002 23:27:53 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <20021108042753.GA8799@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <32290000.1036545797@flay> <Pine.GSO.4.21.0211051932140.6521-100000@steklov.math.psu.edu> <20021107230613.5194156c.rusty@rustcorp.com.au> <20021108035724.GB22031@holomorphy.com> <1036729047.765.2887.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036729047.765.2887.camel@phantasy>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 11:17:21PM -0500, Robert Love wrote:
> On Thu, 2002-11-07 at 22:57, William Lee Irwin III wrote:
> 
> > One way to at least "postpone" having to do things like making a fair
> > tasklist_lock is to make readers well-behaved. /proc/ is the worst
> > remaining offender left with its quadratic (!) get_pid_list(). After
> > "kernel, you're being bad and spinning in near-infinite loops with the
> > tasklist_lock readlocked" is (completely?) solved, then we can wait for
> > boxen with higher cpu counts to catch fire anyway when the arrival rate
> > of readers * hold time of readers > 1, which will happen because arrival
> > rates are O(cpus), and cpus will grow without bound as machines advance.
> > 
> > I'm not sure RCU would help this any; I'd be very much afraid of the
> > writes being postponed indefinitely or just too long in the presence
> > of what's essentially perpetually in-progress read access. Does RCU
> > have a guarantee of forward progress for writers?
> 
> I am not sure I like the idea of RCU for the tasklist_lock.
> 
> I do agree 100% with your first point, though - the problem is
> ill-behaved readers.  I think the writing vs. reading is such that the
> rw-lock we have now is fine, we just need to make e.g. /proc play way
> way more fair.

If you consider the atomicity that readdir() in /proc needs (that is:
almost none; it needs a guarantee that it will not miss a task which is
alive both before and after the opendir; but that's about it) then
there should be an easy way to augment the pidhash for this sort of
search.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
