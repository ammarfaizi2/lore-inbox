Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTIEINf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 04:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbTIEINf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 04:13:35 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:4749 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262321AbTIEINd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 04:13:33 -0400
Subject: Re: Question: monolitic_clock, timer_{tsc,hpet} and CPUFREQ
From: john stultz <johnstul@us.ibm.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200309042214.28179.dtor_core@ameritech.net>
References: <200309042214.28179.dtor_core@ameritech.net>
Content-Type: text/plain
Organization: 
Message-Id: <1062749594.5809.7.camel@laptop.cornchips.homelinux.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Sep 2003 01:13:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-04 at 20:14, Dmitry Torokhov wrote:
> I noticed that although timer_tsc registers cpufreq notifier to detect
> frequency changes and adjust cpu_khz it does not set cyc2ns_scale. Is
> monotonic clocks supposed to be also accurate?

You are correct, without adjusting the cyc2ns_scale value
monotonic_clock() will not be accurate on freq changing hardware.  


> Will something like this suffice for timer_tsc (compiled, not yet booted):
> 
> --- 2.6.0-test4/arch/i386/kernel/timers/timer_tsc.c	2003-08-26 21:56:19.000000000 -0500
> +++ linux-2.6.0-test4/arch/i386/kernel/timers/timer_tsc.c	2003-09-04 22:08:27.000000000 -0500
> @@ -315,6 +315,7 @@
>  		if (use_tsc) {
>  			fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
>  			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
> +			set_cyc2ns_scale(cpu_khz/1000);
>  		}
>  #endif
>  	}

Looks fine to me. Although I don't have any cpufreq enabled hardware, so
I'm unable to test this (main cause I never added it myself). 

thanks
-john


