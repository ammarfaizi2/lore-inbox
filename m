Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbTBJJJO>; Mon, 10 Feb 2003 04:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbTBJJJO>; Mon, 10 Feb 2003 04:09:14 -0500
Received: from dial-ctb03241.webone.com.au ([210.9.243.241]:22790 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S264673AbTBJJJN>;
	Mon, 10 Feb 2003 04:09:13 -0500
Message-ID: <3E476E72.4060900@cyberone.com.au>
Date: Mon, 10 Feb 2003 20:18:42 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Jakob Oestergaard <jakob@unthought.net>, Andrew Morton <akpm@digeo.com>,
       David Lang <david.lang@digitalinsight.com>, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com> <Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com> <20030209203343.06608eb3.akpm@digeo.com> <20030210045107.GD1109@unthought.net> <3E473172.3060407@cyberone.com.au> <20030210073614.GJ31401@dualathlon.random> <3E47579A.4000700@cyberone.com.au> <20030210080858.GM31401@dualathlon.random> <3E476287.8070407@cyberone.com.au> <20030210090248.GP31401@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Mon, Feb 10, 2003 at 07:27:51PM +1100, Nick Piggin wrote:
>
>>
>>Andrea Arcangeli wrote:
>>
>>
>>>On Mon, Feb 10, 2003 at 06:41:14PM +1100, Nick Piggin wrote:
>>>
>>>
>>>>Andrea Arcangeli wrote:
>>>>
>>>>
>>>>
>>>>>On Mon, Feb 10, 2003 at 03:58:26PM +1100, Nick Piggin wrote:
>>>>>
>>>>>
>>>>>>Remember that readahead gets scaled down quickly if it isn't
>>>>>>getting hits. It is also likely to be sequential and in the
>>>>>>track buffer, so it is a small cost.
>>>>>>
>>>>>>Huge readahead is a problem however anticipatory scheduling
>>>>>>will hopefully allow good throughput for multiple read streams
>>>>>>without requiring much readahead.
>>>>>>
>>>>>>
>>What I mean by this is: if we have >1 sequential readers (eg. ftp
>>server), lets say 30MB/s disk, 4ms avg seek+settle+blah time,
>>submitting reads in say 128KB chunks alternating between streams
>>will cut throughput in half... At 1MB readahead we're at 89%
>>throughput. At 2MB, 94%
>>
>>With anticipatory scheduling, we can give each stream say 100ms
>>so thats 96% with, say... 8K readahead if you like. (Yes, I am
>>aware that CPU/PCI/IDE efficiency also mandates a larger request
>>size).
>>
>
>the way things works, if you give 8k readahead, you'll end submitting 8k
>requests no matter how long you wait and it will kill throughput to 10%
>of what was possible to achieve, very especially with scsi, max
>coalescing of ide is 64k and btw that is its main weakness IMHO.
>
>It doesn't make any sense to me your claim that you can decrease the
>readahead by adding anticipatory scheduling, if you do you'll run
>so slow at 8k per request in all common workloads.
>
I mean you kill throughput by submitting non linear requests. OK
with such small requests you probably would lose some throughtput
due to much greater ratio of overheads to work done, but in general
we are talking about disk head positioning. 10 1MB requests should
be much quicker than 1000 10K requests, for disk performance.

