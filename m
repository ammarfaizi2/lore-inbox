Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286895AbSAYAJE>; Thu, 24 Jan 2002 19:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290464AbSAYAIp>; Thu, 24 Jan 2002 19:08:45 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31044 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S286895AbSAYAId>; Thu, 24 Jan 2002 19:08:33 -0500
Date: Fri, 25 Jan 2002 01:09:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre4aa1
Message-ID: <20020125010907.D25170@athlon.random>
In-Reply-To: <20020124002342.A630@earthlink.net> <E16ToWW-0002mf-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E16ToWW-0002mf-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Jan 24, 2002 at 07:27:43AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 07:27:43AM +0100, Daniel Phillips wrote:
> On January 24, 2002 06:23 am, rwhron@earthlink.net wrote:
> > Benchmarks on 2.4.18pre4aa1 and lots of other kernels at:
> > http://home.earthlink.net/~rwhron/kernel/k6-2-475.html
> 
>   "dbench 64, 128, 192 on ext2fs. dbench may not be the best I/O benchmark, 
>   but it does create a high load, and may put some pressure on the cpu and 
>   i/o schedulers. Each dbench process creates about 21 megabytes worth of 
>   files, so disk usage is 1.3 GB, 2.6 GB and 4.0 GB for the dbench runs. Big 
>   enough so the tests cannot run from the buffer/page caches on this box."
> 
> Thanks kindly for the testing, but please don't use dbench any more for 
> benchmarks.  If you are testing stability, fine, but dbench throughput 
> numbers are not good for much more than wild goose chases.
> 
> Even when mostly uncached, dbench still produces flaky results.

this is not enterely true. dbench has a value. the only problem with
dbench is that you can trivially cheat and change the kernel in a broken
way, but optimal _only_ for dbench, just to get stellar dbench numbers,
but this is definitely not the case with the -aa tree, -aa tree is
definitely not optimized for dbench, infact the recent improvement cames
most probably from dyn-sched and bdflush histeresis introduction, not
from vm changes at all (there were no recent significant vm changes in
the page replacement and aging algorithms infact). rmap instead sucks in
most of the benchmarks because of the noticeable overhead of maintaining
those reverse maps that starts to help only by the time you need to
swap/pageout (totally useless and only overhead for number crunching,
database selfcaching etc..). This is the only issue with the rmap design
and you can definitely see it in the numbers. Here I'm only speaking
about the design, I never checked the current implementation.

Andrea
