Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWAPWT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWAPWT7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 17:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWAPWT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 17:19:59 -0500
Received: from ns2.suse.de ([195.135.220.15]:50052 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751032AbWAPWT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 17:19:58 -0500
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)]
References: <20060110235554.GA3527@inferi.kami.home>
	<20060110170037.4a614245.akpm@osdl.org>
	<20060111100016.GC2574@elf.ucw.cz>
	<20060110235554.GA3527@inferi.kami.home>
	<20060110170037.4a614245.akpm@osdl.org>
	<20060111184027.GB4735@inferi.kami.home>
	<20060112220825.GA3490@inferi.kami.home>
	<1137108362.2890.141.camel@cog.beaverton.ibm.com>
	<20060114120816.GA3554@inferi.kami.home>
	<1137442582.27699.12.camel@cog.beaverton.ibm.com>
	<20060116204057.GC3639@inferi.kami.home>
	<1137447763.27699.27.camel@cog.beaverton.ibm.com>
From: Andi Kleen <ak@suse.de>
Date: 16 Jan 2006 23:19:59 +0100
In-Reply-To: <1137447763.27699.27.camel@cog.beaverton.ibm.com>
Message-ID: <p738xtf24ts.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> writes:
> > bus master activity:     00000000
> > states:
> >     C1:                  type[C1] promotion[C2] demotion[--] latency[000] usage[00007790]
> >    *C2:                  type[C2] promotion[--] demotion[C1] latency[010] usage[02310093]
> 
> Hrmm. Interesting. I'm not aware of C2 causing TSC stalls. This may be
> in part why we don't disable the TSC earlier.

On the dual core athlons C1 occasionally loses some ticks (it's not a real stall) when going
in/out of HLT. Since the different cores have different HLT patterns depending on load 
that causes them to drift against slowly each other, and it adds up over longer runtime.

Instead of adding lots of ugly checking code I would just check the CPUs like I do
in x86-64 and not use the TSC if the test fails. I believe the logic currently in there 
handles all modern hardware that is 64bit capable correctly.

-Andi
