Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966758AbWKOKft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966758AbWKOKft (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 05:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966761AbWKOKft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 05:35:49 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:12263 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S966758AbWKOKfs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 05:35:48 -0500
Date: Wed, 15 Nov 2006 16:04:19 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Gautham R Shenoy <ego@in.ibm.com>,
       Reuben Farrelly <reuben-linuxkernel@reub.net>,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com,
       CPUFreq Mailing List <cpufreq@lists.linux.org.uk>
Subject: Re: 2.6.19-rc5-mm2
Message-ID: <20061115103419.GA3131@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061114014125.dd315fff.akpm@osdl.org> <4559A91C.10009@reub.net> <20061114170053.GA22649@in.ibm.com> <20061114205829.GC2504@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114205829.GC2504@inferi.kami.home>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 14, 2006 at 09:58:29PM +0100, Mattia Dongili wrote:
> 
> maybe this helps? mostly guessing here, but when cpufreq_userspace is
> the default governor we may hit this path and leave policy->cur
> unset.

I doubt if that's causing the problem. My reasons are:

- Reuben's config shows his system to be a x64_64. So if I am not
  mistaken, the correct file look for would be 
  arch/ia64/kernel/cpufreq/acpi-cpufreq.c.

- The fix provided by you deals with the state of a 
  driver(hardware) specific variable data->cpu_feature while the
  governors like userspace/performance/powersave/ondemand are 
  driver(hardware) independent.

Nevertheless, it could be a valid fix for i386 acpi_cpufreq considering
that policy->cur is not being initialized if 
data->cpu_feature == ACPI_ADR_SPACE_FIXED_HARDWARE.

Please check with Dave Jones or Venkatesh Pallipadi.

Thanks
gautham.

> 
> diff --git a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
> index 18f4715..94e6e86 100644
> --- a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
> +++ b/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
> @@ -706,7 +706,7 @@ static int acpi_cpufreq_cpu_init(struct
>  		break;
>  	case ACPI_ADR_SPACE_FIXED_HARDWARE:
>  		acpi_cpufreq_driver.get = get_cur_freq_on_cpu;
> -		get_cur_freq_on_cpu(cpu);
> +		policy->cur = get_cur_freq_on_cpu(cpu);
>  		break;
>  	default:
>  		break;
> 
> -- 
> mattia
> :wq!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
