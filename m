Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289729AbSAJWE2>; Thu, 10 Jan 2002 17:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289721AbSAJWEL>; Thu, 10 Jan 2002 17:04:11 -0500
Received: from mx2.elte.hu ([157.181.151.9]:55757 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289733AbSAJWD6>;
	Thu, 10 Jan 2002 17:03:58 -0500
Date: Fri, 11 Jan 2002 01:01:22 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, Mike Kravetz <kravetz@us.ibm.com>,
        Anton Blanchard <anton@samba.org>, george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
In-Reply-To: <Pine.LNX.4.33.0201101017380.2723-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201110034190.10579-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Jan 2002, Linus Torvalds wrote:

> Don't try to make the timer code know stuff that the timer code should
> not and does not know about. Just call the scheduler on each tick, and
> let the scheduler make its decision.

agreed, the -H4 patch implements this cleanup:

    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-pre11-H4.patch

the timer code calls the scheduler_tick() function once per local timer
interrupt. This function then decides whether the current task is idle or
not. (this should also fix the timeslice-expiration bug of any possibly
pid 0 process.)

(there is one small ugliness left, the function also has to be prepared
for a not yet complete scheduler state, rq->idle == NULL and rq->curr ==
NULL. I'll fix this later, it's a detail.)

(-H4 has been sanity-compiled & booted on SMP.)

other changes since -H1:

 - removed dead code from wakeup.

	Ingo

