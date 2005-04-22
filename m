Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVDVAVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVDVAVL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 20:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVDVATS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 20:19:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:3740 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261790AbVDVASZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 20:18:25 -0400
Subject: Re: 2.6.12-rc3 cpufreq compile error on ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
In-Reply-To: <20050421092611.37df940b@colin.toulouse>
References: <20050421092611.37df940b@colin.toulouse>
Content-Type: text/plain
Date: Fri, 22 Apr 2005 10:17:50 +1000
Message-Id: <1114129070.5996.36.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-21 at 09:26 +0200, Colin Leroy wrote:
> Hi guys,
> 
> One of Ben's patches ("ppc32: Fix cpufreq problems") went in 2.6.12-
> rc3, but it depended on another patch that's still in -mm only: 
> add-suspend-method-to-cpufreq-core.patch
> 
> In addition to this, there's a third patch in -mm that fixes warnings
> and line length to the previous patch, but it doesn't apply cleanly
> anymore. It's named add-suspend-method-to-cpufreq-core-warning-fix.patch

Yup, please, Andrew, get those 2 to Linus.

Ben.

> Here's an updated version. HTH,
> 
> Signed-off-by: Colin Leroy <colin@colino.net>
> --- a/drivers/cpufreq/cpufreq.c	2005-04-21 09:14:28.000000000 +0200
> +++ b/drivers/cpufreq/cpufreq.c	2005-04-21 09:18:11.000000000 +0200
> @@ -955,7 +955,6 @@
>  {
>  	int cpu = sysdev->id;
>  	unsigned int ret = 0;
> -	unsigned int cur_freq = 0;
>  	struct cpufreq_policy *cpu_policy;
>  
>  	dprintk("resuming cpu %u\n", cpu);
> @@ -995,21 +994,24 @@
>  			cur_freq = cpufreq_driver->get(cpu_policy->cpu);
>  
>  		if (!cur_freq || !cpu_policy->cur) {
> -			printk(KERN_ERR "cpufreq: resume failed to assert current frequency is what timing core thinks it is.\n");
> +			printk(KERN_ERR "cpufreq: resume failed to assert "
> +					"current frequency is what timing core "
> +					"thinks it is.\n");
>  			goto out;
>  		}
>  
>  		if (unlikely(cur_freq != cpu_policy->cur)) {
>  			struct cpufreq_freqs freqs;
>  
> -			printk(KERN_WARNING "Warning: CPU frequency is %u, "
> -			       "cpufreq assumed %u kHz.\n", cur_freq, cpu_policy->cur);
> +			printk(KERN_WARNING "Warning: CPU frequency is %u, cpufreq assumed "
> +					    "%u kHz.\n", cur_freq, cpu_policy->cur);
>  
>  			freqs.cpu = cpu;
>  			freqs.old = cpu_policy->cur;
>  			freqs.new = cur_freq;
>  
> -			notifier_call_chain(&cpufreq_transition_notifier_list, CPUFREQ_RESUMECHANGE, &freqs);
> +			notifier_call_chain(&cpufreq_transition_notifier_list,
> +						CPUFREQ_RESUMECHANGE, &freqs);
>  			adjust_jiffies(CPUFREQ_RESUMECHANGE, &freqs);
>  
>  			cpu_policy->cur = cur_freq;
> 
> 
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

