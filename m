Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbVHXUDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbVHXUDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 16:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbVHXUDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 16:03:54 -0400
Received: from spirit.analogic.com ([208.224.221.4]:44558 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751524AbVHXUDv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 16:03:51 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050824194836.GA26526@hexapodia.org>
References: <Pine.LNX.4.61.0508240854550.28064@chaos.analogic.com> <20050824173131.50938.qmail@web25809.mail.ukl.yahoo.com> <20050824194836.GA26526@hexapodia.org>
X-OriginalArrivalTime: 24 Aug 2005 20:03:45.0031 (UTC) FILETIME=[EEAEE170:01C5A8E6]
Content-class: urn:content-classes:message
Subject: Re: question on memory barrier
Date: Wed, 24 Aug 2005 16:03:08 -0400
Message-ID: <Pine.LNX.4.61.0508241559450.31759@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: question on memory barrier
Thread-Index: AcWo5u62SZ60Yv2SQdS23ZWZYkM8EQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Andy Isaacson" <adi@hexapodia.org>
Cc: "moreau francis" <francis_moreau2000@yahoo.fr>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Aug 2005, Andy Isaacson wrote:

> On Wed, Aug 24, 2005 at 07:31:31PM +0200, moreau francis wrote:
>> --- "linux-os (Dick Johnson)" <linux-os@analogic.com> a écrit :
>>> On Wed, 24 Aug 2005, moreau francis wrote:
>>>> I'm currently trying to write a USB driver for Linux. The device must be
>>>> configured by writing some values into the same register but I want to be
>>>> sure that the writing order is respected by either the compiler and the
>>>> cpu.
> [snip]
>>>> static inline void dev_out(u32 *reg, u32 value)
>>>> {
>>>>        writel(value, regs);
>>>> }
>>>>
>>>> void config_dev(void)
>>>> {
>>>>        dev_out(reg_a, 0x0); /* first io */
>>>>        dev_out(reg_a, 0xA); /* second io */
>>>> }
>>>>
>>>
>>> This should be fine. The effect of the first bit of code
>>> plus all side-effects (if any) should be complete at the
>>> first effective sequence-point (;) but you need to
>
> While sequence points are relevant for purposes of reasoning about the
> effects of C code on the abstract state machine as defined by the C
> standard, they are irrelevant when talking about IO.
>
>> sorry but I'm not sure to understand you...Do you mean that the first write
>> into reg_a pointer will be completed before the second write because they're
>> separated by a (;) ?
>> Or because writes are encapsulated inside an inline function,
>> therefore compiler must execute every single writes before returning
>> from the inline function ?
>
> The first register write will be completed before the second register
> write because you use writel, which is defined to have the semantics you
> want.  (It uses a platform-specific method to guarantee this, possibly
> "volatile" or "asm("eieio")" or whatever method your platform requires.)
>
> The sequence points, by themselves, do not make any requirements on the
> externally visible behavior of the program.  Nor does the fact that
> there's an inline function involved.  It's just the writel() that
> contains the magic to force in-order execution.
>
> You might benefit by running your source code through gcc -E and seeing
> what the writel() expands to.  (I do something like "rm drivers/mydev.o;
> make V=1" and then copy-n-paste the gcc line, replacing the "-c -o mydev.o"
> options with -E.)
>
> The sequence point argument is obviously wrong, BTW - if it were the
> case that a mere sequence point required the compiler to have completed
> all externally-visible side effects, then almost every optimization that
> gcc does with -O2 would be impossible.  CSE, loop splitting, etc.
>
> -andy


Wrong. Reference:

http://www.phy.duke.edu/~rgb/General/c_book/c_book/chapter8/sequence_points.html

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
