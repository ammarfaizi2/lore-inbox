Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263989AbTDNVuq (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263986AbTDNVuH (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:50:07 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:22026
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263982AbTDNVsv 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:48:51 -0400
Subject: Re: [RFC] 2.5 TASK_INTERRUPTIBLE preemption race
From: Robert Love <rml@tech9.net>
To: Joe Korty <joe.korty@ccur.com>
Cc: Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030414215410.GA18922@rudolph.ccur.com>
References: <20030414215410.GA18922@rudolph.ccur.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050357642.3664.89.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 14 Apr 2003 18:00:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 17:54, Joe Korty wrote:

> Is this analysis correct?  If it is, perhaps there is an alternative
> to fixing these cases individually: make the TASK_INTERRUPTIBLE/
> TASK_UNINTERRUPTIBLE states block preemption.  In which case the
> 'set_current_state(TASK_RUNNING)' macro would need to include the
> same preemption check as 'preemption_enable'.

Thankfully you are wrong or we would have some serious problems :)

See kernel/sched.c :: preempt_schedule() where we set p->preempt_count
to PREEMPT_ACTIVE.

Then see kernel/sched.c :: schedule() where we short-circuit the
remove-from-runqueue code if PREEMPT_ACTIVE is set.

Thus, it is safe to preempt regardless of the task's state.  It will
eventually reschedule.

	Robert Love

