Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUARUg2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 15:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUARUg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 15:36:27 -0500
Received: from smtp.terra.es ([213.4.129.129]:17110 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id S263600AbUARUfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 15:35:05 -0500
Mime-Version: 1.0 (Apple Message framework v609)
Content-Transfer-Encoding: 7bit
Message-Id: <BAB7DAB2-49F5-11D8-9B47-000393CFF340@terra.es>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1--485888299"
To: linux-kernel@vger.kernel.org
From: Natalia Portillo <claunia@terra.es>
Subject: Bug report on UHCI driver.
Date: Sun, 18 Jan 2004 20:34:35 +0000
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.609)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-1--485888299
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Dear Kernel Developers.

This is the bug I'm getting with kernels 2.4.20-xfs-r3, 2.4.23-aa1 and 
2.6.0-test5 (hardware information at bottom).

It seems to be a problem of IRQ conflict.
USB works perfectly, but, suddenly, it stops working and dmesg starts 
saying (and doesn't stop until reboot) the following:
"drivers/usb/host/uhci-hcd.c: cc00: host controller halted. very bad"

It happens after a random working time. I observed this time is less if 
I remove the nVidia graphics card and substitute it for an 3Dfx one 
(the second one doesn't use an IRQ).
It also seems to happen faster in 2.4 kernels.

Regards,
Natalia Portillo

Hardware information:
Motherboard is an Elitegroups ECS K7S5A Pro 5.0 with the lastest 
available BIOS installed.
Installed cards are:
AGP -> nVidia GeForce 4 MX440
PCI0 -> Realtek RTL8139C (Mis detected in 2.4 kernels because IRQ 
conflict)
PCI1 -> Empty
PCI2 -> Matrox Mystique
PCI3 -> Empty
PCI4 -> Empty

It is a SiS chipset with USB 1.0, USB 2.0, network and sound 
integrated, and all enabled on BIOS.

/proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2000+
stepping        : 1
cpu MHz         : 1659.902
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3284.99

/proc/modules:
nvidia 1701100 - - Live 0xf8adf000
parport_pc 41260 - - Live 0xf8901000
lp 10592 - - Live 0xf885d000
parport 43520 - - Live 0xf88f5000
hid 25280 - - Live 0xf88d2000
uhci_hcd 33512 - - Live 0xf88dd000
ohci_hcd 30912 - - Live 0xf88c9000
ehci_hcd 36384 - - Live 0xf88bf000
usbcore 118900 - - Live 0xf88a0000
nls_iso8859_1 3808 - - Live 0xf8850000
nls_cp437 5440 - - Live 0xf883c000
vfat 15648 - - Live 0xf883f000
fat 47392 - - Live 0xf8870000
ide_tape 56048 - - Live 0xf8861000
st 38036 - - Live 0xf8845000

/proc/ioports:
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
c800-c81f : 0000:00:13.0
   c800-c81f : uhci-hcd
cc00-cc1f : 0000:00:13.1
   cc00-cc1f : uhci-hcd
d000-d0ff : 0000:00:09.0
   d000-d0ff : 8139too
d400-d4ff : 0000:00:03.0
   d400-d4ff : sis900
d800-d83f : 0000:00:02.7
   d800-d83f : SiS SI7012 - Controller
dc00-dcff : 0000:00:02.7
   dc00-dcff : SiS SI7012 - AC'97
ff00-ff0f : 0000:00:02.5
   ff00-ff07 : ide0
   ff08-ff0f : ide1

/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c8000-000cffff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
   00100000-003fa2d0 : Kernel code
   003fa2d1-004f053f : Kernel data
3fff0000-3fff7fff : ACPI Tables
3fff8000-3fffffff : ACPI Non-volatile Storage
bbc00000-cbcfffff : PCI Bus #01
   c0000000-c7ffffff : 0000:01:00.0
cc000000-cc7fffff : 0000:00:0d.0
cce00000-ceefffff : PCI Bus #01
   cd000000-cdffffff : 0000:01:00.0
cf000000-cf7fffff : 0000:00:0d.0
cfff8000-cfffbfff : 0000:00:0d.0
cfffc000-cfffcfff : 0000:00:03.0
   cfffc000-cfffcfff : sis900
cfffde00-cfffdeff : 0000:00:13.2
   cfffde00-cfffdeff : ehci_hcd
cfffdf00-cfffdfff : 0000:00:09.0
   cfffdf00-cfffdfff : 8139too
cfffe000-cfffefff : 0000:00:02.2
   cfffe000-cfffefff : ohci-hcd
cffff000-cfffffff : 0000:00:02.3
   cffff000-cfffffff : ohci-hcd
d0000000-d3ffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffee0000-ffefffff : reserved
fffc0000-ffffffff : reserved

/sbin/lspci -vvv:
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 32
         Region 0: Memory at d0000000 (32-bit, non-prefetchable) 
[size=64M]
         Capabilities: [c0] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- 
FW- Rate=x4

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual 
PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: cce00000-ceefffff
         Prefetchable memory behind bridge: bbc00000-cbcfffff
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 07) (prog-if 10 [OHCI])
         Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (20000ns max), cache line size 08
         Interrupt: pin D routed to IRQ 10
         Region 0: Memory at cfffe000 (32-bit, non-prefetchable) 
[size=4K]

00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 07) (prog-if 10 [OHCI])
         Subsystem: Silicon Integrated Systems [SiS] USB 1.0 Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR+
         Latency: 64 (20000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at cffff000 (32-bit, non-prefetchable) 
[size=4K]

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 
d0) (prog-if 80 [Master])
         Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE 
Controller (A,B step)
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 128
         Region 4: I/O ports at ff00 [size=16]

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
Sound Controller (rev a0)
         Subsystem: C-Media Electronics Inc: Unknown device 0300
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (13000ns min, 2750ns max)
         Interrupt: pin C routed to IRQ 10
         Region 0: I/O ports at dc00 [size=256]
         Region 1: I/O ports at d800 [size=64]
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 
10/100 Ethernet (rev 90)
         Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 
Ethernet Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (13000ns min, 2750ns max)
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at d400 [size=256]
         Region 1: Memory at cfffc000 (32-bit, non-prefetchable) 
[size=4K]
         Expansion ROM at cffa0000 [disabled] [size=128K]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR+
         Latency: 64 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at d000 [size=256]
         Region 1: Memory at cfffdf00 (32-bit, non-prefetchable) 
[size=256]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 VGA compatible controller: Matrox Graphics, Inc. MGA 1064SG 
[Mystique] (rev 03) (prog-if 00 [VGA])
         Subsystem: Matrox Graphics, Inc. MGA-1084SG Mystique
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at cc000000 (32-bit, prefetchable) [size=8M]
         Region 1: Memory at cfff8000 (32-bit, non-prefetchable) 
[size=16K]
         Region 2: Memory at cf000000 (32-bit, non-prefetchable) 
[size=8M]
         Expansion ROM at cffe0000 [disabled] [size=64K]

00:13.0 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 4: I/O ports at c800 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.1 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, cache line size 08
         Interrupt: pin B routed to IRQ 11
         Region 4: I/O ports at cc00 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) 
(prog-if 20 [EHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device 
1234
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, cache line size 10
         Interrupt: pin C routed to IRQ 10
         Region 0: Memory at cfffde00 (32-bit, non-prefetchable) 
[size=256]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 
440 AGP 8x] (rev a4) (prog-if 00 [VGA])
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at cd000000 (32-bit, non-prefetchable) 
[size=16M]
         Region 1: Memory at c0000000 (32-bit, prefetchable) [size=128M]
         Expansion ROM at ceee0000 [disabled] [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 3.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                 Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- 
FW- Rate=x4


--Apple-Mail-1--485888299
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Mensaje firmado digitalmente
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (Darwin)

iD8DBQFACu3jM4o5pzs0MrgRAlAAAKCW7zEdB/Vf2Z3uDZiUe6qGWumhtwCfZe6P
1FjLRxHPTIxRCb6G/UGDo6w=
=VEXO
-----END PGP SIGNATURE-----

--Apple-Mail-1--485888299--

