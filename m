Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbTBABOL>; Fri, 31 Jan 2003 20:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264654AbTBABOL>; Fri, 31 Jan 2003 20:14:11 -0500
Received: from dial-ctb0572.webone.com.au ([210.9.245.72]:41988 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S264646AbTBABOI>;
	Fri, 31 Jan 2003 20:14:08 -0500
Message-ID: <3E3B2187.1000203@cyberone.com.au>
Date: Sat, 01 Feb 2003 12:23:19 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Aggelos Economopoulos <aoiko@cc.ece.ntua.gr>
Subject: Re: [BENCHMARK] 2.5.59-mm7 with contest
References: <200302010930.54538.conman@kolivas.net> <200302011144.54554.conman@kolivas.net> <3E3B1B1E.7050800@cyberone.com.au> <200302011209.49692.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>On Saturday 01 Feb 2003 11:55 am, Nick Piggin wrote:
>
>>Con Kolivas wrote:
>>
>>>On Saturday 01 Feb 2003 11:37 am, Nick Piggin wrote:
>>>
>>>>Con Kolivas wrote:
>>>>
>>>>>Seems the fix for "reads starves everything" works. Affected the tar
>>>>>loads too?
>>>>>
>>>>Yes, at the cost of throughput, however for now it is probably
>>>>the best way to go. Hopefully anticipatory scheduling will provide
>>>>as good or better kernel compile times and better throughput.
>>>>
>>>>Con, tell me, are "Loads" normalised to the time they run for?
>>>>Is it possible to get a finer grain result for the load tests?
>>>>
>>>No, the load is the absolute number of times the load successfully
>>>completed. We battled with the code for a while to see if there were ways
>>>to get more accurate load numbers but if you write a 256Mb file you can
>>>only tell if it completes the write or not; not how much has been written
>>>when you stop the write. Same goes with read etc. The load rate is a more
>>>meaningful number but we haven't gotten around to implementing that in
>>>the result presentation.
>>>
>>I don't know how the contest code works, but if you split that into
>>a number of smaller writes it should work?
>>
>
>Yes it would but the load effect is significantly diminished. By writing a 
>file the size==physical ram the load effect is substantial.
>
Oh yes of course, but I meant just break up the writing of that big file
into smaller write(2)s.

>
>
>>>Load rate would be:
>>>
>>>loads / ( load_compile_time - no_load_compile_time )
>>>
>>I think loads / time_load_ran_for should be ok (ie, give you loads per time
>>interval). This would be more useful if your loads were getting more
>>efficient
>>or less because it is possible that an improvement would lower compile time
>>_and_ loads, but overall the loads were getting done quicker.
>>
>
>I found the following is how loads occur almost always:
>noload time: 60
>load time kernal a: 80, loads 20
>load time kernel b: 100, loads 40
>load time kernel c: 90, loads 30
>
>and loads/total time wouldnt show this effect as kernel c would appear to have 
>a better load rate 
>
Kernel a would have a rate of .25 l/s, b: .4 l/s, c: .33~ l/s so I b would
be better.

>
>
>if there was
>load time kernel d: 80, loads 40
>
>that would be more significant no?
>
It would, yes... but it would measure .5 loads per second done.

The noload time is basically constant anyway so I don't think it would add
much value if it were incorporated into the results, but would make the
metric harder to follow than simple "loads per second".

