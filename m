Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTLJWnJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 17:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbTLJWnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 17:43:09 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41180
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264147AbTLJWnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 17:43:06 -0500
Date: Wed, 10 Dec 2003 23:44:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031210224445.GE11193@dualathlon.random>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311031148.40242.kernel@kolivas.org> <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch> <20031208204817.GA19856@holomorphy.com> <20031210215235.GC11193@dualathlon.random> <20031210220525.GA28912@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210220525.GA28912@k3.hellgate.ch>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 11:05:25PM +0100, Roger Luethi wrote:
> On Wed, 10 Dec 2003 22:52:35 +0100, Andrea Arcangeli wrote:
> > On Mon, Dec 08, 2003 at 12:48:17PM -0800, William Lee Irwin III wrote:
> > > qsbench I'd pretty much ignore except as a control case, since there's
> > > nothing to do with a single process but let it thrash.
> > 
> > this is not the point. If a single process like qsbench trashes twice as
> > fast in 2.4, it means 2.6 has some great problem in the core vm, the
> > whole point of swap is to trash but to give the task more physical
> > virtual memory. I doubt you can solve it with anything returned by
> > si_swapinfo.
> 
> Uhm.. guys? I forgot to mention that earlier: qsbench as I used it was not
> about one single process. There were four worker processes (-p 4), and my
> load control stuff did make it run faster, so the point is moot.

more processes can be optimized even better by adding unfariness.
Either ways a significant slowdown of qsbench probably means worse core
VM, at least if compared with 2.4 that isn't adding huge unfariness just
to optimize qsbench.

> Also, the 2.6 core VM doesn't seem all that bad since it was introduced in
> 2.5.27 but most of the problems I measured were introduced after 2.5.40.
> Check out the graph I posted.

you're confusing rmap with core vm. rmap in no way can be defined as the
core vm, rmap is just a method used by the core vm to find some
information more efficiently at the expenses of all the fast paths
that now have to do the rmap bookkeeping.
