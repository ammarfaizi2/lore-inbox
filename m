Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282946AbRK0U56>; Tue, 27 Nov 2001 15:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282948AbRK0U5t>; Tue, 27 Nov 2001 15:57:49 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:15630 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S282946AbRK0U5j>;
	Tue, 27 Nov 2001 15:57:39 -0500
Subject: Re: Scheduler Cleanup
From: Shaya Potter <spotter@cs.columbia.edu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Mike Kravetz <kravetz@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0111261240230.1674-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.40.0111261240230.1674-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 27 Nov 2001 15:57:10 -0500
Message-Id: <1006894632.872.6.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-26 at 15:49, Davide Libenzi wrote:
> On Mon, 26 Nov 2001, Mike Kravetz wrote:
> 
> > I'm happy to see the cleanup of scheduler code that went into
> > 2.4.15/16.  One small difference in behavior (I think) is that
> > the currently running task is not given preference over other
> > tasks on the runqueue with the same 'goodness' value.  I would
> > think giving the current task preference is a good thing
> > (especially in light of recent discussions about too frequent
> > moving/rescheduling of tasks).  Can someone provide the rational
> > for this change?  Was it just the result of making the code
> > cleaner?  Is it believed that this won't really make a difference?
> 
> Mike, I was actually surprised about the presence of that check inside the
> previous code.
> If you think about it, when a running task is scheduled ?
> 
> 1) an IRQ wakeup some I/O bound task
> 2) the quota is expired
> 
> With 1) you've an incoming I/O bound task ( ie: ksoftirqd_* ) that is very
> likely going to have a better dynamic priority ( if not reschedule_idle()
> does not set need_resched ), while with 2) you've the task counter == 0.
> In both cases not only the test is useless but is going to introduce 1)
> the branch in the fast path 2) the cost of an extra goodness().

doesn't schedule() also get called when a new task is put on the
runqueue?

when that happens, doesn't the check matter? or perhaps I'm just
mistaken.

thanks,

shaya


