Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752790AbWKQTWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbWKQTWQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbWKQTWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:22:15 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47025 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752790AbWKQTWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:22:14 -0500
Date: Fri, 17 Nov 2006 20:20:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, nickpiggin@yahoo.com.au,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc patch] Re: sched: incorrect argument used in task_hot()
Message-ID: <20061117192052.GA23272@elte.hu>
References: <000201c70840$a4902df0$d834030a@amr.corp.intel.com> <1163782610.22574.59.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163782610.22574.59.camel@Homer.simpson.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.1090]
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> One way to improve granularity, and eliminate the possibility of 
> p->last_run being > rq->timestamp_tast_tick, and thereby short 
> circuiting the evaluation of cache_hot_time, is to cache the last 
> return of sched_clock() at both tick and sched times, and use that 
> value as our reference instead of the absolute time of the tick.  It 
> won't totally eliminate skew, but it moves the reference point closer 
> to the current time on the remote cpu.
> 
> Looking for a good place to do this, I chose update_cpu_clock().

looks good to me - thus we will update the timestamp not only in the 
timer tick, but also upon every context-switch (when we acquire 
sched_clock() value anyway). Lets try this in -mm?

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
