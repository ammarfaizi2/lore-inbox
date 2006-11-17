Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933767AbWKQV27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933767AbWKQV27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933772AbWKQV27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:28:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:1199 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933767AbWKQV26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:28:58 -0500
X-Authenticated: #14349625
Subject: Re: [rfc patch] Re: sched: incorrect argument used in task_hot()
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, nickpiggin@yahoo.com.au,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061117192052.GA23272@elte.hu>
References: <000201c70840$a4902df0$d834030a@amr.corp.intel.com>
	 <1163782610.22574.59.camel@Homer.simpson.net>
	 <20061117192052.GA23272@elte.hu>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 22:30:34 +0100
Message-Id: <1163799034.23357.2.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 20:20 +0100, Ingo Molnar wrote:
> * Mike Galbraith <efault@gmx.de> wrote:
> 
> > One way to improve granularity, and eliminate the possibility of 
> > p->last_run being > rq->timestamp_tast_tick, and thereby short 
> > circuiting the evaluation of cache_hot_time, is to cache the last 
> > return of sched_clock() at both tick and sched times, and use that 
> > value as our reference instead of the absolute time of the tick.  It 
> > won't totally eliminate skew, but it moves the reference point closer 
> > to the current time on the remote cpu.
> > 
> > Looking for a good place to do this, I chose update_cpu_clock().
> 
> looks good to me - thus we will update the timestamp not only in the 
> timer tick, but also upon every context-switch (when we acquire 
> sched_clock() value anyway). Lets try this in -mm?
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

Then it needs a blame line.

Signed-off-by: Mike Galbraith <efault@gmx.de>

	-Mike

