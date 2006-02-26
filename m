Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWBZL1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWBZL1G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 06:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWBZL1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 06:27:06 -0500
Received: from in.cluded.net ([195.159.29.203]:1259 "EHLO in.cluded.net")
	by vger.kernel.org with ESMTP id S1751319AbWBZL1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 06:27:01 -0500
Message-ID: <44019075.2000205@cluded.net>
Date: Sun, 26 Feb 2006 11:26:45 +0000
From: "Daniel K." <daniel@cluded.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b2) Gecko/20050611
MIME-Version: 1.0
To: MIke Galbraith <efault@gmx.de>
CC: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 2.6.16-rc4-mm1]  Task Throttling V14
References: <1140183903.14128.77.camel@homer> <1140812981.8713.35.camel@homer>
In-Reply-To: <1140812981.8713.35.camel@homer>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MIke Galbraith wrote:
> On Fri, 2006-02-17 at 14:45 +0100, MIke Galbraith wrote: 
> +/*
> + * Masks for p->slice_info, formerly p->first_time_slice.
> + * SLICE_FTS:   0x80000000  Task is in it's first ever timeslice.
> + * SLICE_NEW:   0x40000000  Slice refreshed.
> + * SLICE_SPA:   0x3FFF8000  Spare bits.
> + * SLICE_LTS:   0x00007F80  Last time slice
> + * SLICE_AVG:   0x0000007F  Task slice_avg stored as percentage.
> + */
> +#define SLICE_AVG_BITS    7
> +#define SLICE_LTS_BITS   10
> +#define SLICE_SPA_BITS   13
> +#define SLICE_NEW_BITS    1
> +#define SLICE_FTS_BITS    1

I count 8 and 15 bits in the documentation of LTS/SPA respectively, not 
10 and 13.

>  	}
>  
>  	if (likely(sleep_time > 0)) {
> +

Extra line

> +	{
> +		.ctl_name	= KERN_SCHED_THROTTLE1,
> +		.procname	= "sched_g1",
> +		.data		= &sched_g1,
> +		.maxlen		= sizeof (int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &zero,
> +		.extra2		= &sched_g2_max,

sched_g2_max is possibly badly named, as it is used in connection with 
sched_g1 here.

> +	},
> +	{
> +		.ctl_name	= KERN_SCHED_THROTTLE2,
> +		.procname	= "sched_g2",
> +		.data		= &sched_g2,
> +		.maxlen		= sizeof (int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec,
> +		.extra1		= &zero,
> +		.extra2		= &sched_g2_max,
> +	},


Daniel K.
