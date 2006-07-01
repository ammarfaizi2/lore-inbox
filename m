Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWGAPZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWGAPZY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWGAPZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:25:23 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:21926 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750819AbWGAPZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 11:25:23 -0400
Date: Sat, 1 Jul 2006 11:21:22 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU
  context switch
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Message-ID: <200607011123_MC3-1-C3EB-BFF1@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060630204032.GB22835@frankl.hpl.hp.com>

On Fri, 30 Jun 2006 13:40:32 -0700, Stephane Eranian wrote:

> As Andi is suggesting, I think this may depends on how the BIOS implements
> the low-power state. I have tried the same command on my dual Opteron 250
> 2.4GHz and I get:
> $ pfmon --us-c -ecpu_clk_unhalted,interrupts_masked_cycles -k --system-wide -t 10
> <session to end in 10 seconds>
> CPU0                     9,520,303 CPU_CLK_UNHALTED
> CPU0                     3,726,315 INTERRUPTS_MASKED_CYCLES
> CPU1                    21,268,151 CPU_CLK_UNHALTED
> CPU1                    14,515,389 INTERRUPTS_MASKED_CYCLES

That is similar to what I get with idle=halt. Are you not using ACPI
for idle?

Try this:

$ pfmon -ecpu_clk_unhalted,interrupts_masked_cycles_with_interrupt_pending,interrupts_masked_cycles,cycles_no_fpu_ops_retired -k --system-wide -t 10
<session to end in 10 seconds>
CPU0     95016828 CPU_CLK_UNHALTED
CPU0     36472783 INTERRUPTS_MASKED_CYCLES_WITH_INTERRUPT_PENDING
CPU0     67484408 INTERRUPTS_MASKED_CYCLES
CPU0    445326968 CYCLES_NO_FPU_OPS_RETIRED

That's what I get with idle=halt.  Since the kernel doesn't do FP
the last line should equal clock cycles.  If it were running at full
speed it would be 16 billion...

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
