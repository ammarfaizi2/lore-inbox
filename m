Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267581AbUG3Cb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267581AbUG3Cb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 22:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267582AbUG3Cb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 22:31:29 -0400
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:42425 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S267581AbUG3CbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 22:31:09 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-J3
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com, wli@holomorphy.com,
       lenar@vision.ee, linux-kernel@vger.kernel.org
In-Reply-To: <20040726203634.GA26096@elte.hu>
References: <20040713122805.GZ21066@holomorphy.com>
	 <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com>
	 <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe>
	 <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe>
	 <20040726083537.GA24948@elte.hu> <20040726125750.5e467cfd.akpm@osdl.org>
	 <20040726203634.GA26096@elte.hu>
Content-Type: text/plain
Message-Id: <1091154667.12149.15.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Jul 2004 22:31:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-26 at 16:36, Ingo Molnar wrote:
> one alternative technique to yours would be to notify _all_ CPUs that a
> high-prio RT task is ready to run (via a broadcast need-resched). That
> way the UP latency-break techniques map to SMP in a 1:1 way.
> 
> non-RT tasks dont get this benefit, which is a difference to the UP
> situation, but i dont think it would be appropriate to use the UP
> behavior, due to the overhead of broadcasting.
> 
> a combination of the two techniques could be used too: a global 'break
> locks from now on' flag which gets set if a (RT?) task wants to
> reschedule. Normally this flag would be zero and the cacheline would be
> clean and shared between all CPUs, causing no overhead. Once a task

It might be possible to eliminate the need_resched flag.  Here is an
article that talk about a event-driven preemption model.

Quoting :

Over the long term, MontaVista is investigating whether preemption locks
can be eliminated (or at least greatly reduced in number) by protecting
all the short-duration critical regions with spinlocks that also disable
interrupts on the local CPU, and the long-duration critical regions with
mutex locks. ("Long duration" means much greater than the time taken by
two context switches.) This will reduce the overhead of the preemptable
kernel, since there will no longer be any need to test for preemption
("polling for preemption") at the end of a preemption-locked region
(which could happen tens of thousands of times per second on an average
system). Instead, preemption would happen automatically as part of the
interrupt servicing that causes a higher-priority process to become
runnable ("event-driven preemption"). Typically, this only happens a few
times to a few tens of times per second with an average system workload,
making the "event-driven preemption" model much more efficient than the
"polling for preemption" model. This method also has an added efficiency
in that the system will take advantage of the cache disruption caused by
the interrupt (which is unavoidable) to continue with the preemption.

Reference:

http://www.linuxdevices.com/cgi-bin/printerfriendly.cgi?id=AT4185744181


Best regards,

Eric St-Laurent


