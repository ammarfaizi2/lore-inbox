Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTJBCq1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 22:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbTJBCq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 22:46:27 -0400
Received: from dyn-ctb-203-221-73-10.webone.com.au ([203.221.73.10]:16132 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263212AbTJBCqY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 22:46:24 -0400
Message-ID: <3F7B915C.9050301@cyberone.com.au>
Date: Thu, 02 Oct 2003 12:45:48 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test6
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <3F77BB2C.7030402@cyberone.com.au> <bl9ul0$348$1@gatekeeper.tmr.com> <3F78D866.5070605@cyberone.com.au> <blfg2i$j43$1@gatekeeper.tmr.com>
In-Reply-To: <blfg2i$j43$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



bill davidsen wrote:

>In article <3F78D866.5070605@cyberone.com.au>,
>Nick Piggin  <piggin@cyberone.com.au> wrote:
>| 
>| 
>| bill davidsen wrote:
>| 
>| >In article <3F77BB2C.7030402@cyberone.com.au>,
>| >Nick Piggin  <piggin@cyberone.com.au> wrote:
>| >
>| >| AFAIK, Con's scheduler doesn't change the nice implementation at all.
>| >| Possibly some of his changes amplify its problems, or, more likely they
>| >| remove most other scheduler problems leaving this one noticable.
>| >| 
>| >| If X is running at -20, and xmms at +19, xmms is supposed to still get
>| >| 5% of the CPU. Should be enough to run fine. Unfortunately this is
>| >| achieved by giving X very large timeslices, so xmms's scheduling latency
>| >| becomes large. The interactivity bonuses don't help, either.
>| >
>| >Clearly the "some is good, more is better" approach doesn't provide
>| >stable balance between sound and cpu hogs. It isn't a question of "how
>| >much" cpu, just "when"which works or not.
>| >
>| >This is sort of like the deadline scheduler in that it trades of
>| >throughput for avoiding jackpot cases. I think that's desired behaviour
>| >in a CPU schedular too, at least if used by humans.
>| >
>| 
>| I'm not sure what you mean. There is nothing good to say about Ingo's
>| nice mechanism though (sorry Ingo, its otherwise a very nice
>| scheduler!).
>
>Oh, I think the test5-mm4 behaviour is far better than yours in terms of
>throughput. I would expect that it could have several percent less
>system time, leaving it for cpu-bound user processes. However, on my
>little test machine (PII-350 w/ 96MB) running patch to get a kernel
>source tree ready makes the system damn near unusable. With your v15
>patch neither patch nor a kernel build is a real problem (I don't use
>-j, there's only one processor and it doesn't help). I can happily read
>mail, run windows to remote machines to do admin, check web based
>monitors, and generally use the system. It's not a ball of fire, but
>it's old and slow moving, and I can identify with that ;-)
>
>| In my scheduler, nice -20 processes get small timeslices so scheduling
>| latency stays low or even gets lower, while nice +19 ones get large
>| timeslices for lower context switches and better cache efficiency. As
>| you would like.
>
>Clearly your timeslices don't get so large the system suffers. And I can
>run setiathome with a little nice, like -5, and it will get some time
>without slowing the important stuff on the system. Even at -19 it does
>keep going. On a small memory machine I hate to give pages to a process
>without giving it the CPU to justify the memory.
>
>I'm going to try test5-n15 against test5-mm4 and test6-std with a server
>load, but for now I run your patch on machines I use as personal
>workstations. I haven't tried it SMP, that day will come.
>

Oh ok, yeah. It does look like it might need some work to prevent
timeslices from getting too small. I'm going to start working on this
soon.


