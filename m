Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752292AbWKQVkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbWKQVkV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbWKQVkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:40:21 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46799 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752292AbWKQVkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:40:20 -0500
Date: Fri, 17 Nov 2006 13:39:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       nickpiggin@yahoo.com.au, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [rfc patch] Re: sched: incorrect argument used in task_hot()
Message-Id: <20061117133951.ca22ca7b.akpm@osdl.org>
In-Reply-To: <1163799034.23357.2.camel@Homer.simpson.net>
References: <000201c70840$a4902df0$d834030a@amr.corp.intel.com>
	<1163782610.22574.59.camel@Homer.simpson.net>
	<20061117192052.GA23272@elte.hu>
	<1163799034.23357.2.camel@Homer.simpson.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 22:30:34 +0100
Mike Galbraith <efault@gmx.de> wrote:

> On Fri, 2006-11-17 at 20:20 +0100, Ingo Molnar wrote:
> > * Mike Galbraith <efault@gmx.de> wrote:
> > 
> > > One way to improve granularity, and eliminate the possibility of 
> > > p->last_run being > rq->timestamp_tast_tick, and thereby short 
> > > circuiting the evaluation of cache_hot_time, is to cache the last 
> > > return of sched_clock() at both tick and sched times, and use that 
> > > value as our reference instead of the absolute time of the tick.  It 
> > > won't totally eliminate skew, but it moves the reference point closer 
> > > to the current time on the remote cpu.
> > > 
> > > Looking for a good place to do this, I chose update_cpu_clock().
> > 
> > looks good to me - thus we will update the timestamp not only in the 
> > timer tick, but also upon every context-switch (when we acquire 
> > sched_clock() value anyway). Lets try this in -mm?
> > 
> > Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> Then it needs a blame line.
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
>

And a changelog, then we're all set!

Oh.  And a patch, too.
