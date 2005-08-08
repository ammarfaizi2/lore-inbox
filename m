Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbVHHUTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVHHUTa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 16:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVHHUTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 16:19:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52984 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932254AbVHHUT3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 16:19:29 -0400
Message-ID: <42F7BE4A.6030709@mvista.com>
Date: Mon, 08 Aug 2005 13:19:22 -0700
From: Dave Jiang <djiang@mvista.com>
Organization: MontaVista Software, Inc.
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: x86_64 frame pointer via thread context
References: <42F3EC97.2060906@mvista.com.suse.lists.linux.kernel> <p73slxn1dry.fsf@bragg.suse.de> <42F7A609.5030502@mvista.com> <42F7BB2C.6070004@vc.cvut.cz>
In-Reply-To: <42F7BB2C.6070004@vc.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> Dave Jiang wrote:
> 
>> Andi Kleen wrote:
>>
>>> Dave Jiang <djiang@mvista.com> writes:
>>>
>>>> Am I doing something wrong, or is this intended to be this way on
>>>> x86_64, or is something incorrect in the kernel? This method works
>>>> fine on i386. Thanks for any help!
>>>
>>>
>>>
>>>
>>> I just tested your program on SLES9 with updated kernel and RBP
>>> looks correct to me. Probably something is wrong with your user space
>>> includes or your compiler.
>>>
>>> -Andi
>>
>>
>>
>> I revised the app a little so that it would allow the threads to 
>> start, thus should prevent rBP w/ all 0's showing up. Below are some 
>> of results that I've gotten from various different distros and 
>> platforms. As you can see, the f's shows up on most of them, including 
>> Suse 9.2. The only one showed up looking ok is the Mandrake/Mandriva 
>> distro. I'm not sure how different SLES9 is from Suse9.2....
> 
> 
> Replace call to sleep() with busy loop.  Glibc's sleep() uses %ebp for
> its own data, so when you interrupt sleep(), you get rbp=(unsigned int)-1,
> as rbp really contains 0x0000.0000.ffff.ffff when nanosleep() syscall
> is issued.
>                                 Petr
> 

 From what I understand, when you signal a thread, the signal handler 
executes in the thread context and not the main process context. So 
therefore the rbp would be the thread's copy and not the one that 
sleep() just modified. So whatever sleep does to the main process 
context, there shouldn't be any effect on the thread context.... Also, 
what can I call to allow the threads to run? sleep() allows me to run 
the other threads. Busy wait does not.....

-- 
Dave

------------------------------------------------------
Dave Jiang
Software Engineer          Phone: (480) 517-0372
MontaVista Software, Inc.    Fax: (480) 517-0262
2141 E Broadway Rd, St 108   Web: www.mvista.com
Tempe, AZ  85282          mailto:djiang@mvista.com
------------------------------------------------------

