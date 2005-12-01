Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbVLACsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbVLACsl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 21:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbVLACsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 21:48:41 -0500
Received: from fsmlabs.com ([168.103.115.128]:36994 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751313AbVLACsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 21:48:40 -0500
X-ASG-Debug-ID: 1133405317-13447-96-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Wed, 30 Nov 2005 18:54:17 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Shaohua Li <shaohua.li@intel.com>
cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-ASG-Orig-Subj: Re: [PATCH]nmi VS cpu hotplug
Subject: Re: [PATCH]nmi VS cpu hotplug
In-Reply-To: <1133430364.7980.15.camel@linux.site>
Message-ID: <Pine.LNX.4.64.0511301853140.13220@montezuma.fsmlabs.com>
References: <1133430364.7980.15.camel@linux.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5747
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2005, Shaohua Li wrote:

> Hi,
> With CPU hotplug enabled, NMI watchdog stoped working. It appears the
> violation is the cpu_online check in nmi handler. local ACPI based NMI
> watchdog is initialized before we set CPU online for APs. It's quite
> possible a NMI is fired before we set CPU online, and that's what
> happens here.
> Zwane, I suppose you saw nmi interrupts on offline CPU, so you added
> this one. Several days ago I sent a patch titled 'disable LAPIC
> completely for offline CPU', which I guess will make it disappear. Can
> you try it?
> So the solution is either to initialize nmi later or to delete the
> cpu_online check. I just take what x86_64 does.
> 
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

> ---
> 
>  linux-2.6.14-root/arch/i386/kernel/traps.c |    7 -------
>  1 files changed, 7 deletions(-)
> 
> diff -puN arch/i386/kernel/traps.c~nmi-cpuhotplug arch/i386/kernel/traps.c
> --- linux-2.6.14/arch/i386/kernel/traps.c~nmi-cpuhotplug	2005-12-01 01:22:00.000000000 -0800
> +++ linux-2.6.14-root/arch/i386/kernel/traps.c	2005-12-01 01:22:22.000000000 -0800
> @@ -650,13 +650,6 @@ fastcall void do_nmi(struct pt_regs * re
>  
>  	cpu = smp_processor_id();
>  
> -#ifdef CONFIG_HOTPLUG_CPU
> -	if (!cpu_online(cpu)) {
> -		nmi_exit();
> -		return;
> -	}
> -#endif

Nice catch, well that's really old debug code for the 'toy' i386 hotplug 
code i'm fine with deleting it.

Thanks,
	Zwane

