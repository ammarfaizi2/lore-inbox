Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWCJDVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWCJDVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 22:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWCJDVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 22:21:10 -0500
Received: from [69.90.147.196] ([69.90.147.196]:24713 "EHLO mail.kenati.com")
	by vger.kernel.org with ESMTP id S932089AbWCJDVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 22:21:09 -0500
Message-ID: <4410F1BE.7000904@kenati.com>
Date: Thu, 09 Mar 2006 19:25:50 -0800
From: Carlos Munoz <carlos@kenati.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>, Valdis.Kletnieks@vt.edu
CC: Carlos Munoz <carlos@kenati.com>, linux-kernel@vger.kernel.org
Subject: Re: How can I link the kernel with libgcc ?
References: <4410D9F0.6010707@kenati.com>	 <200603100145.k2A1jMem005323@turing-police.cc.vt.edu> <1141956362.13319.105.camel@mindpipe> <4410EC0D.3090303@kenati.com>
In-Reply-To: <4410EC0D.3090303@kenati.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Munoz wrote:

> Lee Revell wrote:
>
>> On Thu, 2006-03-09 at 20:45 -0500, Valdis.Kletnieks@vt.edu wrote:
>>  
>>
>>> On Thu, 09 Mar 2006 17:44:16 PST, Carlos Munoz said:
>>>   
>>>
>>>> I'm writing an audio driver and the hardware requires floating 
>>>> point arithmetic.  When I build the kernel I get the following 
>>>> errors at link time:
>>>>     
>>>
>>> Tough break, that.  You sure you can't figure a way to either push the
>>> floating point out to userspace
>>>   
>>
>>
>> Audio drivers should never have to directly manipulate the samples -
>> they just manage the DMA buffers and interrupts and wake up the process
>> at the right time.  Mixing, routing, volume control, DSP go in
>> userspace.
>>
>> Lee
>>
>>  
>>
> Hi Lee,
>
> Unfortunately, the driver needs to populate several coefficient tables 
> for the hardware to perform silence suppression and other advance 
> features. The values for these tables are calculated using log10 
> operations. I don't  see a clean way to push these operations to user 
> space without the need for custom applications that build the tables 
> and pass them to the driver.
>
> Thanks,
>
>
> Carlos Munoz
>
Anyway,

I figured out how to get the driver to use floating point operations. I 
included source code (from an open source math library) for the log10 
function in the driver. Then I added the following lines to the file 
arch/sh/kernel/sh_ksyms.c:

DECLARE_EXPORT(__subdf3);
DECLARE_EXPORT(__muldf3);
DECLARE_EXPORT(__divdf3);
DECLARE_EXPORT(__adddf3);
DECLARE_EXPORT(__floatsidf);
DECLARE_EXPORT(__eqdf2);
DECLARE_EXPORT(__fixdfsi);

Everything works now.

Thanks,


Carlos Munoz
