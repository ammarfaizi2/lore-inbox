Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbULROSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbULROSj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 09:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbULROSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 09:18:39 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:25473 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261153AbULRORu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 09:17:50 -0500
Message-ID: <41C43C0D.9000005@ribosome.natur.cuni.cz>
Date: Sat, 18 Dec 2004 15:17:49 +0100
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20041217
X-Accept-Language: cs, en, en-us
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Regression: misdetected PCMCIA KW-7004 in 2.4.29-pre2
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I'm testing 2.4.29-pre2 kernel on my ASUS L3800C laptop.
I have already managed to hit several bugs, this is one of them.
Please Cc: me in replies. Thanks.

When booting the system, I get sometimes:


=======================================================================================
1)

cs: cb_alloc(bus 4): vendor 0x10b9, device 0x5237
PCI: Enabling device 04:00.0 (0000 -> 0002)
PCI: Enabling device 04:00.1 (0000 -> 0002)
PCI: Enabling device 04:00.2 (0000 -> 0002)
PCI: Enabling device 04:00.3 (0000 -> 0002)
PCI: Enabling device 04:00.4 (0000 -> 0002)
ohci1394_1: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[41003800-41003fff]  Max Packet=[2048]
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (ohci1394)







=======================================================================================
2)
or I get:

cs: cb_alloc(bus 4): vendor 0x0000, device 0x5237
PCI: device 04:00.0 has unknown header type 37, ignoring.

together with:

# lspci
0000:00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
0000:00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)
0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 Mobile PCI Bridge (rev 42)
0000:00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio Controller (rev 02)
0000:00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 02)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]
0000:02:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:02:07.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
0000:02:07.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
0000:02:07.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
0000:04:00.0 USB Controller: Gammagraphx, Inc.: Unknown device 0000 (rev 03)


=======================================================================================
3)
or I get:

cs: cb_alloc(bus 4): vendor 0x10b9, device 0x5237
PCI: Enabling device 04:00.0 (0000 -> 0002)
PCI: Enabling device 04:00.1 (0000 -> 0002)
PCI: Enabling device 04:00.2 (0000 -> 0002)
PCI: Enabling device 04:00.3 (0000 -> 0002)
PCI: Enabling device 04:00.4 (0000 -> 0002)
PCI: Setting latency timer of device 04:00.4 to 64
ohci1394_1: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[41003800-41003fff]  Max Packet=[2048]
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (ohci1394)
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0090e60000001271]

together with:

# lspci
0000:00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
0000:00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)
0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 Mobile PCI Bridge (rev 42)
0000:00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio Controller (rev 02)
0000:00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 02)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]
0000:02:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:02:07.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
0000:02:07.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev a8)
0000:02:07.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
0000:04:00.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
0000:04:00.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
0000:04:00.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
0000:04:00.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01)
0000:04:00.4 FireWire (IEEE 1394): ALi Corporation M5253 P1394 OHCI 1.1 Controller

I believe the last one is correct (i.e. ALi Corporation chips are used on this PCMCIA
card).


At least once all those 5 PCI devices 04:00.0 - 04:00.4 were detected as Gammagraphx,
so like in 2). At least if 1 or all 5 devices get detected as from Gammagraphx,
removing the PCMCIA card from the slot results in kernel oops:

Oops: 0002
CPU:    0
EIP:    0010:[<fbd54b4a>]    Not tainted
EFLAGS: 00010286
eax: 00000001   ebx: c0489f80   ecx: f789bcdc   edx: 00000020
esi: 00000000   edi: f7891e00   ebp: c0489f04   esp: c0489ee8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0489000)
Stack: 00000042 00000046 00007c98 f75e0000 f7891e00 c0489f80 c0489f80 c0489f1c 
       fbd56bfc f7891e00 c0489f80 f7891e64 00000001 c0489f34 c030a659 f7891e00 
       c0489f80 f5153364 04000001 c0489f54 c0108768 0000000b f7891e64 c0489f80 
Call Trace:    [<fbd56bfc>] [<c030a659>] [<c0108768>] [<c0108943>] [<c010ad78>]
  [<c0262e17>] [<c0262d24>] [<c0262d24>] [<c01053c2>] [<c0105000>]

Code: c6 46 64 03 c7 46 48 00 00 00 00 89 74 24 04 89 3c 24 e8 df 
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

I cannot resolve the stack as the machine is totally locked up,
only holding PWR button for 5 seconds helps.




----------------------------------------------------------------------------------------
Removing and re-plugging in the card does sometimes (instead of locking up the computer):

cs: cb_free(bus 4)
cs: cb_alloc(bus 4): vendor 0x10b9, device 0x5237
PCI: Enabling device 04:00.0 (0000 -> 0002)
PCI: Enabling device 04:00.1 (0000 -> 0002)
PCI: Enabling device 04:00.2 (0000 -> 0002)
PCI: Enabling device 04:00.3 (0000 -> 0002)
PCI: Enabling device 04:00.4 (0000 -> 0002)
PCI: Setting latency timer of device 04:00.4 to 64
ohci1394_1: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[41003800-41003fff]  Max Packet=[2048]
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (ohci1394)
ohci1394_1: SelfID received, but NodeID invalid (probably new bus reset occurred): 00000020




The output below I believe should be taken as correct and standard, although obtained
during one of those many differently behaving bootups of 2.4.29-pre2:

0000:04:00.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 41000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:04:00.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 41001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:04:00.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 41002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:04:00.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: ALi Corporation: Unknown device 5272
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 41003000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+
        Capabilities: [58] #0a [2090]

0000:04:00.4 FireWire (IEEE 1394): ALi Corporation M5253 P1394 OHCI 1.1 Controller (prog-if 10 [OHCI])
        Subsystem: ALi Corporation M5253 P1394 OHCI 1.1 Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns max)
        Interrupt: pin C routed to IRQ 11
        Region 0: Memory at 41003800 (32-bit, non-prefetchable) [size=2K]
        Expansion ROM at 40c00000 [size=64K]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

Actually, more on this hardware from other kernel releases:
http://bugzilla.kernel.org/attachment.cgi?id=1893&action=view
http://bugzilla.kernel.org/attachment.cgi?id=1892&action=view
http://bugzilla.kernel.org/show_bug.cgi?id=1904
