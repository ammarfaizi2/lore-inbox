Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135249AbREACjH>; Mon, 30 Apr 2001 22:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135264AbREACir>; Mon, 30 Apr 2001 22:38:47 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:19726 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S135249AbREACih>;
	Mon, 30 Apr 2001 22:38:37 -0400
Date: Mon, 30 Apr 2001 23:38:23 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        Linus Torvalds <torvalds@transmeta.com>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 sluggish under fork load
In-Reply-To: <20010430195149.F19620@athlon.random>
Message-ID: <Pine.LNX.4.21.0104302335490.19012-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Andrea Arcangeli wrote:
> On Sun, Apr 29, 2001 at 10:26:57AM +0200, Peter Osterlund wrote:

> > -	p->counter = current->counter;
> > -	current->counter = 0;
> > +	p->counter = (current->counter + 1) >> 1;
> > +	current->counter >>= 1;
> > +	current->policy |= SCHED_YIELD;
> >  	current->need_resched = 1;
> 
> please try to reproduce the bad behaviour with 2.4.4aa2. There's a bug
> in the parent-timeslice patch in 2.4 that I fixed while backporting it
> to 2.2aa and that I now forward ported the fix to 2.4aa. The fact
> 2.4.4 gives the whole timeslice to the child just gives more light to
> such bug.

The fact that 2.4.4 gives the whole timeslice to the child
is just bogus to begin with.

The problem people tried to solve was "make sure the kernel
runs the child first after a fork", this has just about
NOTHING to do with how the timeslice is distributed.

Now, since we are in a supposedly stable branch of the kernel,
why mess with the timeslice distribution between parent and
child?  The timeslice distribution that has worked very well
for the last YEARS...

I agree when people want to fix problems, but I really don't
think 2.4 is the time to also "fix" non-problems.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

