Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWCJR7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWCJR7T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWCJR7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:59:19 -0500
Received: from [69.90.147.196] ([69.90.147.196]:31371 "EHLO mail.kenati.com")
	by vger.kernel.org with ESMTP id S1751375AbWCJR7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:59:19 -0500
Message-ID: <4411BF8E.4080306@kenati.com>
Date: Fri, 10 Mar 2006 10:03:58 -0800
From: Carlos Munoz <carlos@kenati.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: Lee Revell <rlrevell@joe-job.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Subject: Re: How can I link the kernel with libgcc ?
References: <4410D9F0.6010707@kenati.com> <1141961152.13319.118.camel@mindpipe> <4410F6CB.8070907@kenati.com> <200603101237.35687.vda@ilport.com.ua>
In-Reply-To: <200603101237.35687.vda@ilport.com.ua>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

>On Friday 10 March 2006 05:47, Carlos Munoz wrote:
>  
>
>>Lee Revell wrote:
>>
>>    
>>
>>>On Thu, 2006-03-09 at 19:25 -0800, Carlos Munoz wrote:
>>> 
>>>
>>>      
>>>
>>>>I figured out how to get the driver to use floating point operations.
>>>>I included source code (from an open source math library) for the
>>>>log10 function in the driver. Then I added the following lines to the
>>>>file arch/sh/kernel/sh_ksyms.c: 
>>>>   
>>>>
>>>>        
>>>>
>>>Where is the source code to your driver?
>>>
>>>Lee
>>>
>>> 
>>>
>>>      
>>>
>>Hi Lee,
>>
>>Be warned. This driver is in the early stages of development. There is 
>>still a lot of work that needs to be done (interrupt, dma, etc, etc).
>>    
>>
>
>What? You are using log10 only twice!
>
>        if (!(siu_obj_status & ST_OPEN)) {
>		...
>                /* = log2(over) */
>                ydef[22] = (u_int32_t)(log10((double)(over & 0x0000003f)) /
>                                       log10(2));
>		...
>        }
>        else {
>		...
>                if (coef) {
>                        ydef[16] = 0x03045000 | (over << 26) | (tap - 4);
>                        ydef[17] = (tap * 2 + 1);
>                        /* = log2(over) */
>                        ydef[22] = (u_int32_t)
>                                (log10((double)(over & 0x0000003f)) / log10(2));
>                }
>
>Don't you think that log10((double)(over & 0x0000003f)) / log10(2)
>can have only 64 different values depending on the result of (over & 0x3f)?
>
>Obtain them from precomputed uint32_t log10table[64].
>--
>vda
>  
>
Hi Denis,

Yes, the driver code so far only uses log10 twice, but there will be 
more uses for it as I populate the rest of the tables. However, I think 
its use will be some what limited. I wasn't aware that the floating 
point registers are not saved. I'll investigate a way to create a table 
with pre-calculated log10 values.

Thanks,


Carlos
