Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270129AbTGSQpy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 12:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270217AbTGSQpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 12:45:53 -0400
Received: from pop.gmx.de ([213.165.64.20]:29321 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270129AbTGSQpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 12:45:43 -0400
Message-Id: <5.2.1.1.2.20030719184847.01ad4ce8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sat, 19 Jul 2003 19:04:53 +0200
To: Davide Libenzi <davidel@xmailserver.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O6int for interactivity 
Cc: Valdis.Kletnieks@vt.edu,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0307181333520.5608@bigblue.dev.mcafeelabs.co
 m>
References: <5.2.1.1.2.20030718221052.01a88eb8@pop.gmx.net>
 <200307181739.h6IHdFq3006996@turing-police.cc.vt.edu>
 <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <200307170030.25934.kernel@kolivas.org>
 <200307170030.25934.kernel@kolivas.org>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
 <5.2.1.1.2.20030718174433.01b12878@pop.gmx.net>
 <Pine.LNX.4.55.0307180951050.5608@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.55.0307181004200.5608@bigblue.dev.mcafeelabs.com>
 <200307181739.h6IHdFq3006996@turing-police.cc.vt.edu>
 <5.2.1.1.2.20030718221052.01a88eb8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:38 PM 7/18/2003 -0700, Davide Libenzi wrote:
>On Fri, 18 Jul 2003, Mike Galbraith wrote:
>
> > >I'm sorry to say that guys, but I'm afraid it's what we have to do. We did
> > >not think about it when this scheduler was dropped inside 2.5 sadly. The
> > >interactivity concept is based on the fact that a particular class of
> > >tasks characterized by certain sleep->burn patterns are never expired and
> > >eventually, only oscillate between two (pretty high) priorities. Without
> > >applying a global CPU throttle for interactive tasks, you can create a
> > >small set of processes (like irman does) that hit the coded sleep->burn
> > >pattern and that make everything is running with priority lower than the
> > >lower of the two of the oscillation range, to almost completely starve.
> > >Controlled unfairness would mean throttling the CPU time we reserve to
> > >interactive tasks so that we always reserve a minimum time to non
> > >interactive processes.
> >
> > I'd like to find a way to prevent that instead.  There's got to be a way.
>
>Remember that this is computer science, that is, for every problem there
>"at least" one solution ;)

As incentive for other folks to think about the solution I haven't been 
able to come up with, I think I'll post what I do about it here, and 
threaten to submit it for inclusion ;-) ...

> > It's easy to prevent irman type things from starving others permanently (i
> > call this active starvation, or wakeup starvation), and this does something
> > fairly similar to what you're talking about.  Just crawl down the queue
> > heads looking for the oldest task periodically instead of always taking the
> > highest queue.  You can do that very fast, and it does prevent active
> > starvation.
>
>Everything that will make the scheduler to say "ok, I gave enough time to
>interactive tasks, now I'm really going to spin one from the masses" will
>work. Having a clean solution would not be an option here.

... just as soon as I get my decidedly unclean work-around functioning at 
least as well as it did for plain old irman.   irman2 is _much_ more evil 
than irman ever was (wow, good job!).  I thought it'd be a half an hour 
tops.  This little bugger shows active starvation, expired starvation, 
priority inflation, _and_ interactive starvation (i have to keep inventing 
new terms to describe things i see.. jeez this is a good testcase).

         -Mike 

