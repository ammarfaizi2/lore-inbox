Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbTHUWQQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 18:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbTHUWQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 18:16:16 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:837 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262463AbTHUWQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 18:16:08 -0400
Message-ID: <3F454532.4030200@sbcglobal.net>
Date: Thu, 21 Aug 2003 17:18:26 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Con Kolivas <kernel@kolivas.org>, Voluspa <lista1@comhem.se>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O17int
References: <5.2.1.1.2.20030821090657.00b45af8@pop.gmx.net> <200308210723.42789.kernel@kolivas.org> <5.2.1.1.2.20030821090657.00b45af8@pop.gmx.net> <5.2.1.1.2.20030821154224.01990b48@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030821154224.01990b48@pop.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Galbraith wrote:

>>  less I throttled that, the less effective the antistarvation was. 
>> However
>> this is clearly a problem without using up full timeslices. I originally
>> thought they weren't trying to schedule lots because of the drop in ctx
>> during starvation but I forgot that rescheduling the same task doesnt 
>> count
>> as a ctx.
>
>
> Hmm.  In what way did it hurt interactivity?  I know that if you pass 
> the cpu off to non-gui task who's going to use his full 100 ms slice, 
> you'll definitely feel it.  (made workaround, will spare delicate 
> tummies;)  If you mean that, say X releases the cpu and has only a 
> couple of ms left on it's slice and is alone in it's queue, that 
> preempting it at the end of it's slice after having only had the cpu 
> for such a short time after wakeup hurts, you can qualify the preempt 
> decision with a cpu possession time check.

I wish I could get mm3 running so I could evaluate those interactivity 
statements.  I can't imagine it being worse than what I'm experiencing now:

9  0  63968  21992  19672 319056    0    0     0    46 1231   289 87 13  
0  0
 5  0  63968  21096  19704 320020    0    0     0    26 1202   300 86 
14  0  0
14  0  63968  21104  19704 320020    0    0     0     0 1578   385 86 
14  0  0
 8  0  63968  20448  20152 320048    0    0     7    41 1189   294 91  
9  0  0
15  0  63968  19552  20132 321052    0    0     6    76 5926  1330 87 
13  0  0
13  0  63968  18992  20132 321664    0    0     0    31 5464  1266 87 
13  0  0
11  0  63968  18676  20100 321976    0    0     0    65 4613  1008 87 
13  0  0
 8  0  63968  18044  20100 322660    0    0     0    14 4643  1132 87 
13  0  0
16  0  63968  17660  20100 323024    0    0     0    20 5273  1272 87 
13  0  0
14  0  63968  12092  20060 328596    0    0     0    24 5110  1221 87 
13  0  0
14  0  63968  11644  20052 329052    0    0     0    68 5264  1285 87 
13  0  0
13  0  63968  11324  19924 329560    0    0     0    34 4473  1125 87 
13  0  0
16  0  63968  10740  19964 329880    0    0     1    74 1494   445 90 
10  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
 r  b   swpd   free  inact active   si   so    bi    bo   in    cs us sy 
id wa
22  0  63968  10452  19968 330300    0    0     1    51 4584  1059 88 
12  0  0
14  0  63968  10004  19940 330736    0    0     0    90 6567  1547 87 
13  0  0
15  0  63968   9188  20048 331472    5    0    10   106 5176  1289 87 
13  0  0
13  0  63968  13932  20016 326824    6    0     6    26 6026  1318 87 
13  0  0
12  0  63968  13412  19984 327324    0    0     0    24 4683  1083 87 
13  0  0
13  1  63968  12700  20012 327956    0    0    16    46 5673  1313 87 
13  0  0
12  0  63968  12252  20084 328296    0    0     6    78 3499   780 88 
12  0  0
18  0  63968  11468  20060 329016    0    0     0    35 5456  1231 87 
13  0  0
13  0  63968  12052  20096 328580    0    0     3    96 4430   988 87 
13  0  0
13  0  63968   5012  19144 336532    0    0     0    62 5672  1225 88 
12  0  0
16  0  63964   6624  17976 336088    0    0     0   297 4808  1041 88 
12  0  0
11  0  63964   5616  17964 337124    0    0     0    69 5219  1094 89 
11  0  0
16  1  63964   6732  15688 338276   13    0    20   155 4984  1156 87 
13  0  0
 4  1  63964   7772  12544 340436   13    0    20    11 1070   201 90 
10  0  0
 3  1  63964   4364  11560 344840    0    0    86   338 1038   250 92  
8  0  0


That would be compiling the kernel, bunzipping a file, and some cron 
mandb thing that was running gzip in the background niced.  Plus X and 
Mozilla, which probably starts the problem.  At the end there, you see 
things calm down.  That's also the way it starts out, then something 
sets off the "priority inversion" and the machine becomes completely 
worthless.  Even the task that are running aren't really accomplishing 
anything.  So the load goes from around 4/5 into the teens and the 
context switching makes a corresponding jump.  And then both 
interactivity AND throughput fall through the floor.

I can't imagine any interactivity regressions that are worse than this 
behavior...

And this happens with just X and Mozilla running.  It happens less often 
without X running, but still happens.  Even if I'm at a VT, it could 
take 5-6 seconds for my text to appear after I type.  This happens all 
the time, about once every few minutes and correlates with a 
simultaneous increase in context switches and load.

>
>>  Also I recall that winegames got much better in O10 when everything was
>> charged at least one jiffy (pre nanosecond timing) suggesting those 
>> that were
>> waking up for minute amounts of time repeatedly were being penalised; 
>> thus
>> taking out the possibility of the starving task staying high priority 
>> for
>> long.
>
>
> (unsure what you mean here) 

Can you set a cutoff point where if the process uses less that X percent 
of the max timeslice, it is penalized?  I don't know if it's possible  
to do a loop of empty spins at some point and time it to find out what 
the cut-off point should be...otherwise I imagine it would need to be 
tuned for every processor speed.  Could you use the bogomips to gauge 
the speed of the machine and use that to determine the min timeslice?  
 From what I understand above, that would perhaps be more selective than 
just penalizing every process and have a positive affect on 
everything...of course I'm open to the possibility that I have it all 
wrong ;-)

Wes


