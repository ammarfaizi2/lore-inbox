Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289182AbSA1Jsu>; Mon, 28 Jan 2002 04:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289183AbSA1Jsk>; Mon, 28 Jan 2002 04:48:40 -0500
Received: from dsl-213-023-043-003.arcor-ip.net ([213.23.43.3]:25472 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289182AbSA1Js3>;
	Mon, 28 Jan 2002 04:48:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.18pre4aa1
Date: Mon, 28 Jan 2002 10:53:25 +0100
X-Mailer: KMail [version 1.3.2]
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
In-Reply-To: <20020124002342.A630@earthlink.net> <E16ToWW-0002mf-00@starship.berlin> <20020125010907.D25170@athlon.random>
In-Reply-To: <20020125010907.D25170@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16V8Te-00008L-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 25, 2002 01:09 am, Andrea Arcangeli wrote:
> On Thu, Jan 24, 2002 at 07:27:43AM +0100, Daniel Phillips wrote:
> > On January 24, 2002 06:23 am, rwhron@earthlink.net wrote:
> > > Benchmarks on 2.4.18pre4aa1 and lots of other kernels at:
> > > http://home.earthlink.net/~rwhron/kernel/k6-2-475.html
> > 
> >   "dbench 64, 128, 192 on ext2fs. dbench may not be the best I/O 
> >   benchmark, but it does create a high load, and may put some pressure on 
> >   the cpu and i/o schedulers. Each dbench process creates about 21 
> >   megabytes worth of files, so disk usage is 1.3 GB, 2.6 GB and 4.0 GB 
> >   for the dbench runs. Big enough so the tests cannot run from the 
> >   buffer/page caches on this box."
> > 
> > Thanks kindly for the testing, but please don't use dbench any more for 
> > benchmarks.  If you are testing stability, fine, but dbench throughput 
> > numbers are not good for much more than wild goose chases.
> > 
> > Even when mostly uncached, dbench still produces flaky results.
> 
> this is not enterely true. dbench has a value.

Yes, but not for benchmarks.  It has value only as a stability test - while 
it may in some cases provide some general indication of performance, its 
variance is far too large, even under controlled conditions, for it to have 
any value as a benchmark.  I'm surprised you'd even suggest this.

Andrea, please, if we want good benchmarks let's at least be clear on what 
tools benchmarkers should/should not be using.

> the only problem with
> dbench is that you can trivially cheat and change the kernel in a broken
> way, but optimal _only_ for dbench, just to get stellar dbench numbers,

No, this is not the only problem.  DBench is just plain *flaky*.  You don't
appear to be clear on why.  In short, dbench has two main flaws:

  - It's extremely sensitive to scheduling.  If one process happens to make
    progress then it gets more heavily cached and its progress becomes even
    greater.  The benchmark completes much more quickly in this case, whereas
    if all processes progress at nearly the same rate (by chance) it runs
    more slowly.

  - It can happen (again by chance) that dbench files get deleted while still
    in cache, and this process completes in a fraction of the time that real 
    disk IO would require.

I've seen successsive runs of dbench *under identical conditions* (that is, 
from a clean reboot etc.) vary by as much as 30%.  Others report even greater 
variance.  Can we please agree that dbench is useless for benchmarks?

-- 
Daniel
