Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281808AbRK0XJy>; Tue, 27 Nov 2001 18:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282984AbRK0XJo>; Tue, 27 Nov 2001 18:09:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:42475 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S281808AbRK0XJ3>;
	Tue, 27 Nov 2001 18:09:29 -0500
Date: Wed, 28 Nov 2001 02:07:08 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler Cleanup
In-Reply-To: <20011126114610.B1141@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0111280145300.3429-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Nov 2001, Mike Kravetz wrote:

> I'm happy to see the cleanup of scheduler code that went into
> 2.4.15/16.  One small difference in behavior (I think) is that the
> currently running task is not given preference over other tasks on the
> runqueue with the same 'goodness' value.  I would think giving the
> current task preference is a good thing (especially in light of recent
> discussions about too frequent moving/rescheduling of tasks).  Can
> someone provide the rational for this change?  Was it just the result
> of making the code cleaner?  Is it believed that this won't really
> make a difference?

i've done this change as part of the sched_yield() fixes/cleanups, and the
main reason for it is that the current process is preferred *anyway*, due
to getting the +1 boost via current->mm == this_mm in goodness().

(and besides, the percentage/probability of cases where we'd fail reselect
a runnable process where the previous scheduler would reselect it is very
very low. It does not justify adding a branch to the scheduler hotpath
IMO. In 99.9% of the cases if a runnable process is executing schedule()
then there is a higher priority process around that will win the next
selection. Or if there is a wakeup race, then the process will win the
selection very likely because it won the previous selection.)

	Ingo

