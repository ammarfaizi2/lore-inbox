Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVHATbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVHATbl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVHAT3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:29:33 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:56760 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261177AbVHAT1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:27:43 -0400
Subject: Re: [PATCH] Real-Time Preemption V0.7.52-07: rt_init_MUTEX_LOCKED
	declaration
From: Steven Rostedt <rostedt@goodmis.org>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: Luca Falavigna <dktrkranz@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@elte.hu
In-Reply-To: <1122923621.3024.55.camel@imap.mvista.com>
References: <42EE4D27.8060500@gmail.com>
	 <1122922658.6759.22.camel@localhost.localdomain>
	 <ff1cadb205080112051847d6eb@mail.gmail.com>
	 <1122923621.3024.55.camel@imap.mvista.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 01 Aug 2005 15:26:45 -0400
Message-Id: <1122924405.6759.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 12:13 -0700, Sven-Thorsten Dietrich wrote:
> On Mon, 2005-08-01 at 19:05 +0000, Luca Falavigna wrote:
> >
> > 
> > Another solution could be this (as shown in drivers/cpufreq/cpufreq.c):
> > -	init_MUTEX_LOCKED(&policy->lock);
> > +	init_MUTEX(&policy->lock);
> > +	down(&policy->lock);
> > -
> 
> If the semaphore is being used as a mutex, 
> then it could be converted to an RT-mutex.
> 
> That would nicely side-step the problem.
> 
> Note this won't work if you are counting with the sema.

Well it's not really a counter.  It's one of these situations where the
semaphore is locked on init, later someone else ups it on a trigger, and
then the most horrible, it gets down again on module exit! I'm not
really sure what it is doing. The only place that an up is called is on
the watchdog trigger.  I guess it's being used to not let you unload the
module if the watchdog hasn't gone off yet, or something to that effect.

-- Steve


