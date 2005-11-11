Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVKKIUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVKKIUK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVKKIUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:20:10 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:7358 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751244AbVKKIUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:20:08 -0500
Date: Fri, 11 Nov 2005 09:20:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: dino@in.ibm.com, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: IO-APIC problem with 2.6.14-rt9
Message-ID: <20051111082004.GA20977@elte.hu>
References: <20051110200226.GA18780@in.ibm.com> <20051110200205.GA4696@elte.hu> <20051110203000.GB16301@in.ibm.com> <1131654575.27168.685.camel@cog.beaverton.ibm.com> <20051110210458.GA6097@elte.hu> <1131658975.27168.703.camel@cog.beaverton.ibm.com> <20051111073841.GA16009@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051111073841.GA16009@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > Grumble. :( I was hoping to submit my tod code to Andrew tomorrow, but 
> > this might block that.
> 
> hm, ARCH_HAS_READ_CURRENT_TIMER is upstream already. I have not 
> measured the udelay thing upstream, but i thought it would have the 
> same issue.  Does the GTOD code impact this code?

ah, i see - you changed __delay to always be loop-based. That is quite 
incorrect.

but i think there is a generic way to solve this: just busy-poll 
->read_cycles(). I.e. move __delay into the generic code too. This means 
even more architecture-specific code would be consolidated, which is 
always good.

	Ingo
