Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbWB1VNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbWB1VNR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 16:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWB1VNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 16:13:16 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:13326 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932614AbWB1VNQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 16:13:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200602281535.21974.jringle@vertical.com>
x-originalarrivaltime: 28 Feb 2006 21:13:06.0720 (UTC) FILETIME=[C4E73A00:01C63CAB]
Content-class: urn:content-classes:message
Subject: Re: Linux running on a PCI Option device?
Date: Tue, 28 Feb 2006 16:13:06 -0500
Message-ID: <Pine.LNX.4.61.0602281556240.5128@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux running on a PCI Option device?
Thread-Index: AcY8q8TwnPcYYDwoQw6hD8uTYQWImw==
References: <43EAE4AC.6070807@snapgear.com> <200602281535.21974.jringle@vertical.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jon Ringle" <jringle@vertical.com>
Cc: "Greg Ungerer" <gerg@snapgear.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Feb 2006, Jon Ringle wrote:

> On Thursday 09 February 2006 01:43 am, Greg Ungerer wrote:
>> Hi Jon,
>>
>> Jon Ringle wrote:
>>> I am working on a new board that will have Linux running on an xscale
>>> processor. This board will be a PCI Option device. I currently have a
>>> IXDP465 eval board which has a PCI Option connector that I will use for
>>> prototyping. From what I can tell so far, Linux wants to scan the PCI bus
>>> for devices as if it is the PCI host. Is there any provision in Linux so
>>> that it can take on the role of a PCI option rather than a PCI host?
>>
>> Have a look at the code in arch/arm/mach-ixp4xx/common-pci.c, in
>> the function ixp4xx_pci_preinit().
>>
>> It does a check on whether the PCI bus is configured as HOST or not.
>> I don't know if that code support is enough for it all to work right
>> though (I certainly haven't tried it on either the 425 or 465...)
>
> When I have the IXDP465 in PCI Option mode, Linux still writes to pci
> configuration space which confuses the heck out of the PCI Host (Windows
> 2003). What do I need to do in order to have Linux work as a PCI option but
> still not mess with the pci configuration, and leave that task to the PCI
> Host?
>
> Jon

But anything on the PCI bus will get written, at least to find out
the length of the address space. Please read about the PCI System
Architecture. There are several writes that are mandatory. If
somebody is attempting to configure the PCI devices, the following
will occur.

(1) The BIOS will find some available address-space and put it
into any base-address register that has memory-space enabled
in the command register.

(2) The BIOS will find some available I/O space and put it into
a base-address register, too.

This all occurs long before any OS is booted. These writes
will occur. Then, the addresses may be re-written by any OS
including Linux. Additional writes will occur when the
device is enabled and when the cache-line size or the
latency timer is written.

If the device is a host, and you don't want the BIOS to
hack with it, then you need to turn off writes from the
the host-bus side. This is something your FPGA designer
needs to provide.

Usually, option boards use a PCI interface chip such as
a PLX PCI-9656BA. It would not normally BE a PCI device
on the Host side. The host CPU would communicate with it
on a local bus.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
