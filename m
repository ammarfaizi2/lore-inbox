Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWERLYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWERLYr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 07:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWERLYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 07:24:47 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:26519 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750825AbWERLYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 07:24:46 -0400
Date: Thu, 18 May 2006 13:24:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       Lee Revell <rlrevell@joe-job.com>, lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: rt20 scheduling latency testcase and failure data
Message-ID: <20060518112435.GA10463@elte.hu>
References: <200605121924.53917.dvhltc@us.ibm.com> <200605151830.23544.dvhltc@us.ibm.com> <1147764175.3970.33.camel@frecb000686> <200605180214.05690.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605180214.05690.dvhltc@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Darren Hart <dvhltc@us.ibm.com> wrote:

> yet to see a missed period with the version of the program.  While 
> getting to this point, I did see some things that concerned me:
> 
> sched_la-4856  3D... 4083us!: math_state_restore (device_not_available)
> sched_la-4856  3D... 16033us : smp_apic_timer_interrupt (4b3b98e8 0 0)
> 
> Am I reading that right?  12ms to complete math_state_restore()?  What 
> does "device_not_available" mean here?

no - the kernel returned to userspace after doing the 
math_state_restore, and the next thing you saw is the timer IRQ. The 
tracer traces function entries, but not function exits.

> Here are some other similar traces:
> 
> sched_la-5008  2D... 4104us!: math_state_restore (device_not_available)
> sched_la-5008  2.... 4992us > sys_clock_gettime (00000001 b7fc8378 0000007b)

same here: we returned to userspace after FPU restore, and the next 
thing was a sys_clock_gettime() syscall ~800 usecs later.

	Ingo
