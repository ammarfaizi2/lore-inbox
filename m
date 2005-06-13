Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVFMFui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVFMFui (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 01:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVFMFu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 01:50:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43179 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261358AbVFMFt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 01:49:29 -0400
Date: Mon, 13 Jun 2005 07:47:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
Message-ID: <20050613054758.GB7964@elte.hu>
References: <42AA6A6B.5040907@opersys.com> <20050611191448.GA24152@elte.hu> <42AB662B.4010104@opersys.com> <20050612061108.GA4554@elte.hu> <42AC8D00.4030809@opersys.com> <20050612205902.GA31928@elte.hu> <20050613004530.GH5796@g5.random> <42ACDF4D.80503@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ACDF4D.80503@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karim Yaghmour <karim@opersys.com> wrote:

> > -				 0, p->name, p)) {
> > +				 SA_NODELAY, p->name, p)) {
> >  			printk (KERN_WARNING "%s: irq %d in use, "
> >  				"resorting to polled operation\n",
> >  				p->name, p->irq);
> 
> Thanks for the patch. However, we actually wrote our own driver 
> requesting the parport int instead of using the one in Linux. We just 
> wanted to really customize the driver in as much as possible for 
> benchmarking purposes.

in this case you'll still have to use SA_NODELAY - otherwise you'll get 
an interrupt thread allocated, whose priority could, depending on the 
order of IRQ requests, be lower than the priority of some other
interrupt threads. In that case not only do scheduling latencies get
added to your latency value, but also the worst-case latencies of other
IRQ handlers!

	Ingo
