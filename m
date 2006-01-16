Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWAPWlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWAPWlu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 17:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWAPWlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 17:41:50 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:20154 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751239AbWAPWlt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 17:41:49 -0500
Subject: Re: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3
	oops on suspend and more (bonus oops shot!)]
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <p738xtf24ts.fsf@verdi.suse.de>
References: <20060110235554.GA3527@inferi.kami.home>
	 <20060110170037.4a614245.akpm@osdl.org> <20060111100016.GC2574@elf.ucw.cz>
	 <20060110235554.GA3527@inferi.kami.home>
	 <20060110170037.4a614245.akpm@osdl.org>
	 <20060111184027.GB4735@inferi.kami.home>
	 <20060112220825.GA3490@inferi.kami.home>
	 <1137108362.2890.141.camel@cog.beaverton.ibm.com>
	 <20060114120816.GA3554@inferi.kami.home>
	 <1137442582.27699.12.camel@cog.beaverton.ibm.com>
	 <20060116204057.GC3639@inferi.kami.home>
	 <1137447763.27699.27.camel@cog.beaverton.ibm.com>
	 <p738xtf24ts.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 14:41:40 -0800
Message-Id: <1137451300.27699.43.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-16 at 23:19 +0100, Andi Kleen wrote:
> john stultz <johnstul@us.ibm.com> writes:
> > > bus master activity:     00000000
> > > states:
> > >     C1:                  type[C1] promotion[C2] demotion[--] latency[000] usage[00007790]
> > >    *C2:                  type[C2] promotion[--] demotion[C1] latency[010] usage[02310093]
> > 
> > Hrmm. Interesting. I'm not aware of C2 causing TSC stalls. This may be
> > in part why we don't disable the TSC earlier.
> 
> On the dual core athlons C1 occasionally loses some ticks (it's not a real stall) when going
> in/out of HLT. Since the different cores have different HLT patterns depending on load 
> that causes them to drift against slowly each other, and it adds up over longer runtime.

Yes, AMD SMP systems already mark the TSC as unstable w/ my code.

Unfortunately in this case, we're dealing w/ a single 1Ghz PIII where
the TSC is slowing down (due to what seems to be stalls, but could be
cpufreq scaling).

> Instead of adding lots of ugly checking code I would just check the CPUs like I do
> in x86-64 and not use the TSC if the test fails. I believe the logic currently in there 
> handles all modern hardware that is 64bit capable correctly.

If you're suggesting disabling the TSC based off of the results of the
unsynchronized_tsc() check in arch/x86-64/kerenl/time.c, I actually
already do almost the same thing (very much inspired by your code).
Although let me know if you mean something different.

thanks
-john

