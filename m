Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267516AbUGWDU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUGWDU2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 23:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbUGWDU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 23:20:28 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:3170 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267516AbUGWDUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 23:20:08 -0400
Message-ID: <410083E5.6010502@yahoo.com.au>
Date: Fri, 23 Jul 2004 13:20:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jack Steiner <steiner@sgi.com>, Andrew Morton <akpm@osdl.org>
CC: mingo@elte.hu, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Initialize sched domain table
References: <20040723010257.GA27350@sgi.com>
In-Reply-To: <20040723010257.GA27350@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner wrote:
> Here is a trivial patch that is required to boot the latest 2.6.7 tree 
> on the SGI 512p system.
> 
> 	Initial the busy_factor in the sched_domain_init table.
> 	Otherwise, booting hangs doing excessive load balance
> 	operations.
> 
> 	Signed-off-by: Jack Steiner <steiner@sgi.com>
> 

Thanks. Andrew please apply.

> 
> 
> Index: linux/kernel/sched.c
> ===================================================================
> --- linux.orig/kernel/sched.c
> +++ linux/kernel/sched.c
> @@ -3922,6 +3922,7 @@ void __init sched_init(void)
>  	sched_domain_init.groups = &sched_group_init;
>  	sched_domain_init.last_balance = jiffies;
>  	sched_domain_init.balance_interval = INT_MAX; /* Don't balance */
> +	sched_domain_init.busy_factor = 1;
>  
>  	memset(&sched_group_init, 0, sizeof(struct sched_group));
>  	sched_group_init.cpumask = CPU_MASK_ALL;

