Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275218AbTHMPJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275220AbTHMPJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:09:28 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:40833 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S275218AbTHMPJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:09:26 -0400
Date: Wed, 13 Aug 2003 14:56:23 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308131356.h7DDuN3W000921@81-2-122-30.bradfords.org.uk>
To: jakob@unthought.net, Nick.Pavlica@echostar.com
Subject: Re: Swapfile Calculation / 2.4.18 | >
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   Our team is discussing the best approach to calculating the swap
> > file size for the 2.4.18 kernels and newer on systems with 6 - 8
> > Gb of RAM.  Does the "Double The System Ram" rule still apply?
>
> It never did.  It's a rule of thumb, if you have no idea about what
> your swap needs might be, and if it's a general purpose machine with
> "normal amounts of memory" that shouldn't swap at all but still
> should have some swap space just in case.

Too much swap space can be a bad thing.

I know an ISP who had a runaway process on a webserver, which had 256
Mb of RAM, and 512 Mb of swap.  As soon as the process started using a
lot of swap, the machine became almost completely unresponsive, and
somebody ended up driving to the datacentre to reboot it :-).

Just because disk space is cheap, it's not a good idea simply to
allocate swap space excessively.

> The only common rule that I can think of in this respect is: OOM is
> bad!
> Make sure that you have enough virtual memory for your applications,
> and then some to spare. A slow (swap thrashing) machine is better
> than a crashed machine.

Not always!  In the scenario I described above, the machine didn't
need any swap at all - if it hadn't had any, the runaway process would
have just been killed, and downtime would have been avoided.

> The workloads I have are usually a handfull of processes in the
> few-hundred-megs-of-memory range.  For this, I usually make sure
> that I have 1-2 GB of swap *more* than I would ever need.  A little
> headroom is useful when something doesn't run as expected.
>
> Also, having the majority of the used virtual memory in swap (say, a
> 2GB RAM plus 16 GB swap machine with 90% of all virtual memory
> used), is not necessarily a problem.  It depends.  Look at "vmstat".
> If there is virtually no paging activity, then it's probably not a
> performance problem.  Buying those extra 16 GB of RAM instead may
> not help you a lot.  I know people who do chip design, and I've
> heard stories about buying extra 'swap drives' simply in order to
> work around memory leaks in simulation applications.   It's a
> workaround, and the simulation application should of course be
> fixed, but it can work just nicely for memory leaks where the data
> that gets swapped out is never again accessed.

A large number of installations, especially desktop machines, don't
need swap devices at all.

The twice the physical RAM rule simply saves the effort of doing a
real assessment of how much RAM is needed for any particular task, and
doesn't negatively affect performance too much, or cost too much in
terms of disk space.  It works well, and is appropriate as a default
configuration for a Linux distribution, for example.  Wherever
possible, though, it's worth doing a real assessment of memory
requirements.

> So to summarize:  There is no simple rule.

I totally agree :-).

John.
