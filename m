Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266691AbUG0W5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266691AbUG0W5A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 18:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUG0W5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 18:57:00 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:1706 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266691AbUG0W4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 18:56:50 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20040727162759.GA32548@elte.hu>
References: <40F3F0A0.9080100@vision.ee>
	 <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu>  <20040727162759.GA32548@elte.hu>
Content-Type: text/plain
Message-Id: <1090969026.743.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Jul 2004 18:57:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-27 at 12:27, Ingo Molnar wrote:
> i've uploaded -L2:
>  
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-L2
> 
> the hardirq-redirection feature is activated via voluntary-preemption=3
> (default). All irqs except the timer irq are redirected. (the timer irq
> needs to run from irq context - but it has constant latency and constant
> frequency so it's not an issue. Soft timers are executed from the timer
> softirq which is redirected and hence preemptable.)
> 
> this means that with this patch applied the 2.6 UP kernel is quite close
> to being hard-RT capable (using controlled drivers and workloads). All
> unbound-latency asynchronous workloads have been unloaded into
> synchronous, schedulable process contexts - so nothing can delay a
> high-prio RT task. (assuming we caught all the latencies. Any remaining
> latency can be fixed with the existing methods.)
> 
> i've done a softirq lock-break in the atkbd and ps2mouse drivers - this
> should fix the big latencies triggered by NumLock/CapsLock, reported by
> Lee Revell.
> 

The Caps Lock problem goes away with voluntary-preempt=2.  It makes
sense that 3 would be problematic, as for audio work you don't want the
soundcard interrupt redirected.

The obvious next feature to add would be to make certain IRQs
non-schedulable, like you would for an RT system.  For an audio system
this would be just the soundcard interrupt (and timer as stated above). 
Then, while it still might not be hard-RT, it would blow away anything
achievable on the other OS'es people do audio work with.

Lee

