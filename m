Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288154AbSAQDhS>; Wed, 16 Jan 2002 22:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288156AbSAQDhH>; Wed, 16 Jan 2002 22:37:07 -0500
Received: from [202.135.142.196] ([202.135.142.196]:10507 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S288154AbSAQDhB>; Wed, 16 Jan 2002 22:37:01 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: mingo@elte.hu
Cc: Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] I3 sched tweaks... 
In-Reply-To: Your message of "Wed, 16 Jan 2002 23:46:45 BST."
             <Pine.LNX.4.33.0201162343290.18971-100000@localhost.localdomain> 
Date: Thu, 17 Jan 2002 14:37:09 +1100
Message-Id: <E16R3MT-0004Ji-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0201162343290.18971-100000@localhost.localdomain> you
 write:
> 
> On Wed, 16 Jan 2002, Rusty Russell wrote:
> 
> > > > 4) scheduler_tick needs no args (p is always equal to current).
> > >
> > > i have not taken this part. We have 'current' calculated in
> > > update_process_times(), so why not pass it along to the scheduler_tick()
> > > function?
> >
> > Because it's redundant.  It's *always* p == current (and the code
> > assumes this!), but I had to grep the callers to find out.
> 
> we pass pointers across functions regularly, even if the pointer could be
> calculated within the function. We do this in the timer code too.

Look at it semantically: scheduler_tick() is just a function called
regularly for scheduler maintenance.  It might need the CPU number,
the runqueue length, or phase of the moon: the caller shouldn't care.

If it was a static fn, maybe this optimization makes sense.  But it's
an interface wart, and the "optimization" is utterly marginal anyway.

That said, I never would have sent such a trivial patch by itself: I
can't believe how many keystrokes were wasted over this issue!

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
