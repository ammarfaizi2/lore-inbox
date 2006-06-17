Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751672AbWFQP6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWFQP6r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 11:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbWFQP6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 11:58:47 -0400
Received: from mail2.flowline.co.uk ([195.112.4.54]:11272 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1751672AbWFQP6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 11:58:47 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Brice Goglin <brice@myri.com>
Subject: Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilities
Date: Sat, 17 Jun 2006 16:34:24 +0100
User-Agent: KMail/1.9.3
Cc: linux-pci@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
References: <4493709A.7050603@myri.com>
In-Reply-To: <4493709A.7050603@myri.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606171634.24270.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 June 2006 04:01, Brice Goglin wrote:
> Several chipsets are known to not support MSI. Some support MSI but
> disable it by default. Thus, several drivers implement their own way to
> detect whether MSI works.
>
> We introduce whitelisting of chipsets that are known to support MSI and
> keep the existing backlisting to disable MSI for other chipsets. When it
> is unknown whether the root chipset support MSI or not, we disable MSI
> by default except if pci=forcemsi was passed.

I tried your patch on 2.6.17-rc6 (fixed up a view rejects) in an attempt to 
get MSI working with my forcedeth NIC, which advertises the capability. The 
kernel now gives me the following:

PCI: Found MSI HT mapping on 0000:00:0b.0
PCI: Found MSI HT mapping on 0000:00:00.0
PCI: MSI quirk detected. PCI_BUS_FLAGS_MSI set for 0000:00:0b.0 subordinate 
bus.
PCI: Found MSI HT mapping on 0000:00:0c.0
PCI: Found MSI HT mapping on 0000:00:00.0
PCI: MSI quirk detected. PCI_BUS_FLAGS_MSI set for 0000:00:0c.0 subordinate 
bus.
PCI: Found MSI HT mapping on 0000:00:0d.0
PCI: Found MSI HT mapping on 0000:00:00.0
PCI: MSI quirk detected. PCI_BUS_FLAGS_MSI set for 0000:00:0d.0 subordinate 
bus.
PCI: Found MSI HT mapping on 0000:00:0e.0
PCI: Found MSI HT mapping on 0000:00:00.0
PCI: MSI quirk detected. PCI_BUS_FLAGS_MSI set for 0000:00:0e.0 subordinate 
bus.
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
Allocate Port Service[0000:00:0b.0:pcie03]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
Allocate Port Service[0000:00:0c.0:pcie03]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
Allocate Port Service[0000:00:0d.0:pcie03]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
Allocate Port Service[0000:00:0e.0:pcie03]

Is the "vendor BIOS" causing the problem? Here's my /proc/interrupts after 
booting.

           CPU0       CPU1
  0:     574494          0    IO-APIC-edge  timer
  8:          0          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 15:       4891          0    IO-APIC-edge  ide1
 50:          0          0   IO-APIC-level  NVidia CK804
 58:          4          0   IO-APIC-level  ehci_hcd:usb1
 66:       6203          0   IO-APIC-level  ohci1394, wlan
 74:          3          0   IO-APIC-level  ohci1394
217:      21315          0   IO-APIC-level  libata, ohci_hcd:usb2
225:       1031          0   IO-APIC-level  libata
233:      28124          0   IO-APIC-level  EMU10K1, skge
NMI:        171         90
LOC:     574330     574263
ERR:          0
MIS:          0

It's an x86-64 kernel.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
