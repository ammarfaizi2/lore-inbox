Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286209AbRL0Dt0>; Wed, 26 Dec 2001 22:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286207AbRL0DtQ>; Wed, 26 Dec 2001 22:49:16 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:28934 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S286197AbRL0DtJ>;
	Wed, 26 Dec 2001 22:49:09 -0500
Date: Wed, 26 Dec 2001 20:42:15 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>,
        george anzinger <george@mvista.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
Message-ID: <20011226204215.A1007@hq2>
In-Reply-To: <20011223171915.B19931@hq2> <Pine.LNX.4.40.0112231708361.971-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0112231708361.971-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.23i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2001 at 05:20:26PM -0800, Davide Libenzi wrote:
> On Sun, 23 Dec 2001, Victor Yodaiken wrote:
> 
> > On Thu, Dec 20, 2001 at 02:36:07PM -0800, Davide Libenzi wrote:
> > > > My understanding of the POSIX standard is the the highest priority
> > > > task(s) are to get the cpu(s) using the standard calls.  If you want to
> > > > deviate from this I think the standard allows extensions, but they IMHO
> > > > should be requested, not the default, so I would turn your flag around
> > > > to force LOCAL, not GLOBAL.
> > >
> > > So, you're basically saying that for a better standard compliancy it's
> > > better to have global preemption policy by default. And having users to
> > > request rt tasks localization explicitly. It's fine for me.
> >
> > Can you please cite the passaaages in the standrd you have in mind?
> 
> POSIX 1003. The doubt was if ( since the POSIX standard does not talk
> about SMP ) the real time priorities apply to CPU or to the entire system.

Right, that was my question. George says, in your words, "for better
standards compliancy ..." and I want to know why you guys think that.

> This because the scheduler i'm working on has two kind of RT tasks, local
> and global ones. Local RT tasks cannot preempt remote CPU so if, for
> example, one RT task is woke up and its last CPU is running another RT
> task with higher priority, the fresly woke up task will wait even if other
> CPUs are running tasks wil lower priority. Global RT task will force
> remote preemption in case the last CPU that ran the woke up RT task is
> running another higher priority RT task. Global RT tasks have their own
> queue and lock like CPUs. My old default was local RT task that was
> forced by a setscheduler() flag SCHED_RTGLOBAL while George suggested that
> it's better to have default global and to have this behavior forced by a
> SCHED_RTLOCAL flag. I already changed the code to default to global.



> 
> 
> 
> 
> - Davide
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
