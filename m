Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267825AbTBJMCz>; Mon, 10 Feb 2003 07:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267826AbTBJMCz>; Mon, 10 Feb 2003 07:02:55 -0500
Received: from packet.digeo.com ([12.110.80.53]:51678 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267825AbTBJMCw>;
	Mon, 10 Feb 2003 07:02:52 -0500
Date: Mon, 10 Feb 2003 04:12:45 -0800
From: Andrew Morton <akpm@digeo.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: andrea@suse.de, reiser@namesys.com, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
Message-Id: <20030210041245.68665ff6.akpm@digeo.com>
In-Reply-To: <3E4792B7.5030108@cyberone.com.au>
References: <3E47579A.4000700@cyberone.com.au>
	<20030210080858.GM31401@dualathlon.random>
	<20030210001921.3a0a5247.akpm@digeo.com>
	<20030210085649.GO31401@dualathlon.random>
	<20030210010937.57607249.akpm@digeo.com>
	<3E4779DD.7080402@namesys.com>
	<20030210101539.GS31401@dualathlon.random>
	<3E4781A2.8070608@cyberone.com.au>
	<20030210111017.GV31401@dualathlon.random>
	<3E478C09.6060508@cyberone.com.au>
	<20030210113923.GY31401@dualathlon.random>
	<20030210034808.7441d611.akpm@digeo.com>
	<3E4792B7.5030108@cyberone.com.au>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2003 12:12:31.0078 (UTC) FILETIME=[AF938860:01C2D0FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> Andrew Morton wrote:
> 
> >Andrea Arcangeli <andrea@suse.de> wrote:
> >
> >>It's the readahead in my tree that allows the reads to use the max scsi
> >>command size. It has nothing to do with the max scsi command size
> >>itself.
> >>
> >
> >Oh bah.
> >
> >-               *max_ra++ = vm_max_readahead;
> >+               *max_ra = ((128*4) >> (PAGE_SHIFT - 10)) - 1;
> >
> >
> >Well of course that will get bigger bonnie numbers, for exactly the reasons
> >I've explained.  It will seek between files after every 512k rather than
> >after every 128k.
> >
> Though Andrea did say it is a "single threaded" streaming read.

Oh sorry, I missed that.

> That is what I can't understand. Movement of the disk head should
> be exactly the same in either situation and 128K is not exactly
> a pitiful request size - so it suggests a quirk somewhere. It
> is not as if the disk has to be particularly smart or know a
> lot about the data in order to optimise the head movement for
> a load like this.

Yes, that's a bit odd.  Some reduction in CPU cost and bus
traffic, etc would be expected.   Could be that sending out a
request which is larger than a track is saving a rev of the disk
for some reason.

