Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWF3Usj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWF3Usj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 16:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWF3Usj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 16:48:39 -0400
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:37583 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S932227AbWF3Usi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 16:48:38 -0400
Date: Fri, 30 Jun 2006 13:40:32 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Message-ID: <20060630204032.GB22835@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200606301435_MC3-1-C3DD-5B3E@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606301435_MC3-1-C3DD-5B3E@compuserve.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,

On Fri, Jun 30, 2006 at 02:33:49PM -0400, Chuck Ebbert wrote:
> In-Reply-To: <200606301541.22928.ak@suse.de>
> 
> On Fri, 30 Jun 2006 15:41:22 +0200, Andi Kleen wrote:
> 
> > > So why do we need care about context switch in cpu-wide mode?
> > > It is because we support a mode where the idle thread is excluded
> > > from cpu-wide monitoring. This is very useful to distinguish 
> > > 'useful kernel work' from 'idle'. 
> > 
> > I don't quite see the point because on x86 the PMU doesn't run
> > during C states anyways. So you get idle excluded automatically.
> 
> Looks like it does run:
> 
> $ pfmon -ecpu_clk_unhalted,interrupts_masked_cycles -k --system-wide -t 10
> <session to end in 10 seconds>
> CPU0     60351837 CPU_CLK_UNHALTED
> CPU0    346548229 INTERRUPTS_MASKED_CYCLES
> 
> The CPU spent ~60 million clocks unhalted and ~350 million with interrupts
> disabled.  (This is an idle 1.6GHz Turion64 machine.)
> 

As Andi is suggesting, I think this may depends on how the BIOS implements
the low-power state. I have tried the same command on my dual Opteron 250
2.4GHz and I get:
$ pfmon --us-c -ecpu_clk_unhalted,interrupts_masked_cycles -k --system-wide -t 10
<session to end in 10 seconds>
CPU0                     9,520,303 CPU_CLK_UNHALTED
CPU0                     3,726,315 INTERRUPTS_MASKED_CYCLES
CPU1                    21,268,151 CPU_CLK_UNHALTED
CPU1                    14,515,389 INTERRUPTS_MASKED_CYCLES

That's without idle=poll.

-- 

-Stephane
