Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWFFNyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWFFNyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWFFNyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:54:47 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:11164 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932175AbWFFNyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:54:46 -0400
Date: Tue, 6 Jun 2006 15:53:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm3] fix irqpoll some more
Message-ID: <20060606135353.GA25609@elte.hu>
References: <200606050600.k5560GdU002338@shell0.pdx.osdl.net> <1149497459.23209.39.camel@localhost.localdomain> <20060605084938.GA31915@elte.hu> <1149600355.16247.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149600355.16247.49.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 2006-06-05 at 10:49 +0200, Ingo Molnar wrote:
> 
> > +	/*
> > +	 * HACK:
> > +	 *
> > +	 * In the first pass we dont touch handlers that are behind
> > +	 * a disabled IRQ line. In the second pass (having no other
> > +	 * choice) we ignore the disabled state of IRQ lines. We've
> > +	 * got a screaming interrupt, so we have the choice between
> > +	 * a real lockup happening due to that screaming interrupt,
> > +	 * against a theoretical locking that becomes possible if we
> > +	 * ignore a disabled IRQ line.
> 
> FYI, with irqpoll on in my i386 SMP machine, I hit this theoretical 
> locking every time in the vortex driver.

you got a lockup/deadlock every time, due to the bug that the lock 
validator pointed out?

	Ingo
