Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTGODqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 23:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbTGODqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 23:46:43 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:29916 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264551AbTGODqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 23:46:31 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] N1int for interactivity
Date: Tue, 15 Jul 2003 14:03:33 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, efault@gmx.de, felipe_alfaro@linuxmail.org
References: <200307151355.23586.kernel@kolivas.org> <20030714205915.5a4c8d16.akpm@osdl.org>
In-Reply-To: <20030714205915.5a4c8d16.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307151403.33321.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003 13:59, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > I've modified Mike Galbraith's nanosleep work for greater resolution to
> > help the interactivity estimator work I've done in the O*int patches.
> >
> > +inline void __scheduler_tick(runqueue_t *rq, task_t *p)
>
> Two callsites, this guy shouldn't be inlined.
>
> Should it have static scope?  The code as-is generates a third copy...
>
> >  static unsigned long long monotonic_clock_tsc(void)
> >  {
> >  	unsigned long long last_offset, this_offset, base;
> > -
> > +	unsigned long flags;
> > +
> >  	/* atomically read monotonic base & last_offset */
> > -	read_lock_irq(&monotonic_lock);
> > +	read_lock_irqsave(&monotonic_lock, flags);
> >  	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
> >  	base = monotonic_base;
> > -	read_unlock_irq(&monotonic_lock);
> > +	read_unlock_irqrestore(&monotonic_lock, flags);
> >
> >  	/* Read the Time Stamp Counter */
>
> Why do we need to take a global lock here?  Can't we use
> get_cycles() or something?
>
>
> Have all the other architectures been reviewed to see if they need this
> change?

I'm calling for help here. This is getting way out of my depth; I've simply 
applied Mike's patch.

Con

