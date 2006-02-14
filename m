Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422709AbWBNU33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422709AbWBNU33 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 15:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWBNU32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 15:29:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16546 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932335AbWBNU32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 15:29:28 -0500
Date: Tue, 14 Feb 2006 12:28:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc3-mm1
Message-Id: <20060214122825.5b8de370.akpm@osdl.org>
In-Reply-To: <43F1EA2B.4090203@ens-lyon.org>
References: <20060214014157.59af972f.akpm@osdl.org>
	<43F1EA2B.4090203@ens-lyon.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>
> Andrew Morton wrote:
> 
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc3/2.6.16-rc3-mm1/
> >
> >  
> >
> 
> Hi Andrew,
> 
> WARNING: speedstep-centrino.ko needs unknown symbol cpu_online_map
> 
> This symbol is in include/linux/cpumask.h but actually only defined and
> exported in smpboot.c which is not compiled on UP.
> 


diff -puN arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~git-acpi-up-fix-2 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
--- devel/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c~git-acpi-up-fix-2	2006-02-14 12:27:41.000000000 -0800
+++ devel-akpm/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-02-14 12:27:41.000000000 -0800
@@ -654,8 +654,10 @@ static int centrino_target (struct cpufr
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_SMP
 	/* cpufreq holds the hotplug lock, so we are safe from here on */
 	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
+#endif
 
 	saved_mask = current->cpus_allowed;
 	first_cpu = 1;
_

