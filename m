Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315420AbSGIO30>; Tue, 9 Jul 2002 10:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSGIO3Z>; Tue, 9 Jul 2002 10:29:25 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:47083 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S315420AbSGIO3Z>; Tue, 9 Jul 2002 10:29:25 -0400
Date: Tue, 9 Jul 2002 16:00:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: Keith Owens <kaos@ocs.com.au>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
Message-ID: <20020709140052.GC277@elf.ucw.cz>
References: <20020708181331.GD28335@atrey.karlin.mff.cuni.cz> <21009.1026168230@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21009.1026168230@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> freeze_processes()
> >>   signal_wake_up() - sets TIF_SIGPENDING for other task
> >>     kick_if_running()
> >>       resched_task() - calls preempt_disable() for this cpu
> >>         smp_send_reschedule()
> >>           smp_reschedule_interrupt() - now on another cpu
> >>             ret_from_intr
> >>               resume_kernel - on other cpu
> >> 
> >> With CONFIG_PREEMPT, a process running on another cpu without a lock
> >> when freeze_processes() is called should immediately end up in
> >> schedule.  I don't see anything in that code path that disables
> >> preemption on other cpus.  If I am right, then a second cpu could be in
> >> this window when freeze_processes is called
> >> 
> >>   if (xxx->func)
> >>     xxx->func()
> >
> >okay, so we have
> >
> >	if (xxx->func)
> >		interrupt
> >			schedule()
> >
> >but schedule at this point is certainly not going to enter signal
> >handling code
> 
> With preempt it will.  The interrupt drops back through ret_from_intr
> -> resume_kernel.  The preempt count is 0, preemption has only been
> disabled on the sending cpu, not the receiving cpu.  need_resched is
> entered immediately.

Yep but signal handling code will not be entered because signal
handling is only entered when returning to userspace.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
