Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267311AbTBJKqJ>; Mon, 10 Feb 2003 05:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbTBJKqJ>; Mon, 10 Feb 2003 05:46:09 -0500
Received: from dial-ctb04112.webone.com.au ([210.9.244.112]:56326 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267311AbTBJKqI>;
	Mon, 10 Feb 2003 05:46:08 -0500
Message-ID: <3E478528.6030009@cyberone.com.au>
Date: Mon, 10 Feb 2003 21:55:36 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Hans Reiser <reiser@namesys.com>, andrea@suse.de, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com>	<Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com>	<20030209203343.06608eb3.akpm@digeo.com>	<20030210045107.GD1109@unthought.net>	<3E473172.3060407@cyberone.com.au>	<20030210073614.GJ31401@dualathlon.random>	<3E47579A.4000700@cyberone.com.au>	<20030210080858.GM31401@dualathlon.random>	<20030210001921.3a0a5247.akpm@digeo.com>	<20030210085649.GO31401@dualathlon.random>	<20030210010937.57607249.akpm@digeo.com>	<3E4779DD.7080402@namesys.com> <20030210024810.43a57910.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser <reiser@namesys.com> wrote:
>
>>readahead seems to be less effective for non-sequential objects.  Or at 
>>least, you don't get the order of magnitude benefit from doing only one 
>>seek, you only get the better elevator scheduling from having more 
>>things in the elevator, which isn't such a big gain.
>>
>>For the spectators of the thread, one of the things most of us learn 
>>from experience about readahead is that there has to be something else 
>>trying to interject seeks into your workload for readahead to make a big 
>>difference, otherwise a modern disk drive (meaning, not 30 or so years 
>>old) is going to optimize it for you anyway using its track cache.
>>
>>
>
>The biggest place where readahead helps is when there are several files being
>read at the same time.  Without readahead the disk will seek from one file
>to the next after having performed a 4k I/O.  With readahead, after performing
>a (say) 128k I/O.  It really can make a 32x difference.
>
>Readahead is brute force.  The anticipatory scheduler solves this in a
>smarter way.
>
>Yes, device readahead helps.  But I believe the caches are only 4-way
>segmented or thereabouts, so it is easy to thrash them.  Let's test:
>
[snip results]

>
>
>Still only 300%.  I'd expect to see much larger differences on some older
>SCSI disks I have here.
>
It would be interesting to see numbers with and without anticipatory
scheduling as well. I have tried two streaming readers.
Speed with default readahead 13MB/s
Speed with no readahead, no anticipation 7MB/s
Speed with no readahead, anticipation 11.8MB/s

I suspect more readers will simply favour the anticipatory scheduler
more.

Nick

