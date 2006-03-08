Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWCHMDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWCHMDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 07:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWCHMDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 07:03:34 -0500
Received: from spirit.analogic.com ([204.178.40.4]:26119 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932504AbWCHMDd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 07:03:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <440E1E9F.3020208@shaw.ca>
x-originalarrivaltime: 08 Mar 2006 12:03:30.0548 (UTC) FILETIME=[50E0B340:01C642A8]
Content-class: urn:content-classes:message
Subject: Re: de2104x: interrupts before interrupt handler is registered
Date: Wed, 8 Mar 2006 07:03:30 -0500
Message-ID: <Pine.LNX.4.61.0603080658580.12681@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: de2104x: interrupts before interrupt handler is registered
Thread-Index: AcZCqFDntpuiGS3KRjyTsdanzF151g==
References: <5N5Ql-30C-11@gated-at.bofh.it> <5NnDE-44v-11@gated-at.bofh.it> <440CCD9A.3070907@shaw.ca> <Pine.LNX.4.61.0603070705490.8536@chaos.analogic.com> <440D918D.2000502@shaw.ca> <Pine.LNX.4.61.0603070908460.9133@chaos.analogic.com> <440E1E9F.3020208@shaw.ca>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Mar 2006, Robert Hancock wrote:

> linux-os (Dick Johnson) wrote:
>> Thinking that a device powers ON in a stable state is naive.
>
> I don't think so.. if you build a device that connects to the PCI bus it
> had better come up in a stable state if it wants to be compliant with
> the spec. That's what the reset line and power-up reset interval is for.
>
>> Many
>> complex devices will have FPGA devices with floating pins that don't
>> become stable until their contents are loaded serially. Others will
>> have IRQ requests based upon power-on states that need to be cleared
>> with a software reset. One can't issue a software reset until the
>> device is enabled and enabling the device may generate interrupts
>> with no handler in place so you have a "can't get there from here"
>> problem.
>
> You still aren't seeing my point. Why does enabling the device BARs
> cause the device to generate interrupts? And if there's something you
> need to do to prevent the device from generating interrupts, how can you
> do it without enabling the device?
>
> Also, the device's ISR must clear the condition which is causing the
> interrupt, otherwise interrupt storms will result. If your device can
> enter a state where the interrupt cannot be reliably cleared, how can
> you possibly comply with this?

You don't bother to read. The reported interrupt is WRONG, INVALID,
INCORRECT, BROKEN, until __after__ the device is enabled. That means
that one CANNOT put an interrupt handler in place before the
device is enabled.

It's the Linux code that was broken when 2.6.x started. Previous
Linux code never failed to report the correct IRQ.


>
>> Linux-2.4.x had IRQs that were stable. One could put
>> a handler in place that would handle the possible burst of interrupts
>> upon startup. Then this was changed so the IRQ value is wrong
>> until an unrelated and illogical event occurs. Now, you need to
>> make work-arounds that were never before necessary. My request
>> to fix this fell upon deaf ears.
>
> I don't think any workarounds are needed except for devices that don't
> comply with the spec. Asserting interrupts that have not been
> specifically enabled by the driver would meet that definition in my
> view. If a device happens to do this then maybe a workaround would be
> needed, but that's what it would be, a workaround for a broken device.
>
> --
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.50 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
