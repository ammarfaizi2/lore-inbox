Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317261AbSHPTxV>; Fri, 16 Aug 2002 15:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318331AbSHPTxV>; Fri, 16 Aug 2002 15:53:21 -0400
Received: from calhau.terra.com.br ([200.176.3.20]:43428 "EHLO
	calhau.terra.com.br") by vger.kernel.org with ESMTP
	id <S317261AbSHPTxT>; Fri, 16 Aug 2002 15:53:19 -0400
Date: Fri, 16 Aug 2002 16:56:55 -0300
From: Christian Reis <kiko@async.com.br>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: eepro100@scyld.com, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: General network slowness on SIS 530 with eepro100
Message-ID: <20020816165655.A6238@blackjesus.async.com.br>
References: <20020813212923.L2219@blackjesus.async.com.br> <200208150844.g7F8iQp19827@Port.imtp.ilyichevsk.odessa.ua> <20020815162155.L30462@blackjesus.async.com.br> <200208160824.g7G8Ogp24070@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208160824.g7G8Ogp24070@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Fri, Aug 16, 2002 at 11:21:33AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 11:21:33AM -0200, Denis Vlasenko wrote:
> > > On 13 August 2002 22:29, Christian Reis wrote:
> > > > On tri, which is the referred SIS530 box, as you can see, for most runs
> > > > the CPU usage is just so much higher than minas, which has practically
> > > > the same setup: K6-500, old PCI (no AGP) board, eepro100 card. I'm
> > > > wondering if anybody has seen something like this before?
> 
> Network card?

Same type of network card in them them, swapped between them, no change.

> Motherboard? :-)
> BIOS? 8-)

Yes, it has to be something in there. But they are not the same brand,
and I've already updated the BIOS.

> Compare BIOS/chipset setup (lspci -vvvxxx)

Thanks for the suggestion. There are some items that differ between the
outputs, as you can see below. One thing that is suggestive is that
host bridge Control has I/O+ on problematic mobo, but I/O- on the normal
one. I'm not sure what this affects, though. (BTW, I have triple
checked, and there is no interrupt sharing going on).

I've got to a point where I need to understand a bit more about how
interrupts are handled by the hardware and kernel. 

I want to understand how it is possible for one network card in
motherboard A to generate thousands of interrupts more than the same
card in motherboard B for the same amount of net traffic. How does the
kernel (or card?) schedule or postpone (batch?) the interrupts?

Host bridge, Motherboard A (problematic):

    00:00.0 Host bridge: Silicon Integrated Systems [SiS] 530 Host (rev 02) 
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
            ParErr- Stepping- SERR- FastB2B- 
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
            <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32 
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0
            Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2 
            Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
    00: 39 10 30 05 07 00 10 22 02 00 00 06 00 20 80 00
    10: 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
    20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
    40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    50: 90 98 e0 00 00 0d b2 00 50 00 00 00 00 18 00 00
    60: 26 06 06 67 00 00 00 00 c0 00 00 00 00 00 00 00
    70: cc 80 00 00 88 88 88 00 00 00 00 00 00 00 00 00
    80: 00 00 80 03 60 00 03 44 00 10 7b 00 48 00 00 00
    90: 00 00 00 00 40 00 00 01 00 00 00 00 00 00 00 00
    a0: 40 40 80 00 00 00 00 00 00 00 00 00 00 00 00 00
    b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    c0: 02 00 20 00 03 02 00 1f 00 00 00 00 00 00 00 00
    d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Host bridge, Motherboard B (normal):

    00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
        Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+
            AGP System Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
            ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
            <TAbort- <MAbort+ >SERR- <PERR- 
        Latency: 64 
        Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=256M]
        Capabilities: [b0] AGP version 1.0
            Status: RQ=28 SBA+ 64bit- FW- Rate=x1,x2
            Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none> 
    00: b9 10 41 15 06 00 10 24 04 00 00 06 00 40 00 00
    10: 00 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
    20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 41 15
    30: 00 00 00 00 b0 00 00 00 00 00 00 00 00 00 00 00
    40: 13 04 81 75 00 01 00 06 09 ef a0 5c 00 00 ff ff
    50: 00 f0 00 cc 00 05 07 ff 00 00 00 00 00 00 08 00
    60: 00 00 00 00 00 00 00 00 7f b0 ff b0 ff 00 ff 00
    70: 00 30 46 02 00 00 00 00 00 00 00 00 00 00 00 00
    80: 00 00 00 00 0f c8 07 1e ea 20 20 00 00 4b 42 32
    90: 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    b0: 02 00 10 00 03 02 00 1c 00 00 00 00 0a 00 00 00
    c0: 90 00 fd df 00 00 00 00 bf 4a 00 00 00 00 00 10
    d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    e0: 01 00 01 00 00 00 00 00 00 00 00 00 38 11 0c 29
    f0: 00 00 00 08 00 90 95 03 00 00 00 00 00 00 00 00

Ethernet controller, Motherboard A (problematic):

    00:0b.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100]
            (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
            ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
            <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at c7800000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at d800 [size=64]
        Region 2: Memory at c7000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
            Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
                PME(D0+,D1+,D2+,D3hot+,D3cold-)
            Status: D0 PME-Enable- DSel=0 DScale=2 PME-
    00: 86 80 29 12 17 00 90 02 08 00 00 02 08 20 00 00
    10: 00 00 80 c7 01 d8 00 00 00 00 00 c7 00 00 00 00
    20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 0c 00
    30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 08 38
    40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 7e
    e0: 00 40 00 3a 00 00 00 00 00 00 00 00 00 00 00 00
    f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Ethernet controller, Motherboard B (normal):

    00:0b.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
            ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
            <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at de800000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at a400 [size=64]
        Region 2: Memory at de000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
            Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
                PME(D0+,D1+,D2+,D3hot+,D3cold+)
            Status: D0 PME-Enable- DSel=0 DScale=2 PME-
    00: 86 80 29 12 17 00 90 02 08 00 00 02 08 20 00 00
    10: 00 00 80 de 01 a4 00 00 00 00 00 de 00 00 00 00
    20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 0c 00
    30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 08 38
    40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 fe
    e0: 00 40 00 3a 00 00 00 00 00 00 00 00 00 00 00 00
    f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
