Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbTIGG7x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 02:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbTIGG7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 02:59:53 -0400
Received: from static-ctb-210-9-247-166.webone.com.au ([210.9.247.166]:54278
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262325AbTIGG7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 02:59:51 -0400
Message-ID: <3F5AD75A.6080703@cyberone.com.au>
Date: Sun, 07 Sep 2003 16:59:38 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rml@tech9.net, jyau_kernel_dev@hotmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <000101c374a3$2d2f9450$f40a0a0a@Aria>	<1062878664.3754.12.camel@boobies.awol.org>	<3F5ABD3A.7060709@cyberone.com.au>	<20030906231856.6282cd44.akpm@osdl.org>	<3F5AD03E.5070506@cyberone.com.au> <20030906234545.46c990d6.akpm@osdl.org>
In-Reply-To: <20030906234545.46c990d6.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>>My concern is the (large) performance regression with specjbb and
>>>
>> >volanomark, due to increased idle time.
>> >
>> >We cannot just jam all this code into Linus's tree while crossing our
>> >fingers and hoping that something will turn up to fix this problem. 
>> >Because we don't know what causes it, nor whether we even _can_ fix it.
>> >
>> >So this is the problem which everyone who is working on the CPU scheduler
>> >should be concentrating on, please.
>> >
>>
>> IIRC my (equivalent to Andrew's CAN_MIGRATE) patch fixed this. There was 
>> still a small (~8%?) performance regression, but idle times were on par 
>> with -linus. I don't have easy access to a largeish NUMA box, so I
>> can't do much more.
>>
>>
>
>That is not clear at this time.  We do know that the reaim regression was
>introduced by sched-2.6.0-test2-mm2-A3, but we don't know why.  Certainly
>that patch did not introduce the problem which Andrew's patch fixed.  And
>we have theorised that Andrew's patch brought back the reaim throughput. 
>And we have extrapolated those observations to possible improvements in
>volanomark throughput.
>

Earlier we _saw_ my patch do what it was supposed to:
http://members.optusnet.com.au/ckolivas/kernel/2.5/volano/
Idle time is back to mainline levels although throughput is still down
a bit. (I'd say thats due to overbalancing which could be tuned back,
I'm going to attack the SMP and NUMA stuff in the scheduler soon).

>
>
>It's all foggy and I'd like to see a clean rerun of specjbb and volanomark
>by Mark Peloquin and co, confirming that -mm6 is performing OK.
>
>
>Also, I'm concerned that sched-2.6.0-test2-mm2-A3 caused slowdowns and
>Andrew's patch caused speedups and they just cancelled out.  Let's get
>Andrew's patch into Linus's tree and see if it speeds things up.  If it
>does, we probably still have a problem.
>
>

The slowdowns are due to CPUs becoming idle too long, and the patches
fix that. If CPUs aren't idle, the patch will have no effect.

I have no idea how volanomark really works, so I have no idea why the
patch causes queue imbalances. Thats the problem with those jumbo
patches :P


