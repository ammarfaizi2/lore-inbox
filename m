Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWEaLze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWEaLze (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 07:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWEaLzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 07:55:33 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:40678 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932479AbWEaLzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 07:55:33 -0400
Date: Wed, 31 May 2006 13:55:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060531115545.GA4874@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <1149045448.28264.4.camel@localhost.localdomain> <20060530211442.a260a32e.akpm@osdl.org> <20060531063103.GC21779@elte.hu> <1149076243.28264.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149076243.28264.8.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > > It does that because it knows it's about to spend a long time talking 
> > > with the mii registers and it doesn't want to do that with interrupts 
> > > disabled.
> > 
> > i still consider it a 'quirky' locking construct, because disabling 
> > interrupts for a long time also disables all other devices sharing the 
> > same IRQ line - not nice.
> > 
> > Also, this is a really hard case for lockdep to detect 
> > automatically. (fortunately it's also relatively rare)
> 
> What's the standard way to teach lockdep about this?

Not yet. One possibility would be to use existing locks and to get rid 
of the disable_irq(). One technique could be to disable the IRQ on the 
card (i think the code already does this), and then call 
synchronize_irq() instead of disable_irq().

	Ingo
