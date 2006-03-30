Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWC3NJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWC3NJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 08:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWC3NJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 08:09:20 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:49169 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932200AbWC3NJT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 08:09:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <Pine.LNX.4.61.0603301010400.30783@yvahk01.tjqt.qr>
x-originalarrivaltime: 30 Mar 2006 13:09:15.0059 (UTC) FILETIME=[2513D030:01C653FB]
Content-class: urn:content-classes:message
Subject: Re: Float numbers in module programming
Date: Thu, 30 Mar 2006 08:09:14 -0500
Message-ID: <Pine.LNX.4.61.0603300739050.32259@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Float numbers in module programming
Thread-Index: AcZT+yUdEAzxW1UXRr6k9wt7CyTCKA==
References: <3fd7d9680603290634n6fabcdc7r193c30447acc1858@mail.gmail.com> <Pine.LNX.4.61.0603290955440.27913@chaos.analogic.com> <Pine.LNX.4.61.0603301010400.30783@yvahk01.tjqt.qr>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: "beware" <wimille@gmail.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Mar 2006, Jan Engelhardt wrote:

>>
>> This used to be a FAQ. The floating-point coprocessor in ix86
>> machines is a shared resource. There is only one. Therefore,
>> the state of the floating-point unit needs to be saved and
>> restored across all context switches. Because this is expensive
>> in terms of CPU time used, it is not saved and restored during
>> system calls. This means that if you use the coprocessor in
>> the kernel, you may screw up somebody's mathematics,
>
> "somebody" is the current process, is not it? What if used in kthreads?
>

No. Any file I/O, or anything that takes time sleeps and gives up
the CPU, ultimately calling schedule(). That means that anybody
can have its coprocessor state dorked. This has been discussed many
times. Also, floating-point is never required for anything!!! It's
just a convenience for people who like to write code using 10 fingers.
It has real problems when trying to exactly represent real numbers.
For instance __all__ real numbers, except for transcendentals, can
be represented as a ratio of two integers. For instance, you can't
represent 1/3 exactly as a decimal. It is, however exactly the ratio
of 1 and 3, two integers. Given this, I'm sure you can find a way
to perform high-precision mathematics within the kernel without
using the coprocessor. Usually, it's just a little thought that
is required. Somebody needs 8 bits to feed into a volume-control
register, but the value needs to be log-scale. Trivial, even if
you don't want to use a table.

If you divulge the mathematics you need calculated, I'll bet you
will get many answers from responders to the linux-kernel list.
However, if you expect to use the coprocessor as part of an image
processing routine and your driver was designed to use that
coprocessor, then you need a private coprocessor or you need
a user-space 'driver' that probably communicates using shared-
memory, this not involving kernel code at all.


>
> Jan Engelhardt
> --
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
