Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265041AbUEYTMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbUEYTMn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265048AbUEYTMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:12:43 -0400
Received: from web41308.mail.yahoo.com ([66.218.93.57]:22635 "HELO
	web41308.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265041AbUEYTMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:12:36 -0400
Message-ID: <20040525191236.19533.qmail@web41308.mail.yahoo.com>
Date: Tue, 25 May 2004 12:12:36 -0700 (PDT)
From: gb <bakerg3@yahoo.com>
Reply-To: greg@bakers.org
Subject: 2.4.26 agpgart on Tyan K8W 32bit not working?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Howdy,

I'm using the generic 2.4.26 kernel on a Tyan K8W
(dual opteron) with 4GB of memory and an NV18GL
[Quadro4 NVS] graphics card.  The K8W BIOS version is
2.02 (1.02 also exhibits the same behavior).

On a 64bit kernel, the following is returned:

[greg@testpig3 greg]$ lspci
00:06.0 PCI bridge: Advanced Micro Devices [AMD]
AMD-8111 PCI (rev 07)
00:07.0 ISA bridge: Advanced Micro Devices [AMD]
AMD-8111 LPC (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD]
AMD-8111 IDE (rev 03)
00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111
SMBus 2.0 (rev 02)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111
ACPI (rev 05)
00:0a.0 PCI bridge: Advanced Micro Devices [AMD]
AMD-8131 PCI-X Bridge (rev 12)
00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131
PCI-X APIC (rev 01)
00:0b.0 PCI bridge: Advanced Micro Devices [AMD]
AMD-8131 PCI-X Bridge (rev 12)
00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131
PCI-X APIC (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
NorthBridge
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
NorthBridge
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
NorthBridge
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
NorthBridge
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8
NorthBridge
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8
NorthBridge
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8
NorthBridge
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8
NorthBridge
01:06.0 Multimedia audio controller: Creative Labs SB
Audigy (rev 03)
01:06.1 Input device controller: Creative Labs SB
Audigy MIDI/Game port (rev 03)
01:06.2 FireWire (IEEE 1394): Creative Labs SB Audigy
FireWire Port
02:09.0 Ethernet controller: Broadcom Corporation
NetXtreme BCM5703 Gigabit Ethernet (rev 02)
03:00.0 USB Controller: Advanced Micro Devices [AMD]
AMD-8111 USB (rev 0b)
03:00.1 USB Controller: Advanced Micro Devices [AMD]
AMD-8111 USB (rev 0b)
03:0b.0 RAID bus controller: CMD Technology Inc:
Unknown device 3114 (rev 02)
03:0c.0 FireWire (IEEE 1394): Texas Instruments
TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
04:00.0 Host bridge: Advanced Micro Devices [AMD]
AMD-8151 System Controller (rev 13)
04:01.0 PCI bridge: Advanced Micro Devices [AMD]
AMD-8151 AGP Bridge (rev 13)
05:00.0 VGA compatible controller: nVidia Corporation
NV18GL [Quadro4 NVS] (rev a2)
05:00.0 VGA compatible controller: nVidia Corporation
NV18GL [Quadro4 NVS] (rev a2)

[greg@testpig3 greg]$ dmesg | grep -i agp
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory:
9968M
agpgart: Detected AMD 8151 chipset
agpgart: AGP aperture is 256M @ 0xe0000000
PCI-DMA: Reserving 128MB of IOMMU area in the AGP
aperture
AGP: Found AGPv3 capable device at 5:0:0
AGP: Found AGPv3 capable device at 4:0:0
AGP: Found AGPv3 capable device at 5:0:0
AGP: Enough AGPv3 devices found, setting up...

On a 32-bit kernel, the following is returned:

[greg@profit linux]$ lspci
00:06.0 PCI bridge: Advanced Micro Devices [AMD]
AMD-8111 PCI (rev 07)
00:07.0 ISA bridge: Advanced Micro Devices [AMD]
AMD-8111 LPC (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD]
AMD-8111 IDE (rev 03)
00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111
SMBus 2.0 (rev 02)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111
ACPI (rev 05)
00:0a.0 PCI bridge: Advanced Micro Devices [AMD]
AMD-8131 PCI-X Bridge (rev 12)
00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131
PCI-X APIC (rev 01)
00:0b.0 PCI bridge: Advanced Micro Devices [AMD]
AMD-8131 PCI-X Bridge (rev 12)
00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131
PCI-X APIC (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
NorthBridge
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
NorthBridge
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
NorthBridge
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
NorthBridge
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8
NorthBridge
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8
NorthBridge
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8
NorthBridge
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8
NorthBridge
01:06.0 Multimedia audio controller: Creative Labs SB
Audigy (rev 04)
01:06.1 Input device controller: Creative Labs SB
Audigy MIDI/Game port (rev 04)
01:06.2 FireWire (IEEE 1394): Creative Labs SB Audigy
FireWire Port (rev 04)
02:09.0 Ethernet controller: Broadcom Corporation
NetXtreme BCM5703 Gigabit Ethernet (rev 02)
03:00.0 USB Controller: Advanced Micro Devices [AMD]
AMD-8111 USB (rev 0b)
03:00.1 USB Controller: Advanced Micro Devices [AMD]
AMD-8111 USB (rev 0b)
03:0b.0 RAID bus controller: CMD Technology Inc:
Unknown device 3114 (rev 02)
03:0c.0 FireWire (IEEE 1394): Texas Instruments
TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
05:00.0 VGA compatible controller: nVidia Corporation
NV18GL [Quadro4 NVS] (rev a2)

[greg@profit linux]$ dmesg | grep -i agp
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory:
3932M
agpgart: no supported devices found.
[drm:drm_init] *ERROR* Cannot initialize the agpgart
module.
0: NVRM: AGPGART: unable to retrieve symbol table

I have tried booting with:

kernel /vmlinuz-2.4.26-bangalore4-01 ro root=/dev/hda2
hdc=ide-scsi apm=power-off agp_try_unsupported=1



=====
How you doin? http://calendar.yahoo.com/bakerg3


	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
