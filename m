Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAIIry>; Tue, 9 Jan 2001 03:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRAIIrp>; Tue, 9 Jan 2001 03:47:45 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:1555 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S129267AbRAIIrk>; Tue, 9 Jan 2001 03:47:40 -0500
Message-ID: <3A5ACFFE.8FA3C7BF@idb.hist.no>
Date: Tue, 09 Jan 2001 09:46:54 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Chris Evans <chris@scary.beasts.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.2 vs. 2.4 benchmarks
In-Reply-To: <Pine.LNX.4.30.0101090000110.9761-100000@ferret.lmh.ox.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Evans wrote:
> 
> Hi,
> 
> I ran some 2.2 vs. 2.4 benchmarks, particularly in the area of file i/o,
> using bonnie++.
> 
> The machine is a SMP 128Mb PII-350 with a udma2 drive capable of some
> 20Mb/sec+. Kernels involved are 2.4.0, and the default RH7.0 kernel
> (2.2.16 plus more patches than you can shake a stick at).
> 
> Not going too much into the gory details, here are the differences exposed
> between 2,2 and 2.4:
> 
> 1) Amazing 2.4 increase in streaming write performance; 13Mb/sec ->
> 20Mb/sec. I suspect this is the result of the "last minute" 2.4.0 dirty
> buffer/sync waiting handling changes.
> 
> 2) Slight 2.4 increase in streaming read performance; 16Mb/sec ->
> 17Mb/sec. This leaves 2.4.0 writing faster than reading, I find that
> surprising.
>
I am not surprised.  Reading _have_
to read the stuff before presenting a result.  So you are completely
bound by
IO waiting, unless the stuff is cached.  But test-programs tend to
empty the cache first.  Writes can be buffered partially even if the
testfile is
much larger than memory.  The extra 3Mb/s might be going into RAM. 
Filling
128M with 3M/s takes about 43s.  20M/s in 43s is about 850M.  Did you
use a
testfile in the 500MB-1000MB range?
 
> 3) Some 10% drop in rewrite performance from 2.2 -> 2.4 (possibly because
> page aging, like LRU, isn't too hot for the 2nd+ linear scan over data)
> 
> 4) File creation 30% faster in 2.4; random deletes 30% faster; sequential
> deletes 10% slower.
> 
> I did one other quick test, with disappointing results for 2.4.0. I did a
> kernel build with 32Mb.
> 
> 2.4.0 was taking about 10 mins to do the build. 2.2.x was 1min30 quicker
> :( I was hoping/expecting the 2.4.0 page aging to do better, due to
> keeping the more useful pages in RAM better. I have no explanation.

You built exactly the same kernel in each case? (Version and options)
 With the same amount of other software (X, daemons,...)  running?  
Using the same source tree?  (Different disk locations may have large
speed
differences)  The circumstances where the same?  (Doing a make
[dist]clean
in order to get rid of files from the previous build will cache the
directory contents and be unfair if it happened in only one of the
cases.)

Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
