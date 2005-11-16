Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbVKPQKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbVKPQKu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbVKPQKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:10:50 -0500
Received: from spirit.analogic.com ([204.178.40.4]:40207 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030390AbVKPQKt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:10:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <a59861030511160743l19b7be6bn@mail.gmail.com>
References: <a59861030511160743l19b7be6bn@mail.gmail.com>
X-OriginalArrivalTime: 16 Nov 2005 16:10:47.0535 (UTC) FILETIME=[4E253FF0:01C5EAC8]
Content-class: urn:content-classes:message
Subject: Re: fast communication problem
Date: Wed, 16 Nov 2005 11:10:47 -0500
Message-ID: <Pine.LNX.4.61.0511161054510.12055@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: fast communication problem
Thread-Index: AcXqyE4ssfQjT1V8QEuPhmGIHKrwnw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ivan Korzakow" <ivan.korzakow@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Nov 2005, Ivan Korzakow wrote:

> Hi List,
>
> I'm running a 2.6.14 linux on 96 MHz MIPS processor. I need to cope
> with a device that sends a byte of data every 50 microsecond through
> an UART with no FIFO. What would be the best (well, the least
> horrible) way to handle that ? The good point is that I know when the
> communication starts.
>
> Any idea, any help, any "good luck" will be much appreciated !
>
> Thanks in advance,
>
> Ivan

Linux can handle interrupts at 100 microsecond intervals with
an ix86 of 400 MHz or above. The MIPS is supposed to be superb for
this kind of operation so you may not have a problem at 50 us and
90 MHz.

The hardware engineers here do know something so they would
never design something that needed the CPU at 50 microsecond
intervals --yet, although there are some new kids coming out
of school that haven't a clue and might create a requirement
like yours in the future!

The interrupt code must be well thought out, with the minimum
overhead of getting a byte from your buffer and writing it to
the device.

Use fixed buffers, probably ping/pong, so you don't have to
allocate anything in the ISR. If it doesn't work, then
call the hardware engineers the idiots they are after
instrumenting the reason why it won't work (takes 80
microseconds just to get to the ISR, leaving negative
time to do the work). They do everything in FPGAs nowadays.
If they buffered just one byte, you get interrupted every
100 us, 4 bytes 200 us, etc. Every bit helps.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.51 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
