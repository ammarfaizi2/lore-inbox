Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUJFEXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUJFEXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 00:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUJFEXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 00:23:46 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:55896 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266914AbUJFEXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 00:23:43 -0400
Message-ID: <41637321.6090001@yahoo.com.au>
Date: Wed, 06 Oct 2004 14:22:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrea Arcangeli <andrea@novell.com>, Robert Love <rml@novell.com>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
References: <4136E4660006E2F7@mail-7.tiscali.it> <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au> <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost> <20041006015515.GA28536@havoc.gtf.org> <41635248.5090903@yahoo.com.au> <20041006020734.GA29383@havoc.gtf.org> <20041006031726.GK26820@dualathlon.random> <4163660A.4010804@pobox.com> <416369F9.7050205@yahoo.com.au> <41636D8B.8020401@pobox.com>
In-Reply-To: <41636D8B.8020401@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Nick Piggin wrote:
> 
>> Jeff Garzik wrote:
>>

>>
>> But even without preempt you'd still have to profile the latency.
> 
> 
> You're making my point for me.  If the bandaid (preempt) is not active, 
> then the system can be accurated profiled.  If preempt is active, then 
> it is potentially hiding trouble spots.

No. It can still be accurately profiled. You could profile theoretical
!preempt latency on a running preempt kernel.

*You* are ignoring my point :) *Nothing* has to be fixed if !preempt
users aren't seeing unacceptable latency. By definition, right?

> 
> The moral of the story is not to use preempt, as it
> * potentially hides long latency code paths
> * potentially introduces bugs, as we've seen with net stack and many 
> other pieces of code

So does CONFIG_SMP. For better or worse, it is in the kernel and
therefore a preempt bug is a bug and not a reason to turn preempt
off.

> * is simply not needed, if all code paths are fixed
> 

Jeff, the entire point of preempt is to not have to put cond_resched
everywhere. So yes, you can fix it by putting in lots of cond_rescheds,
or turning on preempt. What's more, with preempt, those that don't care
about 100us latency don't have to be executing cond_resched 10000 times
per second.

I'd actually say that the code needs fixing if the !PREEMPT case is doing
that much work to try to achieve insanely low latencies.
