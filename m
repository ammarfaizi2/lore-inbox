Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUITPjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUITPjZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 11:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266725AbUITPjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 11:39:25 -0400
Received: from ts.berklee.edu ([64.119.138.3]:60883 "EHLO snitch.dyndns.org")
	by vger.kernel.org with ESMTP id S266721AbUITPjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 11:39:22 -0400
Date: Mon, 20 Sep 2004 11:39:19 -0400
From: ckottk01@tufts.edu
To: linux-kernel@vger.kernel.org
Cc: ckottk01@tufts.edu
Subject: Sharp MM20 buggy ACPI BIOS
Message-ID: <20040920153919.GA8195@snitch.berklee.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I belive the Sharp Actius MM20 has a buggy BIOS, as the kernel can't seem
to get an irq for the ehci device.  ohci works fine.  I am currently using
kernel 2.6.8.1.

lspci gives:
0000:00:00.0 Host bridge: Transmeta Corporation: Unknown device 0060
0000:00:01.0 PCI bridge: Transmeta Corporation: Unknown device 0061
0000:00:02.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge
0000:00:03.0 ISA bridge: ALi Corporation M1563 HyperTransport South Bridge (rev 20)
0000:00:03.1 Bridge: ALi Corporation M7101 PMU
0000:00:04.0 Multimedia audio controller: ALi Corporation M5455 PCI AC-Link Controller Audio Device (rev 03)
0000:00:06.0 Network controller: Harris Semiconductor: Unknown device 3890 (rev 01)
0000:00:09.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 81)
0000:00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:00:0e.0 IDE interface: ALi Corporation M5229 IDE (rev c5)
0000:00:0f.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
0000:00:0f.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
0000:00:0f.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY

And here is the relevant portion of my dmesg:
...
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:0f.0: ALi Corporation USB 1.1 Controller
ohci_hcd 0000:00:0f.0: irq 5, pci mem e001d000
ohci_hcd 0000:00:0f.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:0f.1[B] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:0f.1: ALi Corporation USB 1.1 Controller (#2)
ohci_hcd 0000:00:0f.1: irq 5, pci mem e001f000
ohci_hcd 0000:00:0f.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
...
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 4 (level, low) -> IRQ 4
    ACPI-1133: *** Error: Method execution failed [\_SB_.PCI0.LPC_.LNKU._CRS] (Node de6141e0), AE_AML_UNINITIALIZED_LOCAL
    ACPI-0154: *** Error: Method execution failed [\_SB_.PCI0.LPC_.LNKU._CRS] (Node de6141e0), AE_AML_UNINITIALIZED_LOCAL
ACPI: Unable to set IRQ for PCI Interrupt Link [LNKU] (likely buggy ACPI BIOS).
Try pci=noacpi or acpi=off
ACPI: PCI interrupt 0000:00:0f.3[D]: no GSI
ehci_hcd 0000:00:0f.3: ALi Corporation USB 2.0 Controller
ehci_hcd 0000:00:0f.3: request interrupt 255 failed
ehci_hcd 0000:00:0f.3: init 0000:00:0f.3 fail, -22
ehci_hcd: probe of 0000:00:0f.3 failed with error -22
...

With pci=noacpi set, dmesg gives:
...
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
PCI: Found IRQ 5 for device 0000:00:0f.0
ohci_hcd 0000:00:0f.0: ALi Corporation USB 1.1 Controller
ohci_hcd 0000:00:0f.0: irq 5, pci mem e001d000
ohci_hcd 0000:00:0f.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 5 for device 0000:00:0f.1
ohci_hcd 0000:00:0f.1: ALi Corporation USB 1.1 Controller (#2)
ohci_hcd 0000:00:0f.1: irq 5, pci mem e001f000
ohci_hcd 0000:00:0f.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
...
PCI: No IRQ known for interrupt pin D of device 0000:00:0f.3. Please try using pci=biosirq.
ehci_hcd 0000:00:0f.3: Found HC with no IRQ.  Check BIOS/PCI 0000:00:0f.3 setup!...

Is there anything I can do to work around or fix this?

Thanks,
Chris Kottke
