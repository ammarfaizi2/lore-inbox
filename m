Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422881AbWBNX07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422881AbWBNX07 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422882AbWBNX07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:26:59 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:64946 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1422881AbWBNX06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:26:58 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc3-mm1
Date: Wed, 15 Feb 2006 10:26:40 +1100
User-Agent: KMail/1.9.1
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>, linux-kernel@vger.kernel.org
References: <20060214014157.59af972f.akpm@osdl.org> <43F1EA2B.4090203@ens-lyon.org> <20060214122825.5b8de370.akpm@osdl.org>
In-Reply-To: <20060214122825.5b8de370.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602151026.40852.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 February 2006 07:28, Andrew Morton wrote:
> Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
> > Andrew Morton wrote:
> > >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc3
> > >/2.6.16-rc3-mm1/
> >
> > Hi Andrew,
> >
> > WARNING: speedstep-centrino.ko needs unknown symbol cpu_online_map
> >
> > This symbol is in include/linux/cpumask.h but actually only defined and
> > exported in smpboot.c which is not compiled on UP.
>
> diff -puN
> arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~git-acpi-up-fix-2
> arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c ---
> devel/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~git-acpi-up-fix-2	2
>006-02-14 12:27:41.000000000 -0800 +++
> devel-akpm/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-02-14
> 12:27:41.000000000 -0800 @@ -654,8 +654,10 @@ static int centrino_target
> (struct cpufr
>  		return -EINVAL;
>  	}
>
> +#ifdef CONFIG_SMP
>  	/* cpufreq holds the hotplug lock, so we are safe from here on */
>  	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
> +#endif

Shouldn't the cpu_online_map be hardcoded to the first/only cpu on UP instead?

Cheers,
Con
