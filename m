Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWEMJUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWEMJUn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 05:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWEMJUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 05:20:43 -0400
Received: from mail.gmx.de ([213.165.64.20]:54210 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750803AbWEMJUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 05:20:43 -0400
X-Authenticated: #4399952
Date: Sat, 13 May 2006 11:20:39 +0200
From: Florian Paul Schmidt <mista.tapas@gmx.net>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rt20 scheduling latency testcase and failure data
Message-ID: <20060513112039.41536fb5@mango.fruits>
In-Reply-To: <200605121924.53917.dvhltc@us.ibm.com>
References: <200605121924.53917.dvhltc@us.ibm.com>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2006 19:24:53 -0700
Darren Hart <dvhltc@us.ibm.com> wrote:

> The test case emulates a periodic thread that wakes up on time%PERIOD=0, so 
> rather than sleeping the same amount of time each round, it checks now 
> against the start of its next period and sleeps for that length of time.  
> Every so often it will miss it's period, I've captured that data and included 
> a few of the interesting bits below.  The results are from a run with a 
> period of 5ms, although I have seen them with periods as high as 17ms.  The 
> system was under heavy network load for some of the time, but not all.

[snip]

> I'd appreciate any feedback on the test case, and in particular suggestions on 
> how I can go about determining where this lost time is being spent.

There's a multitude of ways how you can misconfigure your -rt system :)
Tell us more about your setup. Hardware? Full preemption? High
resolution timers? Priority setup? From your code i see you run at prio
98. What about the IRQ handlers? And the softirq's, too? Other software?

Flo

P.S.: I ran the test a few [20 or so] times and didn't get any failures
of the sort you see. Even with a 1ms period:

~/downloads$ ./sched_latency_lkml 
-------------------------------
Scheduling Latency
-------------------------------

Running 10000 iterations with a period of 1 ms
Expected running time: 10 s

ITERATION DELAY(US) MAX_DELAY(US) FAILURES
--------- --------- ------------- --------
    10000        32            47        0

Start Latency:  305 us: FAIL
Min Latency:     16 us: PASS
Avg Latency:     29 us: PASS
Max Latency:     47 us: PASS
Failed Iterations: 0

~/downloads$ uname -a
Linux mango.fruits 2.6.16-rt20 #4 PREEMPT Wed May 10 12:53:39 CEST 2006 i686 GNU/Linux

Ooops, i must admit i have the nvidia binary only kernel module loaded,
but i suppose this wouldn't make a difference for the better ;)

I got high resolution timers enabled and left the softirq threads at
their defaults.

-- 
Palimm Palimm!
http://tapas.affenbande.org
