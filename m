Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbUL1HaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbUL1HaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 02:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUL1H1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 02:27:55 -0500
Received: from alcazaba.unex.es ([158.49.151.6]:28122 "EHLO www.fcdyc.unex.es")
	by vger.kernel.org with ESMTP id S262119AbUL1HH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 02:07:57 -0500
Message-ID: <1104217668.41d10644a57f7@alcazaba.unex.es>
Date: Tue, 28 Dec 2004 08:07:48 +0100
From: Manuel Perez Ayala <mperaya@alcazaba.unex.es>
To: linux-kernel@vger.kernel.org
Subject: TG3 support broken on PPC (PowerMac G4)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-FCDyC-UEx-MailScanner: Found to be clean
X-MailScanner-From: mperaya@alcazaba.unex.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.6.8, I've noticed that the tigon3 support has problems on PPC machines.

I have a group of powerpc machines (PowerMac G4) whith an extra tigon3
compatible network card, a 3c996 from 3Com.

They are connected to a 3com Gigabit switch and with kernel version 2.6.7 they
are working fine.

Since 2.6.8, then 2.6.9 and now 2.6.10, they are not working as expected. They
lost connection, many times with this message

Disconnecting: Corrupted MAC on input.
lost connection

The keywords may be: modules, networking

afs02-i:/usr/src/linux# cat /proc/version
Linux version 2.6.10-rc3fcdyc-ppc (root@afs02-i) (gcc versión 3.3.4 (Debian
1:3.3.4-13)) #1 Fri Dec 24 08:46:32 CET 2004

I'm working with debian sarge and I've noticed this problem with kernel from
kernel.org and the debianized packages.
The machines are PowerMac G4 (Silver) with 256MB Ram, 733MHz Processor, no
cd-rom, a 3c996 Gigabit tigon3 compatible network card.

afs02-i:/usr/src/linux# ./scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux afs02-i 2.6.10-rc3fcdyc-ppc #1 Fri Dec 24 08:46:32 CET 2004 ppc GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15
util-linux             2.12
mount                  2.12
module-init-tools      3.1
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded

afs02-i:/usr/src/linux#  cat /proc/cpuinfo
processor       : 0
cpu             : 7450, altivec supported
clock           : 733MHz
revision        : 2.0 (pvr 8000 0200)
bogomips        : 729.08
machine         : PowerMac3,5
motherboard     : PowerMac3,5 MacRISC2 MacRISC Power Macintosh
detected as     : 69 (PowerMac G4 Silver)
pmac flags      : 00000000
L2 cache        : 256K unified
memory          : 256MB
pmac-generation : NewWorld

afs02-i:/usr/src/linux#  cat /proc/modules

No modules added, all compiled on kernel.

afs02-i:/usr/src/linux# cat /proc/ioport
00000000-007fffff : /pci@f2000000
00802000-01001fff : /pci@f0000000
ff7fe000-ffffdfff : /pci@f4000000

afs02-i:/usr/src/linux# cat /proc/iomem
80000000-8fffffff : /pci@f2000000
  80000000-8007ffff : 0001:10:17.0
    80000000-8007ffff : 0.80000000:mac-io
      80000050-8000007f : 0.00000050:gpio
      80008000-800080ff : 0.00010000:i2s
      80008100-800081ff : 0.00010000:i2s
      80008200-800082ff : 0.00010000:i2s
      80008300-800083ff : 0.00010000:i2s
      80008a00-80008aff : 0.0001f000:ata-4
        80008a00-80008aff : ide-pmac (dma)
      80008b00-80008bff : 0.00020000:ata-3
        80008b00-80008bff : ide-pmac (dma)
      80008c00-80008cff : 0.00021000:ata-3
        80008c00-80008cff : ide-pmac (dma)
      80010000-80010fff : 0.00010000:i2s
      80013000-80013000 : 0.00013000:ch-b
      80013010-80013010 : 0.00013000:ch-b
      80013020-80013020 : 0.00013020:ch-a
      80013030-80013030 : 0.00013020:ch-a
      80013040-80013040 : 0.00013000:ch-b
      80013050-80013050 : 0.00013020:ch-a
      80015000-80015fff : 0.00015000:timer
      80016000-80017fff : 0.00016000:via-pmu
        80016000-80017fff : via-pmu
      80018000-80018fff : 0.00018000:i2c
      8001f000-8001ffff : 0.0001f000:ata-4
        8001f000-8001ffff : ide-pmac (ports)
      80020000-80020fff : 0.00020000:ata-3
      80021000-80021fff : 0.00021000:ata-3
      80040000-8007ffff : interrupt-controller
        80040000-8007ffff : 0.00040000:interrup
  80080000-80080fff : 0001:10:19.0
    80080000-80080fff : ohci_hcd
  80081000-80081fff : 0001:10:18.0
    80081000-80081fff : ohci_hcd
  800a0000-800affff : 0001:10:13.0
    800a0000-800affff : tg3
90000000-afffffff : /pci@f0000000
  91000000-91ffffff : 0000:00:10.0
  98000000-9fffffff : 0000:00:10.0
    98004000-9807bfff : offb
f1000000-f1ffffff : /pci@f0000000
f3000000-f3ffffff : /pci@f2000000
f5000000-f5ffffff : /pci@f4000000
  f5000000-f5000fff : 0002:20:0e.0
  f5200000-f53fffff : 0002:20:0f.0
    f5200000-f53fffff : sungem
f8000000-f8ffffff : uni-n

afs02-i:/usr/src/linux# lspci -vvv
0000:00:0b.0 Host bridge: Apple Computer Inc. UniNorth 1.5 AGP
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 16, Cache Line Size: 0x08 (32 bytes)
        Capabilities: [80] AGP version 1.0
                Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>

0000:00:10.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX
400] (rev b2) (prog-if 00 [VGA])
        Subsystem: Unknown device 0208:a5b8
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 48
        Region 0: Memory at 91000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at 98000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at 90000000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans-
64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>

0001:10:0b.0 Host bridge: Apple Computer Inc. UniNorth 1.5 PCI
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 16, Cache Line Size: 0x08 (32 bytes)

0001:10:13.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5700 Gigabit
Ethernet (rev 12)
        Subsystem: 3Com Corporation 3C996-T 1000Base-T
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (16000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 53
        Region 0: Memory at 800a0000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at 80090000 [disabled] [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=255 Dev=31 Func=1 64bit+ 133MHz+ SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3
Enable-
                Address: 8f0876cac4ba924c  Data: 1a71

0001:10:17.0 ff00: Apple Computer Inc. KeyLargo Mac I/O (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16, Cache Line Size: 0x08 (32 bytes)
        Region 0: Memory at 80000000 (32-bit, non-prefetchable) [size=512K]

0001:10:18.0 USB Controller: Apple Computer Inc. KeyLargo USB (prog-if 10
[OHCI])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (750ns min, 21500ns max)
        Interrupt: pin A routed to IRQ 27
        Region 0: Memory at 80081000 (32-bit, non-prefetchable) [size=4K]

0001:10:19.0 USB Controller: Apple Computer Inc. KeyLargo USB (prog-if 10
[OHCI])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (750ns min, 21500ns max)
        Interrupt: pin A routed to IRQ 28
        Region 0: Memory at 80080000 (32-bit, non-prefetchable) [size=4K]

0002:20:0b.0 Host bridge: Apple Computer Inc. UniNorth 1.5 Internal PCI
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 16, Cache Line Size: 0x08 (32 bytes)

0002:20:0e.0 ffff: Lucent Microelectronics FW323 (rev ff) (prog-if ff)
        !!! Unknown header type 7f

0002:20:0f.0 Ethernet controller: Apple Computer Inc. UniNorth GMAC (Sun GEM)
(rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
        Latency: 16 (16000ns min, 16000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 41
        Region 0: Memory at f5200000 (32-bit, non-prefetchable) [size=2M]
        Expansion ROM at f5100000 [disabled] [size=1M]

afs02-i:/usr/src/linux# cat /proc/scsi/scsi
Attached devices:



----------
Manuel Perez Ayala
mperaya@alcazaba.unex.es
Facultad de Biblioteconomía y Documentación
Universidad de Extremadura
