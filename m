Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbSL1AML>; Fri, 27 Dec 2002 19:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSL1AML>; Fri, 27 Dec 2002 19:12:11 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:52390 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265270AbSL1AMK>;
	Fri, 27 Dec 2002 19:12:10 -0500
Message-ID: <3E0CEE49.7040106@colorfullife.com>
Date: Sat, 28 Dec 2002 01:20:25 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] generic device DMA implementation
References: <200212272355.gBRNtbl04274@localhost.localdomain>
In-Reply-To: <200212272355.gBRNtbl04274@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>>Noone obeys that rule, and it's not trivial to fix it. 
>>    
>>
>
>Any driver that disobeys this rule today with the pci_ API is prone to cache 
>related corruption on non-coherent architectures.
>  
>
The networking core disobeys the rule in the sendfile implementation. 
Depending on the cacheline size, even small TCP packets might disobey 
the rule. The problem is not restricted to drivers.

>  
>
>>Is it really impossible to work around that in the platform specific
>>code? In the worst case, the arch code could memcopy to/from a
>>cacheline aligned buffer. 
>>    
>>
>
>Well, it's not impossible, but I don't believe it can be done efficiently.  
>And since it can't be done efficiently, I don't believe it's right to impact 
>the drivers that are properly written to take caching effects into account.
>
>Isn't the better solution to let the platform maintainers negotiate with the 
>driver maintainers to get those drivers they care about fixed?
>  
>
I agree that the performance will be bad, but like misaligned memory 
access, the arch code should support it. Leave the warning about bad 
performance in the documentation, and modify the drivers where it 
actually matters.
Your new documentation disagrees with the current implementation, and 
that is just wrong.
And in the case of networking, someone must do the double buffering. 
Doing it within dma_map_single() would avoid modifying every pci driver.

--
    Manfred

