Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUJRPQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUJRPQF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 11:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUJRPQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 11:16:05 -0400
Received: from gprs214-57.eurotel.cz ([160.218.214.57]:18050 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266578AbUJRPQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 11:16:01 -0400
Date: Mon, 18 Oct 2004 17:10:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Nathan Lynch <nathanl@austin.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] i386 CPU hotplug updated for -mm
Message-ID: <20041018151053.GA23069@elf.ucw.cz>
References: <20041001204533.GA18684@elte.hu> <20041001204642.GA18750@elte.hu> <20041001143332.7e3a5aba.akpm@osdl.org> <Pine.LNX.4.61.0410091550300.2870@musoma.fsmlabs.com> <Pine.LNX.4.61.0410102302170.2745@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410102302170.2745@musoma.fsmlabs.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> +#ifdef CONFIG_HOTPLUG_CPU
> +#include <asm/nmi.h>
> +/* We don't actually take CPU down, just spin without interrupts. */
> +static inline void play_dead(void)
> +{
> +	/* Ack it */
> +	__get_cpu_var(cpu_state) = CPU_DEAD;
> +
> +	/* We shouldn't have to disable interrupts while dead, but
> +	 * some interrupts just don't seem to go away, and this makes
> +	 * it "work" for testing purposes. */
> +	/* Death loop */
> +	while (__get_cpu_var(cpu_state) != CPU_UP_PREPARE)
> +		cpu_relax();
> +
> +	local_irq_disable();
> +	__flush_tlb_all();
> +	cpu_set(smp_processor_id(), cpu_online_map);
> +	enable_APIC_timer();
> +	local_irq_enable();
> +}
> +#else

Having real implementation of this one would be very welcome for
suspend-to-{RAM,disk} on smp machines....

Are there really no i386 machines whose hardware supports hotplug?

							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
