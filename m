Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263278AbTIVUxn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbTIVUxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:53:43 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:48029 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263278AbTIVUxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:53:42 -0400
Message-ID: <3F6F6150.10808@colorfullife.com>
Date: Mon, 22 Sep 2003 22:53:36 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move slab objects to the end of the real allocation
References: <200309221733.37203.arnd@arndb.de> <3F6F23DA.9020901@colorfullife.com> <200309222240.01023.arnd@arndb.de>
In-Reply-To: <200309222240.01023.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:

>On Monday 22 September 2003 18:31, Manfred Spraul wrote:
>  
>
>>Right now there are too many patches in Andrew's tree, I'll wait until
>>everything settled down a bit, then I'll resent the cache line size as a
>>one-line patch. Do you want to implement CONFIG_DEBUG_PAGEALLOC
>>immediately? If yes, then I can send you the oneliner immediately.
>>Nothing except CONFIG_DEBUG_PAGEALLOC is affected by the bug.
>>    
>>
>
>Thanks for the explanation. I didn't realize that the code only applies
>to i386. I'm not trying to implement CONFIG_DEBUG_PAGEALLOC currently,
>but I'll put it on my list of things to do. Do I need to do anything
>beyond adding a working kernel_map_pages() and raising the 128 byte limit
>in kmem_cache_create to max(128,L1_CACHE_BYTES)?
>  
>
I'm not aware of any other restrictions, but I think s390 would be the 
first arch beyond i386 that supports DEBUG_PAGEALLOC, so beware. One 
important point is that kernel_map_pages() can be called from irq 
context - I'm not sure if all archs can support that.

--
    Manfred

