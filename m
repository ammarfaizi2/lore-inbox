Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWJCKvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWJCKvl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 06:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWJCKvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 06:51:41 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:25783 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030288AbWJCKvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 06:51:39 -0400
Date: Tue, 3 Oct 2006 12:43:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Message-ID: <20061003104316.GA6830@elte.hu>
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <20061002132116.2663d7a3.akpm@osdl.org> <20061002201836.GB31365@elte.hu> <Pine.LNX.4.64.0610021349090.3952@g5.osdl.org> <20061002140121.f588b463.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002140121.f588b463.akpm@osdl.org>
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

> > I don't personally mind the patch, I just wanted to bring that issue 
> > up.
> 
> yup.  Perhaps we could add
> 
> #define IRQ_HANDLERS_DONT_USE_PTREGS
> 
> so that out-of-tree drivers can reliably do their ifdefing.

i'd suggest we do something like:

 #define __PT_REGS

so that backportable drivers can do:

  static irqreturn_t irq_handler(int irq, void *dev_id __PT_REGS)

instead of an #ifdef jungle. Older kernel bases can define __PT_REGS in 
their interrupt.h (or in the backported driver's header, in one place)

 #ifndef __PT_REGS
 # define __PT_REGS , struct pt_regs *regs
 #endif

this would minimize the direct impact in the source-code.

	Ingo
