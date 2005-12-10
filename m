Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbVLJLQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbVLJLQB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 06:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbVLJLQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 06:16:00 -0500
Received: from smtp1.pochta.ru ([81.211.64.6]:44592 "EHLO smtp1.pochta.ru")
	by vger.kernel.org with ESMTP id S965052AbVLJLQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 06:16:00 -0500
X-Author: vitalhome@rbcmail.ru from [10.1.27.2] ([82.179.192.198]) via Free Mail POCHTA.RU
Message-ID: <439AB8B5.80104@ru.mvista.com>
Date: Sat, 10 Dec 2005 14:15:01 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: Re: [PATCH 2.6-git] SPI core refresh
References: <20051201191109.40f2d04b.vwool@ru.mvista.com> <200512071759.56782.david-b@pacbell.net> <4397D3AA.6050804@ru.mvista.com> <200512091455.01790.david-b@pacbell.net>
In-Reply-To: <200512091455.01790.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>Please remember that using threads is just a default option which may be 
>>even turned off at the kernel configuration stage.
>>    
>>
>
>People keep saying "make it a library" in such cases, and that's the
>kind of layering I've come to think is more appropriate.  So that
>bitbang code needs some reshaping.  As a library, not driver or core.
>  
>
Well, effectively this is the way we do it now... Of course one can 
establish drivers/spi/lib subdir... :)

>>Exposing SPI message structure doesn't look good to me also because 
>>you're making it a part of the interface (and thus unlikely to change).
>>    
>>
>
>The interface will be the interface, sure.  Whatever it is.
>And will accordingly be unlikely to change.  We know that
>from every other API in Linux and elsewhere; nothing new.
>
>Was there some specific issue you forgot to raise here?
>  
>
Well, I've had an experience working with full duplex SPI controller. 
I'm afraid that if you're gonna support it some time in the future, 
you'll have to rework the  message interface, won't you?

>>We're hiding spi_msg internals what allows us to be more flexible in 
>>implementation (for instance, implement our own allocation technique for 
>>spi_msg (more lightweight as the size is always the same).
>>    
>>
>
>What you're doing is requiring a standard dynamic allocation model for
>your "spi_msg" objects ... one per transfer even, much heavier weight than
>the "one per transfer group" model of current "spi_message".  (And much
>heavier than stack based allocation too.)
>  
>
We can allocate a pool of messages at the very init stage and use our 
own technique to grab the next one from the pool in spimsg_alloc.
So we're not requiring _standard_ dynamic allocation model.

Vitaly
