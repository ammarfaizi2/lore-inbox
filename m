Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271579AbRHUHYZ>; Tue, 21 Aug 2001 03:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271580AbRHUHYP>; Tue, 21 Aug 2001 03:24:15 -0400
Received: from [61.11.40.89] ([61.11.40.89]:43427 "EHLO slashetc.net")
	by vger.kernel.org with ESMTP id <S271579AbRHUHX7>;
	Tue, 21 Aug 2001 03:23:59 -0400
Date: Tue, 21 Aug 2001 12:44:22 +0530
From: Chirag Kantharia <chyrag@yahoo.com>
To: "Victoria W." <wicki@terror.de>
Cc: linux-kernel@vger.kernel.org, kollektive-linux@lists.sourceforge.net
Subject: Re: agpgart.o and intel i810-chipset
Message-ID: <20010821124422.A1313@epigonaudio.com>
Reply-To: Chirag Kantharia <chyrag@yahoo.com>
In-Reply-To: <Pine.LNX.4.10.10108210734370.27906-100000@csb.terror.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10108210734370.27906-100000@csb.terror.de>; from wicki@terror.de on Tue, Aug 21, 2001 at 07:59:43AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2001 at 07:59:43AM +0200, Victoria W. wrote:
| 00:00.0 Host bridge: Intel Corporation: Unknown device 7124 (rev 03)
| 00:01.0 VGA compatible controller: Intel Corporation: Unknown device 7125
| (rev 03)
<snip>
| In the driver, there is no case-statement for 
| "PCI_DEVICE_ID_INTEL_810_E_1" like the
| one for "PCI_DEVICE_ID_INTEL_810_E_0" but the one for "810_E_0" searches
| for "PCI_DEVICE_ID_INTEL_810_E_1".
| 
|                 case PCI_DEVICE_ID_INTEL_810_E_0:
|                         i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
|                                              PCI_DEVICE_ID_INTEL_810_E_1,
|                                                    NULL);

The i810 chipset has two devices (host bridge and the vga controller).
PCI..E_0 stands for the first and the ..E_1 stands for the second.
Device ID for the second is +1 the first one. In your case, 0x7124 is
the first device id (PCI_DEVICE_ID_INTEL_810_E_0) and 0x7125 is the
second device id (PCI_DEVICE_ID_INTEL_810_E_1).

| Is here anybody who has an i810-chipset with a working agpgart-driver?

I've a i810 chipset based motherboard and I haven't had problems with
agpgart. The following is output of dmesg | grep -i agp on my box:

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 93M
agpgart: Detected an Intel i810 Chipset.
agpgart: AGP aperture is 64M @ 0xd8000000
[drm] AGP 0.99 on Intel i810 @ 0xd8000000 64MB


| Please send me an "lspci-listing" an the messages while loading the
| driver. I want to find out the difference to my chipset.

IMO, agpgart doesn't have any problems as such with i810 chipset. i810,
sure has problems with framebuffer support. The kernel as of now,
supports only 16 color framebuffer. Kollektive project
(sourceforge.net/projects/kollektive) has developed support for 16 bit
color (64k colors) framebuffer for i810 chipset based motherboards.

The following is output of lspci -v on my box.

00:00.0 Host bridge: Intel Corporation 82810 GMCH [Graphics Memory Controller Hub] (rev 03)
	Subsystem: Intel Corporation 82810 GMCH [Graphics Memory Controller Hub]
	Flags: bus master, fast devsel, latency 0

00:01.0 VGA compatible controller: Intel Corporation 82810 CGC [Chipset Graphics Controller] (rev 03) (prog-if 00 [VGA])
	Subsystem: Intel Corporation 82810 CGC [Chipset Graphics Controller]
	Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 11
	Memory at d8000000 (32-bit, prefetchable) [size=64M]
	Memory at de000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: dc000000-ddffffff

00:1f.0 ISA bridge: Intel Corporation 82801AA ISA Bridge (LPC) (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corporation 82801AA IDE
	Flags: bus master, medium devsel, latency 0
	I/O ports at f000 [size=16]

00:1f.5 Multimedia audio controller: Intel Corporation 82801AA AC'97 Audio (rev 02)
	Subsystem: Analog Devices SoundMAX Integrated Digital Audio
	Flags: bus master, medium devsel, latency 0, IRQ 5
	I/O ports at d800 [size=256]
	I/O ports at dc00 [size=64]

01:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at c000 [size=256]
	Memory at dd301000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

01:0a.0 Multimedia controller: Wipro Infotech Limited: Unknown device 4546
	Subsystem: PLX Technology, Inc.: Unknown device 9054
	Flags: bus master, medium devsel, latency 32, IRQ 9
	Memory at dd300000 (32-bit, non-prefetchable) [size=256]
	I/O ports at c400 [size=256]
	Memory at dd000000 (32-bit, non-prefetchable) [size=2M]
	Memory at dd200000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at dc000000 [disabled] [size=2K]
	Capabilities: <available only to root>

chyrag.
-- 
Chirag Kantharia, chyrag.dhs.org/

