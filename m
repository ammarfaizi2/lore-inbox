Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVABAW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVABAW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 19:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVABAW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 19:22:27 -0500
Received: from banana.active-ns.com ([213.230.202.60]:45760 "EHLO
	banana.catalyst2.com") by vger.kernel.org with ESMTP
	id S261204AbVABAWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 19:22:16 -0500
Message-ID: <41D73EBE.1040808@linuxmod.co.uk>
Date: Sun, 02 Jan 2005 00:22:22 +0000
From: Joel Cant <lkml@linuxmod.co.uk>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Promise 20269 (Rev 02) IDE controller
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - banana.catalyst2.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxmod.co.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a rev 02 promise IDE controller that keeps throwing errors under 
load, reading seems ok, but writing to disk seems to do something awful 
to it

Kernel version 2.6.10 with Alans ac2 patch (Nice set of patches by the way)

lspci -vv output

03:01.0 Unknown mass storage controller: Promise Technology, Inc. 20269 
(rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc. Ultra133TX2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 4500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 28
        Region 0: I/O ports at bc00 [size=8]
        Region 1: I/O ports at b880 [size=4]
        Region 2: I/O ports at b800 [size=8]
        Region 3: I/O ports at b480 [size=4]
        Region 4: I/O ports at b400 [size=16]
        Region 5: Memory at feafc000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at feaf8000 [disabled] [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

lspci for the rest of the system

00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge 
(rev 12)
00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge 
(rev 12)
00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
01:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
01:08.0 SCSI storage controller: Advanced System Products, Inc ABP940-U 
/ ABP960-U (rev 03)
01:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 30)
02:04.0 Unknown mass storage controller: Integrated Technology Express, 
Inc.: Unknown device 8212 (rev 11)
03:01.0 Unknown mass storage controller: Promise Technology, Inc. 20269 
(rev 02)
03:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 
Gigabit Ethernet (rev 03)
03:02.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 
Gigabit Ethernet (rev 03)

Dual opteron 244's with 1gb ram

The error spewed out is

Jan  1 22:25:16 aries kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 22:25:26 aries kernel: hdh: lost interrupt
Jan  1 22:25:26 aries kernel: PDC202XX: Primary channel reset.
Jan  1 22:25:26 aries kernel: hde: DMA interrupt recovery
Jan  1 22:25:26 aries kernel: hde: lost interrupt
Jan  1 22:25:46 aries kernel: hde: dma_timer_expiry: dma status == 0x64
Jan  1 22:25:56 aries kernel: hdh: lost interrupt
Jan  1 22:25:56 aries kernel: PDC202XX: Primary channel reset.
Jan  1 22:25:56 aries kernel: hde: DMA interrupt recovery
Jan  1 22:25:56 aries kernel: hde: lost interrupt

does it on both channels whenever there is a high load, I've had a look 
through on ye olde google, but all i can find is a patch relating to 
2.6.7 ide-probe.c and seems that patch has filtered into 2.6.10 or the 
-ac patches.

Any help or reoloutions to this would be fantastic, the promise 
controller is more reliable than my ITE one, and dont really want to 
have to use that one if i can help it. I might even be able to sort out 
a controller for someone to have play with if it might help

Thanks

Joel







