Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752269AbWJ0Pno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbWJ0Pno (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 11:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbWJ0Pno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 11:43:44 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:37767 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752269AbWJ0Pno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 11:43:44 -0400
Message-ID: <4542292C.3080409@us.ibm.com>
Date: Fri, 27 Oct 2006 10:43:40 -0500
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Avi Kivity <avi@qumranet.com>
CC: Arnd Bergmann <arnd@arndb.de>, kvm-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] [PATCH 6/13] KVM: memory slot management
References: <4540EE2B.9020606@qumranet.com> <200610270044.31382.arnd@arndb.de>	<45419D73.1070106@qumranet.com> <200610270937.11646.arnd@arndb.de> <454208EB.7080007@qumranet.com>
In-Reply-To: <454208EB.7080007@qumranet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
>>> 2. The next mmu implementation, which caches guest translations.
>>>
>>> The potential problem above now becomes acute.  The guest will have 
>>> kernel mappings for every page, and after a short while they'll all be 
>>> faulted in and locked.  This defeats the swap integration which is IMO a 
>>> very strong point.
>>>
>>> We can work around that by periodically forcing out translations (some 
>>> kind of clock algorithm) at some rate so the host vm can have a go at 
>>> them.  That can turn out to be expensive as we'll need to interrupt all 
>>> running vcpus to flush (real) tlb entries.
>>>     
>>>       
>> Don't understand. Can't one CPU cause a TLB entry to be flushed on all
>> CPUs?
>>
>>   
>>     
>
> It's not about tlb entries.  The shadow page tables collaples a GV -> HV 
> -> HP  double translation into a GV -> HP page table.  When the Linux vm 
> goes around evicting pages, it invalidates those mappings.
>
> There are two solutions possible: lock pages which participate in these 
> translations (and their number can be large) or modify the Linux vm to 
> consult a reverse mapping and remove the translations (in which case TLB 
> entries need to be removed).
>   

If you locked pages that have active shadow mappings, you could then use 
a secondary mechanism to invalidate existing mappings when necessary.

You could even base this on a user-configurable heuristic (give this VM 
1G of memory, with 512MB of dedicated memory for instance).

I seem to recall some discussion about having a memory pressure 
notification mechanism.  If such a thing existed, this could be used to 
reduce the guests actual memory foot print.  I'm woefully ignorant 
though of any recent developments in this area...

Regards,

Anthony Liguori

