Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267607AbSLFGHX>; Fri, 6 Dec 2002 01:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267608AbSLFGHX>; Fri, 6 Dec 2002 01:07:23 -0500
Received: from holomorphy.com ([66.224.33.161]:6030 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267607AbSLFGHW>;
	Fri, 6 Dec 2002 01:07:22 -0500
Date: Thu, 5 Dec 2002 22:14:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, Norman Gaywood <norm@turing.une.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206061446.GA11023@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	Norman Gaywood <norm@turing.une.edu.au>,
	linux-kernel@vger.kernel.org
References: <20021206111326.B7232@turing.une.edu.au> <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <3DF034BB.D5F863B5@digeo.com> <20021206054804.GK1567@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206054804.GK1567@dualathlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 06:48:04AM +0100, Andrea Arcangeli wrote:
> you should because it seems you didn't realize how my code works. the
> algorithm is autotuned at boot and depends on the zone sizes, and it
> applies to the dma zone too with respect to the normal zone, the highmem
> case is just one of the cases that the fix for the general problem
> resolves, and you're totally wrong saying that mlocking 700m on a 4G box
> could kill it. I call it the per-claszone point of view watermark. If
> you are capable of highmem (mlock users are) you must left 100M or 10M
> or 10G free on the normal zone (depends on the watermark setting tuned
> at boot that is calculated in function of the zone sizes) etc... so it
> doesn't matter if you mlock 700M or 700G, it can't kill it. The split
> doesn't matter at all. 2.5 misses this important fix too btw.
> If you ignore this bugfix people will notice and there's no other way
> to fix it completely (unless you want to drop the zone-normal and
> zone-dma enterely, actually zone-dma matters much less because even if
> it exists basically nobody uses it).

This problem is not universal; pure GFP_KERNEL allocations are the main
problem here. The fix is necessary for anti-google bits but not a
panacea for all workloads. The issue here is basically forkbombs (i.e.
databases) with potentially high cross-process sharing.

Bill
