Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316501AbSEUDwP>; Mon, 20 May 2002 23:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316502AbSEUDwO>; Mon, 20 May 2002 23:52:14 -0400
Received: from newmx1.fast.net ([209.92.1.31]:48010 "EHLO newmx1.fast.net")
	by vger.kernel.org with ESMTP id <S316501AbSEUDwN>;
	Mon, 20 May 2002 23:52:13 -0400
Date: Mon, 20 May 2002 23:53:51 -0400
Message-Id: <200205210353.g4L3rpk24320@op.net>
From: Paul Davis <pbd@op.net>
To: linux-kernel@vger.kernel.org
Subject: cardbus/pcmcia/pci bridge problems?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently wrote the ALSA driver for the RME Hammerfall DSP, a
high-end audio interface. The H-DSP comes in a variety of
configurations, one of them involving a "pure" PCI interface, the
other a PCMCIA card. The PCI interface works fine. Users with the
PCMCIA card report major problems, the most representative of which
are:

Case One (failure to make iomem available):
=========
>May 16 09:54:57 satellite kernel: cs: cb_alloc(bus 3): vendor 0x10ee, device 
>0x3fc5
>May 16 09:54:57 satellite kernel: PCI: Failed to allocate resource 
>0(d2400000-d20fffff) for 03:00.0
>May 16 09:54:57 satellite kernel: PCI: Enabling device 03:00.0 (0080 -> 0082)
>May 16 09:54:57 satellite cardmgr[258]: socket 0: CardBus hotplug device


Case Two (failure to allocate IRQ):
=========
>May 16 15:15:32 badass-bukvic kernel: PCI: Found IRQ 5 for device
>02:03.0
>May 16 15:15:33 badass-bukvic kernel: Hammerfall memory allocator:
>buffers allocated for 1 cards
>May 16 15:15:33 badass-bukvic kernel: PCI: No IRQ known for interrupt
>pin A of device . Please try using pci=biosirq.
>May 16 15:15:33 badass-bukvic kernel: PCI: Setting latency timer of
>device  to 64
>May 16 15:15:33 badass-bukvic kernel: ALSA
>../../alsa-kernel/pci/rme9652/hdsp.c:2984: unable to grab memory region
>0x0-0x1447

In both cases, the error comes from cardbus/pcmcia/pci code that runs
"below" and/or before the device driver itself.

The PCI profile of the device looks like:

----------------------------------------------------------------------
03:00.0 Multimedia audio controller: Xilinx, Inc.: Unknown device 3fc5 (rev 
0a)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: [virtual] Memory at d2400000 (32-bit, non-prefetchable)
----------------------------------------------------------------------

It appears to me that there may be some problems with the current
cardbus/pci bridge code in 2.4.X. can anyone with any involvement in
this code fill me in on how well it is thought to be working, and what
might give rise to either of the error cases shown above?

--p
