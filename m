Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282956AbRK0Vy2>; Tue, 27 Nov 2001 16:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282976AbRK0VyS>; Tue, 27 Nov 2001 16:54:18 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:49914 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S282974AbRK0Vx5>; Tue, 27 Nov 2001 16:53:57 -0500
Message-ID: <3C040B58.E42B11DF@mvista.com>
Date: Tue, 27 Nov 2001 13:53:28 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shaya Potter <spotter@cs.columbia.edu>
CC: Davide Libenzi <davidel@xmailserver.org>,
        Mike Kravetz <kravetz@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler Cleanup
In-Reply-To: <Pine.LNX.4.40.0111261240230.1674-100000@blue1.dev.mcafeelabs.com> <1006894632.872.6.camel@zaphod>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaya Potter wrote:
> 
> On Mon, 2001-11-26 at 15:49, Davide Libenzi wrote:
> > On Mon, 26 Nov 2001, Mike Kravetz wrote:
> >
> > > I'm happy to see the cleanup of scheduler code that went into
> > > 2.4.15/16.  One small difference in behavior (I think) is that
> > > the currently running task is not given preference over other
> > > tasks on the runqueue with the same 'goodness' value.  I would
> > > think giving the current task preference is a good thing
> > > (especially in light of recent discussions about too frequent
> > > moving/rescheduling of tasks).  Can someone provide the rational
> > > for this change?  Was it just the result of making the code
> > > cleaner?  Is it believed that this won't really make a difference?
> >
> > Mike, I was actually surprised about the presence of that check inside the
> > previous code.
> > If you think about it, when a running task is scheduled ?
> >
> > 1) an IRQ wakeup some I/O bound task
> > 2) the quota is expired
> >
> > With 1) you've an incoming I/O bound task ( ie: ksoftirqd_* ) that is very
> > likely going to have a better dynamic priority ( if not reschedule_idle()
> > does not set need_resched ), while with 2) you've the task counter == 0.
> > In both cases not only the test is useless but is going to introduce 1)
> > the branch in the fast path 2) the cost of an extra goodness().
> 
> doesn't schedule() also get called when a new task is put on the
> runqueue?
> 
> when that happens, doesn't the check matter? or perhaps I'm just
> mistaken.
> 
That is the same as 1) above.  reschedule_idle() should determine if the
new task is to get the cpu and set need_resched as needed.

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
