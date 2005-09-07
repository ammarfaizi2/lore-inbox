Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVIGPAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVIGPAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 11:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVIGPAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 11:00:00 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:37896 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932154AbVIGO77 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 10:59:59 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050907141651.GA10075@kvack.org>
References: <431EC16B.2040604@uab.es> <20050907141651.GA10075@kvack.org>
X-OriginalArrivalTime: 07 Sep 2005 14:59:55.0054 (UTC) FILETIME=[CE8DA4E0:01C5B3BC]
Content-class: urn:content-classes:message
Subject: Re: 'virtual HW' into kernel (SystemC)
Date: Wed, 7 Sep 2005 10:59:54 -0400
Message-ID: <Pine.LNX.4.61.0509071056080.4239@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 'virtual HW' into kernel (SystemC)
Thread-Index: AcWzvM6UAIVMl8hBTLO/9PtJ7Mn/pg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Benjamin LaHaise" <bcrl@kvack.org>
Cc: =?iso-8859-1?Q?M=E0rius_Mont=F3n?= <Marius.Monton@uab.es>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Sep 2005, Benjamin LaHaise wrote:

> On Wed, Sep 07, 2005 at 12:31:07PM +0200, Màrius Montón wrote:
>> At this point, we plan to develop a pci device driver to act as a bridge
>> between kernel PCI subsystem and SystemC simulator (in user space).
>>
>> Do you think this implementation is fine? Maybe it's better to register
>> a new bus
>> subsystem and link to a daemon to user space to run SystemC simulations?
>> We are open to any idea or suggestion about it.
>
> That's actually quite a difficult approach to take as you aren't able to
> fully simulate how the hardware interacts with the system, making concerns
> like timing very difficult to accurately model.  A better approach is to
> tie into a full system simulator -- qemu makes it very easy to add a new
> pci device into the system.  This way your hardware simulator doesn't have
> to worry about the complexities of kernel programming, and the resulting
> device drivers doesn't need hooks for the simulator as it would see the
> pci device as if it were installed in a system.
>
> Btw, do you know of any inexpensive ways to be introduced SystemC
> development on FPGAs?  Cheers,
>
> 		-ben


Writing drivers for an emulated hardware environment probably
won't work because the eventual hardware won't match the
emulation. If you are serious about concurrent development,
i.e., writing software while a device is being designed, I
have some free advice grabbed from a PPT presentation I
made a few years ago.....

The ten steps to writing software for hardware in the
development phase.

(1)  Get the hardware people to define their interface chips.
(2)  Get the hardware people to define their register maps.
(3)  Get the hardware people to define the function of the entire board.
(4)  Get the hardware people to sign off on a written document.
(5)  Write an interface specification (API to driver).
(6)  Write some test-code to that API.
(7)  Write a driver that interfaces with the API and pretends to
      interface with the hardware. Make damn sure that runs first.
      The hardware is emulated with some address-space that your
      driver allocated.
(8)  Write some kind of "debugger/monitor" that allows a user,
      from a user program, to read and write hardware registers
      of the target device through your driver. If you do this
      for a living, use the same program you wrote years ago for
      your first driver (with any new functionality you might need
      for the present one). Leave that new functionality for the
      next project.
(9)  Replace stubs in the emulator code with real functioning
      code. In the absence of hardware, make sure that nothing
      ever "waits forever". Good drivers will work with bad and
      even non-existent hardware. To a driver, a hardware error
      is just an event, handled just like any other kind of event.
      There cannot be any "fatal" errors in drivers.
(10) When the hardware arrives, help debug it with your ready-
      made debugger/monitor after you have gotten the interface
      code to work (PCI perhaps). You will have the opportunity to
      fix bugs in your driver while getting credit for fixing
      hardware, perhaps FPGA, bugs.

The first 5 paragraphs are the hardest. Hardware Engineers often
don't like to commit themselves to anything as specific as a
register map. Sometimes you have to force them to do this work
because certain hardware engineers are used to blaming a late
or non-working project on "software". This gives them time
to fix the broken hardware while pointing fingers at some other
department.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.51 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
