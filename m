Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVCFWZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVCFWZe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVCFWZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:25:33 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2488 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261521AbVCFWZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:25:08 -0500
Date: Sun, 6 Mar 2005 23:24:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org, nacc@us.ibm.com
Subject: Re: [patch 1/1] kernel/smp: replace schedule_timeout() with ssleep()
Message-ID: <20050306222444.GA3282@elf.ucw.cz>
References: <20050306222248.254E11EC90@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050306222248.254E11EC90@trashy.coderock.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Use ssleep() instead of schedule_timeout(). The original code uses
> TASK_INTERRUPTIBLE, but does not check for signals, so I believe the change to
> ssleep() is appropriate.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Domen Puncer <domen@coderock.org>

Actually this code should be rewritten to use cpu hotplug
infrastructure, but this seems simple enough. ACK. [Heh, would be nice
if someone could test it...]

							Pavel

> diff -puN kernel/power/smp.c~ssleep-kernel_power_smp kernel/power/smp.c
> --- kj/kernel/power/smp.c~ssleep-kernel_power_smp	2005-03-05 16:11:19.000000000 +0100
> +++ kj-domen/kernel/power/smp.c	2005-03-05 16:11:19.000000000 +0100
> @@ -13,6 +13,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/suspend.h>
>  #include <linux/module.h>
> +#include <linux/delay.h>
>  #include <asm/atomic.h>
>  #include <asm/tlbflush.h>
>  
> @@ -49,8 +50,7 @@ void disable_nonboot_cpus(void)
>  	printk("Freezing CPUs (at %d)", smp_processor_id());
>  	oldmask = current->cpus_allowed;
>  	set_cpus_allowed(current, cpumask_of_cpu(0));
> -	current->state = TASK_INTERRUPTIBLE;
> -	schedule_timeout(HZ);
> +	ssleep(1);
>  	printk("...");
>  	BUG_ON(smp_processor_id() != 0);
>  
> _

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
