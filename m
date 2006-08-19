Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751772AbWHSSyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbWHSSyh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 14:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbWHSSyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 14:54:37 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:64941 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751773AbWHSSyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 14:54:36 -0400
Message-ID: <44E75E56.60905@colorfullife.com>
Date: Sat, 19 Aug 2006 20:54:14 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Andi Kleen <ak@muc.de>, mpm@selenic.com,
       Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 3/7] A Kmalloc subsystem
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com> <20060816022253.13379.76984.sendpatchset@schroedinger.engr.sgi.com> <20060816094358.e7006276.ak@muc.de> <Pine.LNX.4.64.0608161718160.19789@schroedinger.engr.sgi.com> <44E3FC4F.2090506@colorfullife.com> <Pine.LNX.4.64.0608170922030.24204@schroedinger.engr.sgi.com> <44E6B8EA.2010100@colorfullife.com> <Pine.LNX.4.64.0608190941490.4872@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608190941490.4872@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>On Sat, 19 Aug 2006, Manfred Spraul wrote:
>  
>
>>What about:
>>
>>if (unlikely(addr & (~(PAGE_SIZE-1))))
>>   slabp=virt_to_page(addr)->pagefield;
>>else
>>   slabp=addr & (~(PAGE_SIZE-1));
>>    
>>
>
>Well this would not be working with the simple slab design that puts the 
>first element at the page border to simplify alignment.
>
>And as we have just seen virt to page is mostly an address 
>calculation in many configurations. I doubt that there would be a great 
>advantage. Todays processors biggest cause for latencies are 
>cacheline misses..
>
It involves table walking on discontigmem archs. "slabp=addr & 
(~(PAGE_SIZE-1));" means no pointer chasing, and the access touches the 
same page, i.e. definitively no TLB miss.

> Some arithmetic with addresses does not seem to 
>be that important. Misaligning data in order to not put objects on such
>boundaries could be an issue.
>
> > Modify the kmalloc caches slightly and use non-power-of-2 cache sizes. Move
>  
>
>>the kmalloc(PAGE_SIZE) users to gfp.
>>    
>>
>
>Power of 2 cache sizes make the object align neatly to cacheline 
>boundaries and make them fit tightly into a page.
>  
>
IMHO not really an issue. 2kb-cache_line_size() also aligns perfectly.

--
    Manfred
