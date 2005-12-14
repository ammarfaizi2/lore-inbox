Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbVLNNy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVLNNy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbVLNNy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:54:28 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:50098
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S964774AbVLNNy1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:54:27 -0500
Subject: Re: [ANNOUNCE] 2.6.15-rc5-hrt2 - hrtimers based high resolution
	patches
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1134568080.18921.42.camel@localhost.localdomain>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
	 <1134507927.18921.26.camel@localhost.localdomain>
	 <20051214084019.GA18708@elte.hu>  <20051214084333.GA20284@elte.hu>
	 <1134568080.18921.42.camel@localhost.localdomain>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 14 Dec 2005 15:01:06 +0100
Message-Id: <1134568867.4275.7.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 08:48 -0500, Steven Rostedt wrote:
> On Wed, 2005-12-14 at 09:43 +0100, Ingo Molnar wrote:
> > * Ingo Molnar <mingo@elte.hu> wrote:

> And going into gdb, I get:
> 
> (gdb) li *0xc0136b98
> 0xc0136b98 is in hrtimer_cancel (kernel/hrtimer.c:671).
> 666     int hrtimer_cancel(struct hrtimer *timer)
> 667     {
> 668             for (;;) {
> 669                     int ret = hrtimer_try_to_cancel(timer);
> 670
> 671                     if (ret >= 0)
> 672                             return ret;
> 673             }
> 674     }
> 675
> 
> So it may not really be locked, and if I waited a couple of hours, it
> might actually finish (the test usually takes a couple of minutes to
> run, and I let it run here for about 20 minutes).
> 
> Yeah, the above code would be very bad if this happens after preempting
> the running timer.
> 
> So the fix to this, in the case of preempting the softirq, that we need
> to introduce some wait queue that will allow processes to wait for the
> softirq to finish, and then the softirq will wake up all the processes.

We had the waitqueue in the ktimer based -rt patches and did not add it
back.

	tglx


