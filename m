Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUHIQJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUHIQJB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 12:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUHIQH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 12:07:28 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:16087 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S266715AbUHIQCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 12:02:13 -0400
Subject: Re: AES assembler optimizations
From: Bob Deblier <bob.deblier@telenet.be>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3d620v11e.fsf@averell.firstfloor.org>
References: <2riR3-7U5-3@gated-at.bofh.it>
	 <m3d620v11e.fsf@averell.firstfloor.org>
Content-Type: text/plain
Message-Id: <1092067328.4332.40.camel@orion>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 09 Aug 2004 18:02:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 16:28, Andi Kleen wrote:
> Bob Deblier <bob.deblier@telenet.be> writes:
> 
> > Just picked up on KernelTrap that there were some problems with
> > optimized AES code; if you wish, I can provide my own LGPL licensed (or
> > I can relicense them for you under GPL), as included in the BeeCrypt
> > Cryptography Library.
> >
> > I have generic i586 code and SSE-optimized code available in GNU
> > assembler format. Latest version is always available on SourceForge
> > (http://sourceforge.net/cvs/?group_id=8924).
> 
> Would be interesting.  Do you have any benchmarks for your code?

BeeCrypt contains benchmarks in the 'tests' subdirectory. Running of
'make bench' will execute them. Benchmarks results below for repeatedly
looping over the same 16K block, produced by 'benchbc', without any
tweaks (YMMV):

P4 2400, with MMX:
ECB encrypted 738304 KB in 10.00 seconds = 73823.02 KB/s
CBC encrypted 659456 KB in 10.00 seconds = 65925.82 KB/s
ECB decrypted 765952 KB in 10.00 seconds = 76564.57 KB/s
CBC decrypted 616448 KB in 10.02 seconds = 61546.33 KB/s

P4 2400, plain i386:
ECB encrypted 584704 KB in 10.01 seconds = 58435.34 KB/s
CBC encrypted 570368 KB in 10.01 seconds = 56979.82 KB/s
ECB decrypted 444416 KB in 10.02 seconds = 44357.32 KB/s
CBC decrypted 423936 KB in 10.02 seconds = 42304.76 KB/s

P3 800, with MMX:
ECB encrypted 436224 KB in 10.02 seconds = 43526.64 KB/s
CBC encrypted 308224 KB in 10.02 seconds = 30776.24 KB/s
ECB decrypted 449536 KB in 10.00 seconds = 44935.63 KB/s
CBC decrypted 292864 KB in 10.01 seconds = 29262.99 KB/s

P3 800, plain i386:
ECB encrypted 177152 KB in 10.03 seconds = 17665.74 KB/s
CBC encrypted 160768 KB in 10.03 seconds = 16030.31 KB/s
ECB decrypted 163840 KB in 10.05 seconds = 16300.87 KB/s
CBC decrypted 153600 KB in 10.04 seconds = 15306.43 KB/s

> However I think we would need to get rid of the M4 first. I don't
> think it would be a good idea to add that as kernel build dependency.
> Linux kernel assembly normally uses the C preprocessor and modern gas
> also has a quite powerful macro facility that is usually good
> enough. Any chance to convert the code to one of these?

I switched to M4 just to make sure the code works on more platforms than
just Linux with modern tools. It's quite easy to convert - it probably
wouldn't take more than an hour or so to produce a version for one fixed
platform.

Sincerely,

Bob Deblier

