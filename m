Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVLAHYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVLAHYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 02:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVLAHYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 02:24:41 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:55487 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932104AbVLAHYk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 02:24:40 -0500
Message-ID: <438EA534.9090705@ru.mvista.com>
Date: Thu, 01 Dec 2005 10:24:36 +0300
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
References: <20051130195053.713ea9ef.vwool@ru.mvista.com> <200511301336.38613.david-b@pacbell.net>
In-Reply-To: <200511301336.38613.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>- it can be compiled as a module
>>    
>>
>
>Which as I pointed out would be a rather minor patch to mine.  There's a
>bit of code to manage the board-specific SPI tables, which _can't_ be
>a module.  Then there's something less than 2KB of code (ARM .text) that
>could live in a module.  I can't get excited about making that live in
>a module, but I'd take a patch to change that.
>  
>
Well, it's a sign of convergence :)

>
>  
>
>>- it is DMA-safe
>>    
>>
>
>Which as I pointed out is incorrect.  The core API (async) has always
>been fully DMA-safe.  And a **LOT** lower overhead than yours, which
>allocates buffers behind the back of drivers, and encourages lots of
>memcpy rather than just doing DMA directly to/from the buffers that
>are provided by the SPI protocol drivers.
>  
>
Lower overhead? Lemme absolutely disagree with you. Please be aware that 
memory allocation routines are abstract, so no necessary memory allocation.
Yeah, anyway, your latest core doesn't look DMA-unsafe to me.

>  
>
>>- it is priority inversion-free
>>- it can gain more performance with multiple controllers
>>- it's more adapted for use in real-time environments
>>    
>>
>
>You'd have to explain what you mean by all of these.  I could guess
>based on what you've said before (disagree!), but that won't help.
>  
>
Your taking semaphore in spi_write_then_read which all the sync routines 
are based on may lead to priority inversion and of course is not optimal 
in terms of overall performance, if there's more than one controller 
(have you tested your core in this situation BTW?)
Suppose you have two kernel threads with different priorities dealing 
with SPI controller each... Of course you'll get priority inversion when 
the thread with higher prio will wait for semaphore release!

>
>  
>
>>- it's not so lightweight, but it leaves less effort for the bus driver developer.
>>    
>>
>
>Whereas in my previous comments about your framework, I think I've
>pointed out that imposing needless and restrictive policies on how
>the controller drivers work is a Bad Thing.
>  
>
It's just a *reasonable* _default_ policy.

Vitaly
