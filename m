Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135199AbRAVT0P>; Mon, 22 Jan 2001 14:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135196AbRAVT0F>; Mon, 22 Jan 2001 14:26:05 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:32916 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S133010AbRAVTZs>;
	Mon, 22 Jan 2001 14:25:48 -0500
Importance: Normal
Subject: Re: [Lse-tech] more on scheduler benchmarks
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFD98AF4AA.8482CDDD-ON852569DC.0069E839@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Mon, 22 Jan 2001 14:27:03 -0500
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.6 |December 14, 2000) at
 01/22/2001 02:25:44 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mike,

Deactivating that optimization is a good idea.
What we are interested in is what the general latency of the scheduler code
is. This should help to determine that.

The only problem I have with sched_yield like benchmarks is that it creates
artificial lock contention as we basically spent most of the time other
then context switching + syscall under the scheduler lock. This we won't
see in real apps, that's why I think the chatroom numbers are probably
better indicators.


Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Mike Kravetz <mkravetz@sequent.com>@lists.sourceforge.net on 01/22/2001
01:17:38 PM

Sent by:  lse-tech-admin@lists.sourceforge.net


To:   lse-tech@lists.sourceforge.net
cc:   linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject:  [Lse-tech] more on scheduler benchmarks



Last week while discussing scheduler benchmarks, Bill Hartner
made a comment something like the following "the benchmark may
not even be invoking the scheduler as you expect".  This comment
did not fully sink in until this weekend when I started thinking
about changes made to sched_yield() in 2.4.0.  (I'm cc'ing Ingo
Molnar because I think he was involved in the changes).  If you
haven't taken a look at sys_sched_yield() in 2.4.0, I suggest
that you do that now.

A result of new optimizations made to sys_sched_yield() is that
calling sched_yield() does not result in a 'reschedule' if there
are no tasks waiting for CPU resources.  Therefore, I would claim
that running 'scheduler benchmarks' which loop doing sched_yield()
seem to have little meaning/value for runs where the number of
looping tasks is less than then number of CPUs in the system.  Is
that an accurate statement?

If the above is accurate, then I am wondering what would be a
good scheduler benchmark for these low task count situations.
I could undo the optimizations in sys_sched_yield() (for testing
purposes only!), and run the existing benchmarks.  Can anyone
suggest a better solution?

Thanks,
--
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
15450 SW Koll Parkway
Beaverton, OR 97006-6063                     (503)578-3494

_______________________________________________
Lse-tech mailing list
Lse-tech@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/lse-tech



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
