Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267844AbTBJNKb>; Mon, 10 Feb 2003 08:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267845AbTBJNKb>; Mon, 10 Feb 2003 08:10:31 -0500
Received: from dial-ctb04112.webone.com.au ([210.9.244.112]:2056 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267844AbTBJNK2>;
	Mon, 10 Feb 2003 08:10:28 -0500
Message-ID: <3E47A6E6.8070202@cyberone.com.au>
Date: Tue, 11 Feb 2003 00:19:34 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <20030210001921.3a0a5247.akpm@digeo.com> <20030210085649.GO31401@dualathlon.random> <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au> <20030210113923.GY31401@dualathlon.random> <20030210034808.7441d611.akpm@digeo.com> <20030210120916.GD31401@dualathlon.random> <3E47A1E5.6020902@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

> Is the following a fair summary?
>
> There is a certain minimum size required for the IOs to be cost 
> effective.  This can be determined by single reader benchmarking.  
> Only readahead and not anticipatory scheduling addresses that.

Well as a rule you would gain efficiency the larger your request size gets.
There will be a point where you make the trade off. And no, anticipatory
scheduling will not make read request sizes bigger.

>
>
> Anticipatory scheduling does not address the application that spends 
> one minute processing every read that it makes.  Readahead does.

In the presence of other IO, anticipatory scheduling would help here. In the
absense of other IO, readahead would not help (past the efficiency problem
above). However anticipatory scheduling _would_ mean you don't need as much
RAM tied up doing nothing (or being discarded) for one minute before it
is needed.

>
>
> Anticipatory scheduling does address the application that reads 
> multiple files that are near each other (because they are in the same 
> directory), and current readahead implementations (excepting reiser4 
> in progress vaporware) do not.

File readahead would not help. Anticipatory scheduling can.

>
>
> Anticipatory scheduling can do a better job of avoiding unnecessary 
> reads for workloads with small time gaps between reads than readahead 
> (it is potentially more accurate for some workloads).

It avoids seeks mainly, but the lesser need for readahead should mean
the readahead algorithm doesn't need to be very smart.

>
>
> Is this a fair summary?

Well I don't see it so much as readahead vs anticipatory scheduling.
I know readahead is important.

