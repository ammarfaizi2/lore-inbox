Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRADXMS>; Thu, 4 Jan 2001 18:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131598AbRADXMJ>; Thu, 4 Jan 2001 18:12:09 -0500
Received: from mercury.Sun.COM ([192.9.25.1]:44441 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S129267AbRADXL7>;
	Thu, 4 Jan 2001 18:11:59 -0500
Message-ID: <3A550433.52982189@sun.com>
Date: Thu, 04 Jan 2001 15:16:04 -0800
From: ludovic fernandez <ludovic.fernandez@sun.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14-15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@norran.net>
CC: Daniel Phillips <phillips@innominate.de>,
        george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
In-Reply-To: <3A53D863.53203DF4@sun.com> <3A5427A6.26F25A8A@innominate.de> <3A5437A1.F540D794@sun.com> <01010423104900.01080@dox>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Larsson wrote:

> On Thursday 04 January 2001 09:43, ludovic fernandez wrote:
>
> > I'm not convinced a full preemptive kernel is something
> > interesting mainly due to the context switch cost (actually mmu contex
> > switch).
>
> It will NOT be fully, it will be mostly.
> You will only context switch when a higher prio thread gets runnable, two
> ways:
> 1) external intterupt waking higher prio process, same context swithes as
> when running in user code. We won't get more interrupts.
> 2) wake up due to something we do. Not that many places, mostly due to
> releasing syncronization objects (spinlocks does not count).
>
> If this still is a problem, we can select to only preemt to processes running
> RT stuff. SCHED_FIFO and SCHED_RR by letting them set need_resched to 2...
> > What about only preemptable kernel threads ?
>
> No, it won't help enough.
>

This is not the point I was trying to make .....
So far we are talking about real time behaviour. This is a very interesting/exciting
thing and we all agree it's a huge task which goes much more behind
just having a preemptive kernel.
I'm not convinced that a preemptive kernel is interesting for apps using
the time sharing scheduling, mainly because it is not deterministic and the
price of a mmu conntext switch is still way to heavy (that's my 2 cents belief
anyway).
But, having a preemptive kernel could be interesting for an another issue.
More and more the linux kernel is using the concept of kernel threads to
defer part of the processing. Right now they are not preemptable and one
has to put explicit preemption points. I believe this solution doesn't fly in
the long term (the code changes, the locking design changes and the
preemption points become irrelevant). They could be preemptable because
they have a way of being deterministic (preemption disable) and they
are lightweight to schedule since they don't use a mmu context.

Ludo.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
