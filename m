Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWDFEKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWDFEKL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 00:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWDFEKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 00:10:11 -0400
Received: from mail.gmx.de ([213.165.64.20]:10433 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932142AbWDFEKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 00:10:09 -0400
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-mm2 10/9] sched throttle tree extract - kill
	interactive task feedback loop
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <200604060915.07036.kernel@kolivas.org>
References: <1143880124.7617.5.camel@homer> <1143883915.7617.77.camel@homer>
	 <1144258731.7894.12.camel@homer>  <200604060915.07036.kernel@kolivas.org>
Content-Type: text/plain
Date: Thu, 06 Apr 2006 06:10:19 +0200
Message-Id: <1144296619.7436.8.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-06 at 09:15 +1000, Con Kolivas wrote:
> On Thursday 06 April 2006 03:38, Mike Galbraith wrote:
> > Greetings,
> >
> > The patch below stops interactive tasks from feeding off each other
> > during round-robin.
> >
> > With this 10th patch in place, a busy server with _default_ throttle
> > settings (ie tunables may now be mostly unneeded) looks like this:
> 
> > --- linux-2.6.16-mm2/kernel/sched.c-9.export_tunables	2006-03-31
> > 13:37:09.000000000 +0200 +++ linux-2.6.16-mm2/kernel/sched.c	2006-04-05
> > 19:22:01.000000000 +0200 @@ -3480,7 +3480,7 @@ go_idle:
> >  	queue = array->queue + idx;
> >  	next = list_entry(queue->next, task_t, run_list);
> >
> > -	if (!rt_task(next) && interactive_sleep(next->sleep_type)) {
> > +	if (!TASK_INTERACTIVE(next) && interactive_sleep(next->sleep_type)) {
> 
> You can't remove that rt_task check from there can you? We shouldn't ever 
> requeue a rt task.

RT tasks are always interactive aren't they?  (I'll check)

Anyway, this is definitely a large part of the problem with the ssh to
busy server, but a complete block of interactive tasks isn't quite the
right solution.  With an SMP kernel, my desktop appeared to be fine, but
a quick spin with UP kernel isn't looking quite so good.  This needs
more investigation.

	-Mike

