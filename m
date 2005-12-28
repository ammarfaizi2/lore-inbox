Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbVL1NOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVL1NOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 08:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbVL1NOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 08:14:35 -0500
Received: from spirit.analogic.com ([204.178.40.4]:61714 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964806AbVL1NOe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 08:14:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200512241403.38482.vda@ilport.com.ua>
X-OriginalArrivalTime: 28 Dec 2005 13:14:31.0580 (UTC) FILETIME=[A3BC15C0:01C60BB0]
Content-class: urn:content-classes:message
Subject: Re: 4k stacks
Date: Wed, 28 Dec 2005 08:14:17 -0500
Message-ID: <Pine.LNX.4.61.0512280808290.25369@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 4k stacks
Thread-Index: AcYLsKPFrAnDmfJESD+5Hzc9xk6ryQ==
References: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com> <200512241403.38482.vda@ilport.com.ua>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Denis Vlasenko" <vda@ilport.com.ua>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 24 Dec 2005, Denis Vlasenko wrote:

> On Thursday 22 December 2005 23:53, linux-os (Dick Johnson) wrote:
>>
>> Yesterday I sent a patch to add stack-poison so the stack usage
>> could be observed.
>>
>> Today I wrote a small program and tested the stack usage. Both
>> the program and the patch is attached. The result is:
>>
>> Offset : 2ec8f000	Available Stack bytes = 3104
>> Offset : 2ecb1000	Available Stack bytes = 3104
>> Offset : 2ee5f000	Available Stack bytes = 20
>> Offset : 2f36d000	Available Stack bytes = 3104
>> Offset : 2fd09000	Available Stack bytes = 3012
>> Offset : 2fd0b000	Available Stack bytes = 3312
>> Offset : 2fd0f000	Available Stack bytes = 2132
>> Offset : 2fd2f000	Available Stack bytes = 2744
>> Offset : 2fd57000	Available Stack bytes = 2900
>> Offset : 2fdd5000	Available Stack bytes = 1400
>> Offset : 2fe35000	Available Stack bytes = 2832
>> Offset : 2ff3f000	Available Stack bytes = 776
>> Offset : 2ff45000	Available Stack bytes = 3188
>>
>> This, after compiling the kernel. I did not have 4k stacks
>> enabled for this test so any crashing of the stack beyond
>> one page will not hurt the system. This was on linux-2.6.13.4.
>>
>> Anyway, I tried to enable 4k stacks and the machine would
>> not boot past trying to install the first module. It just
>> stopped with the interrupts disabled. So, I am now rebuilding
>> the kernel back as I write this. That's why I am using 2.6.13
>> at the moment.
>>
>> Anyway, getting down to 20 bytes of stack-space available
>> seems to be pretty scary.
>
> +       movl    %esp, %edi
> +       movl    %edi, %ecx
> +       andl    $~0x1000, %edi
> +       subl    %edi, %ecx
>
> ecx will be equal to ?

Whatever the stack was minus that value ANDed with NOT 0x1000,
i.e. 0x1000 minus the stack already in use. The code assumes
that the stack starts and ends on a 0x1000 (page) boundary.
If that's not true, then all bets are off.

>
> +       movb    $'Q', %al
> +       rep     stosb
> --
> vda
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5591.11 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
