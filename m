Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129985AbRAVSS6>; Mon, 22 Jan 2001 13:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133001AbRAVSSj>; Mon, 22 Jan 2001 13:18:39 -0500
Received: from gateway.sequent.com ([192.148.1.10]:15584 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S129985AbRAVSSb>; Mon, 22 Jan 2001 13:18:31 -0500
Date: Mon, 22 Jan 2001 10:17:38 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: more on scheduler benchmarks
Message-ID: <20010122101738.B7427@w-mikek.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
