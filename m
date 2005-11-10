Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVKJVFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVKJVFE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVKJVFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:05:03 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:26814 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932121AbVKJVFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:05:01 -0500
Date: Thu, 10 Nov 2005 22:04:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: dino@in.ibm.com, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: IO-APIC problem with 2.6.14-rt9
Message-ID: <20051110210458.GA6097@elte.hu>
References: <20051110200226.GA18780@in.ibm.com> <20051110200205.GA4696@elte.hu> <20051110203000.GB16301@in.ibm.com> <1131654575.27168.685.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131654575.27168.685.camel@cog.beaverton.ibm.com>
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


* john stultz <johnstul@us.ibm.com> wrote:

> > > //#define ARCH_HAS_READ_CURRENT_TIMER  1
> > > 
> > > to:
> > > 
> > > #define ARCH_HAS_READ_CURRENT_TIMER  1
> > > 
> > > ?
> > 
> > It works !!  Thanks Ingo for the immediate response
> 
> Hrm. Could you post the value for BogoMIPS that you're getting now?
> 
> My patches touch the __delay() code, since using the TSC based delay 
> has just as many, if not more, problems as the loop based delay. So I 
> want to be careful that my changes are not further causing problems.
> 
> Ingo, did you commented out ARCH_HAS_READ_CURRENT_TIMER because of 
> problems with the new calibration code?

yes. traces show that the new calibration code results in a bogomips 
value on Athlon64 CPUs that halve the timeout. I.e. udelay(100) now 
takes 50 usecs (!). The calibration code seems to assume the number of 
cycles == number of loops in __delay() - that is not valid. The 
calibration needs to happen based on some real clock, such as the PIT, 
or PIT-driven jiffies.

	Ingo
