Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754431AbWKIJPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbWKIJPT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 04:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbWKIJPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 04:15:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:10182 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1753992AbWKIJPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 04:15:17 -0500
Date: Thu, 9 Nov 2006 10:14:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Kevin Hilman <khilman@mvista.com>
Cc: john cooper <john.cooper@third-harmonic.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rt7: rollover with 32-bit cycles_t
Message-ID: <20061109091404.GA23876@elte.hu>
References: <4551348B.6070604@mvista.com> <45513BB6.4010308@third-harmonic.com> <45522E7F.2050503@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45522E7F.2050503@mvista.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4998]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Kevin Hilman <khilman@mvista.com> wrote:

> -	if (T2 < T1)
> +
> +	/* check for buggy clocks, handling wrap for 32-bit clocks */
> +	if (TYPE_EQUAL(cycles_t, unsigned long)) {
> +		if (time_after(T1, T2))
> +			printk("bug: %08x < %08x!\n", T2, T1);
> +	} else if (T2 < T1)
>  		printk("bug: %016Lx < %016Lx!\n", T2, T1);
> +	

ok, i have applied this one.

	Ingo
