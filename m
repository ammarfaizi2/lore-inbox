Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750786AbWFEJBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWFEJBz (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 05:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWFEJBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 05:01:54 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:21907 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750786AbWFEJBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 05:01:54 -0400
Date: Mon, 5 Jun 2006 11:01:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, torvalds@osdl.org
Subject: Re: [RFC][PATCH] request_irq(...,SA_BOOTMEM);
Message-ID: <20060605090119.GA849@elte.hu>
References: <1149486009.8543.42.camel@localhost.localdomain> <1149491309.8543.54.camel@localhost.localdomain> <20060605003127.fc1ea37a.akpm@osdl.org> <1149493691.8543.57.camel@localhost.localdomain> <20060605012405.ac17f918.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605012405.ac17f918.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5005]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> And yes, the mutex code will (with debug enabled) unconditionally 
> enable interrupts.  ppc64 tends to oops when this happens, in the 
> timer handler (so it'll be intermittent...)

hm, i sent a patch to fix that, long time ago.

> But looking at 
> work-around-ppc64-bootup-bug-by-making-mutex-debugging-save-restore-irqs.patch 
> I realise I don't understand it.  We only go into the irq-enabling 
> code in the case of contention, and there cannot be contention in this 
> case?

in the debug case we go into the 'slowpath' all the time - so that we 
can do the debug checks under the mutex lock.

if we get real contention then we have a might_sleep() check that will 
catch that.

i'd suggest to push 
work-around-ppc64-bootup-bug-by-making-mutex-debugging-save-restore-irqs.patch 
upstream - i thought we agreed that while it's a bit hacky and slows the 
mutex code down a bit, it's not practical right now to forbid 
uncontended mutex_lock() in early init code?

	Ingo
