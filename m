Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030603AbWBOC75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030603AbWBOC75 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 21:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030606AbWBOC75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 21:59:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1990 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030603AbWBOC74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 21:59:56 -0500
Date: Tue, 14 Feb 2006 18:58:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Brice.Goglin@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc3-mm1
Message-Id: <20060214185849.59517e75.akpm@osdl.org>
In-Reply-To: <200602151026.40852.kernel@kolivas.org>
References: <20060214014157.59af972f.akpm@osdl.org>
	<43F1EA2B.4090203@ens-lyon.org>
	<20060214122825.5b8de370.akpm@osdl.org>
	<200602151026.40852.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> On Wednesday 15 February 2006 07:28, Andrew Morton wrote:
> > Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
> > > Andrew Morton wrote:
> > > >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc3
> > > >/2.6.16-rc3-mm1/
> > >
> > > Hi Andrew,
> > >
> > > WARNING: speedstep-centrino.ko needs unknown symbol cpu_online_map
> > >
> > > This symbol is in include/linux/cpumask.h but actually only defined and
> > > exported in smpboot.c which is not compiled on UP.
> >
> > diff -puN
> > arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~git-acpi-up-fix-2
> > arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c ---
> > devel/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~git-acpi-up-fix-2	2
> >006-02-14 12:27:41.000000000 -0800 +++
> > devel-akpm/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-02-14
> > 12:27:41.000000000 -0800 @@ -654,8 +654,10 @@ static int centrino_target
> > (struct cpufr
> >  		return -EINVAL;
> >  	}
> >
> > +#ifdef CONFIG_SMP
> >  	/* cpufreq holds the hotplug lock, so we are safe from here on */
> >  	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
> > +#endif
> 
> Shouldn't the cpu_online_map be hardcoded to the first/only cpu on UP instead?
> 

Probably.  That's just a make-it-build patch.  The ACPI guys will need to
come up with a suitable permanent fix.
