Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWCGOVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWCGOVV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 09:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWCGOVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 09:21:21 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:10247 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750831AbWCGOVU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 09:21:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <440D918D.2000502@shaw.ca>
x-originalarrivaltime: 07 Mar 2006 14:21:04.0402 (UTC) FILETIME=[5E251F20:01C641F2]
Content-class: urn:content-classes:message
Subject: Re: de2104x: interrupts before interrupt handler is registered
Date: Tue, 7 Mar 2006 09:21:04 -0500
Message-ID: <Pine.LNX.4.61.0603070908460.9133@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: de2104x: interrupts before interrupt handler is registered
Thread-Index: AcZB8l4suMSVc5POQeubp8ta1HsoIw==
References: <5N5Ql-30C-11@gated-at.bofh.it> <5NnDE-44v-11@gated-at.bofh.it> <440CCD9A.3070907@shaw.ca> <Pine.LNX.4.61.0603070705490.8536@chaos.analogic.com> <440D918D.2000502@shaw.ca>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Mar 2006, Robert Hancock wrote:

> linux-os (Dick Johnson) wrote:
>> No. It would be good if that was true. Unfortunately, the IRQ
>> returned before the pci_enable_device() is not correct. It
>> gets re-written by pci_enable_device().
>
> That wasn't what I meant, yes, that is true in the current kernel.
> However, any device which would start generating interrupts just because
>  its BARs got enabled by pci_enable_device seems broken.

Thinking that a device powers ON in a stable state is naive. Many
complex devices will have FPGA devices with floating pins that don't
become stable until their contents are loaded serially. Others will
have IRQ requests based upon power-on states that need to be cleared
with a software reset. One can't issue a software reset until the
device is enabled and enabling the device may generate interrupts
with no handler in place so you have a "can't get there from here"
problem. Linux-2.4.x had IRQs that were stable. One could put
a handler in place that would handle the possible burst of interrupts
upon startup. Then this was changed so the IRQ value is wrong
until an unrelated and illogical event occurs. Now, you need to
make work-arounds that were never before necessary. My request
to fix this fell upon deaf ears.

>
> The driver needs to request the interrupt after the device is enabled,
> and only after that can it enable the device to generate interrupts.
>
> --
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/
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
