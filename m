Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965223AbWFIFvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbWFIFvT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 01:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWFIFvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 01:51:18 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:28327 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965223AbWFIFvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 01:51:17 -0400
Message-ID: <44890C0A.1000005@jp.fujitsu.com>
Date: Fri, 09 Jun 2006 14:50:02 +0900
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Peter Williams <peterw@aurema.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>, Kirill Korotaev <dev@openvz.org>,
       Srivatsa <vatsa@in.ibm.com>, CKRM <ckrm-tech@lists.sourceforge.net>,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>,
       MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Subject: Re: [ckrm-tech] [RFC 0/4] sched: Add CPU rate caps (improved)
References: <20060606023708.2801.24804.sendpatchset@heathwren.pw.nest>	<448688B2.2030206@jp.fujitsu.com>	<4487D6B0.3080502@bigpond.net.au> <4488C765.2050108@aurema.com>
In-Reply-To: <4488C765.2050108@aurema.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> 
> I've done some informal testing with smaller values of CAP_STATS_OFFSET 
> and there is only a minor improvement.
> 
> However, something that does improve behaviour for short lived tasks is 
> to increase the value of HZ.  This is because the basic unit of CPU
> allocation by the scheduler is 1/HZ and this is also the minimum time 
> (and granularity) with which sinbinning and other capping measures can 
> be implemented.  This is the fundamental limiting factor for the 
> accuracy of capping i.e. if everything worked perfectly the best 
> granularity that can be expected from capping of short lived tasks is 
> 1000 / (HZ * duration) where duration is in seconds.

I already defines CONFIG_HZ=1000. Do you suggest increasing more?

> For longer living tasks, once the initial phase has passed the half life 
> of the Kalman filters takes over from "HZ * duration" in the above 
> expression.  Reducing CAP_STATS_OFFSET will shorten the half life of the 
> filters and this in turn will make capping coarser.  On the other hand, 
> if the half lives are too big then capping will be too slow in reacting 
> to changes in a task's CPU usage patterns.  So there's a sweet spot in 
> there somewhere.  There's also an upper limit imposed by the likelihood 
> of arithmetic overflow during the calculations and this has to consider 
> the fact that the average cycle length (one of the metrics) can be quite 
> long.  The current values was based on these considerations.
> 
> Peter

Thanks,
MAEDA Naoaki

