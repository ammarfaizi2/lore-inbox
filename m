Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbUA3UBu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 15:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUA3UBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 15:01:39 -0500
Received: from spf13.us4.outblaze.com ([205.158.62.67]:16535 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S264285AbUA3UAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 15:00:46 -0500
Message-ID: <20040130200043.1249.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "claudiu b" <xstorm@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 31 Jan 2004 04:00:41 +0800
Subject: PROBLEM : Reporting a kernel bug with APM
X-Originating-Ip: 81.196.186.174
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Summary : X server hangs randomly, because of power related issues.

2. Full description : 
 Before, with Kernel 2.4.22, my X server would randomly hang, and I would have to reboot the system.
This happened pretty often, in about 10-20 minutes of starting the X server.
 I modprobed apm at startup, and the problem dissapeared.

 Now I am using Kernel 2.6.1 stable, and with ACPI enabled it crashes. So I disabled ACPI and enabled APM (*) built in, and random crashes in X would still happen. Then I triend APM as a module, modprobed it at startup, and it still crashes...

3. My output of sh scripts/ver_linux :
----------------------------------------------
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux pacifier 2.6.1 #5 Fri Jan 30 10:50:54 GMT+2 2004 i686 unknown unknown GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.14
e2fsprogs              1.34
jfsutils               1.1.3
xfsprogs               2.5.6
pcmcia-cs              3.2.5
quota-tools            3.09.
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.3
Procps                 2.0.16
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         iptable_mangle iptable_nat ipt_REJECT ipt_limit ipt_state ip_conntrack ipt_LOG ipt_ULOG iptable_filter ip_tables snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd soundcore fglrx intel_agp sk98lin apm agpgart
------------------------------------------------
4. I am using :
a) Software : 
Slackware 9.1
KDE 3.1.4
ATI driver from www.ati.com version 3.7.0 which has module "fglrx" and configures X through fglrxconfig
The intel-agp module from the 2.6.1 kernel
b) Hardware
Intel Pentium 4 2400Mhz Hyper-Threading
ASUS P4P800 deluxe motherboard 
512 MB DDRAM Dual Channel
Seagate 80GB ATA 100 HDD

5. Output of lspci -vvv :
00:00.0 Host bridge: Intel Corp.: Unknown device 2570 (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 80f2
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [e4] #09 [2106]
        Capabilities: [a0] AGP version 3.0
                Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x8

00:01.0 PCI bridge: Intel Corp.: Unknown device 2571 (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fe900000-fe9fffff
        Prefetchable memory behind bridge: cff00000-efefffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp.: Unknown device 24d2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 4: I/O ports at ef00 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 24d4 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at ef20 [size=32]

00:1d.2 USB Controller: Intel Corp.: Unknown device 24d7 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 5
        Region 4: I/O ports at ef40 [size=32]

00:1d.3 USB Controller: Intel Corp.: Unknown device 24de (rev 02) (prog-if 00 [UHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 4: I/O ports at ef80 [size=32]

00:1d.7 USB Controller: Intel Corp.: Unknown device 24dd (rev 02) (prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev c2) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fea00000-feafffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24d0 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24db (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at fc00 [size=16]
        Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp.: Unknown device 24d3 (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 80a6
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 0400 [size=32]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R300 NE [Radeon 9700] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 (2000ns min), cache line size 04
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at fe9f0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at fe9c0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x8
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 Display controller: ATI Technologies Inc Radeon R300 [Radeon 9700] (Secondary)
        Subsystem: ATI Technologies Inc: Unknown device 0003
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 04
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at fe9e0000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 808a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns max), cache line size 04
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at feaff800 (32-bit, non-prefetchable) [size=2K]
        Region 1: I/O ports at dc00 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 Ethernet controller: 3Com Corporation: Unknown device 1700 (rev 12)
        Subsystem: Asustek Computer, Inc.: Unknown device 80eb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (5750ns min, 7750ns max), cache line size 04
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at feaf8000 (32-bit, non-prefetchable) [size=16K]
        Region 1: I/O ports at d800 [size=256]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data

02:0b.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
        Subsystem: Creative Labs: Unknown device 1007
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at df00 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0b.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 04)
        Subsystem: Creative Labs: Unknown device 0060
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: I/O ports at dfe0 [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0b.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04) (prog-if 10 [OHCI])
        Subsystem: Creative Labs SB Audigy FireWire Port
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max), cache line size 04
        Interrupt: pin B routed to IRQ 5
        Region 0: Memory at feaff000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at feaf4000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

-------------------------------------------------------------------------------------

-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
