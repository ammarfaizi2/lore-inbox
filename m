Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268996AbRHCMX1>; Fri, 3 Aug 2001 08:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269000AbRHCMXS>; Fri, 3 Aug 2001 08:23:18 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:12416 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S268996AbRHCMXL>; Fri, 3 Aug 2001 08:23:11 -0400
Message-ID: <3B6A96D3.F5A394AA@randomlogic.com>
Date: Fri, 03 Aug 2001 05:19:31 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
CC: "kplug-list@kernel-panic.org" <kplug-list@kernel-panic.org>
Subject: Re: Dual Athlon, AGP, and PCI
In-Reply-To: <3B691B85.368D1BD0@randomlogic.com> <3B6939BA.30001@fugmann.dhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Alan - please read below for the IDs you requested)


Anders Peter Fugmann wrote:
> 

[SNIP]
> 
> I have an UP system with the AMD761 chipset.
> Agpgart is working here with NVidias driver. Its own agp-module makes
> the system crash hard. As for the FW and SBA, there must be something
> you have overlooked when reading Nvidias code. It is default disabled,
> but you can enable it with module the module parameters:
> 
> NVreg_EnableAGPFW=1

Will not work on my system, but I haven't spent a lot of time on it yet.

> NVreg_EnableAGPSBA=1

Works. I changed the default in the code to 1 to enable it all the time
(it can still be set to 0 [disabled] by setting it with insmod).

> 
> (try look in NVIDIA_kernel-1.0-1251/os-registry.c for more parameters)

I looked and saw nothing else that might help me out. I did quickly scan
the rest of the code and added the AMD-762 ID and description (BTW,
anyone know what the REAL name of the MP chips are? I used Irongate MP),
and changed the description for the GeForce ID to something more
meaningful, to produce the following:

[root@keroon /root]# cat /proc/nv/card0 
----- Driver Info ----- 
NVRM Version: 1.0-1251
------ Card Info ------
Model:        GeForce3 DDR
IRQ:          17
------ AGP Info -------
AGP status:   Enabled
AGP Driver:   AGPGART
Bridge:       AMD Irongate MP
SBA:          Supported [enabled]
FW:           Supported [disabled]
Rates:        4x 2x 1x  [4x]
Registers:    0x0f000217:0x00000304
[root@keroon /root]# 

I also managed to get it to work with the NVidia AGP driver (as opposed
to agpgart), but still without FW. I swear FW works on my A7V133 with
this same video card.



Alan,

   I created a new file - amd7411.c - based upon the previous file for
the AMD7409. I added IDs to pci_ids.h, pci.h, etc. in an effort to
support the different AMD devices. My kernel loads the AMD7411 driver
now, but does not enable DMA, etc., although using hdparm to enable
everything seems more reliable now.

Below is the output from lspci -vvv and lspci -x for my system as it
sits now. (Hmmm, looking at it I think I mis-named a couple of the
devices. Oh well - too much work, too little sleep [thank you SirCam,
Code Red, et. al] :)


[root@keroon /root]# lspci -vvv | more
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-762 [Irongate MP]
System Controller (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at f0004000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at 1c30 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-766 [Irongate MP]
PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f2000000-f2ffffff
	Prefetchable memory behind bridge: f8000000-fc0fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-766 [Cobra MP] ISA
(rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-766 [Cobra MP]
IDE (rev 01) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-766 [Cobra MP] Bridge
(rev 01)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-


-------------------------


[root@keroon /root]# lspci -x | more
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-762 [Irongate MP]
System Controller (rev 11)
00: 22 10 0c 70 06 00 10 22 11 00 00 06 00 40 00 00
10: 08 00 00 f4 08 40 00 f0 31 1c 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-766 [Irongate MP]
PCI Bridge
00: 22 10 0d 70 07 00 20 02 00 00 04 06 00 63 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 44 f1 01 20 22
20: 00 f2 f0 f2 00 f8 00 fc 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 0c 00

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-766 [Cobra MP] ISA
(rev 02)00: 22 10 10 74 0f 00 00 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-766 [Cobra MP]
IDE (rev 01)
00: 22 10 11 74 05 00 00 02 01 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-766 [Cobra MP] Bridge
(rev 01)
00: 22 10 13 74 00 00 80 02 01 00 80 06 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

---------------------------------


PGA

--
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
