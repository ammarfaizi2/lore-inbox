Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263993AbTDNWQ2 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264009AbTDNWQ2 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:16:28 -0400
Received: from users.ccur.com ([208.248.32.211]:61113 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S263993AbTDNWQY (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 18:16:24 -0400
Date: Mon, 14 Apr 2003 18:27:51 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5 TASK_INTERRUPTIBLE preemption race
Message-ID: <20030414222750.GA19050@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <20030414215410.GA18922@rudolph.ccur.com> <1050357642.3664.89.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050357642.3664.89.camel@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 06:00:42PM -0400, Robert Love wrote:
> On Mon, 2003-04-14 at 17:54, Joe Korty wrote:
> 
> > Is this analysis correct?  If it is, perhaps there is an alternative
> > to fixing these cases individually: make the TASK_INTERRUPTIBLE/
> > TASK_UNINTERRUPTIBLE states block preemption.  In which case the
> > 'set_current_state(TASK_RUNNING)' macro would need to include the
> > same preemption check as 'preemption_enable'.
> 
> Thankfully you are wrong or we would have some serious problems :)
> 
> See kernel/sched.c :: preempt_schedule() where we set p->preempt_count
> to PREEMPT_ACTIVE.
> 
> Then see kernel/sched.c :: schedule() where we short-circuit the
> remove-from-runqueue code if PREEMPT_ACTIVE is set.
> 
> Thus, it is safe to preempt regardless of the task's state.  It will
> eventually reschedule.
> 
> 	Robert Love


I see.  It is because the 'goto pick_next_task' skips the
'deactivate_task' call.  Therefore the previous task remains on the
run queue in spite of its TASK_UNINTERRUPTIBLE state.  Clever!

Joe
