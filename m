Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbUCRRxr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUCRRxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:53:47 -0500
Received: from mx2out.umbc.edu ([130.85.25.11]:4849 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id S262818AbUCRRxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:53:40 -0500
Date: Thu, 18 Mar 2004 12:53:37 -0500 (EST)
From: "Mustafa C. Kuscu" <Mustafa.Kuscu@umbc.edu>
X-X-Sender: kuscu1@linux3.gl.umbc.edu
To: linux-kernel@vger.kernel.org
Subject: (updated) irq assignment issue: TI 1410 + Serverworks 
In-Reply-To: <Pine.LNX.4.58L6.0403171932480.22647@linux2.gl.umbc.edu>
Message-ID: <Pine.LNX.4.58L6.0403181243140.30920@linux3.gl.umbc.edu>
References: <Pine.LNX.4.58L6.0403171932480.22647@linux2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AvMilter-Key: 1079632718:dc82d4f36e9aa1a096cac1573abb23e5
X-Avmilter: Message Skipped, too small
X-Processed-By: MilterMonkey Version 0.9 -- http://www.membrain.com/miltermonkey
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this a known issue with TI-1410 and the Serverworks chipset, on kernel
2.4?

The `lspci -vvv` for the bridge is as follows:
00:07.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 01)
        Subsystem: SCM Microsystems: Unknown device 3000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 20000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt-
PostWrite+
        16-bit legacy interface ports at 0001



I have a working TI-1410 on another machine, on IRQ3 (non-Serverworks
chipset):

01:01.0 CardBus bridge: Texas Instruments PCI1410 PC card
Cardbus Controller (rev 01)
        Subsystem: SCM Microsystems: Unknown device 3000
        Flags: bus master, medium devsel, latency 168, IRQ 3
        Memory at 1ff01000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 20000000-203ff000 (prefetchable)
        Memory window 1: 20400000-207ff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 0001


Earlier discussion on linux-pcmcia: (includes dmesg and
some relevant /var/log/messages output)
http://lists.infradead.org/pipermail/linux-pcmcia/2004-March/000583.html
http://lists.infradead.org/pipermail/linux-pcmcia/2004-March/000585.html

Thanks in advance!

Musty

On Wed, 17 Mar 2004, Mustafa C. Kuscu wrote:

> Dear all,
>
> Problem: A "Texas Instruments 1410" PCI-PCMCIA bridge is not being
> assigned any IRQ.
> Chipset: Serverworks
> Kernel: 2.4.20-30 (RH9-update), 2.4.25 (vanilla) -- neither assigns an IRQ
> Box: 2 Dell Poweredge 600SC
>
> [root@client1 root]# lspci
> 00:00.0 Host bridge: ServerWorks: Unknown device 0017 (rev 32)
> 00:00.1 Host bridge: ServerWorks: Unknown device 0017
> 00:02.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet
> Controller (rev 02)
> 00:07.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
> Controller (rev 01)
> 00:08.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> 00:0e.0 IDE interface: ServerWorks: Unknown device 0217 (rev a0)
> 00:0f.0 Host bridge: ServerWorks: Unknown device 0203 (rev a0)
> 00:0f.1 IDE interface: ServerWorks: Unknown device 0213 (rev a0)
> 00:0f.2 USB Controller: ServerWorks: Unknown device 0221 (rev 05)
> 00:0f.3 ISA bridge: ServerWorks: Unknown device 0227
>
>
> Another (almost) identical box without the TI bridge shows the following:
>
> [root@engr-84-251 root]# lspci
> 00:00.0 Host bridge: ServerWorks GCNB-LE Host Bridge (rev 32)
> 00:00.1 Host bridge: ServerWorks GCNB-LE Host Bridge
> 00:02.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet
> Controller (rev 02)
> 00:07.0 Ethernet controller: Netgear GA630 (rev 01)
> 00:08.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> 00:0e.0 IDE interface: ServerWorks: Unknown device 0217 (rev a0)
> 00:0f.0 Host bridge: ServerWorks CSB6 South Bridge (rev a0)
> 00:0f.1 IDE interface: ServerWorks CSB6 RAID/IDE Controller (rev a0)
> 00:0f.2 USB Controller: ServerWorks CSB6 OHCI USB Controller (rev 05)
> 00:0f.3 ISA bridge: ServerWorks GCLE-2 Host Bridge
>
>
> So far, I have tried
>   - kernels: 2.4.20 (redhat's latest) & 2.4.25
>   - kernel options: pci=biosirq apic=off
>
> The BIOS setup does *not* allow me to assign IRQ to the TI bridge. In the
> setup screen, only the USB controller and the integrated ethernet
> controller IRQs can be assigned.
>
> Any suggestions?
>
> Thanks,
>
>      Mustafa C. Kuscu
>      Computer Science and Electrical Engineering
>      University of Maryland, Baltimore County
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


     Mustafa C. Kuscu
     Computer Science and Electrical Engineering
     University of Maryland, Baltimore County

