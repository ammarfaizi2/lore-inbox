Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbVLVPoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbVLVPoq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVLVPoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:44:46 -0500
Received: from [195.144.244.147] ([195.144.244.147]:42181 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S1030204AbVLVPoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:44:44 -0500
Message-ID: <43AAC9E8.2060105@varma-el.com>
Date: Thu, 22 Dec 2005 18:44:40 +0300
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: Pantelis Antoniou <panto@intracom.gr>
Cc: jes@trained-monkey.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] genalloc != generic DEVICE memory allocator
References: <43A98F90.9010001@varma-el.com> <43AA65F4.10409@intracom.gr> <43AAAEA2.8030200@varma-el.com> <43AAB508.7000007@intracom.gr>
In-Reply-To: <43AAB508.7000007@intracom.gr>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=pgp.dtype.org
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pantelis Antoniou wrote:
> Andrey Volkov wrote:
> 
>> Hi Pantelis,
>>
>> Pantelis Antoniou wrote:
>>
>>> Andrey Volkov wrote:
>>>
> 
> [snip]
> 
>>>
>>> Hi Andrey,
>>>
>>> FYI, on arch/ppc/lib/rheap.c theres an implementation of a remote heap.
>>>
>>> It is currently used for the management of freescale's CPM1 & CPM2
>>> internal
>>> dual port RAM.
>>>
>>> Take a look, it might be what you have in mind.
>>>
>>> Regards
>>>
>>> Pantelis
>>
>>
>>
>> Thanks I missed it (and small wonder! :( ).
>>
>> Andrew, Is somebody count HOW MANY dev specific implementation
>> of buddy/first-fit allocators now in kernel?
>>
> 
> Yes, it is indeed messy.
> 
> The rheap implementation is generic enough and I believe can fit most of
> the
> special memory allocators needs. If you'd like I could move it somewhere
> generic and test it.
> 
I'm sure lib/ will be appropriate place. and something like
"DON'T TRY REINVENT WHEEL, TRY FIX EXISTS" in documentation/ :).

Now couple word about rheap: I understand why you are use static
alignment in allocator, but its very specialized for CPM. IMO, align
must be a param of xx_alloc. For ex: device may demand alignment by
8 bytes, which ok until... you are try map this memory to the user
space (don't shoot at me, remember about framebuffer & co).

-- 
Regards
Andrey Volkov
