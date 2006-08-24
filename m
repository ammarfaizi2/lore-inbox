Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751609AbWHXPxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbWHXPxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWHXPxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:53:45 -0400
Received: from dvhart.com ([64.146.134.43]:28367 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S965008AbWHXPxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:53:44 -0400
Message-ID: <44EDCB83.2010806@mbligh.org>
Date: Thu, 24 Aug 2006 08:53:39 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Edward Falk <efalk@google.com>,
       linux-kernel@vger.kernel.org, Michael Davidson <md@google.com>
Subject: Re: [PATCH] Fix x86_64 _spin_lock_irqsave()
References: <44ED157D.6050607@google.com>	<44ED1891.6090708@yahoo.com.au> <20060823214831.aa687ebe.akpm@osdl.org>
In-Reply-To: <20060823214831.aa687ebe.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 24 Aug 2006 13:10:09 +1000
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Edward Falk wrote:
>>
>>>Add spin_lock_string_flags and _raw_spin_lock_flags() to 
>>>asm-x86_64/spinlock.h so that _spin_lock_irqsave() has the same 
>>>semantics on x86_64 as it does on i386 and does *not* have interrupts 
>>>disabled while it is waiting for the lock.
>>>
>>>This fix is courtesy of Michael Davidson
>>
>>So, what's the bug? You shouldn't rely on these semantics anyway
>>because you should never expect to wait for a spinlock for so long
>>(and it may be the case that irqs can't be enabled anyway).
>>
>>BTW. you should be cc'ing Andi Kleen (x86+/-64 maintainer) on
>>this type of stuff.
>>
>>No comments on the merits of adding this feature. I suppose parity
>>with i386 is a good thing, though.
>>
> 
> 
> We put this into x86 ages ago and Andi ducked the x86_64 patch at the time.
> 
> I don't recall any reports about the x86 patch (Zwane?) improving or
> worsening anything.  I guess there are some theoretical interrupt latency
> benefits.

Spinlocks are indeed meant to be held for a short time, but irq
disabling is meant to be shorter.

I think the real question is: what is the justification for disabling
interrupts when spinning for a lock? We should never disable interrupts
unless we have to.

M.
