Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161588AbWJDQnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161588AbWJDQnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161594AbWJDQnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:43:53 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:1971 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161589AbWJDQnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:43:51 -0400
Date: Wed, 4 Oct 2006 18:35:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch] clockevents: drivers for i386, fix #2
Message-ID: <20061004163527.GA2328@elte.hu>
References: <20061003084729.GA24961@elte.hu> <20061003103503.GA6350@elte.hu> <20061003203620.d85df9c6.akpm@osdl.org> <20061004064620.GA22364@elte.hu> <20061004003228.98ec3b39.akpm@osdl.org> <20061004075540.GA31415@elte.hu> <20061004011544.d49308de.akpm@osdl.org> <20061004105315.GA24940@elte.hu> <1159960776.1386.244.camel@localhost.localdomain> <20061004090205.9c29f5bf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004090205.9c29f5bf.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> >  	.name = "lapic",
> >  	.capabilities = CLOCK_CAP_NEXTEVT | CLOCK_CAP_PROFILE
> > +#ifdef CONFIG_SMP
> >  			| CLOCK_CAP_UPDATE,
> > +#endif
> >  	.shift = 32,
> >  	.set_mode = lapic_timer_setup,
> >  	.set_next_event = lapic_next_event,
> 
> that (after a tweak to make it compile) fixes it. [...]

cool!

the vanilla SMP kernel will likely show similar effects on your laptop. 
We'll figure out a safe way to detect this quirk, and to work it around 
or turn off the lapic timer driver in that case.

(Btw., this bug was cleanups collateral damage. Many people are running 
-rt on laptops and i think we'd have noticed.)

	Ingo
