Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbTGBCuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 22:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbTGBCuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 22:50:51 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32466
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264608AbTGBCup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 22:50:45 -0400
Date: Wed, 2 Jul 2003 05:04:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Joel.Becker@oracle.com,
       Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030702030443.GW3040@dualathlon.random>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <20030701032531.GC20413@holomorphy.com> <20030701043902.GP3040@dualathlon.random> <20030701063317.GF20413@holomorphy.com> <20030701074915.GQ3040@dualathlon.random> <20030701085939.GG20413@holomorphy.com> <7950000.1057069435@[10.10.2.4]> <20030701162204.GV29000@holomorphy.com> <437540000.1057082096@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437540000.1057082096@flay>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 10:54:56AM -0700, Martin J. Bligh wrote:
> --On Tuesday, July 01, 2003 09:22:04 -0700 William Lee Irwin III <wli@holomorphy.com> wrote:
> 
> > At some point in the past, I wrote:
> >>> First I ask, "What is this exercising?" That answer is largely process
> >>> creation and destruction and SMP scheduling latency when there are very
> >>> rapidly fluctuating imbalances.
> >>> After observing that, the benchmark is flawed because
> >>> (a) it doesn't run long enough to produce stable numbers
> >>> (b) the results are apparently measured with gettimeofday(), which is
> >>> 	wildly inaccurate for such short-lived phenomena
> > 
> > On Tue, Jul 01, 2003 at 07:24:03AM -0700, Martin J. Bligh wrote:
> >> Bullshit. Use a maximal config file, and run it multiple times. I have
> >> sub 0.5% variance. 
> > 
> > My thought here had more to do with the measurements becoming dominated
> > by ramp-up and ramp-down and than the thing literally producing unreliable
> > timings. "Instability" was almost certainly the wrong word.
> > 
> > I'm also skeptical of its usefulness for scalability comparisons with a
> > single-threaded phase like the linking phase and the otherwise large
> > variations in concurrency. It seems much more like a binary test of
> > "does it get slower when I add more cpus?" than a measure of scalability.
> > 
> > For instance, if you were to devise some throughput measure say per
> > gigacycle based on this and compare efficiencies on various systems
> > with it so as to measure scaling factors, what would it be? Would you
> > feel comfortable using it for scalability comparisons given the
> > concurrency limitations for a single compile as a benchmark?
> 
> I'm not convinced it's that limited. I'm getting about 1460% cpu out
> of 16 processors - that's pretty well parallelized in my mind.

yes, especially considering what William said above.

But the point here is not to measure scalability in absolute terms, the
point IMHO is the scalability regression introduced by rmap (w/o
objrmap).

The fact the kernel workload isn't the most scalable thing on earth,
simply means other workloads doing the same thing that make+gcc does - but
never serializing in linking - will be hurted even more.

Andrea
