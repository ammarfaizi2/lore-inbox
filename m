Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161419AbWASVIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161419AbWASVIk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161421AbWASVIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:08:40 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:9194
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1161419AbWASVIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:08:39 -0500
Subject: Re: [PATCH] Clean up of hrtimer code.
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: george@mvista.com
Cc: Lee Revell <rlrevell@joe-job.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <43CFFC60.8010405@mvista.com>
References: <43CEF172.2000308@mvista.com>
	 <1137701896.7947.56.camel@localhost.localdomain>
	 <43CFFC60.8010405@mvista.com>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 22:09:14 +0100
Message-Id: <1137704954.7947.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George,

On Thu, 2006-01-19 at 12:53 -0800, George Anzinger wrote:
> > The assumption that the CLOCK_REALTIME/MONOTONIC relationship is valid
> > for all additional clocks is not correct.
> 
> Well, it is until it isn't.  There really does need to be a paring of some 
> sort to sort out the ABS flag.

How is this applicable to some additional non posix clocks ? It applies
to CLOCK_MONOTONIC and CLOCK_REALTIME, but nothing speaks against
implementing CLOCK_WHATEVER with a totally different behaviour vs. the
ABS_TIME flag. Am I missing something ?

> >> 
> >> static inline int common_timer_create(struct k_itimer *new_timer)
> >> {
> >>-	hrtimer_init(&new_timer->it.real.timer, new_timer->it_clock);
> > 
> > 
> > I kept that init as a dummy one. Thats simpler than adding all the 
> > if(!base) stuff into the hrtimer code. Not having those checks gives a
> > nice oops, when somebody tries to access a non initialized hrtimer !
> 
> An additional problem that you may want to address it that the SIGEV_NONE 
> timers never get their time set (that being done by being put in the timer 
> queue) and so the return value on a timer_gettime() is wrong.  I have updated 
> the absolute timer test on sourceforge (in the CVS) to test for this, and, of 
> course it fails.  I, in one version, added a NO_QUEUE flag to the mode to 
> tell the enqueue_timer code to return just prior to actually doing the 
> enqueue to handle this.  The other possibility is to fill the expire time in 
> in posix-timers.c, but that means it has to do stuff that is already coded in 
> enqueue_timer.  Your choice, but currently what happens is wrong.

Thanks for pointing this out. I fix this before pushing stuff.

	tglx


