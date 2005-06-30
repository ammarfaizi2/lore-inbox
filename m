Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbVF3HIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbVF3HIM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 03:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbVF3HIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 03:08:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32164 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262882AbVF3HIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 03:08:06 -0400
Date: Thu, 30 Jun 2005 09:07:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Bill Huey <bhuey@lnxw.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, andrea@suse.de, tglx@linutronix.de,
       karim@opersys.com, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, take 3
Message-ID: <20050630070709.GA26239@elte.hu>
References: <42C320C4.9000302@opersys.com> <20050629225734.GA23793@nietzsche.lynx.com> <20050629235422.GI1299@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629235422.GI1299@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> However, on a UP system, I have to agree with Kristian's choice of 
> configuration.  An embedded system developer running on a UP system 
> would naturally use a UP Linux kernel build, so it makes sense to 
> benchmark a UP kernel on a UP system.

sure.

keeping that in mind, PREEMPT_RT is quite similar to the SMP kernel (it 
in fact activates much of the SMP code), so if you want to isolate the 
overhead coming from the non-locking portions of PREEMPT_RT, you'd 
compare to the SMP kernel. I do that frequently.

another point is that this test is measuring the overhead of PREEMPT_RT, 
without measuring the benefit of the cost: RT-task scheduling latencies.  
We know since the rtirq patch (to which i-pipe is quite similar) that we 
can achieve good irq-service latencies via relatively simple means, but 
that's not what PREEMPT_RT attempts to do. (PREEMPT_RT necessarily has 
to have good irq-response times too, but much of the focus went to the 
other aspects of RT task scheduling.)

were the wakeup latencies of true RT tasks tested, you could see which 
technique does what. But all that is being tested here is pure overhead 
to non-RT tasks, and the worst-case latency of raw interrupt handling.  
While they are important and necessary components of the whole picture, 
they are not the whole picture. This is a test that is pretty much 
guaranteed to show -RT as having higher costs - in fact i'm surprised it 
held up this well :)

so in that sense, this test is like running an SMP kernel on an UP box 
and comparing it against the UP kernel (or running an SMP kernel on an 
SMP box but only running a single task to measure performance), and 
concluding that it has higher costs. It is a technically correct 
conclusion, but obviously misses the whole picture, and totally misses 
the point behind the SMP kernel.

	Ingo
