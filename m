Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267638AbTBJLnu>; Mon, 10 Feb 2003 06:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267681AbTBJLnu>; Mon, 10 Feb 2003 06:43:50 -0500
Received: from dial-ctb04112.webone.com.au ([210.9.244.112]:19719 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267638AbTBJLnt>;
	Mon, 10 Feb 2003 06:43:49 -0500
Message-ID: <3E4792B7.5030108@cyberone.com.au>
Date: Mon, 10 Feb 2003 22:53:27 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Andrea Arcangeli <andrea@suse.de>, reiser@namesys.com, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <3E47579A.4000700@cyberone.com.au>	<20030210080858.GM31401@dualathlon.random>	<20030210001921.3a0a5247.akpm@digeo.com>	<20030210085649.GO31401@dualathlon.random>	<20030210010937.57607249.akpm@digeo.com>	<3E4779DD.7080402@namesys.com>	<20030210101539.GS31401@dualathlon.random>	<3E4781A2.8070608@cyberone.com.au>	<20030210111017.GV31401@dualathlon.random>	<3E478C09.6060508@cyberone.com.au>	<20030210113923.GY31401@dualathlon.random> <20030210034808.7441d611.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Andrea Arcangeli <andrea@suse.de> wrote:
>
>>It's the readahead in my tree that allows the reads to use the max scsi
>>command size. It has nothing to do with the max scsi command size
>>itself.
>>
>
>Oh bah.
>
>-               *max_ra++ = vm_max_readahead;
>+               *max_ra = ((128*4) >> (PAGE_SHIFT - 10)) - 1;
>
>
>Well of course that will get bigger bonnie numbers, for exactly the reasons
>I've explained.  It will seek between files after every 512k rather than
>after every 128k.
>
Though Andrea did say it is a "single threaded" streaming read.
That is what I can't understand. Movement of the disk head should
be exactly the same in either situation and 128K is not exactly
a pitiful request size - so it suggests a quirk somewhere. It
is not as if the disk has to be particularly smart or know a
lot about the data in order to optimise the head movement for
a load like this.

