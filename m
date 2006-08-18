Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWHRLqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWHRLqL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWHRLqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:46:10 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:46861 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1030282AbWHRLqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:46:08 -0400
Message-ID: <44E5A7F3.8080707@shadowen.org>
Date: Fri, 18 Aug 2006 12:43:47 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: "Abu M. Muttalib" <abum@aftek.com>
CC: Arjan van de Ven <arjan@infradead.org>, kernelnewbies@nl.linux.org,
       linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Relation between free() and remove_vm_struct()
References: <BKEKJNIHLJDCFGDBOHGMEEFBDGAA.abum@aftek.com>
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMEEFBDGAA.abum@aftek.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abu M. Muttalib wrote:
> Hi,
> 
>>>> second of all, glibc delays freeing of some memory (in the brk() area)
>>>> to optimize for cases of frequent malloc/free operations, so that it
>>>> doesn't have to go to the kernel all the time (and a free would imply
> a
>>>> cross cpu TLB invalidate which is *expensive*, so batching those up is
> a
>>>> really good thing for performance)
>>> As per my observation, in two scenarios that I have tried, in one
> scenario I
>>> am able to see the prints from remove_vm_struct(), but in the other
>>> scenario, I don't see any prints from remove_vm_strcut().
>>>
>>> My question is, if there is delayed freeing of virtual address space, it
>>> should be the same in both the scenarios, but its not the case, and this
>>> behavior is consistent for my two scenarios, i.e.. in one I am able to
> see
>>> the kernel prints and in other I am not, respectively.
>> I'm sorry but you're not providing enough information for me to
>> understand your follow-on question.
> 
> Well, the application, which is causing problem is specific to our
> organization and details may not be known to the list. Any ways I am
> detailing it further,
> 
> Our application is a VoIP application, which uses OSIP stack.
> 
> While running the application, when I give outgoing call, I see the VM
> getting allocated and subsequently getting freed, this I have verified from
> /proc/meminfo and kernel prints (that of remove_vm_struct). But in the case
> of incoming call, though this is a reverse case, but I see memory only
> getting allocated and not being freed.
> 
> I can see in the code that the free function is called but the call has not
> been propagated to the kernel. The allocation is in the tune of 4 MB, so the
> memory must have been allocated using mmap and not brk, as the heap size for
> an application is defined to be 4 K, as per my knowledge. Even if the
> allocation is from heap, the heap should get enlarged and on subsequent call
> to free, the surplus space should be returned to OS.
> 
> Please help.

Can you attach a ptrace to the process in question to see what calls it 
makes, brk, mmap, munmap should be sufficient.  That will allow you to 
determine if the memory is being returned by the libc to the kernel or not.

-apw
