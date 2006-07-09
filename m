Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWGIHu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWGIHu1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 03:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWGIHu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 03:50:27 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:49109 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932402AbWGIHu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 03:50:26 -0400
Date: Sun, 9 Jul 2006 09:45:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Joseph Fannin <jfannin@gmail.com>, linux-kernel@vger.kernel.org,
       arjan@infradead.org, John Stultz <johnstul@us.ibm.com>
Subject: Re: [LOCKDEP] 2.6.18-rc1: inconsistent {hardirq-on-W} -> {in-hardirq-W} usage
Message-ID: <20060709074543.GA4444@elte.hu>
References: <20060709050525.GA1149@nineveh.rivenstone.net> <20060708232512.12b59269.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060708232512.12b59269.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> yup, thanks, bug.
> 
> --- a/arch/i386/kernel/time.c~get_cmos_time-locking-fix
> +++ a/arch/i386/kernel/time.c
> @@ -206,15 +206,16 @@ irqreturn_t timer_interrupt(int irq, voi
>  unsigned long get_cmos_time(void)
>  {
>  	unsigned long retval;
> +	unsigned long flags;
>  
> -	spin_lock(&rtc_lock);
> +	spin_lock_irqsave(&rtc_lock, flags);

Acked-by: Ingo Molnar <mingo@elte.hu>

this bug has been in the upstream kernel for a couple of years: it was
apparently introduced as part of HPET support, via the late_time_init()
hook/hack in init/main.c. The lockup window is open once, during bootup.

	Ingo
