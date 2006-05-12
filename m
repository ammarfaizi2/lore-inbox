Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWELRrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWELRrr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 13:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWELRrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 13:47:47 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:12504 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932176AbWELRrq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 13:47:46 -0400
Subject: Re: [RFC][PATCH -rt] irqd starvation on SMP by a single process?
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20060512055025.GA25824@elte.hu>
References: <1147401812.1907.14.camel@cog.beaverton.ibm.com>
	 <20060512055025.GA25824@elte.hu>
Content-Type: text/plain
Date: Fri, 12 May 2006 10:47:41 -0700
Message-Id: <1147456061.9343.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-12 at 07:50 +0200, Ingo Molnar wrote:
> * john stultz <johnstul@us.ibm.com> wrote:
> > +		if(!cpus_equal(current->cpus_allowed, irq_affinity[irq]));
> > +			set_cpus_allowed(current, irq_affinity[irq]);
> 
> > The patch below appears to correct this issue, however it also
> > repeatedly(on different irqs) causes the following BUG:
> 
> ah. This actually uncovered a real bug. We were calling __do_softirq() 
> with interrupts enabled (and being preemptible) - which is certainly 
> bad.
> 
> this was hidden before because the smp_processor_id() debugging code 
> handles tasks bound to a single CPU as per-cpu-safe.
> 
> could you check the (totally untested) patch below and see if that fixes 
> things for you? I've also added your affinity change.

Yep, no BUG messages and I get irq affinity behavior that matches what I
echo into the proc interface.

Looks good to me so far. I'll keep running w/ it and let you know if we
see any issues.

thanks
-john

