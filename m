Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWAEMTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWAEMTV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 07:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWAEMTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 07:19:21 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:16610 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751458AbWAEMTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 07:19:21 -0500
Subject: Re: sched.c:659 dec_rt_tasks BUG with patch-2.6.15-rt1
	(realtime-preempt)
From: Steven Rostedt <rostedt@goodmis.org>
To: Nedko Arnaudov <nedko@arnaudov.name>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <87u0cj3saf.fsf@arnaudov.name>
References: <87ek3ug314.fsf@arnaudov.name> <87mzie2tzu.fsf@arnaudov.name>
	 <20060102214516.GA12850@elte.hu> <87lkxyrzby.fsf_-_@arnaudov.name>
	 <87u0cj5riq.fsf_-_@arnaudov.name>
	 <1136436273.12468.113.camel@localhost.localdomain>
	 <87u0cj3saf.fsf@arnaudov.name>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 07:19:12 -0500
Message-Id: <1136463552.12468.119.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 12:03 +0200, Nedko Arnaudov wrote:
> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > Could you send me your .config.  And this is a smp machine right?
> 
> No it is not. Sending you my config personally.
> 

The reason that I asked is that sched.c:659 looks like this:

static inline void dec_rt_tasks(task_t *p, runqueue_t *rq)
{
#if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
	if (rt_task(p)) {
		WARN_ON(!rq->rt_nr_running);
		rq->rt_nr_running--;
		if (rq->rt_nr_running == 1)
			atomic_dec(&rt_overload);
	}
#endif
}

And so that will only get into that path on a SMP configured system. But
although you are not running on an SMP machine, here's what's in
your .config.

CONFIG_SMP=y
CONFIG_NR_CPUS=8

Although this should not bug, and I'm going to try this config on a UP
machine myself to see if I can reproduce your problem, I'd suggest to
you to turn off the SMP configuration.

-- Steve


