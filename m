Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVFJXv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVFJXv3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVFJXv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:51:28 -0400
Received: from dvhart.com ([64.146.134.43]:10409 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261482AbVFJXux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:50:53 -0400
Date: Fri, 10 Jun 2005 16:50:40 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.6.12-rc6-mm1
Message-ID: <1155200000.1118447440@flay>
In-Reply-To: <200506110019.13204.kernel@kolivas.org>
References: <20050607170853.3f81007a.akpm@osdl.org> <20050610070214.GA31323@elte.hu> <200506102203.15909.kernel@kolivas.org> <200506110019.13204.kernel@kolivas.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> These tend to run together so just try adding my four patches together. In
>> retrospect I guess they're likely candidates because they also change the
>> _ratio_ of balance which they should not so they are buggy as a group
>> currently. Easy enough to fix but it will make it easy to pinpoint the
>> problem if they're responsible.
>> 
>> sched-implement-nice-support-across-physical-cpus-on-smp.patch
>> sched-change_prio_bias_only_if_queued.patch
>> sched-account_rt_tasks_in_prio_bias.patch
>> sched-smp-nice-bias-busy-queues-on-idle-rebalance.patch
> 
> By the way it has already been decided to remove these patches from -mm 
> pending the completion of current scheduler work. If they turn out to be 
> responsible for this regression I apologise profusely :-|. 
> 
> It is clearer to me now that I have made a mistake with the priority biasing, 
> and the following patch corrects it to the planned behaviour. This is 
> academic at this stage as we won't be looking at this particular feature 
> again in earnest until the other 32 scheduler patches (and any followups) go 
> upstream. 
> 
> It's already known that schedstats data will be off without further code to 
> understand smp nice as well (thanks Nick for pointing out the data)... more 
> academic stuff but obviously something to consider when/if we get there.

OK, I backed out those 4, and the degredation mostly went away.
See http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/perf/kernbench.moe.png

and more specifically, see the +p5150 near the right hand side.
I don't think it's quite as good as mainline, but much closer.
I did this run with HZ=1000, and the the one with no scheduler
patches at all with HZ=250, so I'll try to do a run that's more
directly comparable as well

Thanks,

M.

