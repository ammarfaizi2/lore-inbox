Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVLAHbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVLAHbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 02:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVLAHbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 02:31:25 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:3009 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1750738AbVLAHbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 02:31:25 -0500
Message-ID: <438EA6C8.1010108@ru.mvista.com>
Date: Thu, 01 Dec 2005 10:31:20 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: stephen@streetfiresound.com
CC: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH 2.6-git] SPI core refresh
References: <20051130195053.713ea9ef.vwool@ru.mvista.com>	 <200511301336.38613.david-b@pacbell.net> <1133387950.4528.16.camel@localhost.localdomain>
In-Reply-To: <1133387950.4528.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Street wrote:

>On Wed, 2005-11-30 at 13:36 -0800, David Brownell wrote:
>  
>
>>>- it is DMA-safe
>>>      
>>>
>>Which as I pointed out is incorrect.  The core API (async) has always
>>been fully DMA-safe.  And a **LOT** lower overhead than yours, which
>>allocates buffers behind the back of drivers, and encourages lots of
>>memcpy rather than just doing DMA directly to/from the buffers that
>>are provided by the SPI protocol drivers.
>>    
>>
>
>Minimal (or no) core intervention on the DMA code path is a good thing.
>I need to fix some broken hardware with software and must to move 96
>bytes from one SPI device to another on the same SPI bus every for 4ms.
>Needless memcpy's will cause substantial performance problems in my
>application. Thinner is definitely better.
>  
>
Oh yep, I must agree with you here, thanks.
However, it's not a big thing to change memcpy to spi_memcpy which will 
copy the data only when necessary.
That's what I definitely had been doing but didn't include in the patch 
sent, oops. :(
I'll come up with that shortly.

Vitaly
