Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282502AbRKZUnB>; Mon, 26 Nov 2001 15:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282501AbRKZUl4>; Mon, 26 Nov 2001 15:41:56 -0500
Received: from [208.129.208.52] ([208.129.208.52]:25096 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S282499AbRKZUj6>; Mon, 26 Nov 2001 15:39:58 -0500
Date: Mon, 26 Nov 2001 12:49:47 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Kravetz <kravetz@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler Cleanup
In-Reply-To: <20011126114610.B1141@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.40.0111261240230.1674-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Mike Kravetz wrote:

> I'm happy to see the cleanup of scheduler code that went into
> 2.4.15/16.  One small difference in behavior (I think) is that
> the currently running task is not given preference over other
> tasks on the runqueue with the same 'goodness' value.  I would
> think giving the current task preference is a good thing
> (especially in light of recent discussions about too frequent
> moving/rescheduling of tasks).  Can someone provide the rational
> for this change?  Was it just the result of making the code
> cleaner?  Is it believed that this won't really make a difference?

Mike, I was actually surprised about the presence of that check inside the
previous code.
If you think about it, when a running task is scheduled ?

1) an IRQ wakeup some I/O bound task
2) the quota is expired

With 1) you've an incoming I/O bound task ( ie: ksoftirqd_* ) that is very
likely going to have a better dynamic priority ( if not reschedule_idle()
does not set need_resched ), while with 2) you've the task counter == 0.
In both cases not only the test is useless but is going to introduce 1)
the branch in the fast path 2) the cost of an extra goodness().




- Davide



