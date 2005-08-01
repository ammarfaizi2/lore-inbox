Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVHATOC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVHATOC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVHATOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:14:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:65265 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261155AbVHATOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:14:01 -0400
Subject: Re: [PATCH] Real-Time Preemption V0.7.52-07: rt_init_MUTEX_LOCKED
	declaration
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@elte.hu
In-Reply-To: <ff1cadb205080112051847d6eb@mail.gmail.com>
References: <42EE4D27.8060500@gmail.com>
	 <1122922658.6759.22.camel@localhost.localdomain>
	 <ff1cadb205080112051847d6eb@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 12:13:41 -0700
Message-Id: <1122923621.3024.55.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 19:05 +0000, Luca Falavigna wrote:
> > The patch you wanted to send was:
> > 
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > 
> > Index: linux_realtime_ernie/drivers/char/watchdog/cpu5wdt.c
> > ===================================================================
> > --- linux_realtime_ernie/drivers/char/watchdog/cpu5wdt.c        (revision 265)
> > +++ linux_realtime_ernie/drivers/char/watchdog/cpu5wdt.c        (working copy)
> > @@ -56,7 +56,7 @@
> >  /* some device data */
> > 
> >  static struct {
> > -       struct semaphore stop;
> > +       struct compat_semaphore stop;
> >         volatile int running;
> >         struct timer_list timer;
> >         volatile int queue;
> 
> Another solution could be this (as shown in drivers/cpufreq/cpufreq.c):
> -	init_MUTEX_LOCKED(&policy->lock);
> +	init_MUTEX(&policy->lock);
> +	down(&policy->lock);
> -

If the semaphore is being used as a mutex, 
then it could be converted to an RT-mutex.

That would nicely side-step the problem.

Note this won't work if you are counting with the sema.

Sven


