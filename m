Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbVHKCBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbVHKCBS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 22:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbVHKCBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 22:01:17 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18680 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1750807AbVHKCBR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 22:01:17 -0400
Subject: Re: [Patch]: latency histogram patch cleanup
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: yang.yi@bmrtech.com
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1123753388.4092.173.camel@montavista2>
References: <1123753388.4092.173.camel@montavista2>
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 10 Aug 2005 19:01:04 -0700
Message-Id: <1123725664.8187.24.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Comments below ...


On Thu, 2005-08-11 at 09:43 +0000, yangyi wrote:
> +#ifndef CONFIG_CRITICAL_LATENCY_HIST
>  	if (!report_latency(delta))
>  		goto out;
> +#endif

Why ? This combined with the hunk below is just preempt_threshold ..
Just use preempt_threshold instead of all the ifdefs everywhere .
 
>  	____trace(cpu, TRACE_FN, tr, CALLER_ADDR0, parent_eip, 0, 0, 0);
>  	/*
> @@ -1393,11 +1382,13 @@ check_critical_timing(int cpu, struct cp
>  	if (tr->critical_sequence != max_sequence || down_trylock(&max_mutex))
>  		goto out;
>  
> +#ifndef CONFIG_CRITICAL_LATENCY_HIST
>  	if (!preempt_thresh && preempt_max_latency > delta) {
>  		printk("bug: updating %016Lx > %016Lx?\n",
>  			preempt_max_latency, delta);
>  		printk("  [%016Lx %016Lx %016Lx]\n", T0, T1, T2);
>  	}
> +#endif
>  
>  	latency = cycles_to_usecs(delta);
>  


