Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267838AbTBJM1R>; Mon, 10 Feb 2003 07:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267839AbTBJM1R>; Mon, 10 Feb 2003 07:27:17 -0500
Received: from dial-ctb04112.webone.com.au ([210.9.244.112]:42503 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267838AbTBJM1P>;
	Mon, 10 Feb 2003 07:27:15 -0500
Message-ID: <3E479CE2.5090605@cyberone.com.au>
Date: Mon, 10 Feb 2003 23:36:50 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@digeo.com>,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au> <20030210113923.GY31401@dualathlon.random> <3E4790F7.2010208@cyberone.com.au> <20030210120006.GC31401@dualathlon.random> <3E4796D5.7070009@cyberone.com.au> <20030210122248.GG31401@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Mon, Feb 10, 2003 at 11:11:01PM +1100, Nick Piggin wrote:
>
>>I don't understand it at all. I mean there is no other IO going
>>
>
>Unfortunately I can't help you understand it, but this is what I found
>with my pratical experience, I found it the first time in my alpha years
>ago when I increased the sym to 512k in early 2.4 then since it could
>break stuff we added the max_sectors again in 2.4. But of course if you
>don't fix readahead there's no way reads can take advantage of these
>lowlevel fixes. I thought I fixed readahead too but I felt it got backed
>out and when I noticed I resurrected it in my tree (see the name of the
>patch ;)
>
Fair enough. I accept it is important. Still think its odd ;)

[snip]

>>It would be easy to anticipate or not based on hints. We could
>>
>
>yep.
>
>
>>anticipate sync writes if we wanted, lower expire time for sync
>>writes, increase it for async reads. It is really not very
>>complex (although the code needs tidying up).
>>
>
>this is not the way I thought at it. I'm interested to give an hint
>only to know for sure which are the intermediate sync dependent reads
>(the obvious example is when doing the get_block and walking the
>3 level of inode indirect metadata blocks with big files, or while
>walking the balanced tree in reiserfs), and I'm not interested at all
>about writes. And I would just set an higher timeout when a read that I
>know for sure (thanks to the hint) is "intermdiate" is completed. We can
>use high timeouts there because we know they won't trigger 90% of the
>time, a new dependent read will be always submitted first.
>
This is a lot of nitty gritty stuff. It will all help, especially
in corner cases. Luckily it seems you don't need such
infrastructure to demonstrate most anticipatory scheduler gains.

