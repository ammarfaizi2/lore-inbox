Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbUFVKVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUFVKVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 06:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUFVKVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 06:21:10 -0400
Received: from zero.aec.at ([193.170.194.10]:51462 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261981AbUFVKVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 06:21:06 -0400
To: Andrew Morton <akpm@osdl.org>
cc: mikpe@csd.uu.se, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
References: <223si-461-9@gated-at.bofh.it> <29Piu-4H4-27@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 22 Jun 2004 12:21:01 +0200
In-Reply-To: <29Piu-4H4-27@gated-at.bofh.it> (Andrew Morton's message of
 "Tue, 22 Jun 2004 11:00:14 +0200")
Message-ID: <m3pt7revw2.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[few points I just noticed]

Andrew Morton <akpm@osdl.org> writes:
>
> - a general overview of how the whole thing operates (what's
>   PERFCTR_INTERRUPT_SUPPORT do?  What interrupts are generated?  Describe

The hardware can usually generate an interrupt when the performance counter
under or overflows. oprofile uses this too.


>   the backpatching design, etc).  What is "forbidden" on p4 siblings, and

p4 siblings share only a single set of performance counters, so you must
keep them synchronized.

>
> - <canofworms>cannot cpus_copy_to_user() share code with
>   sys_sched_getaffinity()?</canofworms>

The sched_getaffinity code for that is broken, I'm about to submit
a patch for it.  I haven't looked at that one.

>
> - Is there much point in making CONFIG_PERFCTR_VIRTUAL optional?

It slows down an important fast path (context switch) 
But it would be better to use some back patching design like kernel hooks
to keep the cost for the common case (no perfctr getting switched) 
low.  If that common case can be kept at a "no checks at all" level
then it's good. That would be best for distribution kernels too.

-Andi

