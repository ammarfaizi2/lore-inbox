Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVF0KUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVF0KUx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 06:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVF0KUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 06:20:53 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:27070 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S261522AbVF0KT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 06:19:59 -0400
Message-ID: <42BFD2EA.5060808@dev.rtsoft.ru>
Date: Mon, 27 Jun 2005 14:20:26 +0400
From: Vitaly Wool <vwool@dev.rtsoft.ru>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] SPI core -- revisited
References: <20050626193621.8B8E44C4D1@abc.pervushin.pp.ru> <200506270049.10970.adobriyan@gmail.com> <1119819580.3215.47.camel@laptopd505.fenrus.org> <42BF7496.7080204@dev.rtsoft.ru> <1119860886.3186.30.camel@laptopd505.fenrus.org> <42BFC348.5040709@dev.rtsoft.ru> <20050627102047.B10822@flint.arm.linux.org.uk>
In-Reply-To: <20050627102047.B10822@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Mon, Jun 27, 2005 at 01:13:44PM +0400, Vitaly Wool wrote:
>  
>
>>Arjan van de Ven wrote:
>>    
>>
>>>how is that??
>>>      
>>>
>>These functions are not exactly *wrappers*, there's some little 
>>additional logic inside.
>>spi-pnx0105_atmel.c uses spi_pnx_msg_buff_t structure to embed physical 
>>and virtual address and length of the memory area allocated by 
>>consistent_alloc, so if we just get rid of the alloc/free functions, 
>>we'll copy wrong data from the userspace and nothing'll work.
>>
>>Let's look at it from another point. When a read request comes from the 
>>userspace to spi-dev, spi-dev should allocate  memory and copy the user 
>>data in there. The problem is it is not (and shouldn't be) aware whether 
>>the transfer is gonna be DMA or not so spi-dev can't choose 
>>theappropriate method of memory allocation. Therefore it's reasonable to 
>>let algorithm provide routines to do that.
>>    
>>
>
>Sorry, this isn't making sense.  Are you implying that you want to use
>DMA to copy data from user to kernel space?  Or something else?
>
>In any case, I do hope that you are aware that copy_to_user/copy_from_user
>have rather important side effects other than just copying data?  They
>cause page faults which ensure that the user space pages are paged in
>and/or copied if written to as appropriate.
>  
>
Looks like you've misunderstood me. I was talking only about mem-to-dev 
and dev-to-mem DMA transfers, where dev is actually an SPI device. The 
thing I was talking about was that the 'wrappers' are necessary to call 
*real* copy_from_user/copy_to_user with the appropriate parameters. I 
hope this can also be derived by looking in the code.

>In another post, you mention that this patch was not provided for review.
>However, it _is_ effectively provided for review because it's an
>illustration of _how_ the interfaces are used - and we're reviewing
>the interfaces provided by the SPI core.
>
>  
>
Ok, readily agreeing to that.
But -- does the interfaces review imply checking wthether the figure 
brackets are complying to K&R? ;)

