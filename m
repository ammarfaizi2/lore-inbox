Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272537AbTHPBrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 21:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272552AbTHPBrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 21:47:42 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:32983 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S272537AbTHPBrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 21:47:40 -0400
Message-ID: <3F3D8D3B.3020708@colorfullife.com>
Date: Sat, 16 Aug 2003 03:47:39 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] slab debug vs. L1 alignement
References: <3F3D558D.5050803@colorfullife.com> <1060990883.581.87.camel@gaston>
In-Reply-To: <1060990883.581.87.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>On Fri, 2003-08-15 at 23:50, Manfred Spraul wrote:
>  
>
>>Ben wrote:
>>
>>    
>>
>>>Currently, when enabling slab debugging, we lose the property of
>>>having the objects aligned on a cache line size.
>>> 
>>>
>>>      
>>>
>>Correct. Cache line alignment is advisory. Slab debugging is not the 
>>only case that violates the alignment, for example 32-byte allocations 
>>are not padded to the 128 byte cache line size of the Pentium 4 cpus. I 
>>really doubt we want that.
>>    
>>
>
>Yes, I understand that, but that is wrong for GFP_DMA imho. Also, 
>SLAB_MUST_HWCACHE_ALIGN just disables redzoning, which is not smart,
>I'd rather allocate more and keep both redzoning and cache alignement,
>that would help catch some of those subtle problems when a chip DMA
>engine plays funny tricks.
>
I don't want to upgrade SLAB_HWCACHE_ALIGN to SLAB_MUST_HWCACHE_ALIGN 
depending on GFP_DMA: IIRC one arch (ppc64?) marks everything as 
GFP_DMA, because all memory is DMA capable.

Which arch do you use? Perhaps alignment could be added for broken archs.

Actually I think you should fix your arch, perhaps by double buffering 
in pci_map_ if the input pointers are not aligned. What if someone uses 
O_DIRECT with an unaligned pointer?

--
    Manfred

