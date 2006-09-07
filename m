Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWIGN6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWIGN6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 09:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWIGN6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 09:58:49 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:49590 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751767AbWIGN6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 09:58:47 -0400
Date: Thu, 7 Sep 2006 15:51:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.18-rc5-mm1: strange /proc/interrupts contents on HPC nx6325
Message-ID: <20060907135105.GA3318@elte.hu>
References: <200609062117.31125.rjw@sisk.pl> <20060906201953.d96ee183.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906201953.d96ee183.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> This is due to a gruesome hack (IMO) in the genirq code 
> (handle_irq_name()) which magically "knows" about the various types of 
> IRQ handler, but doesn't know about the MSI ones.  It should be 
> converted to a field in irq_desc, or a callback or something.

a field in irq_desc[] was frowned upon during initial genirq review, due 
to size reasons, so i removed it and replaced it with the hack.

> I already had a whine about this then forgot about it, but it seems that
> code can't be changed by whining at it ;)

;)

i think we could add a 'register handler name' API (or extend 
set_irq_handler() API), to pass in the name of handlers, and store it in 
a small array (instead of embedding it in irq_desc)? handle_irq_name() 
is not performance-critical.

	Ingo
