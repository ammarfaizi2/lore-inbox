Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbTBJKbc>; Mon, 10 Feb 2003 05:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbTBJKbc>; Mon, 10 Feb 2003 05:31:32 -0500
Received: from dial-ctb04112.webone.com.au ([210.9.244.112]:54022 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S264915AbTBJKba>;
	Mon, 10 Feb 2003 05:31:30 -0500
Message-ID: <3E4781A2.8070608@cyberone.com.au>
Date: Mon, 10 Feb 2003 21:40:34 +1100
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
References: <20030209203343.06608eb3.akpm@digeo.com> <20030210045107.GD1109@unthought.net> <3E473172.3060407@cyberone.com.au> <20030210073614.GJ31401@dualathlon.random> <3E47579A.4000700@cyberone.com.au> <20030210080858.GM31401@dualathlon.random> <20030210001921.3a0a5247.akpm@digeo.com> <20030210085649.GO31401@dualathlon.random> <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Mon, Feb 10, 2003 at 01:07:25PM +0300, Hans Reiser wrote:
>
>>Andrew Morton wrote:
>>
>>
>>>Large directories tend to be spread all around the disk anyway.  And I've
>>>never explicitly tested for any problems which the loss of readahead might
>>>have caused ext2.  Nor have I tested inode table readahead.  Guess I 
>>>should.
>>>
>>>
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>>
>>>
>>>
>>>
>>readahead seems to be less effective for non-sequential objects.  Or at 
>>
>
>yes, this is why I said readahead matters mostly to generate the bigdma
>commands, so if the object is sequential it will be served by the
>lowlevel with a single dma using SG. this is also why when I moved the
>high dma limit of scsi to 512k (from 128k IIRC) I got such a relevant
>throughput improvement. Also watch the read speed in my tree compared to
>2.4 and 2.5 in bigbox.html from Randy (bonnie shows it well).
>
...AND readahead matters mostly to disk head scheduling when there
is other IO competing with the streaming read...

A big throughput improvement would have seen would be all to do with
better disk head scheduling due to the larger request sizes, yeah?
And this would probably be to do with the elevator accounting being
based on requests and/or seeks. You shouldn't notice much difference
with the elevator stuff in Andrew's mm patches.

I don't know too much about SCSI stuff, but if driver / wire / device
overheads were that much higher at 128K compared to 512K I would
think something is broken or maybe optimised badly.

Nick


