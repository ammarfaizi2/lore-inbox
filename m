Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbTAEDsi>; Sat, 4 Jan 2003 22:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbTAEDsi>; Sat, 4 Jan 2003 22:48:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36621 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262662AbTAEDsh>; Sat, 4 Jan 2003 22:48:37 -0500
Date: Sat, 4 Jan 2003 19:51:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: Andi Kleen <ak@suse.de>, <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
In-Reply-To: <Pine.LNX.4.44.0301041930300.1388-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0301041942560.1651-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 4 Jan 2003, Linus Torvalds wrote:
> 
> It doesn't show up on lmbench (insufficient precision), but your AIM9
> numbers are quite interesting. Are they stable?

Btw, which checking whether the numbers are stable it is also interesting
to see stability across reboots etc, since for the scheduling latency in
particular it can easily depend on location of the binaries in physical
memory etc, since that matters for cache accesses (I think the L1 D$ on a
PIII is 4-way associative, I'm not sure - it makes it _reasonably_ good at
avoiding cache conflicts, but they can still happen and easily account for
a 5% fluctuation. I don't remember what the L1 I$ situation is).

And with a fairly persistent page cache, whatever cache situation there is
tends to largely stay the same, so just re-running the benchmark may not
change much, at least for the I$ situation.

You can see this effect quite clearly in lmbench: while the 2p/0k context
switch numbers tend to be fairly stable (almost zero likelyhood of any
cache conflicts), the others often fluctuate more even with the same
kernel (ie for me the 2p/16kB numbers fluctuate between 3 and 6 usecs).

D$ conflicts are largely easier to see (because they usually _will_ change 
when you re-run the benchmark, so they show up as fluctuations), but the 
I$ effects in particular can be quite persistent because (a) the kernel 
code will always be at the same place and (b) the user code tends to be 
sticky in the same place due to the page cache. 

I'm convinced the I$ effects are one major issue why we sometimes see
largish fluctuations on some ubenchmarks between kernels when nothing has
really changed.

		Linus

