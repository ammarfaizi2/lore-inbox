Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbTHWJub (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 05:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTHWJub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 05:50:31 -0400
Received: from dyn-ctb-210-9-245-87.webone.com.au ([210.9.245.87]:19983 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262404AbTHWJuU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 05:50:20 -0400
Message-ID: <3F4738BE.6060007@cyberone.com.au>
Date: Sat, 23 Aug 2003 19:49:50 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH]O18.1int
References: <200308231555.24530.kernel@kolivas.org> <20030823023231.6d0c8af3.akpm@osdl.org>
In-Reply-To: <20030823023231.6d0c8af3.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>We have a problem.   See the this analysis from Steve Pratt.
>
>
>Steven Pratt <slpratt@austin.ibm.com> wrote:
>
>>Mark Peloquin wrote:
>>
>>
>>>Been awhile since results where posted, therefore this is a little long.
>>>
>>>
>>>Nightly Regression Summary for 2.6.0-test3 vs 2.6.0-test3-mm3
>>>
>>>Benchmark         Pass/Fail   Improvements   Regressions       
>>>Results       Results   Summary
>>>---------------   ---------   ------------   -----------   
>>>-----------   -----------   -------
>>>dbench.ext2           P            N              N        2.6.0-test3 
>>>2.6.0-test3-mm3    report
>>>dbench.ext3           P            N              Y        2.6.0-test3 
>>>2.6.0-test3-mm3    report 
>>>
>>The ext3 dbench regression is very significant for multi threaded 193 -> 
>>118.  Looks like this regression first showed up in mm1 and does not 
>>exist in any of the bk trees.
>>
>>http://ltcperf.ncsa.uiuc.edu/data/history-graphs/dbench.ext3.throughput.plot.16.png
>>
>>
>>>volanomark            P            N              Y        2.6.0-test3 
>>>2.6.0-test3-mm3    report
>>>
>>Volanomark is significant as well.  10% drop in mm tree. This one also 
>>appeared to show up in mm1 although it was a 14% drop then so mm3 
>>actually looks a little better.  There were build errors on mm2 run so I 
>>don't have that data at this time.
>>Following link illustrates the drop in mm tree for volanomark.
>>
>>http://ltcperf.ncsa.uiuc.edu/data/history-graphs/volanomark.throughput.plot.1.png
>>
>>
>>SpecJBB2000 for high warehouses also took a bit hit.  Probably the same 
>>root cause as volanomark.
>>Here is the history plot for the 19 warehouse run.
>>
>>http://ltcperf.ncsa.uiuc.edu/data/history-graphs/specjbb.results.avg.plot.19.png
>>
>>Huge spike in idle time.
>>http://ltcperf.ncsa.uiuc.edu/data/history-graphs/specjbb.utilization.idle.avg.plot.19.png
>>
>>
>>>http://ltcperf.ncsa.uiuc.edu/data/2.6.0-test3-mm3/2.6.0-test3-vs-2.6.0-test3-mm3/ 
>>>
>>>
>
>Those graphs are woeful.
>

Aren't they.

>
>Steve has done some preliminary testing which indicates that the volanomark
>and specjbb regressions are due to the CPU scheduler changes.
>
>I have verifed that the ext3 regression is mostly due to setting
>PF_SYNCWRITE on kjournald.  I/O scheduler stuff.  I don't know why, but
>that patch obviously bites the dust.  There is still a 10-15% regression on
>dbench 16 on my 4x Xeon which is due to the CPU scheduler patches.
>

Thats fine. I never measured any improvement with it. Its sad that
that it didn't go as I hoped, but that probably tells you I don't
know enough about how journalling works.

>
>It's good that the reaim regression mostly went away, but it would be nice
>to know why.  When I was looking into the reaim problem it appeared that
>setting TIMESLICE_GRANULARITY to MAX_TIMESLICE made no difference, but more
>careful testing is needed on this.
>
>There really is no point in proceeding with this fine tuning activity when
>we have these large and not understood regressions floating about.
>

I think changes in the CPU scheduler cause butterflies to flap their
wings or what have you. Good luck pinning it down.

>
>I suggest that what we need to do is to await some more complete testing of
>the CPU scheduler patch alone from Steve and co.  If it is fully confirmed
>that the CPU scheduler changes are the culprit we need to either fix it or
>go back to square one and start again with more careful testing and a less
>ambitious set of changes.
>
>It could be that we're looking at some sort of tradeoff here, and we're
>already too far over to one side.  I don't know.
>
>It might help if you or a buddy could get set up with volanomark on an OSDL
>4-or-8-way so that you can more closely track the effect of your changes on
>such benchmarks.
>

I think you'd be wasting your time until the interactivity side of
things is working better. Unless Con has a smaller set of undisputed
improvements to test with.


