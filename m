Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268629AbTBZENT>; Tue, 25 Feb 2003 23:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268630AbTBZENT>; Tue, 25 Feb 2003 23:13:19 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:13303 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP
	id <S268629AbTBZENS>; Tue, 25 Feb 2003 23:13:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Gerhard Mack <gmack@innerfire.net>, Larry McVoy <lm@bitmover.com>
Subject: Re: Server shipments [was Re: Minutes from Feb 21 LSE Call]
Date: Tue, 25 Feb 2003 22:23:04 -0600
X-Mailer: KMail [version 1.2]
Cc: Gerrit Huizenga <gh@us.ibm.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302251844560.7307-100000@innerfire.net>
In-Reply-To: <Pine.LNX.4.44.0302251844560.7307-100000@innerfire.net>
MIME-Version: 1.0
Message-Id: <03022522230400.04587@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 February 2003 17:46, Gerhard Mack wrote:
> On Tue, 25 Feb 2003, Larry McVoy wrote:
> > Date: Tue, 25 Feb 2003 15:19:26 -0800
> > From: Larry McVoy <lm@bitmover.com>
> > To: Gerrit Huizenga <gh@us.ibm.com>
> > Cc: Larry McVoy <lm@bitmover.com>, Martin J. Bligh <mbligh@aracnet.com>,
> >      linux-kernel@vger.kernel.org
> > Subject: Re: Server shipments [was Re: Minutes from Feb 21 LSE Call]
> >
[snip]
> > On the high end, go look at what customers want.  They are mostly taking
> > those big boxes and partitioning them.  Sooner or later some bright boy
> > is going to realize that they could put 4 4 way boxes in one rack and
> > call it a 16 way box with 4 way partitioning "pre-installed".
>
> er you mean like what racksaver.com does with their 2 dual CPU servers in
> a box?

And that is not "Big Iron".

sorry - Big Iron is a 1 -5 TFlop single system image, shared memory, with 
streaming vector processor...

Something like a Cray X1, single processor for instance.
Or a 1024 processor Cray T3, again single system image, even if it doesn't
have a streaming vector processor.

I don't see that any of the current cluster systems provide the throughput
of such a system. Not even IBMs' SP series. Aggregate measures of theoretical
throughput just don't add up. Practical throughput is almost always only 80% 
of the theoretical (ie. the advertised) througput. Most cannot handle the data
I/O requirement, much less the IPC latency.

Sure, 3 microseconds sounds nice for myranet, but nothing beats 17 clock ticks
where each tick is 4 ns for the first 64 bit word of data... followed by the 
next word in 4 ns per buss. ( and that is on a slow processor....)

The output is fed to memory on every clock tick. (most Cray processors have 4 
memory busses for each processor - two for input data, one for output data 
and one for the instruction stream ; and each has the same cycle time...Now
go to 4/8/16/32 processors without reducing that timing. That requires some
CAREFULL hardware design.)

And you better believe that there are big margins on such a system. You only
have to sell 8 to 16 units to exceed the yearly profit of most computer 
companies. Do I have hard numbers on the units? no. I don't work for Cray.
I have used their systems for the last 12 years, and until the Earth Simulator
came on line, there was nothing that came close to their throughput for 
weather modeling, finite element analysis, or other large problem types.

None of the microprocessors (possibly excepting the Power 4) can come close -
When you look at the processor internals, they all only have a single memory 
buss, running approximately 1 - 2 GB/second to cache.

Look at the cray this way: ALL of main memory is cache... with 4 ports to 
it... for EACH processor... 

Would I like to see Linux running on these? yes. Can I pay for it? No. I'm 
not in such a position where I could buy one. Would customers buy one?
Perhaps - if the price were right or the need great enough. Would having
Linux on it save the vendor money? I don't know. I hope that it would.

Unfortunately, there are too many things missing from Linux for it to be
considered:
	job and process checkpoint/restart (with files/pipes/sockets intact)
	batch job processors (REAL batch jobs ... not just cron)
	resource accounting and resource allocation control
	compartmented mode security support
	truly large filesystem support (10 TB online, 300+ TB nearline in one fs)
	large file support (100-300 GB in one file at least)
	large process support 
		(10Gb processes, 10-1000 threads... I can dream can't I :-)
	automatic hardware failover support
	hot swap components (disks, tapes, memory, processors)

to make a short list.
