Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268353AbTBYW0I>; Tue, 25 Feb 2003 17:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268354AbTBYW0I>; Tue, 25 Feb 2003 17:26:08 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:2951 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268353AbTBYW0H>;
	Tue, 25 Feb 2003 17:26:07 -0500
Date: Tue, 25 Feb 2003 23:37:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225223728.GB29467@dualathlon.random>
References: <20030225175928.GP29467@dualathlon.random> <20030225185008.GF10396@holomorphy.com> <20030225191817.GT29467@dualathlon.random> <372680000.1046201260@flay> <20030225203001.GV29467@dualathlon.random> <417110000.1046206424@flay> <20030225211718.GY29467@dualathlon.random> <421460000.1046207575@flay> <20030225221602.GZ29467@dualathlon.random> <490220000.1046211468@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490220000.1046211468@flay>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 02:17:48PM -0800, Martin J. Bligh wrote:
> > Sure, it is more expensive to use them, but all we care about is
> > complexity, and they solve the complexity problem just fine, so I
> > definitely prefer it. Cpu utilization during heavy swapping isn't a big
> > deal IMHO
> 
> I totally agree with you. However the concerns others raised were over
> page aging and page stealing (eg from pagecache), which might not involve
> disk, but would also be slower. It probably need some tuning and tweaking,
> but I'm pretty sure it's fundamentally the right approach.

there's no slowdown at all when we don't need to unmap anything.  We
just need to avoid watching the pte young bit in the pagetables unless
we're about to start unmapping stuff. Most machines won't reach the
point where they need to start unmapping stuff. Watching the ptes during
normal pagecache recycling would be wasteful anyways, regardless what
chain we take to reach the pte.

Andrea
