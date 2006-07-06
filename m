Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWGFUYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWGFUYo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWGFUYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:24:44 -0400
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:3724 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S1750807AbWGFUYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:24:43 -0400
Date: Thu, 6 Jul 2006 13:16:16 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Message-ID: <20060706201616.GA10760@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200607061333_MC3-1-C44C-96D1@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607061333_MC3-1-C44C-96D1@compuserve.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,

On Thu, Jul 06, 2006 at 01:30:14PM -0400, Chuck Ebbert wrote:
> In-Reply-To: <20060704152857.GA6999@frankl.hpl.hp.com>
> 
> On Tue, 4 Jul 2006 08:28:57 -0700, Stephan Eranian wrote:
> 
> > Here is what I get on my dual 2.4GHz Opteron 250:
> > 
> > booted with idle=halt
> > $ pfmon --us-c -ecpu_clk_unhalted,interrupts_masked_cycles_with_interrupt_pending,interrupts_masked_cycles,cycles_no_fpu_ops_retired -k --system-wide -t 10
> > <session to end in 10 seconds>
> > CPU0                    11,356,210 CPU_CLK_UNHALTED                               
> > CPU0                             0 INTERRUPTS_MASKED_CYCLES_WITH_INTERRUPT_PENDING
> > CPU0                     3,836,107 INTERRUPTS_MASKED_CYCLES                       
> > CPU0                23,910,784,532 CYCLES_NO_FPU_OPS_RETIRED                      
> > CPU1                    19,303,632 CPU_CLK_UNHALTED                               
> > CPU1                             0 INTERRUPTS_MASKED_CYCLES_WITH_INTERRUPT_PENDING
> > CPU1                    13,942,265 INTERRUPTS_MASKED_CYCLES                       
> > CPU1                23,911,872,654 CYCLES_NO_FPU_OPS_RETIRED                      
> 
> So it looks like your Opteron continues to count CYCLES_NO_FPU_OPS_RETIRED
> at full clock speed even when halted.
> 

Yes, it certainly looks like it, idling at full clock speed. But that's a server CPU!
I think this may have to do with latency to get back to useful work.


> My Turion appears to slow down to ~40 MHz when halted and counts those
> events at that speed.  Using idle=poll shows no slowdown, as expected,
> and unhalted clocks equals cycles_no_fpu_ops_retired.
> 
That's a mobile processor, so I would expect it to use more aggressive
power-saving scheme while idle, at the cost of higher latency to get
back to full speed. 

The good thing about this is that it was not too hard to figure out what is
going using pfmon. Where you specifically looking for this? Is this a documented
behavior of the Turion64?

-- 
-Stephane
