Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbRDFCBH>; Thu, 5 Apr 2001 22:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130791AbRDFCA5>; Thu, 5 Apr 2001 22:00:57 -0400
Received: from sm10.texas.rr.com ([24.93.35.222]:10150 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S130552AbRDFCAs>;
	Thu, 5 Apr 2001 22:00:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@austin.rr.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2-ac18 Severworks AGP
Date: Thu, 5 Apr 2001 20:02:29 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01040520022900.00762@bozo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Tyan S1867 (Server Set III HE) for which I'd like to have AGP 
support.  Here's the relevant output of lspci -v :

00:00.0 Host bridge: ServerWorks CNB20HE (rev 22)
	Flags: fast devsel
	Memory at fa000000 (32-bit, prefetchable) [disabled] [size=32M]
	Memory at feafb000 (32-bit, non-prefetchable) [disabled] [size=4K]

00:00.1 PCI bridge: ServerWorks CNB20HE (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: fd000000-fdffffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	Capabilities: [80] AGP version 2.0
    ...
    ...
    ...
01:00.0 VGA compatible controller: nVidia Corporation NV15 Bladerunner 
(Geforce2 GTS) (rev a4) (prog-if 00 [VGA])
	Subsystem: Elsa AG: Unknown device 0c56
	Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 17
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
	Capabilities: [44] AGP version 2.0

The first thing to be noted is that the Capabilities Pointer for this chipset 
is on the AGP bridge not on the Host bridge like it is for currently 
supported chips. If I change the line

	if ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8, NULL)) == NULL)

to
	if ((dev = pci_find_class(PCI_CLASS_BRIDGE_PCI << 8, NULL)) == NULL)

in the agp_find_supported_device routine then I am able to load the patched 
agpgart module. But, unfortunately, it is clear that the intel_generic setup 
routines won't work.  Eg, intel_fetch_size returns 256 MB no matter what I 
have the aperture set to in the BIOS.

Just poking around I notice that the byte at 0x8c changes from 
1,3,5,7,9,11,13 as I change the aperture to 32,64,128,.256,512,1G,2G.

Does anyone have the relevant documentation for the ServerWorks AGP 
configuration registers?

Thanks,
Marvin
