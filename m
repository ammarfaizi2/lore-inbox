Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVLPIiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVLPIiE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 03:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVLPIiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 03:38:04 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:30591 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S932183AbVLPIiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 03:38:02 -0500
Message-ID: <43A27CDA.4020304@ru.mvista.com>
Date: Fri, 16 Dec 2005 11:37:46 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051214171842.GB30546@kroah.com> <43A05C32.3070501@ru.mvista.com> <200512141102.53599.david-b@pacbell.net> <43A1118E.9040608@ru.mvista.com> <20051215164444.GA14870@kroah.com> <43A1ECE4.6010600@ru.mvista.com> <20051215230217.GA11880@kroah.com>
In-Reply-To: <20051215230217.GA11880@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Fri, Dec 16, 2005 at 01:23:32AM +0300, Vitaly Wool wrote:
>  
>
>>Greg KH wrote:
>>
>>    
>>
>>>On Thu, Dec 15, 2005 at 09:47:42AM +0300, Vitaly Wool wrote:
>>>
>>>
>>>      
>>>
>>>>David Brownell wrote:
>>>>
>>>>  
>>>>
>>>>        
>>>>
>>>>>No, "stupid drivers will suffer"; nothing new.  Just observe
>>>>>how the ads7846 touchscreen driver does small async transfers.
>>>>>
>>>>>
>>>>>    
>>>>>
>>>>>          
>>>>>
>>>>One cannot allocate memory in interrupt context, so the way to go is 
>>>>allocating it on stack, thus the buffer is not DMA-safe.
>>>>Making it DMA-safe in thread that does the very message processing is a 
>>>>good way of overcoming this.
>>>>Using preallocated buffer is not a good way, since it may well be
>>>>already used by another interrupt or not yet processed by the worker
>>>>thread (or tasklet, or whatever).
>>>>  
>>>>
>>>>        
>>>>
>>>Yes it is a good way.  That's the way USB currently works in the kernel,
>>>and it works just fine.  It keeps the rules simple and everyone knows
>>>what needs to be done.
>>>
>>>
>>>      
>>>
>>Looking at my usbnet stuff, I can't share that opinion :-/
>>Are you really ready to lower the performance and quality of service 
>>just for approach uniformity?
>>    
>>
>
>What performance issues?  As an example, USB has this rule, and we can
>saturate a 480Mbit line with a _userspace_ driver (loads of memcopy
>calles involved there.)
>  
>
What CPU is used there? I guess it's not 144 MHz ARM ;-)

>  
>
>>And, can you please point me out the examples of devices behind USB bus 
>>that need to write registers from an interrupt context?
>>    
>>
>
>usb to serial drivers need to allocate buffers for their write functions
>as they can be called in irq context from a tty line dicipline, which
>causes a USB packet to be dynamically created and sent to the USB core.
>I also think the USB network and ATM drivers have these requirements
>too, just search for GFP_ATOMIC in the drivers/usb/ directory to find
>these instances.
>  
>
Oh BTW... I'm experiencing constant problems with root filesystem over 
NFS over usbnet on my target
I'm getting "server not responding, still trying" error whenever the 
system (208-MHz ARM926 board) is under heavy load.
I think it may well be related to the thing we discuss.

Vitaly
