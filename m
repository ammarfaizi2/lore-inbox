Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287367AbRL3KBo>; Sun, 30 Dec 2001 05:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287370AbRL3KBf>; Sun, 30 Dec 2001 05:01:35 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:11002 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S287367AbRL3KB2> convert rfc822-to-8bit; Sun, 30 Dec 2001 05:01:28 -0500
Message-ID: <3C2EE5DC.6EB60E17@mvista.com>
Date: Sun, 30 Dec 2001 02:01:00 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Martin Knoblauch <knobi@sirius-cafe.de>,
        Davide Libenzi <davidel@xmailserver.org>, Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
In-Reply-To: <200112291907.LAA25639@messenger.mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:
> 
> Martin Knoblauch wrote:
> >
> > > Re: [RFC] Scheduler issue 1, RT tasks ...
> > >
> > > >
> > > > Right, that was my question. George says, in your words, "for better
> > >
> > > > standards compliancy ..." and I want to know why you guys think
> > > that.
> > >
> > > The thought was that if someone need RT tasks he probably need a very
> > > low latency and so the idea that by applying global preemption decisions
> > > would lead to a better compliancy. But i'll be happy to ear that this is
> > > false anyway ...
> > >
> >
> >  without wanting to start a RT flame-fest, what do people really want
> > when they talk about RT in this [Linux] context:
> >
> > - very low latency
> > - deterministic latency ("never to exceed")
> > - both
> > - something completely different
> >
> > All of the above from time to time and user to user.  That is, some
> > folks want one or more of the above, some folks want more, some less.
> > What is really up?  Well they have a job to do that requires certain
> > things.  Different jobs require different capabilities.  It is hard to
> > say that any given system will do a reasonably complex job with out
> > testing.  For example we may have the required latency but find the
> > system fails because, to get the latency, we preempted another task that
> > was (and so still is) in the middle of updating something we need to
> > complete the job.
> 
> So George what direction should I try for some tests?
> 2.4.17 plus your and Robert's preempt plus lock-break?
> Add your high-res-timers, rtscheduler or both?
> Do they apply against 2.4.17/2.4.18-pre1?
> A combination of the above plus Davide's BMQS?

I would guess you want preempt plus lock-break at least.  rtsched may
give a small improvement if you run any real time (i.e. not SCHED_OTHER)
tasks (and the improvement should be in both real time and non-real time
preemption) but, in general, the schedule is not any where near the
problem the long held locks are so I really don't expect to see much
improvement here.  If you have a lot of task on the system (not active,
just there) you may see the "recalculate" with the standard scheduler
which is much improved with rtsched (it does not include tasks not in
the run list in the recalculate).

As for high-res-timers, I just put out a 2.4.13 version which should
work on 2.4.17 (there are rejects in the patch, but all in non-i386
code).  I have one report, however, of asm errors which seem to depend
on the compiler (or asm) version.  I will look into this and put up a
2.4.17 version early next week.  Testing wise, I don't think this will
be visible because you most likely are not using POSIX timers.  There is
a change in the timer list structure, but that should be in the noise
also.  In short, the high-res-timers project provides new capability,
not improved performance with existing capability.
> 
> I ask because my MP3/Ogg-Vorbis hiccup during dbench isn't solved anyway.
> Running 2.4.17 + preempt + lock-break + 10_vm-21 (AA).
> Some wisdom?

Try the preempt-stats patch and collect data during the hiccup.  It
should point the finger at the problem.  Let us know what you find. 
Robert has been very good at fixing things like this with his lock-break
stuff, but we/he need to know who the bad guy is.
> 
> Thank you for all your work and
>                         Happy New Year
> 
> -Dieter
> --
> Dieter Nützel
> Graduate Student, Computer Science
> 
> University of Hamburg
> Department of Computer Science
> @home: Dieter.Nuetzel@hamburg.de

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
