Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWAKDtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWAKDtF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 22:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWAKDtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 22:49:05 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:37284 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751166AbWAKDtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 22:49:04 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: -mm seems significanty slower than mainline on kernbench
Date: Wed, 11 Jan 2006 14:49:29 +1100
User-Agent: KMail/1.8.2
Cc: Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <43C45BDC.1050402@google.com> <200601111407.05738.kernel@kolivas.org> <43C47E32.4020001@bigpond.net.au>
In-Reply-To: <43C47E32.4020001@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601111449.29269.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006 02:40 pm, Peter Williams wrote:
> Con Kolivas wrote:
> > I disagree. I think the current implementation changes the balancing
> > according to nice much more effectively than previously where by their
> > very nature, low priority tasks were balanced more frequently and ended
> > up getting their own cpu.
>
> I can't follow the logic here 

cpu bound non interactive tasks have long timeslices. Tasks that have short 
timeslices like interactive ones or cpu bound ones at nice 19 have short 
timeslices. If a nice 0 and nice 19 task are running on the same cpu, the 
nice 19 one is going to be spending most of its time waiting in the runqueue. 
As soon as an idle cpu appears it will only pull a task that is waiting in a 
runqueue... and that is going to be the low priority tasks. 

> Yes, that's true.  I must admit that I wouldn't have expected the
> increased overhead to be very big.  In general, the "system" CPU time in
> a kernbench is only about 1% of the total CPU time and the extra
> overhead should be just a fraction of that.

Doesn't appear to be system time. Extra idle time does suggest poor balancing 
though. Remember the effort I went to to avoid altering the delicate idle 
balancing...

> It's possible that better distribution of niceness across CPU leads to
> more preemption within a run queue (i.e. if there all the same priority
> they won't preempt each other much) leading to more context switches.

Can't see how that is for what you say below.

> But you wouldn't expect that to show up in kernbench as the tasks are
> all the same niceness and usually end up with the same dynamic priority.

The whole of userspace on a kernbench run is going to be nice 0. 

Let's wait till we confirm or deny this patch is responsible before 
postulating further.

Cheers,
Con
