Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTLHXap (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 18:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTLHXap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 18:30:45 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:27317 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261872AbTLHXan
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 18:30:43 -0500
Message-ID: <3FD50698.6090108@cyberone.com.au>
Date: Tue, 09 Dec 2003 10:17:44 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@redhat.com>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] make cpu_sibling_map a cpumask_t
References: <3FD3FD52.7020001@cyberone.com.au> <Pine.LNX.4.58.0312080109010.1758@montezuma.fsmlabs.com> <Pine.LNX.4.58.0312081553340.31173@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.58.0312081553340.31173@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:

>On Mon, 8 Dec 2003, Zwane Mwaikambo wrote:
>
>
>>>P.S.
>>>I have an alternative to Ingo's HT scheduler which basically does
>>>the same thing. It is showing a 20% elapsed time improvement with a
>>>make -j3 on a 2xP4 Xeon (4 logical CPUs).
>>>
>>-j3 is an odd number, what does -j4, -j8, -j16 look like?
>>
>
>let me guess: -j3 is the one that gives the highest performance boost on a 
>2-way/4-logical P4 box?
>
Yep! Note: -j3 now gives you 2 compute "threads" in the build. Basically
(as you know Ingo), you'll see the best improvement when there is the
most opportunity for one physical CPU to be saturated and the other idle.

[piggin@ragnarok piggin]$ grep user compile-test11
319.56user 30.04system 2:53.61elapsed 201%CPU
320.50user 30.33system 2:54.04elapsed 201%CPU
318.44user 30.94system 2:53.44elapsed 201%CPU
[piggin@ragnarok piggin]$ grep user compile-w26p20
268.04user 27.48system 2:26.94elapsed 201%CPU
267.36user 27.69system 2:26.10elapsed 201%CPU
266.66user 27.63system 2:25.68elapsed 202%CPU

Note here that both sets of results saturate 2 CPUs. My changes (and
Ingo's too, of course) try to ensure that those 2 CPUs are different
physical ones which is why they are getting more work done.

>
>for the SMT/HT scheduler to give any benefits there has to be idle time -
>so that SMT decisions actually make a difference.
>
>the higher -j values are only useful to make sure that SMT scheduling does
>not introduce regressions - performance should be the same as the pure
>SMP/NUMA scheduler's performance.
>

I haven't run your HT patch Ingo, but of course I'll have to get more
comprehensive benchmarks before we go anywhere with this.


