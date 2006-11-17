Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755833AbWKQTly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833AbWKQTly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755835AbWKQTly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:41:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:26633 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1755834AbWKQTlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:41:53 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,435,1157353200"; 
   d="scan'208"; a="163210958:sNHT20346207"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>, "Mike Galbraith" <efault@gmx.de>
Cc: <nickpiggin@yahoo.com.au>, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
Subject: RE: [rfc patch] Re: sched: incorrect argument used in task_hot()
Date: Fri, 17 Nov 2006 11:41:51 -0800
Message-ID: <000401c70a80$6eaa61a0$2880030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccKfjk9SR1RaxbuQlizu1cJKCob0gAAZD0A
In-Reply-To: <20061117192052.GA23272@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Friday, November 17, 2006 11:21 AM
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

Certainly gets my vote.  For my particular workload environment, there
are enough schedule activity on the remote CPU and in theory it should
make time calculation a lot better than what it is now.  I will run a
couple of experiment to verify.

Acked-by: Ken Chen <kenneth.w.chen@intel.com>

