Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbVKOEZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVKOEZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 23:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVKOEZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 23:25:27 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:7870 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932369AbVKOEZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 23:25:27 -0500
In-Reply-To: <43796596.2010908@watson.ibm.com>
References: <43796596.2010908@watson.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1F92A563-B430-49FE-895E-FB93DC64981E@comcast.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [Patch 1/4] Delay accounting: Initialization
Date: Mon, 14 Nov 2005 23:25:24 -0500
To: Shailabh Nagar <nagar@watson.ibm.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 14, 2005, at 11:35 PM, Shailabh Nagar wrote:

> +/* because of hardware timer drifts in SMPs and task continue on  
> different cpu
> + * then where the start_ts was taken there is a possibility that
> + * end_ts < start_ts by some usecs. In this case we ignore the diff
> + * and add nothing to the total.

Curious as to when would this occur. Probably for tasks running on a  
SMP machine for a very short period of time (timer drift should not  
be hopefully that high) and switching CPUs in that short period of time?

> +config STATS_CONNECTOR
> +config DELAY_ACCT

Probably TASK_DELAY_STATS_CONNECTOR and TASK_DELAY_ACCOUNTING are  
better names?

> @@ -813,6 +821,9 @@ struct task_struct {
>  	int cpuset_mems_generation;
>  #endif
>  	atomic_t fs_excl;	/* holding fs exclusive resources */
> +#ifdef	CONFIG_DELAY_ACCT
> +	struct task_delay_info delays;
> +#endif
>  };

Does this mean, whether or not the per task delay accounting is used,  
we have a constant overhead of sizeof(spinlock_t) + 2*sizeof 
(uint32_t) + 2* sizeof(uint64_t) bytes going into the struct  
task_struct?. Is it possible/beneficial to use struct task_delay_info  
*delays instead and allocate it if task wants to use the information?

Parag
