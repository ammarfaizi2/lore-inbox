Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264533AbTDYVuC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbTDYVuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:50:02 -0400
Received: from watch.techsource.com ([209.208.48.130]:16319 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S264533AbTDYVuA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:50:00 -0400
Message-ID: <3EA9B061.600@techsource.com>
Date: Fri, 25 Apr 2003 18:02:09 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: TASK_UNMAPPED_BASE & stack location
References: <459930000.1051302738@[10.10.2.4]> <b8c7no$u59$1@cesium.transmeta.com> <1750000.1051305030@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>>Is there any good reason we can't remove TASK_UNMAPPED_BASE, and just
>>>shove libraries directly above the program text? Red Hat seems to have
>>>patches to dynamically tune it on a per-processes basis anyway ...
>>>
>>>Moreover, can we put the stack back where it's meant to be, below the
>>>program text, in that wasted 128MB of virtual space? Who really wants 
>>>      
>>>
>>>>128MB of stack anyway (and can't fix their app)?
>>>>        
>>>>
>>That space is NULL pointer trap zone.  NULL pointer trapping -> good.
>>    
>>
>
>128Mb of it? The bottom page, or even a few Mb, sure ... 
>but 128Mb seems somewhat excessive ..
>  
>
Considering that your process space is 4gig, and that that 128Mb doesn't 
really exist anywhere (no RAM, no page table entries, nothing), it's 
really not excessive.  If you're so strapped for process space that you 
need that extra 128Mb, then you probably shouldn't be using a 32-bit 
processor.

I understand that the stack exists somewhere high up in the address 
space.  And there's some other things up there (mmap space, etc).  What 
happens if the heap grows so much that it collides with one of those 
upper address spaces?  Out of memory?


