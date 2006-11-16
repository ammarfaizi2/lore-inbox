Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424481AbWKPUwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424481AbWKPUwS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 15:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424482AbWKPUwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 15:52:18 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:10074 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S1424481AbWKPUwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 15:52:17 -0500
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@timesys.com>, Alan Stern <stern@rowland.harvard.edu>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       john stultz <johnstul@us.ibm.com>, David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
In-Reply-To: <20061116201531.GA31469@elte.hu>
References: <1163707250.10333.24.camel@localhost.localdomain>
	 <20061116201531.GA31469@elte.hu>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 21:52:12 +0100
Message-Id: <1163710333.28060.1.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-16 at 21:15 +0100, Ingo Molnar wrote:

> From: Ingo Molnar <mingo@elte.hu>
> Subject: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
> 
> init_cpufreq_transition_notifier_list() should execute first, which is a 
> core_initcall, so mark cpufreq_tsc() core_initcall_sync.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> --- linux.orig/arch/x86_64/kernel/tsc.c
> +++ linux/arch/x86_64/kernel/tsc.c

it seems to want to be arch/x86_64/kernel/time.c

> @@ -138,7 +138,11 @@ static int __init cpufreq_tsc(void)
>  	return 0;
>  }
>  
> -core_initcall(cpufreq_tsc);
> +/*
> + * init_cpufreq_transition_notifier_list() should execute first,
> + * which is a core_initcall, so mark this one core_initcall_sync:
> + */
> +core_initcall_sync(cpufreq_tsc);
>  
>  #endif
>  /*

