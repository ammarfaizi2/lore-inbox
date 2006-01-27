Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWA0Mrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWA0Mrh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 07:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWA0Mrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 07:47:37 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:53208 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965005AbWA0Mrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 07:47:36 -0500
Subject: Re: [RT] possible bug in trace_start_sched_wakeup
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060127095449.GC24878@elte.hu>
References: <1138327022.7814.8.camel@localhost.localdomain>
	 <1138336718.7814.41.camel@localhost.localdomain>
	 <20060127095449.GC24878@elte.hu>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 07:47:31 -0500
Message-Id: <1138366051.8988.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-27 at 10:54 +0100, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> >  			trace_special_pid(sch.task->pid, sch.task->prio, p->prio);
> > -		if (sch.task && (sch.task->prio >= p->prio))
> > +		if (sch.task && ((sch.task->prio <= p->prio) || !rt_task(p)))
> >  			sch.task = NULL;
> 
> this second condition i'd not change: it just expresses the rare case 
> where a higher-prio task hits the CPU that we somehow did not start to 
> trace. In that case we just zap the current trace.
> 

OK, I think I understand that part now too.  There wasn't any comments
about what it was doing so I wasn't sure if that was the right move.
But looking at it further, I believe you are right.

Thanks,

-- Steve


