Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130988AbRCJKIC>; Sat, 10 Mar 2001 05:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130993AbRCJKHw>; Sat, 10 Mar 2001 05:07:52 -0500
Received: from ppp-96-119-an01u-dada6.iunet.it ([151.35.96.119]:27652 "HELO
	home.bogus") by vger.kernel.org with SMTP id <S130988AbRCJKHl>;
	Sat, 10 Mar 2001 05:07:41 -0500
Message-ID: <XFMail.20010310123041.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010309164740.D1057@w-mikek2.sequent.com>
Date: Sat, 10 Mar 2001 12:30:41 +0100 (CET)
From: Davide Libenzi <davidel@xmailserver.org>
To: Mike Kravetz <mkravetz@sequent.com>
Subject: RE: sys_sched_yield fast path
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10-Mar-2001 Mike Kravetz wrote:
> Any thoughts about adding a 'fast path' to the SMP code in
> sys_sched_yield.  Why not compare nr_pending to smp_num_cpus
> before examining the aligned_data structures?  Something like,
> 
> if (nr_pending > smp_num_cpus)
>       goto set_resched_now;
> 
> Where set_resched_now is a label placed just before the code
> that sets the need_resched field of the current process.
> This would eliminate touching all the aligned_data cache lines
> in the case where nr_pending can never be decremented to zero.
> 
> Also, would it make sense to stop decrementing nr_pending to
> prevent it from going negative?  OR  Is the reasoning that in
> these cases there is so much 'scheduling' activity that we
> should force the reschedule?

Probably the rate at which is called sys_sched_yield() is not so high to let
the performance improvement to be measurable.
If You're going to measure the schedule() speed with the test program in which
the schedule() rate is the same of the sched_yield() rate, this could clean Your
measure of the schedule() speed.




- Davide

