Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267847AbTBJMTu>; Mon, 10 Feb 2003 07:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267849AbTBJMTu>; Mon, 10 Feb 2003 07:19:50 -0500
Received: from [195.223.140.107] ([195.223.140.107]:31362 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267847AbTBJMTf>;
	Mon, 10 Feb 2003 07:19:35 -0500
Date: Mon, 10 Feb 2003 13:28:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@digeo.com>, reiser@namesys.com, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210122856.GJ31401@dualathlon.random>
References: <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au> <20030210113923.GY31401@dualathlon.random> <20030210034808.7441d611.akpm@digeo.com> <20030210120916.GD31401@dualathlon.random> <3E47985A.8000203@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E47985A.8000203@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 11:17:30PM +1100, Nick Piggin wrote:
> Andrea Arcangeli wrote:
> 
> >On Mon, Feb 10, 2003 at 03:48:08AM -0800, Andrew Morton wrote:
> >
> >>Andrea Arcangeli <andrea@suse.de> wrote:
> >>
> >>>It's the readahead in my tree that allows the reads to use the max scsi
> >>>command size. It has nothing to do with the max scsi command size
> >>>itself.
> >>>
> >>Oh bah.
> >>
> >>-               *max_ra++ = vm_max_readahead;
> >>+               *max_ra = ((128*4) >> (PAGE_SHIFT - 10)) - 1;
> >>
> >>
> >>Well of course that will get bigger bonnie numbers, for exactly the 
> >>reasons
> >>I've explained.  It will seek between files after every 512k rather than
> >>after every 128k.
> >>
> >
> >NOTE: first there is no seek at all in the benchmark we're talking
> >about, no idea why you think there are seeks. This is not tiobench, this
> >is bonnie sequential read.
> >
> Yes, Andrew obviously missed this... Anyway, could it be due to
> a big stripe size and hitting more disks in the RAID? How does
> a single SCSI disk perform here, Andrea?

Actually I increased readahead to more than just 512k in my last tree,
especially to take care of RAID :) so that both lowlevel will get the
512k, instead of being limited to 256k command each 8) This might apply
to hardware raid too.

Andrea
