Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUAHPNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUAHPNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:13:49 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:27353 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265119AbUAHPMf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:12:35 -0500
Message-ID: <3FFD7340.7050209@cyberone.com.au>
Date: Fri, 09 Jan 2004 02:12:00 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [patch] RCU for low latency [1/2]
References: <20040108114851.GA5128@in.ibm.com> <20040108114958.GB5128@in.ibm.com>
In-Reply-To: <20040108114958.GB5128@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dipankar Sarma wrote:

>Provide a rq_has_rt_task() interface to detect runqueues with
>real time priority tasks. Useful for RCU optimizations.
>

Can you make rq_has_rt_task the slow path? Adding things like this
can actually be noticable on microbenchmarks (eg. pipe based ctx
switching). Its probably cache artifacts that I see, but it wouldn't
hurt to keep the scheduler as tight as possible.

I think this should cover it.

int rq_has_rt_task(int cpu)
{
	runqueue_t *rq = cpu_rq(cpu);
	return (sched_find_first_bit(rq->active) < MAX_RT_PRIO);
}

Any good?



