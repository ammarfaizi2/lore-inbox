Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263998AbUDFUhX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263999AbUDFUhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:37:22 -0400
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:7867 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S263998AbUDFUhE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:37:04 -0400
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: Dave Jones <davej@redhat.com>, Bjoern Michaelsen <bmichaelsen@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Date: Tue, 6 Apr 2004 22:37:02 +0200
User-Agent: KMail/1.6.1
References: <20040406031949.GA8351@lord.sinclair> <200404062206.38731.volker.hemmann@heim10.tu-clausthal.de> <20040406203122.GB1100@redhat.com>
In-Reply-To: <20040406203122.GB1100@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404062237.02210.volker.hemmann@heim10.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 06 April 2004 22:31, Dave Jones wrote:
> On Tue, Apr 06, 2004 at 10:06:38PM +0200, Hemmann, Volker Armin wrote:
>  >  static void __devinit sis_get_driver(struct agp_bridge_data *bridge)
>  >  {
>  > -       if (bridge->dev->device == PCI_DEVICE_ID_SI_648 ||
>  > -           bridge->dev->device == PCI_DEVICE_ID_SI_746) {
>  > -               if (agp_bridge->major_version == 3) {
>  > +        if (bridge->dev->device == PCI_DEVICE_ID_SI_648 ||
>  > +           bridge->dev->device == PCI_DEVICE_ID_SI_746) {
>  > +               if (agp_bridge->major_version == 3 &&
>  > agp_bridge->minor_version < 5) {
>  > +                       sis_driver.agp_enable=sis_648_enable;
>  > +               } else {
>
> Ah, a clue. lspci -vvv output please ?
>
> 		Dave


energy root # lspci -vvv
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 746 Host (rev 02)
        Subsystem: Unknown device 1849:0746
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, non-prefetchable)
        Capabilities: [c0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=3 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=3 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x8

0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SG86C202 (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=128
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: cdd00000-cfefffff
        Prefetchable memory behind bridge: bda00000-cdbfffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device 0963 
(rev 25)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at 0c00 [size=32]

0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] 
(prog-if 80 [Master])
        Subsystem: Unknown device 1849:5513
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Region 4: I/O ports at ff00 [size=16]

0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Unknown device 1849:7001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (20000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at cfffd000 (32-bit, non-prefetchable)

0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Unknown device 1849:7001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (20000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 21
        Region 0: Memory at cfffe000 (32-bit, non-prefetchable)

0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 
Controller (prog-if 20 [EHCI])
        Subsystem: Unknown device 1849:7001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (20000ns max)
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at cffff000 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 
10/100 Ethernet (rev 90)
        Subsystem: Unknown device 1849:8201
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (13000ns min, 2750ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at dc00 [size=fffe0000]
        Region 1: Memory at cfffc000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.0 Multimedia video controller: Brooktree Corporation Bt848 Video 
Capture (rev 12)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at cdcff000 (32-bit, prefetchable)

0000:00:0d.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 
10)
        Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at d800
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 
5200] (rev a1) (prog-if 00 [VGA])
        Subsystem: LeadTek Research Inc.: Unknown device 2967
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at ce000000 (32-bit, non-prefetchable) 
[size=cfee0000]
        Region 1: Memory at c0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x8

Glück Auf
Volker

-- 
Conclusions 
 In a straight-up fight, the Empire squashes the Federation like a bug. Even 
with its numerical advantage removed, the Empire would still squash the 
Federation like a bug. Accept it. -Michael Wong 
