Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbTBJJ5r>; Mon, 10 Feb 2003 04:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbTBJJ5q>; Mon, 10 Feb 2003 04:57:46 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:21700 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264867AbTBJJ5p>; Mon, 10 Feb 2003 04:57:45 -0500
Message-ID: <3E4779DD.7080402@namesys.com>
Date: Mon, 10 Feb 2003 13:07:25 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Andrea Arcangeli <andrea@suse.de>, piggin@cyberone.com.au,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com>	<Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com>	<20030209203343.06608eb3.akpm@digeo.com>	<20030210045107.GD1109@unthought.net>	<3E473172.3060407@cyberone.com.au>	<20030210073614.GJ31401@dualathlon.random>	<3E47579A.4000700@cyberone.com.au>	<20030210080858.GM31401@dualathlon.random>	<20030210001921.3a0a5247.akpm@digeo.com>	<20030210085649.GO31401@dualathlon.random> <20030210010937.57607249.akpm@digeo.com>
In-Reply-To: <20030210010937.57607249.akpm@digeo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>
>Large directories tend to be spread all around the disk anyway.  And I've
>never explicitly tested for any problems which the loss of readahead might
>have caused ext2.  Nor have I tested inode table readahead.  Guess I should.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
readahead seems to be less effective for non-sequential objects.  Or at 
least, you don't get the order of magnitude benefit from doing only one 
seek, you only get the better elevator scheduling from having more 
things in the elevator, which isn't such a big gain.

For the spectators of the thread, one of the things most of us learn 
from experience about readahead is that there has to be something else 
trying to interject seeks into your workload for readahead to make a big 
difference, otherwise a modern disk drive (meaning, not 30 or so years 
old) is going to optimize it for you anyway using its track cache.

-- 
Hans


