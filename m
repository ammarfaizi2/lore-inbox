Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266819AbUHISRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266819AbUHISRT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266816AbUHISRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:17:17 -0400
Received: from colin2.muc.de ([193.149.48.15]:27923 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266833AbUHISQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:16:24 -0400
Date: 9 Aug 2004 20:16:22 +0200
Date: Mon, 9 Aug 2004 20:16:22 +0200
From: Andi Kleen <ak@muc.de>
To: Bob Deblier <bob.deblier@telenet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AES assembler optimizations
Message-ID: <20040809181622.GA42722@muc.de>
References: <2riR3-7U5-3@gated-at.bofh.it> <m3d620v11e.fsf@averell.firstfloor.org> <1092067328.4332.40.camel@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092067328.4332.40.camel@orion>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 06:02:08PM +0200, Bob Deblier wrote:
> On Mon, 2004-08-09 at 16:28, Andi Kleen wrote:
> > Bob Deblier <bob.deblier@telenet.be> writes:
> > 
> > > Just picked up on KernelTrap that there were some problems with
> > > optimized AES code; if you wish, I can provide my own LGPL licensed (or
> > > I can relicense them for you under GPL), as included in the BeeCrypt
> > > Cryptography Library.
> > >
> > > I have generic i586 code and SSE-optimized code available in GNU
> > > assembler format. Latest version is always available on SourceForge
> > > (http://sourceforge.net/cvs/?group_id=8924).
> > 
> > Would be interesting.  Do you have any benchmarks for your code?
> 
> BeeCrypt contains benchmarks in the 'tests' subdirectory. Running of
> 'make bench' will execute them. Benchmarks results below for repeatedly
> looping over the same 16K block, produced by 'benchbc', without any
> tweaks (YMMV):

I guess a cache cold benchmark would be more interesting. AFAIK 
linux does encryption/decryption usually on cache cold buffers.

> P4 2400, with MMX:
> ECB encrypted 738304 KB in 10.00 seconds = 73823.02 KB/s
> CBC encrypted 659456 KB in 10.00 seconds = 65925.82 KB/s
> ECB decrypted 765952 KB in 10.00 seconds = 76564.57 KB/s
> CBC decrypted 616448 KB in 10.02 seconds = 61546.33 KB/s
> 
> P4 2400, plain i386:
> ECB encrypted 584704 KB in 10.01 seconds = 58435.34 KB/s
> CBC encrypted 570368 KB in 10.01 seconds = 56979.82 KB/s
> ECB decrypted 444416 KB in 10.02 seconds = 44357.32 KB/s
> CBC decrypted 423936 KB in 10.02 seconds = 42304.76 KB/s

MMX seems to be fast enough that it's probably a win to use,
even with the overhead of kernel_fpu_begin/end

It usually annoys the "low latency" people a bit though because
it requires disabling kernel preemption during the computation.

-Andi
