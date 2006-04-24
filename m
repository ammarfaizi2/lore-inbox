Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWDXNJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWDXNJT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWDXNJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:09:19 -0400
Received: from spirit.analogic.com ([204.178.40.4]:25096 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750774AbWDXNJS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:09:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <9871ee5f0604211353p21f29e56gaeef61255ebae85d@mail.gmail.com>
X-OriginalArrivalTime: 24 Apr 2006 13:09:16.0773 (UTC) FILETIME=[4A6D1950:01C667A0]
Content-class: urn:content-classes:message
Subject: Re: HELP: Need to determine physical slot number of card in PCIe slot
Date: Mon, 24 Apr 2006 09:09:16 -0400
Message-ID: <Pine.LNX.4.61.0604240901540.23183@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HELP: Need to determine physical slot number of card in PCIe slot
thread-index: AcZnoEp0NbqbzlgtQvmWHSXD7060DQ==
References: <9871ee5f0604211353p21f29e56gaeef61255ebae85d@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Timothy Miller" <theosib@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Apr 2006, Timothy Miller wrote:

> I apologize if this is not the right place to ask this question.  I
> have done some googling around, and I have not found an answer to
> this, although I suspect I'm just not using the right search terms.
> Also, I'm not a member of this list, so please CC me if you reply.
>
> I have put together a diagnostic system for my employer using a
> stripped-down Gentoo system (2.6.15 kernel).  We're testing some PCIe
> cards on an ABIT IL8, which has four PCIe slots.  Since this is a test
> rig, when a card fails a test, we need to know which of the four slots
> the card is in.  When developing this, I had assumed that the PCI bus
> ID would be a function of the slot number, but apparently, it is not.
> We can put one card into any of the four slots, and we get the same
> bus ID.  If we put in four cards, we get a set of ID numbers that
> isn't sequential.
>
> I've poked around in /proc, without finding anything.  I found
> /sys/bus/pci_express, but it's really weird what I see, because it
> shows what appears to be some slots repeated and some missing, and
> also, there doesn't seem to be a way to associate the slot with the
> bus ID  (I assume pcie00 is slot zero).  Under /sys/bus/pci/devices, I
> do see the PCI bus ID of the cards in question, but I cannot figure
> out how to associate that with the slot number.  The directory
> /sys/bus/pci/slots is empty.
>
> Is there some reasonable way for me to be able to determine, given a
> bus ID, which physical slot the PCIe card is in?
>
> Note:  I am not using a kernel driver for these cards.  I'm using
> /dev/mem to map mmio, and I'm using libpci to access PCI config space.
> Everything works great (besides the slot number issue here).
>
> Thank you very much in advance for your help.
>
>
> --- Timothy Miller

PCI_SLOT(struct pci_dev *) is a macro defined in one of the headers.
Unfortunately, it will not uniquely define a board. Also, the slot number
itself has nothing to do with the physical machine because, upon
startup, the BIOS assigns "slots" in the order devices are found.

But, for a particular configuration, it is possible to uniquely
define a board as long as they don't get moved around! In one
of our devices, I do something like this and it has been good enough
for the service people to find a malfunctioning board.

slot = dev->bus->number << 8) | PCI_SLOT(dev->devfn);


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
