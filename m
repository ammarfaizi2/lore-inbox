Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUDMV7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 17:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263779AbUDMV7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 17:59:42 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6787
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263778AbUDMV7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 17:59:37 -0400
Date: Tue, 13 Apr 2004 23:59:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: Benchmarking objrmap under memory pressure
Message-ID: <20040413215940.GD2150@dualathlon.random>
References: <1130000.1081841981@[10.10.2.4]> <20040413005111.71c7716d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040413005111.71c7716d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 12:51:11AM -0700, Andrew Morton wrote:
> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
> >
> > UP Athlon 2100+ with 512Mb of RAM. Rebooted clean before each test
> > then did "make clean; make vmlinux; make clean". Then I timed a
> > "make -j 256 vmlinux" to get some testing under mem pressure. 
> > 
> > I was trying to test the overhead of objrmap under memory pressure,
> > but it seems it's actually distinctly negative overhead - rather pleasing
> > really ;-) 
> > 
> > 2.6.5
> > 225.18user 30.05system 6:33.72elapsed 64%CPU (0avgtext+0avgdata 0maxresident)k
> > 0inputs+0outputs (37590major+2604444minor)pagefaults 0swaps
> > 
> > 2.6.5-anon_mm
> > 224.53user 26.00system 5:29.08elapsed 76%CPU (0avgtext+0avgdata 0maxresident)k
> > 0inputs+0outputs (29127major+2577211minor)pagefaults 0swaps
> 
> A four second reduction in system time caused a one minute reduction in
> runtime?  Pull the other one ;)
> 
> Average of five runs, please...

at the very least the 6 seconds difference on a ~6 minutes load between
anonvma and anonmm sounds smaller than the measurement error generated
by disk seeks for a swapping workload, so yes, I'd like to see all 5
runs (not just the average).

As for the difference between 2.6.5 and 2.6.5-anonvma, that might be the
memory saved by the removal of rmap that in turn reduces the swap-I/O
required to complete the load or something like that, so that one may
not be a measurement error but just the benefit of anon-vma or anonmm,
but for a 6 seconds difference during a swap load I'd definitely like to
see the 5 runs.

Thanks!
