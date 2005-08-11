Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbVHKOEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbVHKOEs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbVHKOEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:04:48 -0400
Received: from spirit.analogic.com ([208.224.221.4]:20233 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030317AbVHKOEr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:04:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <E1E3DJm-0000jy-0B@be1.lrz>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz>
X-OriginalArrivalTime: 11 Aug 2005 14:04:45.0796 (UTC) FILETIME=[A0EDB240:01C59E7D]
Content-class: urn:content-classes:message
Subject: Re: Need help in understanding  x86  syscall
Date: Thu, 11 Aug 2005 10:04:32 -0400
Message-ID: <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Need help in understanding  x86  syscall
Thread-Index: AcWefaD5uKAgqhOBSsmSlpXNx9+wqA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <7eggert@gmx.de>
Cc: "Ukil a" <ukil_a@yahoo.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 Aug 2005, Bodo Eggert wrote:

> Ukil a <ukil_a@yahoo.com> wrote:
>
>> Now I had the doubt that if the the syscall
>> implementation is very large will the scheduling and
>> other interrupts be blocked for the whole time till
>> the process returns from the ISR (because in an ISR by
>> default the interrupts are disabled unless "sti" is
>> called explicitly)?
>
> According to my documentation it isn't. A software interrupt is a far call
> with an extra pushf, and a hardware interrupt is protected against recursion
> by the PIC, not by an interrupt flag.
> --

Every interrupt software, or hardware, results in the branched
procedure being executed with the interrupts OFF. That's why
one of the first instructions in the kernel entry for a syscall
is 'sti' to turn them back on. Look at entry.S, line 182. This
occurs any time a trap occurs as well (Page 26-168, i486
Programmer's reference manual). FYI, this is helpful when
designing/debugging complex interrupt-service routines since
you can execute the interrupt with a software 'INT' instruction
(with the correct offset from the IRQ you are using). The software
doesn't 'know' where the interrupt came from, HW or SW.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
