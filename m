Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267387AbTAQFeV>; Fri, 17 Jan 2003 00:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267389AbTAQFeV>; Fri, 17 Jan 2003 00:34:21 -0500
Received: from packet.digeo.com ([12.110.80.53]:14820 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267387AbTAQFeU>;
	Fri, 17 Jan 2003 00:34:20 -0500
Date: Thu, 16 Jan 2003 21:44:24 -0800
From: Andrew Morton <akpm@digeo.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, rml@tech9.net
Subject: Re: [PATCH][2.5] smp_call_function_mask
Message-Id: <20030116214424.037f57aa.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0301170014230.24250-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0301170014230.24250-100000@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2003 05:43:11.0149 (UTC) FILETIME=[520F3DD0:01C2BDEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@holomorphy.com> wrote:
>
> This patch adds a smp_call_function which also accepts a cpu mask which is 
> needed for targetting specific or groups of cpus.

What is it needed for?

> Index: linux-2.5.58-cpu_hotplug/arch/i386/kernel/smp.c

ia32 only?

>  
> +int smp_call_function_mask (void (*func) (void *info), void *info, int nonatomic,
> +			int wait, unsigned long mask)
> +/*
> + * [SUMMARY] Run a function on specific CPUs, save self.
> + * <func> The function to run. This must be fast and non-blocking.
> + * <info> An arbitrary pointer to pass to the function.
> + * <nonatomic> currently unused.
> + * <wait> If true, wait (atomically) until function has completed on other CPUs.
> + * <mask> The bitmask of CPUs to call the function
> + * [RETURNS] 0 on success, else a negative status code. Does not return until
> + * remote CPUs are nearly ready to execute <<func>> or are or have executed.
> + *
> + * You must not call this function with disabled interrupts or from a
> + * hardware interrupt handler or from a bottom half handler.
> + */

Please don't invent new coding styles.  The comment block goes outside the
function.  Nice comment block though.

> +{
> +	struct call_data_struct data;
> +	int num_cpus = hweight32(mask);
> +
> +	if (num_cpus == 0)
> +		return -EINVAL;
> +
> +	if ((1UL << smp_processor_id()) & mask)
> +		return -EINVAL;

Preempt safety?


