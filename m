Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267693AbSLGBse>; Fri, 6 Dec 2002 20:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267698AbSLGBse>; Fri, 6 Dec 2002 20:48:34 -0500
Received: from [195.223.140.107] ([195.223.140.107]:30850 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267693AbSLGBse>;
	Fri, 6 Dec 2002 20:48:34 -0500
Date: Sat, 7 Dec 2002 02:56:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       Norman Gaywood <norm@turing.une.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021207015615.GB4335@dualathlon.random>
References: <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <20021206222852.GF4335@dualathlon.random> <20021206232125.GR9882@holomorphy.com> <3DF13A54.927C04C1@digeo.com> <20021207002133.GT9882@holomorphy.com> <1039227589.25062.10.camel@irongate.swansea.linux.org.uk> <20021207014643.GW9882@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021207014643.GW9882@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 05:46:43PM -0800, William Lee Irwin III wrote:
> On Sat, 2002-12-07 at 00:21, William Lee Irwin III wrote:
> >> 16K is reasonable; after that one might as well go all the way.
> >> About the only way to cope is amortizing it by cacheing zeroed pages,
> >> and that has other downsides.
> 
> On Sat, Dec 07, 2002 at 02:19:49AM +0000, Alan Cox wrote:
> > Some of the lower end CPU's only have about 12-16K of L1. I don't think
> > thats a big problem since those aren't going to be highmem or large
> > memory users 
> 
> It's an arch parameter, so they'd probably just
> #define MMUPAGE_SIZE PAGE_SIZE
> Hugh's original patch did that for all non-i386 arches.

I would say the most important thing to evaluate before the cpu and
cache size is the amount of ram in the machine. The major downside of
going to 8k is the loss of granularity in the paging, so a small machine
may not want to pagein the next page too unless it's been explicitly
touched by the program, to utilize the few available ram at best and to
have the most finegrined info possible about the working set in the
pagetables. The breakpoint depends on the workload. probably it would
make sense to keep at 4k all boxes <= 64M or something on those lines.

Andrea
