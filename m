Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268856AbUJPUk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268856AbUJPUk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 16:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268864AbUJPUk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 16:40:57 -0400
Received: from mail.timesys.com ([65.117.135.102]:23594 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S268856AbUJPUkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 16:40:53 -0400
Message-ID: <4171871D.3000601@timesys.com>
Date: Sat, 16 Oct 2004 16:39:57 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, john cooper <john.cooper@timesys.com>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <Pine.LNX.4.58.0410161426020.1223@gradall.private.brainfood.com> <20041016193626.GB10626@elte.hu> <Pine.LNX.4.58.0410161457410.1223@gradall.private.brainfood.com> <20041016201417.GA12371@elte.hu>
In-Reply-To: <20041016201417.GA12371@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2004 20:36:04.0406 (UTC) FILETIME=[C1C20560:01C4B3BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,
    In reading your -U3 patch the test below (#156)
wasn't clear to me.   It would seem in the case of
softirq_preemption, __do_softirq() should be called
to kick ksoftirqd, otherwise ___do_softirq() would
be called to exec softirqs in the immediate context.

kernel/softirq.c:

  153   asmlinkage void _do_softirq(void)
  154   {
  155           local_irq_disable();
  156           if (!softirq_preemption)
  157                   __do_softirq();
  158           else
  159                   ___do_softirq();
  160           local_irq_enable();
  161   }

-john

-- 
john.cooper@timesys.com

