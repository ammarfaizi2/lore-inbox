Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161435AbWALXIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161435AbWALXIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161264AbWALXIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:08:49 -0500
Received: from igw2.zrnko.cz ([81.31.45.164]:23439 "EHLO anubis.fi.muni.cz")
	by vger.kernel.org with ESMTP id S1161435AbWALXIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:08:48 -0500
Date: Fri, 13 Jan 2006 00:08:35 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: ACPI Suspend-to-ram issues
Message-ID: <20060112230835.GC2961@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed (also thanks to discussion about DOS and NTFS) that suspend to ram
consumes a lot of battery power.
I'm using 2.6.15-git7 kernel now.

According to lspci I have:
0000:00:00.0 Host bridge
0000:00:01.0 PCI bridge
0000:00:02.0 VGA compatible controller (915GM)
0000:00:02.1 VGA compatible controller
0000:00:1b.0 High Definition Audio Controller 
0000:00:1d.0 USB Controller UHCI
0000:00:1d.1 USB Controller UHCI
0000:00:1d.2 USB Controller UHCI
0000:00:1d.3 USB Controller UHCI
0000:00:1d.7 USB Controller EHCI
0000:00:1e.0 PCI bridge
0000:00:1f.0 ISA bridge
0000:00:1f.1 IDE interface
0000:00:1f.3 SMBus Controller 
0000:01:00.0 Ethernet controller
0000:01:01.0 CardBus bridge
0000:01:01.1 FireWire (IEEE 1394)
0000:01:01.2 SD/SDIO/MMC/MS/MSPro
0000:01:01.3 Memory Stick Bus
0000:01:01.4 Ricoh Co Ltd xD-Picture Card Controller
0000:01:02.0 Network controller

I have modules for both USB1.1, USB2.0, sound card, dri, both ethernet
controllers, cardbus, and IEEE1394. 

In normal situation, I load modules for: DRI, sound, USB1, USB2, ethernet
cotroller. Suspend-to-ram takes 2.8W. 

If I boot using init=/bin/bash i.e. not using any module, then suspend-to-ram
takes 1.6W (which is still a lot, it should taky 0.7W approx).

I do not know, how PCI devices disabling works. Does message:
ACPI: PCI interrupt for device 0000:01:00.0 disabled
have additional meaning, that device 0000:01:00.0 went into D3 state?

However, I have these messages in dmesg (if usual modules are present):
ACPI: PCI interrupt for device 0000:01:00.0 disabled
ACPI: PCI interrupt for device 0000:00:1d.7 disabled
ACPI: PCI interrupt for device 0000:00:1d.3 disabled
ACPI: PCI interrupt for device 0000:00:1d.2 disabled
ACPI: PCI interrupt for device 0000:00:1d.1 disabled
ACPI: PCI interrupt for device 0000:00:1d.0 disabled
ACPI: PCI interrupt for device 0000:00:1b.0 disabled

So, it looks like IRQ is not disabled for graphic and IDE, cardbus, firewire,
card reader. Is this OK?

-- 
Luká¹ Hejtmánek
