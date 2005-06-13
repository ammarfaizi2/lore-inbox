Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVFMBJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVFMBJz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 21:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVFMBJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 21:09:55 -0400
Received: from opersys.com ([64.40.108.71]:46086 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261305AbVFMBJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 21:09:36 -0400
Message-ID: <42ACDF4D.80503@opersys.com>
Date: Sun, 12 Jun 2005 21:20:13 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Ingo Molnar <mingo@elte.hu>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
References: <42AA6A6B.5040907@opersys.com> <20050611191448.GA24152@elte.hu> <42AB662B.4010104@opersys.com> <20050612061108.GA4554@elte.hu> <42AC8D00.4030809@opersys.com> <20050612205902.GA31928@elte.hu> <20050613004530.GH5796@g5.random>
In-Reply-To: <20050613004530.GH5796@g5.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli wrote:
> Karim, just in case you're not very familiar with parport, this should
> do the trick:
> 
> diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
> --- a/drivers/parport/parport_pc.c
> +++ b/drivers/parport/parport_pc.c
> @@ -2286,7 +2286,7 @@ struct parport *parport_pc_probe_port (u
>  	}
>  	if (p->irq != PARPORT_IRQ_NONE) {
>  		if (request_irq (p->irq, parport_pc_interrupt,
> -				 0, p->name, p)) {
> +				 SA_NODELAY, p->name, p)) {
>  			printk (KERN_WARNING "%s: irq %d in use, "
>  				"resorting to polled operation\n",
>  				p->name, p->irq);

Thanks for the patch. However, we actually wrote our own driver requesting
the parport int instead of using the one in Linux. We just wanted to
really customize the driver in as much as possible for benchmarking
purposes.

> With above patch applied my crystal ball expects preempt-RT to perform
> much closer to adeos, but with the difference that the non-RT part of
> the system will still get the burden of the added complexity that adeos
> won't have.

We'll be redoing some of the tests, and we'll keep you posted on
the results.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
