Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUHGR4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUHGR4O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 13:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUHGR4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 13:56:14 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:51302 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S263875AbUHGRz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 13:55:59 -0400
Message-ID: <4115179F.6060609@travellingkiwi.com>
Date: Sat, 07 Aug 2004 18:55:43 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cs using 100% CPU
References: <40FA4328.4060304@travellingkiwi.com> <20040806202747.H13948@flint.arm.linux.org.uk> <4113DD20.1010808@travellingkiwi.com> <20040806203849.I13948@flint.arm.linux.org.uk>
In-Reply-To: <20040806203849.I13948@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Fri, Aug 06, 2004 at 08:33:52PM +0100, Hamie wrote:
>  
>
>>Russell King wrote:
>>
>>    
>>
>>>On Sun, Jul 18, 2004 at 10:30:16AM +0100, Hamie wrote:
>>> 
>>>
>>>      
>>>
>>>>Anyone know why this happens? Something busy waiting? (BUt that should 
>>>>show as system cpu right?) or something taking out really long locks?
>>>>   
>>>>
>>>>        
>>>>
>>>It'll be because IDE is using PIO to access the CF card, which could
>>>have long access times (so reading a block of sectors could take some
>>>time _and_ use CPU.)  Obviously, PIO requires the use of the CPU, so
>>>the CPU can't be handed off to some other task while this is occuring.
>>>
>>> 
>>>
>>>      
>>>
>>Well... I did consider that. And not to disbelieve you, since you know 
>>the kernel way better than I do, But decided I was being silly that a 
>>1.6GHz Pentium-M processor should use 100% CPU moving a couple of 
>>MB/second across a CF interface...
>>
>>Is 100% CPU not excessive? IIRC my PIII-750 used to use less CPU doing 
>>the same job as quick, or even slightly faster...
>>
>>And should it not use system CPU rather than user CPU?
>>    
>>
>
>Actually, if its being accounted for as waitIO, then we should be
>running some other task...  However, I've just realised that we
>don't appear to specifically account IO waits in the kernel, so
>I'm not sure how userspace comes up with this magic number.
>
>Sorry for the noise...
>
>  
>

Hey... Make all the noise you like. If I knew the internals a bit more 
nowadays, I'd find it determine why it looks like userCPU myself.

Why doesn't the kernel account for waitIO? Design decision? or just not 
yet implemented? Or not wanted (Not sure why it'd be the third  or first 
:). Bug?

H



