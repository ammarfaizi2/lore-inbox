Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422769AbWA1BCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422769AbWA1BCc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 20:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422771AbWA1BCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 20:02:32 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:12161 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422769AbWA1BCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 20:02:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=PaK4+jyrvlpnkC+FXluto67UkOxM4bFuTGXdLsxE1Tts2QF7ViOmH53l+Ai5i8EK4GNMAiLg7Zw2kMsRvKbdtBK0nl+SbL/n4uMsf7xVObGu70j724c6azqBdflJwE+mBOLcbWF2mY4ZtLWphr9YOsKeJQ6Cx5COGv53cBzDEMA=
Message-ID: <43DAC2B1.7060708@gmail.com>
Date: Sat, 28 Jan 2006 09:02:41 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Hai Zaar <haizaar@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: vesa fb is slow on 2.6.15.1
References: <cfb54190601260620l5848ba3ai9d7e06c41d98c362@mail.gmail.com>	 <43D8E1EE.3040302@gmail.com>	 <cfb54190601260806h7199d7aej79139140d145d592@mail.gmail.com>	 <43D94764.3040303@gmail.com>	 <cfb54190601261610o1479b8fdsbedb0ca96b14b6@mail.gmail.com>	 <43D9B77E.6080003@gmail.com>	 <cfb54190601270832x29681873i624818603d5db26e@mail.gmail.com>	 <43DA5681.2020305@gmail.com>	 <cfb54190601271628j774df3d0xce0ab24c8abca845@mail.gmail.com>	 <43DABCF6.4000904@gmail.com> <cfb54190601271654i8a001b7y5c37b27e2e7fa0ed@mail.gmail.com>
In-Reply-To: <cfb54190601271654i8a001b7y5c37b27e2e7fa0ed@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hai Zaar wrote:
> On 1/28/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Hai Zaar wrote:
>>>> Looks harmless to me.
>>>>
>>>> Can you check /proc/iomem just to verify if that particular address has
>>>> been reserved by the OS.
>>> Relevant iomem entries are:
>>> f0000000-f7ffffff : PCI Bus #40
>>>   f0000000-f7ffffff : 0000:40:00.0
>>>     f0000000-f7ffffff : vesafb
>>> f8000000-f9ffffff : PCI Bus #40
>>>   f8000000-f8ffffff : 0000:40:00.0
>>>   f9000000-f9ffffff : 0000:40:00.0
>>> After I load nvidia.ko, it changes to:
>>> f0000000-f7ffffff : PCI Bus #40
>>>   f0000000-f7ffffff : 0000:40:00.0
>>>     f0000000-f7ffffff : vesafb
>>> f8000000-f9ffffff : PCI Bus #40
>>>   f8000000-f8ffffff : 0000:40:00.0
>>     ^^^^^^^^
>> Yes, this address range (16M) is already allocated to resource #0
>> of the nvidia card.  So trying to allocate resource #6 on the same
>> address looks bogus to me.
> 
> Ok. What now?

Well, it looks to me like a harmless message and I'll just ignore it, I think,
as long as the affected pci device works properly.

> I've rebooted without 'vga' and 'video' parameters at all - the error stays.
> 
> BTW: How do you know that its allocated to resource #0 - are resource
> numbers written somewhere in /proc/iomem and I've missed it?

This was part of your lspci:

	Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f0000000 (64-bit, prefetchable) [size=128M]
	Region 3: Memory at f9000000 (64-bit, non-prefetchable) [size=16M]

See region 0.


Tony
