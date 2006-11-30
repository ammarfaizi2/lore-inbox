Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933744AbWK3Jyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933744AbWK3Jyx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933676AbWK3Jyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:54:53 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:31184 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S933718AbWK3Jyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:54:52 -0500
Date: Thu, 30 Nov 2006 12:52:33 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Miller <davem@davemloft.net>, wenji@fnal.gov, akpm@osdl.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
Message-ID: <20061130095232.GA8990@2ka.mipt.ru>
References: <20061130061758.GA2003@elte.hu> <20061129.223055.05159325.davem@davemloft.net> <20061130064758.GD2003@elte.hu> <20061129.231258.65649383.davem@davemloft.net> <20061130073504.GA19437@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061130073504.GA19437@elte.hu>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 30 Nov 2006 12:52:34 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 08:35:04AM +0100, Ingo Molnar (mingo@elte.hu) wrote:
> what was observed here were the effects of completely throttling TCP 
> processing for a given socket. I think such throttling can in fact be 
> desirable: there is a /reason/ why the process context was preempted: in 
> that load scenario there was 10 times more processing requested from the 
> CPU than it can possibly service. It's a serious overload situation and 
> it's the scheduler's task to prioritize between workloads!
> 
> normally such kind of "throttling" of the TCP stack for this particular 
> socket does not happen. Note that there's no performance lost: we dont 
> do TCP processing because there are /9 other tasks for this CPU to run/, 
> and the scheduler has a tough choice.
> 
> Now i agree that there are more intelligent ways to throttle and less 
> intelligent ways to throttle, but the notion to allow a given workload 
> 'steal' CPU time from other workloads by allowing it to push its 
> processing into a softirq is i think unfair. (and this issue is 
> partially addressed by my softirq threading patches in -rt :-)

Doesn't the provided solution is just a in-kernel variant of the
SCHED_FIFO set from userspace? Why kernel should be able to mark some
users as having higher priority?
What if workload of the system is targeted to not the maximum TCP
performance, but maximum other-task performance, which will be broken
with provided patch.

> 	Ingo

-- 
	Evgeniy Polyakov
