Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUBSIk0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 03:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267020AbUBSIk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 03:40:26 -0500
Received: from [218.5.74.208] ([218.5.74.208]:25283 "EHLO vhost.bizcn.com")
	by vger.kernel.org with ESMTP id S266508AbUBSIkS (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 03:40:18 -0500
Message-ID: <403474C7.5020304@lovecn.org>
Date: Thu, 19 Feb 2004 16:33:11 +0800
From: Coywolf Qi Hunt <coywolf@lovecn.org>
Organization: LoveCN.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Riley@Williams.Name, davej@codemonkey.org.uk, hpa@zytor.com,
       Linux kernel <Linux-Kernel@vger.kernel.org>
Subject: { Linux not only practical, but an ideal. } Re: [PATCH 2.4.24] Fix
 GDT limit in setup.S 
References: <403114D9.2060402@lovecn.org> <Pine.LNX.4.53.0402161504490.15476@chaos> <40340EF4.4050409@greatcn.org>
In-Reply-To: <40340EF4.4050409@greatcn.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:

> Richard B. Johnson wrote:
> 
>> On Tue, 17 Feb 2004, Coywolf Qi Hunt wrote:
>>
>>
>>> Hello 2.4.xx hackers,
>>>
>>> In setup.S, i feel like that the gdt limit 0x8000 is not proper and it
>>> should be 0x800.  How came 0x800 into 0x8000 in 2.4.xx code?  Is there a
>>> story?  It shouldn't be a careless typo. 256 gdt entries should be
>>> enough and since it's boot gdt, 256 is ok even if the code is run on SMP
>>> with 64 cpus.
>>>
>>
>>
>> The first element has nothing to do with the number of GDT entries.
>> It represents the LIMIT. Because the granularity bit is
>> set meaning 4 kilobyte pages and 0x8000 * 0x1000  = 0x8000000
>>                                       |      |
>>                                       |      |_______ Page size
>>                                       |______________ GDT value
>> This is the size of address space that is unity-mapped for boot.
>>
>> The granularity is also not the number of GDT entries. It
>> represents the length for which the GDT definition applies.
>>
>> Because this GDT is used only for booting, somebody decided that
>> there would never be any boot code beyond 2 GB so there was no
>> reason to make room for it. If you change the number to 0x0800,
>> you are declaring that neither the boot code nor any RAM-disk
>> combination will ever exceed 0x800 * 0x1000 = 0x800000 bytes.
>> Therefore you broke my imbedded system. Do not do this.
>>
>>
>>> At least the comment doesn't match the code. Either fix the code or fix
>>> the comment.  We really needn't so many GDT entries. Let's use the intel
>>> segmentation in a most limited way. Below follows a patch fixing the 
>>> code.
>>>
>>> I don't have the latest 2.4.24, but setup.S isn't changed from 2.4.23 to
>>> 2.4.24.
>>>
>>> Regards, Coywolf
>>>
> 
> Thank you for you kindly reply, though I really don not agree with you.
> But thanks very much, since you are the only one replying me. I CCed to
> all the 2.0 2.2 2.4 maintainers.
> 
> 

Hello Richard B. Johnson,

I've just find out where the problem lying in your answer, that you are
not talking the same thing as i am. You are talking about the descriptor 
on which you are quite correct, while I am talking about GDTR, similar 
to selector, but not selector, could be called `selector' in GDTR. Two 
different things.


To All Hackers,

plz take my patch to make our kernel more perfect. Linux should be not 
only practical, but an ideal. And i have more such patches to send.


Regards,
Coywolf


-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

