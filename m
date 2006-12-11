Return-Path: <linux-kernel-owner+w=401wt.eu-S937574AbWLKTHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937574AbWLKTHe (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937575AbWLKTHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:07:34 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:50801 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937573AbWLKTHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:07:32 -0500
Date: Mon, 11 Dec 2006 20:05:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt][RESEND] fix preempt hardirqs on OMAP
Message-ID: <20061211190554.GA26392@elte.hu>
References: <20061210163545.488430000@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210163545.488430000@mvista.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> +	/*
> +	 * Some boards will disable an interrupt when it
> +	 * sets IRQ_PENDING . So we have to remove the flag
> +	 * and re-enable to handle it.
> +	 */
> +	if (desc->status & IRQ_PENDING) {
> +		desc->status &= ~IRQ_PENDING;
> +		if (desc->chip)
> +			desc->chip->enable(irq);
> +		goto restart;
> +	}

what if the irq got disabled meanwhile? Also, chip->enable is a 
compatibility method, not something we should use in a flow handler.

	Ingo
