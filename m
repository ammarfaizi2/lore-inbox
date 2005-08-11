Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVHKP25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVHKP25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVHKP25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:28:57 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:14345 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751090AbVHKP24 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:28:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <2cd57c90050811081374d7c4ef@mail.gmail.com>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz> <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com> <1123770661.17269.59.camel@localhost.localdomain> <2cd57c90050811081374d7c4ef@mail.gmail.com>
X-OriginalArrivalTime: 11 Aug 2005 15:28:54.0710 (UTC) FILETIME=[6250D560:01C59E89]
Content-class: urn:content-classes:message
Subject: Re: Need help in understanding x86 syscall
Date: Thu, 11 Aug 2005 11:28:41 -0400
Message-ID: <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Need help in understanding x86 syscall
Thread-Index: AcWeiWJaDnK1Zv5USX+wul7ZLf/6Ag==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Coywolf Qi Hunt" <coywolf@gmail.com>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
       "Ukil a" <ukil_a@yahoo.com>, <7eggert@gmx.de>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 Aug 2005, Coywolf Qi Hunt wrote:

> On 8/11/05, Steven Rostedt <rostedt@goodmis.org> wrote:
>> On Thu, 2005-08-11 at 10:04 -0400, linux-os (Dick Johnson) wrote:
>>> Every interrupt software, or hardware, results in the branched
>>> procedure being executed with the interrupts OFF. That's why
>>> one of the first instructions in the kernel entry for a syscall
>>> is 'sti' to turn them back on. Look at entry.S, line 182. This
>>> occurs any time a trap occurs as well (Page 26-168, i486
>>> Programmer's reference manual). FYI, this is helpful when
>>> designing/debugging complex interrupt-service routines since
>>> you can execute the interrupt with a software 'INT' instruction
>>> (with the correct offset from the IRQ you are using). The software
>>> doesn't 'know' where the interrupt came from, HW or SW.
>>
>> I'm looking at 2.6.13-rc6-git1 line 182 of entry.S and I don't see it.
>> Must be a different kernel.
>>
>> According to the documentation that I was looking at, a trap in x86 does
>> _not_ turn off interrupts.
>>
> ...
>>
>> I don't see a sti here.
>

Search for sysenter_entry. This is where the stack is switched
to the kernel stack. Then the code falls through past the
next label, sysenter_past_esp. The very next instruction
after the kernel stack has been set is 'sti'. Clear as day.

>
>> -- Steve
>
>
> He is RBJ, Richard B. Johnson, the LKML defacto official troll.
>
> --
> Coywolf Qi Hunt
> http://ahbl.org/~coywolf/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
