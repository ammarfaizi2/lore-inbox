Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422799AbWBNXjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422799AbWBNXjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422806AbWBNXjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:39:04 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:3049 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1422799AbWBNXjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:39:03 -0500
Message-ID: <43F26A04.7000801@ens-lyon.org>
Date: Tue, 14 Feb 2006 18:38:44 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc3-mm1
References: <20060214014157.59af972f.akpm@osdl.org> <43F1EA2B.4090203@ens-lyon.org> <20060214122825.5b8de370.akpm@osdl.org> <200602151026.40852.kernel@kolivas.org>
In-Reply-To: <200602151026.40852.kernel@kolivas.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>On Wednesday 15 February 2006 07:28, Andrew Morton wrote:
>  
>
>>Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>>    
>>
>>>WARNING: speedstep-centrino.ko needs unknown symbol cpu_online_map
>>>
>>>This symbol is in include/linux/cpumask.h but actually only defined and
>>>exported in smpboot.c which is not compiled on UP.
>>>      
>>>
>>diff -puN
>>arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~git-acpi-up-fix-2
>>arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c ---
>>devel/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~git-acpi-up-fix-2	2
>>006-02-14 12:27:41.000000000 -0800 +++
>>devel-akpm/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-02-14
>>12:27:41.000000000 -0800 @@ -654,8 +654,10 @@ static int centrino_target
>>(struct cpufr
>> 		return -EINVAL;
>> 	}
>>
>>+#ifdef CONFIG_SMP
>> 	/* cpufreq holds the hotplug lock, so we are safe from here on */
>> 	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
>>+#endif
>>    
>>
>
>Shouldn't the cpu_online_map be hardcoded to the first/only cpu on UP instead?
>
>Cheers,
>Con
>  
>
It's actually defined on UP in kernel/sched.c:

#ifndef CONFIG_SMP
cpumask_t cpu_online_map __read_mostly = CPU_MASK_ALL;
cpumask_t cpu_possible_map __read_mostly = CPU_MASK_ALL;
#endif

What about adding an EXPORT_SYMBOL_GPL there ?

Brice

