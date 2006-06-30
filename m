Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933063AbWF3ThV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933063AbWF3ThV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933074AbWF3ThV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:37:21 -0400
Received: from cantor.suse.de ([195.135.220.2]:46229 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933063AbWF3ThU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:37:20 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Date: Fri, 30 Jun 2006 21:37:15 +0200
User-Agent: KMail/1.9.3
Cc: Stephane Eranian <eranian@hpl.hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200606301519_MC3-1-C3E0-AD22@compuserve.com>
In-Reply-To: <200606301519_MC3-1-C3E0-AD22@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606302137.15644.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But that is using cpu_clk_unhalted (isn't it?)  If so, it would slow down
> when the system is idle.
> The BIOS writer's guide, Ch. 10.2, says only events outside of the
> processor, 

The other events don't happen by definition. 

If the system is C1 idle there are no cache misses, no pipe line events,
nothing - just cache snoops and waiting for interrupts and TSC
ticking.

> like northbridge DMA accesses, stop counting during halt. 
> (And by definition cpu_clk_unhalted.)

It also depends on which C state and how the BIOS implements your C state.

e.g. there is C1/C2/C3 and then there are various modi of C1
(HLT aka C1 is actually some SMM code in the BIOS that does different
stuff). 
 
I think there is at least one mode that ramps down large parts of the
CPU (it's called C1 clock ramping - that is what has caused the TSC
sync problems on some dual core systems).

I guess your BIOS is not very aggressive in its SMM code in
disabling the CPU.

C2/C3 also depend on SMM code, but when implemented should definitely
stop everything.
 
Intel also has different implementations of C1/C2/C3 depending
on CPU and BIOS. Especially lowend code 

But I still maintain something must be wrong with your 
measurements.

-Andi
