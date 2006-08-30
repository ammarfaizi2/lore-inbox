Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWH3Q7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWH3Q7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWH3Q7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:59:36 -0400
Received: from spirit.analogic.com ([204.178.40.4]:7439 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751159AbWH3Q7f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:59:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 30 Aug 2006 16:59:31.0955 (UTC) FILETIME=[A9CA9430:01C6CC55]
Content-class: urn:content-classes:message
Subject: Re: [PATCH][RFC] exception processing in early boot
Date: Wed, 30 Aug 2006 12:59:31 -0400
Message-ID: <Pine.LNX.4.61.0608301251570.13282@chaos.analogic.com>
In-Reply-To: <200608301830.40994.ak@suse.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][RFC] exception processing in early boot
Thread-Index: AcbMVanWMFfg/ZQdS+KPddUfM0Z9YA==
References: <20060830063932.GB289@1wt.eu> <200608301459.15008.ak@suse.de> <44F5D81A.9650.5BE48F99@pageexec.freemail.hu> <200608301830.40994.ak@suse.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <pageexec@freemail.hu>, "Willy Tarreau" <w@1wt.eu>, <Riley@williams.name>,
       <davej@redhat.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Aug 2006, Andi Kleen wrote:

> On Wednesday 30 August 2006 18:25, pageexec@freemail.hu wrote:
>> On 30 Aug 2006 at 14:59, Andi Kleen wrote:
>>>> I think that the good method would be to :
>>>>   - announce the patch
>>>>   - find a volunteer to port it
>>>>   - apply it once the volunteer agrees to handle it
>>>> This way, no code gets lost because there's always someone to track it.
>>>
>>> I can put that one into my tree for .19
>>
>> here's my quick attempt:
>
>
> It would be better to separate exceptions from interrupts here.
> A spurious interrupt is not necessarily fatal, just an exception is.
>
> But I went with the simpler patch with some changes now
> (added PANIC to the message etc.)
>
>>
>> --- linux-2.6.18-rc5/arch/i386/kernel/head.S	2006-08-28 11:37:31.000000000
>> +0200
>> +++ linux-2.6.18-rc5-fix/arch/i386/kernel/head.S	2006-08-30
>> 18:22:15.000000000 +0200
>> @@ -382,34 +382,25 @@ rp_sidt:
>>  /* This is the default interrupt "handler" :-) */
>>  	ALIGN
>>  ignore_int:
>> -	cld
>>  #ifdef CONFIG_PRINTK
>> -	pushl %eax
>> -	pushl %ecx
>> -	pushl %edx
>> -	pushl %es
>> -	pushl %ds
>> +	cld
>>  	movl $(__KERNEL_DS),%eax
>>  	movl %eax,%ds
>>  	movl %eax,%es
>> -	pushl 16(%esp)
>> -	pushl 24(%esp)
>> -	pushl 32(%esp)
>> -	pushl 40(%esp)
>> +	pushl 12(%esp)
>> +	pushl 12(%esp)
>> +	pushl 12(%esp)
>> +	pushl 12(%esp)
>>  	pushl $int_msg
>>  #ifdef CONFIG_EARLY_PRINTK
>>  	call early_printk
>>  #else
>>  	call printk
>>  #endif
>> -	addl $(5*4),%esp
>> -	popl %ds
>> -	popl %es
>> -	popl %edx
>> -	popl %ecx
>> -	popl %eax
>>  #endif
>> -	iret
>> +1:	hlt
>
> This is wrong because i386 still supports some CPUs that don't support
> HLT.
>
> -Andi

Even the i286 and the 8086 support hlt. Is there some Cyrix chip that
you are trying to preserve? I think even those all implimented
hlt as well.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
