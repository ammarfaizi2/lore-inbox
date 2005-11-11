Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVKKHin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVKKHin (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 02:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVKKHin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 02:38:43 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:22659 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932184AbVKKHim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 02:38:42 -0500
Date: Fri, 11 Nov 2005 08:38:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: dino@in.ibm.com, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: IO-APIC problem with 2.6.14-rt9
Message-ID: <20051111073841.GA16009@elte.hu>
References: <20051110200226.GA18780@in.ibm.com> <20051110200205.GA4696@elte.hu> <20051110203000.GB16301@in.ibm.com> <1131654575.27168.685.camel@cog.beaverton.ibm.com> <20051110210458.GA6097@elte.hu> <1131658975.27168.703.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131658975.27168.703.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john stultz <johnstul@us.ibm.com> wrote:

> > yes. traces show that the new calibration code results in a bogomips 
> > value on Athlon64 CPUs that halve the timeout. I.e. udelay(100) now 
> > takes 50 usecs (!). The calibration code seems to assume the number of 
> > cycles == number of loops in __delay() - that is not valid.
> 
> Yea, that makes sense, because the READ_CURRENT_TIMER calibration is 
> all TSC based and with my code we use the loop based delay (since the 
> TSC based one can have a number of problems). So that doesn't mesh 
> well when the loop/cycle values are not equivalent.
> 
> That still leaves open the question why Dinakar is seeing issues w/ 
> the loop based calibration, but I've got some similar hardware in my 
> lab, so I can probably work that out.
> 
> I'll see if I can't avoid touching the delay code. Its such a sketchy 
> calibration sensitive code path that I'd really like to see it killed, 
> but maybe there's something simple that can be done.
> 
> Grumble. :( I was hoping to submit my tod code to Andrew tomorrow, but 
> this might block that.

hm, ARCH_HAS_READ_CURRENT_TIMER is upstream already. I have not measured 
the udelay thing upstream, but i thought it would have the same issue.  
Does the GTOD code impact this code?

	Ingo
