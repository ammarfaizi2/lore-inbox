Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161202AbWJLGcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161202AbWJLGcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 02:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161207AbWJLGcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 02:32:41 -0400
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:10996 "EHLO Smtp.neuf.fr")
	by vger.kernel.org with ESMTP id S1161202AbWJLGck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 02:32:40 -0400
Date: Thu, 12 Oct 2006 08:32:43 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] fdtable: Eradicate fdarray overflow.
In-reply-to: <200610112307.38485.vlobanov@speakeasy.net>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <452DE18B.9030701@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <200610111958.03238.vlobanov@speakeasy.net>
 <452DD058.7000301@cosmosbay.com> <200610112307.38485.vlobanov@speakeasy.net>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lobanov a écrit :
> On Wednesday 11 October 2006 22:19, Eric Dumazet wrote:
>> Hi Vadim
>>
>> I find your PAGE_SIZE/4 minimum allocation quite unjustified.
>>
>> For architectures with 64K PAGE_SIZE, we endup allocating 16K, for poor
>> tasks that happen to touch a not so high (>= 64) file descriptor...
>>
>> I would vote for a fixed size, like 1024
> 
> In my opinion, always picking 1024 would be highly suboptimal for some 
> architectures (x86-64 in particular -- that's a whole page, just for the 
> fdarray!). If anything, I'd prefer something similar to this pseudo-code:

I was speaking of 1024 bytes.

I was the guy who made fdset going from PAGE_SIZE to 64 bytes (L1_CACHE_BYTES 
if you dare), I wont be the guy responsible for a reverse path on fdtable :)

That is replace your (PAGE_SIZE/4)  by 1024, wich was you probably meant
No archi has a smaller page, so no need to play with min_t() macro...

> 
> #define FDTABLE_MIN min_t(uint, PAGE_SIZE / 4 / sizeof(struct file *), 1024)
> ...
> nr /= FDTABLE_MIN;
> nr = roundup_pow_of_two(nr + 1);
> nr *= FDTABLE_MIN;
> 
> gcc should be smart enough to optimize that expression into a single constant. 
> At least it did (version 4.1.0) in my quick test here.
> 
>> Eric
> 
> Let me know what you think. Please don't just go radio-silent on me. ;)
> 

radio-silent ? well, it seems I already sent you many mails about your patches :)

Eric

