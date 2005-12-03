Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVLCQy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVLCQy5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 11:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVLCQy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 11:54:57 -0500
Received: from mx1.rowland.org ([192.131.102.7]:47110 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751294AbVLCQy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 11:54:56 -0500
Date: Sat, 3 Dec 2005 11:54:52 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Patrizio Bassi <patrizio.bassi@gmail.com>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [BUG] 2.6.15-rc4-git1 ehci suspend regression
In-Reply-To: <4391553C.2060208@gmail.com>
Message-ID: <Pine.LNX.4.44L0.0512031145520.4924-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Dec 2005, Patrizio Bassi wrote:

> Yesterday i wrote i got all my suspend problems fixed in -rc3.
> 
> i tried -rc4-git1 and got another problem after suspend.
> 
> on resume, i can use no more che ehci device (pci usb card).
> on -rc3, after resume hotplug could reload device driver, while with rc4
> device is no more found, neither after unplug/replug.
> 
> infact lsusb shows:
> Bus 004 Device 001: ID 0000:0000
> Bus 003 Device 001: ID 0000:0000
> Bus 002 Device 001: ID 0000:0000
> Bus 001 Device 001: ID 0000:0000
> 
> i have to reboot (usb are built-in)
> and i can get:
> 
> Bus 004 Device 001: ID 0000:0000
> Bus 003 Device 001: ID 0000:0000
> Bus 002 Device 004: ID 0915:8000 GlobeSpan, Inc.
> Bus 002 Device 001: ID 0000:0000
> Bus 001 Device 001: ID 0000:0000
> 
> 
> this is a rc4 regression, i saw Greg posted some patches...
> 
> this is the dmesg:
> 
> 
> Stopping tasks: ===================|
> Freeing memory... done (4076 pages freed)
> ACPI: PCI interrupt for device 0000:00:0d.0 disabled
> ACPI: PCI interrupt for device 0000:00:0a.2 disabled
> ACPI: PCI interrupt for device 0000:00:0a.1 disabled
> ACPI: PCI interrupt for device 0000:00:0a.0 disabled
> ACPI: PCI interrupt for device 0000:00:09.0 disabled
> ACPI: PCI interrupt for device 0000:00:04.2 disabled
> swsusp: Need to copy 7852 pages
> ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKD] -> GSI 9 (level, low)
> -> IRQ 9
> ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 9 (level, low)
> -> IRQ 9
> ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 9 (level, low)
> -> IRQ 9
> eth0: Setting promiscuous mode.
> ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 5 (level, low)
> -> IRQ 5
> ACPI: PCI Interrupt 0000:00:0a.1[B] -> Link [LNKD] -> GSI 9 (level, low)
> -> IRQ 9
> ACPI: PCI Interrupt 0000:00:0a.2[C] -> Link [LNKA] -> GSI 11 (level,
> low) -> IRQ 11
> ehci_hcd 0000:00:0a.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
> ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level,
> low) -> IRQ 10
> ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low)
> -> IRQ 9
> ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low)
> -> IRQ 9
> eth1: Setting promiscuous mode.
> Restarting tasks... done
> usb 2-2: new full speed USB device using uhci_hcd and address 3
> usb 2-2: device descriptor read/64, error -71
> usb 2-2: device descriptor read/64, error -71
> usb 2-2: new full speed USB device using uhci_hcd and address 4
> usb 2-2: device descriptor read/64, error -71
> usb 2-2: device descriptor read/64, error -71
> usb 2-2: new full speed USB device using uhci_hcd and address 5
> usb 2-2: device not accepting address 5, error -71
> usb 2-2: new full speed USB device using uhci_hcd and address 6
> usb 2-2: device not accepting address 6, error -71
> usb 2-2: new full speed USB device using uhci_hcd and address 7
> usb 2-2: device descriptor read/64, error -71
> usb 2-2: device descriptor read/64, error -71
> usb 2-2: new full speed USB device using uhci_hcd and address 8
> usb 2-2: device descriptor read/64, error -71
> usb 2-2: device descriptor read/64, error -71
> usb 2-2: new full speed USB device using uhci_hcd and address 9
> usb 2-2: device not accepting address 9, error -71
> usb 2-2: new full speed USB device using uhci_hcd and address 10
> usb 2-2: device not accepting address 10, error -71
> 
> lspci
> 00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host
> bridge (rev 03)
> 00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP
> bridge (rev 03)
> 00:04.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
> 00:04.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
> 00:04.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
> 00:04.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
> 00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
> (rev 30)
> 00:0a.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 50)
> 00:0a.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 50)
> 00:0a.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
> 00:0b.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
> 00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado]
> (rev 74)
> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF/SG AGP

This sounds a lot like a problem reported some time ago by Oliver Neukum.  
It seems as if there's something wrong with the way the EHCI controller 
manages the PORT_OWNER bit, or the way the internal hardware switch obeys 
it.

What happens if you plug the GlobeSpan device into a motherboard USB port 
instead of a port on the PCI card?

Alan Stern

