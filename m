Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284300AbRLXBSY>; Sun, 23 Dec 2001 20:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284301AbRLXBSO>; Sun, 23 Dec 2001 20:18:14 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:40205 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284300AbRLXBR6>; Sun, 23 Dec 2001 20:17:58 -0500
Date: Sun, 23 Dec 2001 17:20:26 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Victor Yodaiken <yodaiken@fsmlabs.com>
cc: george anzinger <george@mvista.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
In-Reply-To: <20011223171915.B19931@hq2>
Message-ID: <Pine.LNX.4.40.0112231708361.971-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001, Victor Yodaiken wrote:

> On Thu, Dec 20, 2001 at 02:36:07PM -0800, Davide Libenzi wrote:
> > > My understanding of the POSIX standard is the the highest priority
> > > task(s) are to get the cpu(s) using the standard calls.  If you want to
> > > deviate from this I think the standard allows extensions, but they IMHO
> > > should be requested, not the default, so I would turn your flag around
> > > to force LOCAL, not GLOBAL.
> >
> > So, you're basically saying that for a better standard compliancy it's
> > better to have global preemption policy by default. And having users to
> > request rt tasks localization explicitly. It's fine for me.
>
> Can you please cite the passaaages in the standrd you have in mind?

POSIX 1003. The doubt was if ( since the POSIX standard does not talk
about SMP ) the real time priorities apply to CPU or to the entire system.
This because the scheduler i'm working on has two kind of RT tasks, local
and global ones. Local RT tasks cannot preempt remote CPU so if, for
example, one RT task is woke up and its last CPU is running another RT
task with higher priority, the fresly woke up task will wait even if other
CPUs are running tasks wil lower priority. Global RT task will force
remote preemption in case the last CPU that ran the woke up RT task is
running another higher priority RT task. Global RT tasks have their own
queue and lock like CPUs. My old default was local RT task that was
forced by a setscheduler() flag SCHED_RTGLOBAL while George suggested that
it's better to have default global and to have this behavior forced by a
SCHED_RTLOCAL flag. I already changed the code to default to global.




- Davide


