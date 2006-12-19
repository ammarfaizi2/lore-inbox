Return-Path: <linux-kernel-owner+w=401wt.eu-S933010AbWLSV12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933010AbWLSV12 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933017AbWLSV12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:27:28 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55830 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933010AbWLSV11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:27:27 -0500
Date: Tue, 19 Dec 2006 22:24:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux@bohmer.net
Cc: linux-kernel@vger.kernel.org, Clark Williams <williams@redhat.com>
Subject: Re: [BUG+PATCH] RT-Preempt: IRQ threads running at prio 0 SCHED_OTHER
Message-ID: <20061219212427.GA11516@elte.hu>
References: <3efb10970612191252m33e7b88cydca7fb488251ee35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3efb10970612191252m33e7b88cydca7fb488251ee35@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Remy Bohmer <l.pinguin@gmail.com> wrote:

> Hello Ingo,
> 
> I am using your yum-distributed kernel 2.6.19.1-rt15, and 
> unfortunately I experienced very worse latencies. It turned out that 
> ALL the IRQ threads were all running at prio 0, SCHED_OTHER.
> 
> Looking at the current code in kernel/irq/manage.c, the goal was to 
> put them at MAX_RT_PRIO, but the call to sys_sched_setscheduler() 
> fails with EINVAL. I have attached a patch to set them to 
> (MAX_RT_PRIO-1). This works.

oops - my intention was to set all IRQs and softirqs to SCHED_FIFO prio 
50. I have fixed that now in my tree.

prio 99 is pretty extensive and makes it hard to move tasks 'above' 
hardirq priority, without setting the priority of /every/ IRQ thread. So 
i picked SCHED_FIFO:50 - at exact half way.

> Further I believe that each application of the RT-kernel requires a 
> different configuration of these thread-priorities and I prefer to 
> reconfigure these prios from userland during boot. As these 
> threadnames contain whitespaces in its name, they make the 
> shell-scripts unnecessary complex that I use to reconfigure the thread 
> priorities.

ok - lets try it. Clark: does this impact the set_kthread_prio utility? 
I've changed "IRQ 123" to "IRQ-123" to make pidof & friends work better.

	Ingo
