Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWGFRh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWGFRh0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWGFRhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:37:25 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:8113 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030358AbWGFRhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:37:24 -0400
Date: Thu, 6 Jul 2006 13:30:14 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU
  context switch
To: "eranian@hpl.hp.com" <eranian@hpl.hp.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607061333_MC3-1-C44C-96D1@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060704152857.GA6999@frankl.hpl.hp.com>

On Tue, 4 Jul 2006 08:28:57 -0700, Stephan Eranian wrote:

> Here is what I get on my dual 2.4GHz Opteron 250:
> 
> booted with idle=halt
> $ pfmon --us-c -ecpu_clk_unhalted,interrupts_masked_cycles_with_interrupt_pending,interrupts_masked_cycles,cycles_no_fpu_ops_retired -k --system-wide -t 10
> <session to end in 10 seconds>
> CPU0                    11,356,210 CPU_CLK_UNHALTED                               
> CPU0                             0 INTERRUPTS_MASKED_CYCLES_WITH_INTERRUPT_PENDING
> CPU0                     3,836,107 INTERRUPTS_MASKED_CYCLES                       
> CPU0                23,910,784,532 CYCLES_NO_FPU_OPS_RETIRED                      
> CPU1                    19,303,632 CPU_CLK_UNHALTED                               
> CPU1                             0 INTERRUPTS_MASKED_CYCLES_WITH_INTERRUPT_PENDING
> CPU1                    13,942,265 INTERRUPTS_MASKED_CYCLES                       
> CPU1                23,911,872,654 CYCLES_NO_FPU_OPS_RETIRED                      

So it looks like your Opteron continues to count CYCLES_NO_FPU_OPS_RETIRED
at full clock speed even when halted.

My Turion appears to slow down to ~40 MHz when halted and counts those
events at that speed.  Using idle=poll shows no slowdown, as expected,
and unhalted clocks equals cycles_no_fpu_ops_retired.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
