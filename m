Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946248AbWKJKLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946248AbWKJKLG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946249AbWKJKLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:11:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18859 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946248AbWKJKLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:11:04 -0500
Subject: Re: [patch 09/19] i386: Convert to clock event devices
From: Arjan van de Ven <arjan@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       John Stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20061109233035.106281000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <20061109233035.106281000@cruncher.tec.linutronix.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 10 Nov 2006 11:10:58 +0100
Message-Id: <1163153459.3138.647.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 23:38 +0000, Thomas Gleixner wrote:
> - * Local timer interrupt handler. It does both profiling and
> - * process statistics/rescheduling.
> + * The guts of the apic timer interrupt
>   */
> -inline void smp_local_timer_interrupt(void)
> +fastcall void local_apic_timer_interrupt(struct pt_regs *regs)

please don't add more "fastcall"; CONFIG_REGPARM makes that the default
anyway



> +void __init setup_pit_timer(void)
> +{
> +	pit_clockevent.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC, 32);
> +	pit_clockevent.max_delta_ns =
> +		clockevent_delta2ns(0x7FFF, &pit_clockevent);
> +	pit_clockevent.min_delta_ns =
> +		clockevent_delta2ns(0xF, &pit_clockevent);
> +	register_global_clockevent(&pit_clockevent);
> +#ifdef CONFIG_HPET_TIMER
> +	global_clock_event = &pit_clockevent;
> +#endif
> +}

ok this ifdef looks really really weird to me. Why does PIT code depend
on CONFIG_HPET ? HPET is mostly a runtime property!


other than that Acked-by: Arjan van de Ven <arjan@linux.intel.com>

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

