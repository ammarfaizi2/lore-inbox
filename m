Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268153AbTCDFQ3>; Tue, 4 Mar 2003 00:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268269AbTCDFQ1>; Tue, 4 Mar 2003 00:16:27 -0500
Received: from static-ctb-203-29-86-202.webone.com.au ([203.29.86.202]:6672
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id <S268153AbTCDFQY>; Tue, 4 Mar 2003 00:16:24 -0500
Message-ID: <3E64390F.7090309@cyberone.com.au>
Date: Tue, 04 Mar 2003 16:26:39 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.63-mm2 + i/o schedulers with contest
References: <200303041354.03428.kernel@kolivas.org> <3E642932.7070205@cyberone.com.au> <200303041615.17617.kernel@kolivas.org>
In-Reply-To: <200303041615.17617.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>On Tue, 4 Mar 2003 03:18 pm, Nick Piggin wrote:
>
>>small randomish reads vs large writes _is_ where AS really can
>>perform better than non a non AS scheduler. Unfortunately gcc
>>doesn't have the _best_ IO pattern for AS ;)
>>
>
>Yes I recall this discussion against a gcc based benchmark. However it is 
>interesting that it still performed by far the best.
>
Yes, AS obviously does help gcc against io_load. My
"unfortunately" comment was just a pun, of course we
don't want to just test where AS does well.

>>>CFQ and DL scheduler were faster compiling the kernel under read_load,
>>>list_load and dbench_load.
>>>
>>>Mem_load result of AS being slower was just plain weird with the result
>>>rising from 100 to 150 during testing.
>>>
>>I would like to see if AS helps much with a swap/memory
>>thrashing load.
>>
>
>That's what mem_load is. It repeatedly tries to access 110% of available ram.
>quote from original post:
>mem_load:
>Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
>2.5.63              3   104     75.0    57.7    1.9     1.32
>2.5.63-mm2cfq       3   101     76.2    52.3    2.0     1.28
>2.5.63-mm2          3   132     59.1    90.3    2.3     1.65
>2.5.63-mm2dl        3   100     79.0    52.0    2.0     1.27
>
>Note that mm2 with AS performed equivalent to the other schedulers but on 
>later runs took longer. (99, 148,150) This is usually suspicious of a memory 
>leak that contest is unusually sensitive at picking up, but there wasn't 
>anything suspicious about the meminfo after these runs, and none of the other 
>loads changed over time. io_load usually shows drastic prolongation when 
>memory is leaking.
>
Ah ok. And this change didn't affect other schedulers on mm2? Is
it reproducable with AS? I'll have to keep this in mind and take
another look at it after a few othe bugs are fixed.

