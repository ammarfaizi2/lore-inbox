Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbVHPQxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbVHPQxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 12:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbVHPQxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 12:53:08 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:4997 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1030237AbVHPQxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 12:53:07 -0400
Subject: Re: [PATCH,RFC] quirks for VIA VT8237 southbridge
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200508160949.10607.bjorn.helgaas@hp.com>
References: <200508131710.38569.annabellesgarden@yahoo.de>
	 <200508151631.07717.bjorn.helgaas@hp.com>
	 <200508161726.14149.annabellesgarden@yahoo.de>
	 <200508160949.10607.bjorn.helgaas@hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Aug 2005 18:20:16 +0100
Message-Id: <1124212816.20707.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-16 at 09:49 -0600, Bjorn Helgaas wrote:
> On Tuesday 16 August 2005 9:26 am, Karsten Wiese wrote:
> > What about the following version?
> > quirk_via_686irq() only works on pci_devs that are part of the 686.
> > Sooner or later there'll be more VIA southbridge types, which will
> > not need quirk_via_irq() like the 8237.
> 
> Do you have VIA spec references to support this?  I had a quick
> look, but couldn't find anything specific about which VIA devices
> need the quirk and which don't.

PCI interrupt line routing is used for all V-Bus devices. Thats all
devices in any way on an internal bus of the north or south bridge. The
quirk is harmless when applied to other devices.

Note the description of the quirk is still wrong


> >  * For these devices, this register is defined to be 4 bits wide.
> >  * Normally this is fine.  However for IO-APIC motherboards, or
> >  * non-x86 architectures (yes Via exists on PPC among other places),
> >  * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
> >  * interrupts delivered properly.

The interrupt line field is used to indicate the ISA type IRQ or the
APIC pin used for the IRQ delivery. See the data sheet.

The & 0x0F is the old hack used to get the ISA type IRQ line in use from
the IRQ number. 

Alan

