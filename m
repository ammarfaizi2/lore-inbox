Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932651AbVJGOLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbVJGOLi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVJGOLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:11:38 -0400
Received: from spirit.analogic.com ([204.178.40.4]:44554 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932651AbVJGOLi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:11:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200510071346.j97Dk3va005818@laptop11.inf.utfsm.cl>
References: <200510071346.j97Dk3va005818@laptop11.inf.utfsm.cl>
X-OriginalArrivalTime: 07 Oct 2005 14:11:32.0872 (UTC) FILETIME=[051C5080:01C5CB49]
Content-class: urn:content-classes:message
Subject: Re: [2.6] binfmt_elf bug (exposed by klibc). 
Date: Fri, 7 Oct 2005 10:11:32 -0400
Message-ID: <Pine.LNX.4.61.0510071004280.4184@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6] binfmt_elf bug (exposed by klibc). 
Thread-Index: AcXLSQUtCStaO92GQHKrmTqKNtlnzA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Cc: "Pawel Sikora" <pluto@agmk.net>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Oct 2005, Horst von Brand wrote:

> Pawe≈' Sikora <pluto@agmk.net> wrote:
>> I've a simple program called empty.c.
>>
>> $ cat empty.c
>>
>> int main(int argc, char* argv[])
>> {
>>     return 0;
>> }
>>
>> $ cat empty410.s
>>
>>         .file   "empty.c"
>>         .text
>>         .p2align 4,,15
>> .globl main
>>         .type   main, @function
>> main:
>>         xorl    %eax, %eax
>>         ret
>>         .size   main, .-main
>>         .ident  "GCC: (GNU) 4.1.0 20050922 (experimental)"
>>         .section        .note.GNU-stack,"", at progbits
>

With this compilation, the 'C' compiler looked and said; "you
are just going to return 0..." So that's the code it generated.
This compiler probably defaults to "-fomit-frame-pointer".


> I get a substantially different empty.s (gcc-4.0.2, Fedora rawhide on i686):
>
>        .file   "empty.c"
>        .text
>        .p2align 2,,3
> .globl main
>        .type   main, @function
> main:
>        pushl   %ebp
>        movl    %esp, %ebp
>        subl    $8, %esp
>        andl    $-16, %esp
>        subl    $16, %esp
>        xorl    %eax, %eax
>        leave
>        ret
>        .size   main, .-main
>        .ident  "GCC: (GNU) 4.0.2 20050928 (Red Hat 4.0.2-1)"
>        .section        .note.GNU-stack,"",@progbits


With this compiler, it assumed that you were going to do something
useful so it set up a stack-frame. It also aligned the stack after
it saved the intitial value in EBP. Then it cleared the return-
value, reset the stack, and returned.

This compiler did not default to "-fomit-frame-pointer" so it
set up a stack-frame.

>
>> binutils-2.15.94.0.2.2 produces for this code empty .data and .bss
>> sections:
>

There is nothing wrong here at all.

> binutils-2.16.91.0.2-4 doesn't. It looks like you are using broken tools.
> --
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
