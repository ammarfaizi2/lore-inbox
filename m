Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUFUVep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUFUVep (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 17:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266482AbUFUVep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 17:34:45 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:10996 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266481AbUFUVem
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 17:34:42 -0400
Message-ID: <40D7542B.3020508@mvista.com>
Date: Mon, 21 Jun 2004 14:33:31 -0700
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: karim@opersys.com
CC: ganzinger@mvista.com, Geoff Levand <geoffrey.levand@am.sony.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Philippe Gerum <rpm@xenomai.org>
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
References: <40C7BE29.9010600@am.sony.com> <40CA4D23.2010006@opersys.com> <40CE1128.8030806@mvista.com> <40D6529F.6060305@opersys.com>
In-Reply-To: <40D6529F.6060305@opersys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> 
> George Anzinger wrote:
> 
>> I don't see how this delivers any added value to the user.  I suppose 
>> code running at the kernel level might gain something, but at the user 
>> level we still have to deal with preemption latencies, which are the 
>> biggest problem (and, aside from messing up the accuracy of the 
>> timers, are NOT timer issues at all).
> 
> 
> Actually I think the point I'm trying to make can't be fairly conveyed
> without providing a lot of background of what can be done with Adeos. I
> would suggest that those interested do some digging. Among other things,
> you may want to read about RTAI/fusion:
> http://www.fdn.fr/~brouchou/rtai/rtai-doc-prj/rtai-fusion.html
> http://www.fdn.fr/~brouchou/rtai/modules.php?name=Content&pa=showpage&pid=1
> 
> Here's a quote from Philippe on how this compares to HRT:
> 
>> Last time I checked (i.e. two days ago on a 2.6.6), hi-res timers were
>> not capable of providing 1Khz periodic timings for 10mn with no overrun
>> through clock_nanosleep(), even with no additional load on the machine.
>> fusion is able to do that directly through a plain nanosleep(); in fact
>> it is able to sustain 10Khz periodic timings with a compilation, disk
>> I/O and interrupt flooding in the background. Frankly, IMHO, determinism
>> with really hi-res timing in user-space is a territory which will remain
>> ruled by RTAI for quite a long time; vanilla Linux will always look
>> miserable at some point in this respect unless, e.g. stuff like that
>> (which is otherwise perfectly sound for a GPOS) disappears from its code
>> base:
>>
>> kernel/softirq.c:
>>
>> /*
>>  * We restart softirq processing MAX_SOFTIRQ_RESTART times,
>>  * and we fall back to softirqd after that.
>>  *
>>  * This number has been established via experimentation.
>>  * The two things to balance is latency against fairness -
>>  * we want to handle softirqs as soon as possible, but they
>>  * should not be able to lock up the box.
>>  */
>> #define MAX_SOFTIRQ_RESTART 10
>>
>> asmlinkage void __do_softirq(void)
>>
>> -- 
>>
>> But, hey! I WANT to be able to lock up this box! :o)
> 
> 
> Unfortunately, there's no sustained vendor push behind this kind of stuff
> as their is for HRT, but my experience has been that this is for lack of
> understanding of what Linux can/should be able to provide as a GPOS then
> anything else (i.e. a lot of "embedded"/"carrier-grade" vendors seem to

I think the real problem is an open source question.  The RTAI and RTLINUX folks 
are not exactly in the same camp (either with each other OR with LINUX) in this 
regard.  Should that change and one or more of these become truly open source 
without others claiming "foul", there are vendors who are ready and willing to 
work with the code.  Vendors of open source (and their customers) don't want to 
find themselves in law suits...

As such, this is really off topic...  as is a discussion of the merits of this 
sort of solution.  On this list we are interested in working in the confines of 
LINUX as found on linux.org possibly modified by truly open source patches and 
packages.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

