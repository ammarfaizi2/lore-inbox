Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271682AbTGRLXq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 07:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271695AbTGRLXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 07:23:46 -0400
Received: from dyn-ctb-203-221-74-239.webone.com.au ([203.221.74.239]:37906
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S271682AbTGRLXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 07:23:42 -0400
Message-ID: <3F17DC22.2070605@cyberone.com.au>
Date: Fri, 18 Jul 2003 21:38:10 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Wiktor Wodecki <wodecki@gmx.de>
CC: Con Kolivas <kernel@kolivas.org>, Mike Galbraith <efault@gmx.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] O6int for interactivity
References: <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net> <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net> <20030718103105.GE622@gmx.de> <200307182043.06029.kernel@kolivas.org> <20030718113436.GA627@gmx.de>
In-Reply-To: <20030718113436.GA627@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Wiktor Wodecki wrote:

>On Fri, Jul 18, 2003 at 08:43:05PM +1000, Con Kolivas wrote:
>
>>On Fri, 18 Jul 2003 20:31, Wiktor Wodecki wrote:
>>
>>>On Fri, Jul 18, 2003 at 12:18:33PM +0200, Mike Galbraith wrote:
>>>
>>>>That _might_ (add salt) be priorities of kernel threads dropping too low.
>>>>
>>>>I'm also seeing occasional total stalls under heavy I/O in the order of
>>>>10-12 seconds (even the disk stops).  I have no idea if that's something
>>>>in mm or the scheduler changes though, as I've yet to do any isolation
>>>>and/or tinkering.  All I know at this point is that I haven't seen it in
>>>>stock yet.
>>>>
>>>I've seen this too while doing a huge nfs transfer from a 2.6 machine to
>>>a 2.4 machine (sparc32). Thought it'd be something with the nfs changes
>>>which were recently, might be the scheduler, tho. Ah, and it is fully
>>>reproducable.
>>>
>>Well I didn't want to post this yet because I'm not sure if it's a good 
>>workaround yet but it looks like a reasonable compromise, and since you have a 
>>testcase it will be interesting to see if it addresses it. It's possible that 
>>a task is being requeued every millisecond, and this is a little smarter. It 
>>allows cpu hogs to run for 100ms before being round robinned, but shorter for 
>>interactive tasks. Can you try this O7 which applies on top of O6.1 please:
>>
>>available here:
>>http://kernel.kolivas.org/2.5
>>
>
>sorry, the problem still persists. Aborting the cp takes less time, tho
>(about 10 seconds now, before it was about 30 secs). I'm aborting during
>a big file, FYI.
>

OK if the IO actually stops then it shouldn't be an IO scheduler or
request allocation problem, but could you try to capture a sysrq T
trace for me during the freeze.

