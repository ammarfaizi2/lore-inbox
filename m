Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWJBU0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWJBU0T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWJBU0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:26:19 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:64424 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964981AbWJBU0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:26:18 -0400
Date: Mon, 2 Oct 2006 22:18:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Message-ID: <20061002201836.GB31365@elte.hu>
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <20061002132116.2663d7a3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002132116.2663d7a3.akpm@osdl.org>
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

> I think the change is good.  But I don't want to maintain this whopper 
> out-of-tree for two months!  If we want to do this, we should just 
> smash it in and grit our teeth.  But I am a bit concerned about the 
> non-x86 architectures.  I assume they'll continue to compile-and-work?
> 
> What does Ingo think?

i agree that we should do this in one go and in Linus' tree. I suspect 
David has a script for this, so we can do it anytime for any tree, 
right?

the amount of code that truly relies on regs being present is very low. 
Mostly only sysrq type of stuff and the timer interrupt is such. Any 
arch should be able to adopt to that promptly, but i'd favor a 
switchover that works on 99% of the arches, just to have this pain over 
instantly (sans small bugs).

	Ingo
