Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWD0BKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWD0BKB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 21:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWD0BKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 21:10:01 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:21508 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751007AbWD0BKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 21:10:00 -0400
Message-ID: <445019E7.80900@vmware.com>
Date: Wed, 26 Apr 2006 18:09:59 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.com>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Jan Beulich <jbeulich@novell.com>,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>
Subject: Re: [PATCH 2/2] I386 convert pae wmb to non smp
References: <200604262203.k3QM3qOC009581@zach-dev.vmware.com> <445009A2.3030305@yahoo.com.au>
In-Reply-To: <445009A2.3030305@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Zachary Amsden wrote:
>
>> Similar to the last bug, on set_pte, we don't want the compiler to 
>> re-order
>> the write of the PTE, even in non-SMP configurations, since if the 
>> write of
>> the low word occurs first, the TLB could prefetch a bad highmem 
>> mapping which
>> has been aliased into low memory.
>>
>
> wmb() means that it also orders IO memory. It is no difference for
> i386, but smp_wmb() actually has the right semantics of the abstract
> Linux memory model.

The name is pretty confused.  smp_wmb seems to imply an SMP-only 
barrier, whereas we want here a write barrier on regular memory.  Both 
smp_wmb and wmb() are identical in that they both reduce to barrier 
today, but I confess not to know which one semantically is correct.  
Your call on this patch - it is unecessary, I thought it was more 
semantically correct, but you probably know that better than me.  So, 
drop part 2 of this patch?

Zach
