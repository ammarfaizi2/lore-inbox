Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVFLEKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVFLEKr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 00:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVFLEKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 00:10:47 -0400
Received: from opersys.com ([64.40.108.71]:35080 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261869AbVFLEKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 00:10:36 -0400
Message-ID: <42ABB839.7030207@opersys.com>
Date: Sun, 12 Jun 2005 00:21:13 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
References: <42AA6A6B.5040907@opersys.com> <20050611192722.GB24152@elte.hu>
In-Reply-To: <20050611192722.GB24152@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> hackbench:
> 
>   http://developer.osdl.org/craiger/hackbench/
>   http://developer.osdl.org/craiger/hackbench/src/hackbench.c
[snip]
> this is good at triggering worst-case latencies too. Plus dbench is good 
> too:
> 
>   http://samba.org/ftp/tridge/dbench/
>   http://samba.org/ftp/tridge/dbench/dbench-3.03.tar.gz

hackbench and dbench are fine by me, they seem good tests to run.

However ...

> also, there's a very good on-host IRQ-latency measurement tool as well:
> 
>    http://www.affenbande.org/~tapas/wiki/index.php?rtc_wakeup

This tool I just can't trust. Any software tool that measures the
interrupt latency of the system on which it runs is highly suspect.
There are far too many things happening on the system itself for
the tool to act as an "independent" observer. The only true way to
measure interrupt latency is to have some outside system generate
the interrupts and measure the target system's response time.

In our early tests, we actually had an oscilloscope hooked onto
the target and we had a function generator ready to go for pumping
square waves into the target. However, after spending quite some
time looking at the output on the scope, we concluded that there
was just no way for us to measure the peaks (at least with the
scope we had access to; there are very fancy scopes out there
that can probably do a better job by collecting entire samples,
but we don't have those at hand and so too will it be very likely
that others who want to make such measurements may not have
access to such scopes.) Hence the use of the logger to trigger
and measure interrupts. The logger, target and host setup we
put together can very well be implemented using even antiquated
PCs, something any computer enthusiast can easily obtain very
cheaply at any used computer parts store in their neighborhood.

<background>
A truly hard-rt deterministic system should be very easily
viewed using a function generator and a scope. You pump the
square wave, and the measured system generates a delayed
wave. The interrupt latency is the distance between the two.
You would then be able to increase the square wave's frequency
and see the target system follow, up until it couldn't respond
no more and then by turning the knob down back again, you would
find the nice response square waves again. On modern PCs, even
the hardware isn't deterministic, so you can't see such nice
waves. Instead, you need to collect samples and determine
maximums.
</background>

So hackbench and dbench yes, but rtc_wakeup ... hmm ...

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
