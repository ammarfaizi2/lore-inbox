Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268726AbTBZL7Z>; Wed, 26 Feb 2003 06:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268727AbTBZL7Z>; Wed, 26 Feb 2003 06:59:25 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:4346 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP
	id <S268726AbTBZL7Y>; Wed, 26 Feb 2003 06:59:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Server shipments [was Re: Minutes from Feb 21 LSE Call]
Date: Wed, 26 Feb 2003 06:09:19 -0600
X-Mailer: KMail [version 1.2]
References: <E18nu68-0004Ty-00@calista.inka.de>
In-Reply-To: <E18nu68-0004Ty-00@calista.inka.de>
MIME-Version: 1.0
Message-Id: <03022606091900.05181@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 February 2003 23:27, Bernd Eckenfels wrote:
> In article <03022522230400.04587@tabby> you wrote:
> > Something like a Cray X1, single processor for instance.
> > Or a 1024 processor Cray T3, again single system image, even if it
> > doesn't have a streaming vector processor.
> >
> > I don't see that any of the current cluster systems provide the
> > throughput of such a system. Not even IBMs' SP series.
>
> This clearly depends on the workload. For most vector processors
> partitioning does not make sense. And dont forget, most of those systems
> are pure compute servers used fr scientific computing.

Not as much as you would expect. I've been next to (cubical over) from some
people doing benchmarking on the IBM SP 3 (a 330 node quad processor system
and a newer one). Neither could achieve the "advertised" speed on real 
problems.

> > The output is fed to memory on every clock tick. (most Cray processors
> > have 4 memory busses for each processor - two for input data, one for
> > output data and one for the instruction stream
>
> The fastest Cray on top500.org is T3E1200 on rank _22_, the fastest IBM is
> ranked _2_ with a Power3 PRocessor. There are 13 IBM systems before the
> first (fastest) Cray system. Of course those GFlops are measured for
> parallel problems, but there are a lot out there.

The T3 achieves its speed based on the torus network. The processors
are only 400 MHz Alphas, 4 to a processing element. The IBM achives
its speed from a carefully crafted benchmark to show the fasted aggregate
computation possible. It is not a practical usage. Basically the computation
is split into the largest possible chunk, each chunk run on independant
systems, and merged at the very end of the computation. (I've used them too
and have access to two of them).

It takes something in the neighborhood of 60-100 processors in a T3 to
equal one Cray arch processor (even on a C90). A 32 processor C90
easily kept up with a T3 until you exceed 900 processors in the T3. (had
access to each of those too).

> And all those numbers are totally uninteresting for DB or Storage Servers.
> Even a SAP SD Benchmark would not be fun on a Cray.

The Cray has been known to support 200+ GB filesystems with 300+TB
nearline storage with a maximum of 11 second access to data when that
data has been migrated to tape... Admittedly, the time gets longer if the file
exceeds about 100 MB since it must then access multiple tapes in parallel.

> > I have used their systems for the last 12 years, and until the Earth
> > Simulator came on line, there was nothing that came close to their
> > throughput for weather modeling, finite element analysis, or other large
> > problem types.
>
> thats clearly wrong. http://www.top500.org/lists/lists.php?Y=2002&M=06

what you are actually looking at is a custom benchmark, carefully crafted
to show the fasted aggregate computation possible. It is not a practical
usage. The aggregate Cray system throughput (if you max out a X1 cluster)
exceeds even the Earth Simulator. Unfortunately, one of these hasn't been
sold yet.

One of the biggest weaknesses in the IBM world is the SP switch. The lack
of true shared memory programming model limites the systems to very coarse
grained parallelism. It really is just a collection of very fast small 
servers. There is no "single system image". The OS and all core utilities 
must be duplicated on each node or the cluster will not boot.

> There are a lot of Power3 ans Alpha systems before the first cray.

Ah  no. The first cray was before the Pentium... The company made a profit
off of its first sale on one system. There was no power 3 or alpha chip.
