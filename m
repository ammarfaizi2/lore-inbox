Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVLAHRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVLAHRi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 02:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVLAHRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 02:17:38 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:39359 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932102AbVLAHRh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 02:17:37 -0500
Message-ID: <438EA389.7030704@ru.mvista.com>
Date: Thu, 01 Dec 2005 10:17:29 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Underwood <basicmark@yahoo.com>
CC: linux-kernel@vger.kernel.org, david-b@pacbell.net, dpervushin@gmail.com,
       akpm@osdl.org, greg@kroah.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: Re: [PATCH 2.6-git] SPI core refresh
References: <20051130202930.67776.qmail@web36914.mail.mud.yahoo.com>
In-Reply-To: <20051130202930.67776.qmail@web36914.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Underwood wrote:

>>However, there also are some advantages of our core compared to David's I'd like to mention
>>
>>- it can be compiled as a module
>>    
>>
>So can David's. You can use BIOS tables in which case you must compile the SPI core into the
>kernel but you can also use spi_new_device which allows the SPI core to be built as a module (and
>is how I am using it).
>  
>
You limit the functionality, so it's not the case.

>  
>
>>- it is DMA-safe
>>    
>>
>To my understanding David's core is DMA-safe. Yes there is a question mark over one of the helper
>functions, but the _main_ functions _are_ DMA-safe.
>  
>
Yeah, I can agree with this statement. However, as it turns out, the 
latest David's core eliminates this issue.

>  
>
>>- it is priority inversion-free
>>- it can gain more performance with multiple controllers
>>    
>>
>Sorry I'm not sure what you mean here.
>  
>
If there's more than one SPI controller onboard, spi_write_then_read 
will serialize the transfers related to two different controllers what 
will have significant negative impact on the transfer speed (so DMA 
won't help increasing the speed in this case). Moreover, if, say, two 
kernel threads with different priorities are working with two SPI 
controllers respectively *priority inversion* will happen.
You might also want to learn more about real-time systems 
characterictics such as priority inversion, BTW.

>  
>
>>- it's more adapted for use in real-time environments
>>- it's not so lightweight, but it leaves less effort for the bus driver developer.
>>    
>>
>
>But also less flexibility. A core layer shouldn't _force_ a policy
>  
>
Nope, it's just a default policy.

>on a bus driver. I am currently developing an adapter driver for David's system and I wouldn't say
>that the core is making me do things I think the core should do. Please could you provide examples
>of where you think Davids SPI core requires 'effort'.
>  
>
Main are
- the need to call 'complete' in controller driver
- the need to implement policy in controller driver

Vitaly
