Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWBJBBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWBJBBE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 20:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWBJBBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 20:01:04 -0500
Received: from smtpout.mac.com ([17.250.248.87]:12994 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750925AbWBJBBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 20:01:02 -0500
In-Reply-To: <200602100123.36077.ak@suse.de>
References: <200602071215.46885.ak@suse.de> <Pine.LNX.4.61.0602071336060.30994@scrub.home> <20060210000523.GE3524@stusta.de> <200602100123.36077.ak@suse.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CC2C8F34-4451-46B2-8887-15FF3D61AB41@mac.com>
Cc: Adrian Bunk <bunk@stusta.de>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Cleanup possibility in asm-i386/string.h
Date: Thu, 9 Feb 2006 20:00:44 -0500
To: Andi Kleen <ak@suse.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 09, 2006, at 19:23, Andi Kleen wrote:
> On Friday 10 February 2006 01:05, Adrian Bunk wrote:
>> On Tue, Feb 07, 2006 at 01:39:50PM +0100, Roman Zippel wrote:
>>> Hi,
>>>
>>> On Tue, 7 Feb 2006, Andi Kleen wrote:
>>>
>>>>> This means you define a prototype for the builtin function and  
>>>>> not for the normal function. I'm not sure this is really intended.
>>>>
>>>> What good would be a prototype for a symbol that is defined to a  
>>>> different symbol?
>>>
>>> The point is you define a prototype for a builtin function, I'm  
>>> not sure that's a good thing to do. Actually I'd prefer to remove  
>>> -ffreestanding again, especially because it disables builtin  
>>> functions, which we have to painfully enable all again  one by  
>>> one, instead of leaving it just to gcc.
>>
>> I remember playing with using more gcc builtins in the kernel some  
>> time ago, and some gcc builtin used a different library function,  
>> which was a function the kernel did not supply.
>
> It works fine on x86-64. If something is missing it can be also  
> supplied.

I don't remember exactly, but I think the problem was something like  
this (even if not this exact case, it was similarly obscure):  If - 
ffreestanding was not specified, then the following code would  
generate an implicit call to memcpy() or some other library function.

struct a {
	[... large struct with lots of fields ...]
}

struct a first = { ..... };
[... more code ...];
struct a second = first; /* <== This line would generate implicit  
memcpy */

Cheers,
Kyle Moffett

--
Diplomacy involves walking softly and _carrying_ a big stick.   
Actually using the big stick means the diplomacy part failed.
   -- Rob Landley



