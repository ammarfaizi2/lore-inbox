Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTKYCdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 21:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbTKYCdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 21:33:23 -0500
Received: from palrel13.hp.com ([156.153.255.238]:24744 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261901AbTKYCdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 21:33:20 -0500
Date: Mon, 24 Nov 2003 18:33:19 -0800
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Hinds <dhinds@sonic.net>, linux-pcmcia@lists.infradead.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Ricoh Cardbus -> Can't get interrupts
Message-ID: <20031125023319.GA3819@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20031124235727.GA2467@bougret.hpl.hp.com> <20031124162628.A32213@sonic.net> <20031125004942.GA3002@bougret.hpl.hp.com> <Pine.LNX.4.58.0311241804560.1599@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311241804560.1599@home.osdl.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 06:06:51PM -0800, Linus Torvalds wrote:
> 
> On Mon, 24 Nov 2003, Jean Tourrilhes wrote:
> >
> > 	This is a box from 1998, and the manual doesn't mention
> > anything about ACPI. I highly doubt it would support ACPI, but how do
> > I check that ?
> 
> Enable CONFIG_ACPI and CONFIG_ACPI_BOOT.

----------------------------------------------------
ACPI: Subsystem revision 20031002
ACPI: System description tables not found
    ACPI-0084: *** Error: acpi_load_tables: Could not get RSDP, AE_NOT_FOUND
    ACPI-0134: *** Error: acpi_load_tables: Could not load tables: AE_NOT_FOUND
ACPI: Unable to load the System Description Tables
----------------------------------------------------

> > 	Which in this case failed. I think all I need is to configure
> > cp_pci_irq to the proper value.
> 
> That may work, but it equally well might not. Quite often the irq routing
> actually has to physically connect the irq line (well, "physically" in
> this case is a matter of reprogramming the proper southbridge registers).

	In the case of the old Pcmcia package, there was a bunch of
options to take care of that, such as "cb_pci_irq". I didn't try yet
the old Pcmcia package to check if this option is working, because I
would need to recompile a kernel 2.4.X. But, if the old Pcmcia package
was able to do it, it's not impossible.

> 		Linus

	Currently, I managed to narrow down to :
-------------------------------------------------
PCI: Using IRQ router PIIX [8086/7110] at 0000:00:07.0
PCI: IRQ fixup
querying PCI -> IRQ mapping bus:0, slot:7, pin:3.
pin_2_irq idx:9, apic:0, pin:19.
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
querying PCI -> IRQ mapping bus:0, slot:8, pin:0.
pin_2_irq idx:16, apic:0, pin:16.
PCI->APIC IRQ transform: (B0,I8,P0) -> 16
querying PCI -> IRQ mapping bus:0, slot:17, pin:0.
pin_2_irq idx:19, apic:0, pin:18.
PCI->APIC IRQ transform: (B0,I17,P0) -> 18
querying PCI -> IRQ mapping bus:0, slot:18, pin:0.
pin_2_irq idx:20, apic:0, pin:16.
PCI->APIC IRQ transform: (B0,I18,P0) -> 16
querying PCI -> IRQ mapping bus:0, slot:19, pin:0.
querying PCI -> IRQ mapping bus:1, slot:0, pin:0.
pin_2_irq idx:21, apic:0, pin:18.
PCI->APIC IRQ transform: (B1,I0,P0) -> 18
querying PCI -> IRQ mapping bus:2, slot:4, pin:0.
pin_2_irq idx:17, apic:0, pin:17.
PCI->APIC IRQ transform: (B2,I4,P0) -> 17
querying PCI -> IRQ mapping bus:2, slot:5, pin:0.
pin_2_irq idx:18, apic:0, pin:18.
PCI->APIC IRQ transform: (B2,I5,P0) -> 18
-------------------------------------------------
	The Pcmcia bridge is in slot 19.

	Thanks a lot !

	Jean

