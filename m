Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263042AbUJ1NGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263042AbUJ1NGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 09:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbUJ1NGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 09:06:45 -0400
Received: from mail.timesys.com ([65.117.135.102]:10342 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S263051AbUJ1NFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 09:05:33 -0400
Message-ID: <4180EE56.4030100@timesys.com>
Date: Thu, 28 Oct 2004 09:04:22 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: karim@opersys.com
CC: Andrew Morton <akpm@osdl.org>, paulmck@us.ibm.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, rpm@xenomai.org,
       john cooper <john.cooper@timesys.com>
Subject: Re: [RFC][PATCH] Restricted hard realtime
References: <20041023194721.GB1268@us.ibm.com>	<417F12F1.5010804@opersys.com> <20041026212956.4729ce98.akpm@osdl.org> <4180DDFA.1050409@opersys.com>
In-Reply-To: <4180DDFA.1050409@opersys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2004 13:00:08.0406 (UTC) FILETIME=[0D44AF60:01C4BCEE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Usually one of the litmus tests for this is to hook a function
> generator to the system and inject a square wave through an
> interrupt-generating I/O (ex.: parallel port), while measuring the
> response time of an interrupt service routine and comparing it to
> the input wave using an oscilloscope. One sign that the system is
> indeed deterministic is that both square waves should appear
> steady regardless of the load.

Ideally yes, but there will still be some phase modulation
due to the natural randomness of interrupt masking for hard
irqs and from scheduling preemption latency for irqs run in
task context.  Also contributing to this will be latency
due to interrupt hardware which may not be constant.

One likely observation will be increased contention
from periodic interrupt sources (clock) with the injected
square wave interrupt when these frequencies (or their
harmonics) approach each other.   The contention would
appear periodic at the difference of these interrupt
frequencies.

Other sources of phase bobble will include variable
CPU cache content, loading of the bus from other DMA
masters, SMP bus contention, etc.. which are much more
difficult to address.

-john


-- 
john.cooper@timesys.com
