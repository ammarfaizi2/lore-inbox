Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWA0MqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWA0MqY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 07:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWA0MqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 07:46:23 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:34004 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750967AbWA0MqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 07:46:23 -0500
Subject: Re: [RT] possible bug in trace_start_sched_wakeup
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060127094656.GA24878@elte.hu>
References: <1138327022.7814.8.camel@localhost.localdomain>
	 <1138336718.7814.41.camel@localhost.localdomain>
	 <20060127094656.GA24878@elte.hu>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 07:46:18 -0500
Message-Id: <1138365978.8988.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-27 at 10:46 +0100, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> >  	spin_lock(&sch.trace_lock);
> > -	if (sch.task && (sch.task->prio >= p->prio))
> > +	if (sch.task && ((sch.task->prio <= p->prio) || !rt_task(p)))
> >  		goto out_unlock;
> 
> good catch - but i'd not do the !rt_task(p) condition, because e.g. PI 
> related priority boosting works _without_ changing p->policy. So it is 
> p->prio that controls. I.e. a simple "sch.task->prio <= p->prio" should 
> be enough.

Ah, I don't know what I was thinking about the rt_task part (I was
working on very little sleep).  You're right.  Nuke it!

Thanks,

-- Steve


