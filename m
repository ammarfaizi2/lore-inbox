Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVILJAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVILJAk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVILJAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:00:40 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:3495 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751253AbVILJAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:00:40 -0400
Date: Mon, 12 Sep 2005 11:01:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "linux-kernel @ vger. kernel. org" <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: possible bug in RP kernel
Message-ID: <20050912090115.GA5731@elte.hu>
References: <20050912105010.701a822f@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912105010.701a822f@mango.fruits.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> Problem is: i wrote a small test program running at prio 80 that 
> simply busy loops for about 15 seconds. It seems from the log output 
> that the main thread never wakes up during the time of the test 
> program running.
> 
> Sep 12 10:36:07 mango rt_watchdog: count 5
> Sep 12 10:36:30 mango rt_watchdog: count 6
>              ^^
> 23 seconds gap between two wakeups
> 
> Maybe my understanding of how sched fifo works is wrong, but i assumed 
> a higher prio thread shold get woken up from a sleep by the scheduler 
> which gets run by the timer interrupt [which is still non 
> preemptible].

depending on what type of timeout you are using you'll also need to chrt 
the softirq-timer kernel thread(s) to prio 99. Otherwise the timer fn 
will have no chance to be executed. There's work going on by Thomas to 
make such things automatic, by prioritizing timers. If you have HRT 
enabled in the .config then it should mostly be automatic already 
though.

	Ingo
