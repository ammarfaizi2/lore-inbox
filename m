Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267288AbTBJLiR>; Mon, 10 Feb 2003 06:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267382AbTBJLiR>; Mon, 10 Feb 2003 06:38:17 -0500
Received: from packet.digeo.com ([12.110.80.53]:8158 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267288AbTBJLiP>;
	Mon, 10 Feb 2003 06:38:15 -0500
Date: Mon, 10 Feb 2003 03:48:08 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: piggin@cyberone.com.au, reiser@namesys.com, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
Message-Id: <20030210034808.7441d611.akpm@digeo.com>
In-Reply-To: <20030210113923.GY31401@dualathlon.random>
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
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2003 11:47:53.0690 (UTC) FILETIME=[3EFC03A0:01C2D0FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> It's the readahead in my tree that allows the reads to use the max scsi
> command size. It has nothing to do with the max scsi command size
> itself.

Oh bah.

-               *max_ra++ = vm_max_readahead;
+               *max_ra = ((128*4) >> (PAGE_SHIFT - 10)) - 1;


Well of course that will get bigger bonnie numbers, for exactly the reasons
I've explained.  It will seek between files after every 512k rather than
after every 128k.

> You can wait 10 minutes and still such command can't grow.  This is why
> claiming anticipatory scheduling can decrease the need for readahead
> doesn't make much sense to me, there are important things you just can't
> achieve by only waiting.
> 

The anticipatory scheduler can easily permit 512k of reading before seeking
away to another file.  In fact it can allow much more, without requiring that
readhead be cranked up.

