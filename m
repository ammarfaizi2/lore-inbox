Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbULTSY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbULTSY0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 13:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbULTSY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 13:24:26 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:49291 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261604AbULTSYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 13:24:22 -0500
Message-ID: <41C718C7.1020908@colorfullife.com>
Date: Mon, 20 Dec 2004 19:24:07 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reimplementation of linux dynamic percpu memory allocator
References: <41C35DD6.1050804@colorfullife.com> <20041220182057.GA16859@in.ibm.com>
In-Reply-To: <20041220182057.GA16859@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:

>Hmmm..I knew from some experiments earlier that access to per cpu versions
>of memory was slow with the slab based implementation -- which this patch
>addresses, but I didn't know allocs themselves were slow...
>Creation of a disk should not be a fast path no?
>  
>
No, not fast path. But it can happen a few thousand times. The slab 
implementation failed due to heavy internal fragmentation. If your code 
runs fine with a few thousand users, then there shouldn't be a problem.

>>>      
>>>
>>That means no large pte entries for the per-cpu allocations, right?
>>I think that's a bad idea for non-numa systems. What about a fallback to 
>>simple getfreepages() for non-numa systems?
>>    
>>
>
>Can we have large pte entries with PAGE_SIZEd pages?  
>
>  
>
For non-NUMA systems, I would use get_free_pages() to allocate a 
multi-page area instead of map_vm_area(). Typically, get_free_pages() is 
backed by large pte memory and map_vm_area() by normal virtual memory.

--
    Manfred
