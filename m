Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSFVSfa>; Sat, 22 Jun 2002 14:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316846AbSFVSf3>; Sat, 22 Jun 2002 14:35:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50800 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S316845AbSFVSf2>; Sat, 22 Jun 2002 14:35:28 -0400
To: Larry McVoy <lm@bitmover.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Cort Dougan <cort@fsmlabs.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
References: <Pine.LNX.4.44.0206201003500.8225-100000@home.transmeta.com>
	<m1r8j1rwbp.fsf@frodo.biederman.org>
	<20020621105055.D13973@work.bitmover.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Jun 2002 12:25:09 -0600
In-Reply-To: <20020621105055.D13973@work.bitmover.com>
Message-ID: <m1lm97rx16.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

> On Fri, Jun 21, 2002 at 12:15:54AM -0600, Eric W. Biederman wrote:
> > I think Larry's perspective is interesting and if the common cluster
> > software gets working well enough I might even try it.  But until a
> > big SMP becomes commodity I don't see the point.
> 
> The real point is that multi threading screws up your kernel.  All the Linux
> hackers are going through the learning curve on threading and think I'm an
> alarmist or a nut.  After Linux works on a 64 way box, I suspect that the
> majority of them will secretly admit that threading does screw up the kernel
> but at that point it's far too late.

I don't see a argument that locks that get to fine grained are not an
issue.  However even traditional version of single cpu unix are multi
threaded.  The locking in a multi cpu design just makes that explicit.

And the only really nasty place to get locks is when you get a
noticeable number of them in your device drivers.  With the core code
you can fix it without out worrying about killing the OS.
 
> The current approach is a lot like western medicine.  Wait until the
> cancer shows up and then make an effort to get rid of it.  My suggested
> approach is to take steps to make sure the cancer never gets here in
> the first place.  It's proactive rather than reactive.  And the reason
> I harp on this is that I'm positive (and history supports me 100%)
> that the reactive approach doesn't work, you'll be stuck with it,
> there is no way to "fix" it other than starting over with a new kernel.
> Then we get to repeat this whole discussion in 15 years with one of the
> Linux veterans trying to explain to the NewOS guys that multi threading
> really isn't as cool as it sounds and they should try this other
> approach.

Proactive don't add a lock unless you can really justify that you need
it.  That is well suited to open source code review type practices,
and it appears to be what we are doing now.  And if you don't add
locks you certainly don't get into a lock tangle.

As for 100% history supported all I see is that evolution of code,
as it dynamically gathers the requirements instead of magically
knowing them does much better than design as a long term 
strategy.  Of course you design the parts you can see but every has a
limited ability to see the future.

To specifics, I don't see the point of OSlets on a single cpu that is
hyper threaded.  Traditional threading appears to make more sense to
me.  Similarly I don't see the point in the 2-4 cpu range.

Given that there are some scales when you don't want/need more than
one kernel, who has a machine where OSlets start to pay off?  They
don't exist in commodity hardware, so being proactive now looks
stupid.

The only practical course I see is to work on solutions that work on
clusters of commodity machines.  At least any one who wants one can
get one.  If you can produce a single system image, the big iron guys
can tweak the startup routing and run that on their giant NUMA or SMP
machines.

Eric
