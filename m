Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbTIVQdN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 12:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbTIVQdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 12:33:13 -0400
Received: from zeus.kernel.org ([204.152.189.113]:10665 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263231AbTIVQdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 12:33:09 -0400
Message-ID: <3F6F23DA.9020901@colorfullife.com>
Date: Mon, 22 Sep 2003 18:31:22 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
Subject: Re: [PATCH] Move slab objects to the end of the real allocation
References: <200309221733.37203.arnd@arndb.de>
In-Reply-To: <200309221733.37203.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:

>Manfred Spraul wrote:
>  
>
>>   - Do not page-pad allocations that are <= SMP_CACHE_LINE_SIZE.  This
>>     crashes.  Right now the limit is hardcoded to 128 bytes, but sooner or
>>     later an arch will appear with 256 byte cache lines.
>>    
>>
>
>What made you think that 128 is the current maximum? All s390 machines
>have 256 byte cache lines.
>  
>
When I wrote "128" I was not aware that this is linked to the cache line 
size. Initially it was ">128", just as an arbitrary number. I replaced 
that with "> 116" due to an unrelated change, and that crashed, because 
the cache line size was set to 128 bytes.

My patch fixes this bug: It replaces the limits with >=116 [avoid 
wasting too much memory, guarantee that there is a cache for the 
off-slab control structures] and > SMP_CACHE_LINE_SIZE [guarantee that 
there is a cache for the off-slab control structures].

Right now there are too many patches in Andrew's tree, I'll wait until 
everything settled down a bit, then I'll resent the cache line size as a 
one-line patch. Do you want to implement CONFIG_DEBUG_PAGEALLOC 
immediately? If yes, then I can send you the oneliner immediately. 
Nothing except CONFIG_DEBUG_PAGEALLOC is affected by the bug.

--
    Manfred

