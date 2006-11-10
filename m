Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946372AbWKJK0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946372AbWKJK0P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946373AbWKJK0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:26:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58037 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946372AbWKJK0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:26:14 -0500
Subject: Re: [patch 12/19] high-res timers: core
From: Arjan van de Ven <arjan@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       John Stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20061109233035.455633000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <20061109233035.455633000@cruncher.tec.linutronix.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 10 Nov 2006 11:26:11 +0100
Message-Id: <1163154371.3138.663.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 23:38 +0000, Thomas Gleixner wrote:
> + * hrtimer callback modes:
> + *
> + *	HRTIMER_CB_SOFTIRQ:		Callback must run in softirq context
> + *	HRTIMER_CB_IRQSAFE:		Callback may run in hardirq context
> + *	HRTIMER_CB_IRQSAFE_NO_RESTART:	Callback may run in hardirq context and
> + *					does not restart the timer
> + *	HRTIMER_CB_IRQSAFE_NO_SOFTIRQ:	Callback must run in softirq context
> + *					Special mode for tick emultation

This naming is treacherous (or the comment is wrong); NO_SOFTIRQ
suggests "can't run in softirq" but your comment says "must run in
softirq".. which is it?





> +/**
> + * hrtimer_clock_notify - A clock source or a clock event has been installed
> + *
> + * Notify the per cpu softirqs to recheck the clock sources and events
> + */
> +void hrtimer_clock_notify(void)
> +{
> +	int i;
> +
> +	if (hrtimer_hres_enabled) {
> +		for_each_possible_cpu(i)

hmm. possible or online or .. 


If you fix the comment/define: 
Acked-by: Arjan van de Ven <arjan@linux.intel.com>
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

