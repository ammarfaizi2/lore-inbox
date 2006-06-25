Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965319AbWFYTve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965319AbWFYTve (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 15:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965351AbWFYTve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 15:51:34 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58343 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965319AbWFYTvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 15:51:33 -0400
Date: Sun, 25 Jun 2006 21:46:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, Ralf.Hildebrandt@charite.de,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.6.17-mm2
Message-ID: <20060625194639.GB11494@elte.hu>
References: <20060625103523.GY27143@charite.de> <20060625034913.315755ae.akpm@osdl.org> <1151256246.25491.398.camel@localhost.localdomain> <20060625103246.a309d67b.akpm@osdl.org> <1151257123.25491.404.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151257123.25491.404.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sun, 2006-06-25 at 10:32 -0700, Andrew Morton wrote:
> > > So in fact this just silently acks spurious interrupts which have an
> > > hw_irq_controller assigned. If there is no action, then nothing has
> > > called setup_irq/request_irq for this interrupt line and therefor it is
> > > an spurious interrupt which should not happen.
> > > 
> > > 
> > > genirq makes these visible and informs noisily about those events. 
> > > 
> > 
> > hm, OK.  I guess we can let it ride for now.  Later we can decide whether
> > we need to shut that warning up.  I suspect we should, if the machine's
> > working OK.
> 
> We can make it once per IRQ.

yeah. A bit more sophisticated method would be to use a new sticky 
IRQ_SPURIOUS bit and only print a warning if it goes from 0 to 1. 
Whenever a real handler is installed the bit gets cleared. This will 
make behavior a bit more deterministic than 'once per bootup', and it 
will still not spam the box with printks. (Or never let that bit go from 
1 to 0 - this effectively implements the once-per-bootup warning.)

> In fact I think the original behaviour is a BUG. You have no chance to 
> notice that your box gets flooded by such interrupts. With my 
> willingly asserted spurious interrupts the box simply stalls in a 
> flood of interrupts without any notice.

hm, doesnt note_interrupt()/irqpoll detect and handle this to a certain 
degree?

	Ingo
