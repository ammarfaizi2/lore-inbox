Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262525AbSJKPg6>; Fri, 11 Oct 2002 11:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbSJKPg6>; Fri, 11 Oct 2002 11:36:58 -0400
Received: from franka.aracnet.com ([216.99.193.44]:11203 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262525AbSJKPg5>; Fri, 11 Oct 2002 11:36:57 -0400
Date: Fri, 11 Oct 2002 08:34:17 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Andrew Theurer <habanero@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pooling NUMA scheduler with initial load balancing
Message-ID: <1713823758.1034325255@[10.10.2.3]>
In-Reply-To: <200210111729.45129.efocht@ess.nec.de>
References: <200210111729.45129.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> arch/i386/kernel/smpboot.c:smp_tune_scheduling() says:
> 
>        if (!cpu_khz) {
>                 /*
>                  * this basically disables processor-affinity
>                  * scheduling on SMP without a TSC.
>                  */
>                 cacheflush_time = 0;
>                 return;
> 
> If you boot with notsc, you won't have cache affinity on your machine.
> Which means that the load_balancer eventually selects cache hot tasks
> for stealing. The O(1) scheduler doesn't do that under normal conditions!

OK, that makes more sense ... I'll go stare at the code some more and
see what can be done.
 
> Of course I'll add something to my patch such that it doesn't crash
> if cache_decay_ticks is unset. But you might be measuring wrong things
> right now if you leave cache_decay_ticks=0 as then the cache-affinity
> on NUMAQ is switched off with the vanilla O(1) and with Michael's patch.
> I want to say: you cannot evaluate the impact of Michael's patches if
> you don't fix that. This issue is independent of my patches.

OK, I'll make sure to make the tests uniform somehow to get a fair 
comparison.

Thanks!

M.

