Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbQLSSBY>; Tue, 19 Dec 2000 13:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130205AbQLSSBP>; Tue, 19 Dec 2000 13:01:15 -0500
Received: from exit1.i-55.com ([204.27.97.1]:33274 "EHLO exit1.i-55.com")
	by vger.kernel.org with ESMTP id <S129604AbQLSSBF>;
	Tue, 19 Dec 2000 13:01:05 -0500
Message-ID: <3A3F9A2A.6020304@cs.rose-hulman.edu>
Date: Tue, 19 Dec 2000 11:26:02 -0600
From: Leslie Donaldson <donaldlf@cs.rose-hulman.edu>
Reply-To: donaldlf@cs.rose-hulman.edu
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 alpha; en-US; m18) Gecko/20001106
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: X 4.0.1 -> pci memory overlap
Content-Type: multipart/mixed;
 boundary="------------030808050900020009000606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030808050900020009000606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
I know this isn't quite the right place but... very
few people have actually but 2 pci video cards
in an alpha an they are actually from different
chipset manufactures. Well X reports an overlap bug
and I was wondering if anyone has a good idea
where to start looking for the problem.

[root@shadowdragon /root]# lspci -vv
00:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W 
[Millennium] (rev 01) (prog-if 00 [VGA])
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Interrupt: pin A routed to IRQ 18
Region 0: [virtual] Memory at 000000000c860000 (32-bit, 
non-prefetchable) [size=16K]
Region 1: Memory at 000000000c000000 (32-bit, prefetchable) [size=8M]
Expansion ROM at 000000000c840000 [size=64K]

00:06.0 SCSI storage controller: Adaptec 7899A (rev 01)
Subsystem: Adaptec: Unknown device f620
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Latency: 32 (10000ns min, 6250ns max), cache line size 08
Interrupt: pin A routed to IRQ 16
BIST result: 00
Region 0: I/O ports at 8000 [size=256]
Region 1: Memory at 000000000c864000 (64-bit, non-prefetchable) [size=4K]
Expansion ROM at 000000000c800000 [disabled] [size=128K]
Capabilities: [dc] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.1 SCSI storage controller: Adaptec 7899A (rev 01)
Subsystem: Adaptec: Unknown device f620
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Latency: 32 (10000ns min, 6250ns max), cache line size 08
Interrupt: pin B routed to IRQ 23
BIST result: 00
Region 0: I/O ports at 8400 [size=256]
Region 1: Memory at 000000000c865000 (64-bit, non-prefetchable) [size=4K]
Expansion ROM at 000000000c820000 [disabled] [size=128K]
Capabilities: [dc] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 
15) (prog-if 00 [VGA])
Subsystem: Guillemot Corporation: Unknown device 4d21
Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Latency: 32 (1250ns min, 250ns max)
Interrupt: pin A routed to IRQ 17
Region 0: Memory at 0000000009000000 (32-bit, non-prefetchable) 
[disabled] [size=16M]
Region 1: Memory at 000000000a000000 (32-bit, prefetchable) [disabled] 
[size=32M]
Expansion ROM at 000000000c850000 [size=64K]
Capabilities: [60] Power Management version 1
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Non-VGA unclassified device: Intel Corporation 82378IB [SIO ISA 
Bridge] (rev 43)
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Latency: 0

00:09.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
Subsystem: Unknown device 4942:4c4c
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
Latency: 32 (3000ns min, 32000ns max)
Interrupt: pin A routed to IRQ 19
Region 0: I/O ports at 8800 [size=64]

00:0b.0 IDE interface: CMD Technology Inc PCI0646 (rev 01) (prog-if 80 
[Master])
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
Latency: 32 (500ns min, 1000ns max)
Interrupt: pin A routed to IRQ 21
Region 4: I/O ports at 8840 [size=16]


--------------030808050900020009000606
Content-Type: text/plain;
 name="xlog_00.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xlog_00.txt"


XFree86 Version 4.0.1a / X Window System
(protocol Version 11, revision 0, vendor release 6400)
Release Date: 2 August 2000
	If the server is older than 6-12 months, or if your card is newer
	than the above date, look for a newer version before reporting
	problems.  (see http://www.XFree86.Org/FAQ)
Operating System: Linux 2.2.15 alpha [ELF] 
Module Loader present
(==) Log file: "/var/log/XFree86.0.log", Time: Fri Dec 15 10:17:58 2000
(++) Using config file: "/root/XF86Config.new"
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (??) unknown.
(==) ServerLayout "XFree86 Configured"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "Card0"
(**) |-->Screen "Screen1" (1)
(**) |   |-->Monitor "Monitor1"
(**) |   |-->Device "Card1"
(**) |-->Input Device "Mouse0"
(**) |-->Input Device "Keyboard0"
(**) Option "AutoRepeat" "500 5"
(**) Option "XkbModel" "microsoft"
(**) XKB: model: "microsoft"
(**) Option "XkbLayout" "us"
(**) XKB: layout: "us"
(==) FontPath set to "/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/CID/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/"
(==) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(**) Option "BlankTime" "10"
(**) Option "StandbyTime" "20"
(**) Option "SuspendTime" "30"
(**) Option "OffTime" "60"
(--) using VT number 7

(II) Module ABI versions:
	XFree86 ANSI C Emulation: 0.1
	XFree86 Video Driver: 0.2
	XFree86 XInput driver : 0.1
	XFree86 Server Extension : 0.1
	XFree86 Font Renderer : 0.1
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.1
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.2
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:05:0: chip 102b,0519 card 0000,0000 rev 01 class 03,00,00 hdr 00
(II) PCI: 00:06:0: chip 9005,00c0 card 9005,f620 rev 01 class 01,00,00 hdr 80
(II) PCI: 00:06:1: chip 9005,00c0 card 9005,f620 rev 01 class 01,00,00 hdr 80
(II) PCI: 00:07:0: chip 10de,002d card 14af,4d21 rev 15 class 03,00,00 hdr 00
(II) PCI: 00:08:0: chip 8086,0484 card 0000,0000 rev 43 class 00,00,00 hdr 00
(II) PCI: 00:09:0: chip 1274,5000 card 4942,4c4c rev 00 class 04,01,00 hdr 00
(II) PCI: 00:0b:0: chip 1095,0646 card 0000,0000 rev 01 class 01,01,80 hdr 00
(II) PCI: End of PCI scan
(II) LoadModule: "scanpci"
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.2
(II) UnloadModule: "scanpci"
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(--) PCI: (0:5:0) Matrox MGA 2064W rev 1, Mem @ 0x0c860000/14, 0x0c000000/23
(--) PCI:*(0:7:0) NVidia Riva Ultra 64 rev 21, Mem @ 0x09000000/24, 0x0a000000/25
(II) Addressable bus resource ranges are
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1	0x00000000 - 0xffffffff (0x0) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[1] -1	0x00000000 - 0x000001ff (0x200) IX[B]E
(II) Active PCI resource ranges:
	[0] -1	0x0c820000 - 0x0c83ffff (0x20000) MX[B]E
	[1] -1	0x0c865000 - 0x0c865fff (0x1000) MX[B]E
	[2] -1	0x0c800000 - 0x0cffffff (0x800000) MX[B]E
	[3] -1	0x0c864000 - 0x0c867fff (0x4000) MX[B]E
	[4] -1	0x0c850000 - 0x0c8500ff (0x100) MX[B](B)
	[5] -1	0x0a000000 - 0x0bffffff (0x2000000) MX[B](B)
	[6] -1	0x09000000 - 0x09ffffff (0x1000000) MX[B](B)
	[7] -1	0x0c840000 - 0x0c84ffff (0x10000) MX[B](B)
	[8] -1	0x0c000000 - 0x0c7fffff (0x800000) MX[B](B)
	[9] -1	0x0c860000 - 0x0c863fff (0x4000) MX[B](B)
	[10] -1	0x00008840 - 0x0000887f (0x40) IX[B]E
	[11] -1	0x00008800 - 0x000088ff (0x100) IX[B]E
	[12] -1	0x00008400 - 0x000084ff (0x100) IX[B]E
	[13] -1	0x00008000 - 0x000080ff (0x100) IX[B]E
(II) PCI I/O resource overlap reduced 0x00008800 from 0x000088ff to 0x0000883f
(II) PCI Memory resource overlap reduced 0x0c800000 from 0x0cffffff to 0x0c81ffff
(II) PCI Memory resource overlap reduced 0x0c864000 from 0x0c867fff to 0x0c864fff
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0x0c820000 - 0x0c83ffff (0x20000) MX[B]E
	[1] -1	0x0c865000 - 0x0c865fff (0x1000) MX[B]E
	[2] -1	0x0c800000 - 0x0c81ffff (0x20000) MX[B]E
	[3] -1	0x0c864000 - 0x0c864fff (0x1000) MX[B]E
	[4] -1	0x0c850000 - 0x0c8500ff (0x100) MX[B](B)
	[5] -1	0x0a000000 - 0x0bffffff (0x2000000) MX[B](B)
	[6] -1	0x09000000 - 0x09ffffff (0x1000000) MX[B](B)
	[7] -1	0x0c840000 - 0x0c84ffff (0x10000) MX[B](B)
	[8] -1	0x0c000000 - 0x0c7fffff (0x800000) MX[B](B)
	[9] -1	0x0c860000 - 0x0c863fff (0x4000) MX[B](B)
	[10] -1	0x00008840 - 0x0000887f (0x40) IX[B]E
	[11] -1	0x00008800 - 0x0000883f (0x40) IX[B]E
	[12] -1	0x00008400 - 0x000084ff (0x100) IX[B]E
	[13] -1	0x00008000 - 0x000080ff (0x100) IX[B]E
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[1] -1	0x00000000 - 0x000001ff (0x200) IX[B]E
(II) All system resource ranges:
	[0] -1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[1] -1	0x0c820000 - 0x0c83ffff (0x20000) MX[B]E
	[2] -1	0x0c865000 - 0x0c865fff (0x1000) MX[B]E
	[3] -1	0x0c800000 - 0x0c81ffff (0x20000) MX[B]E
	[4] -1	0x0c864000 - 0x0c864fff (0x1000) MX[B]E
	[5] -1	0x0c850000 - 0x0c8500ff (0x100) MX[B](B)
	[6] -1	0x0a000000 - 0x0bffffff (0x2000000) MX[B](B)
	[7] -1	0x09000000 - 0x09ffffff (0x1000000) MX[B](B)
	[8] -1	0x0c840000 - 0x0c84ffff (0x10000) MX[B](B)
	[9] -1	0x0c000000 - 0x0c7fffff (0x800000) MX[B](B)
	[10] -1	0x0c860000 - 0x0c863fff (0x4000) MX[B](B)
	[11] -1	0x00000000 - 0x000001ff (0x200) IX[B]E
	[12] -1	0x00008840 - 0x0000887f (0x40) IX[B]E
	[13] -1	0x00008800 - 0x0000883f (0x40) IX[B]E
	[14] -1	0x00008400 - 0x000084ff (0x100) IX[B]E
	[15] -1	0x00008000 - 0x000080ff (0x100) IX[B]E
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension DPMS
(II) Loading extension FontCache
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) LoadModule: "xie"
(II) Loading /usr/X11R6/lib/modules/extensions/libxie.a
(II) Module xie: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension XIE
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension GLX
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) LoadModule: "GLcore"
(II) Reloading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.13.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension RECORD
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension XFree86-DRI
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.1
(II) LoadModule: "pex5"
(II) Loading /usr/X11R6/lib/modules/extensions/libpex5.a
(II) Module pex5: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.1
(II) Loading extension X3D-PEX
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.1
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "speedo"
(II) Loading /usr/X11R6/lib/modules/fonts/libspeedo.a
(II) Module speedo: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.1
(II) Loading font Speedo
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.1.7
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.1
(II) Loading font FreeType
(II) LoadModule: "mga"
(II) Loading /usr/X11R6/lib/modules/drivers/mga_drv.o
(II) Module mga: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.0.0
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.2
(II) LoadModule: "nv"
(II) Loading /usr/X11R6/lib/modules/drivers/nv_drv.o
(II) Module nv: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.0.0
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.2
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.0.0
	Module class: XFree86 XInput Driver
	ABI class: XFree86 XInput driver, version 0.1
(II) MGA: driver for Matrox chipsets: mga2064w, mga1064sg, mga2164w,
	mga2164w AGP, mgag100, mgag200, mgag200 PCI, mgag400
(II) NV: driver for NVIDIA chipsets: RIVA128, RIVATNT, RIVATNT2,
	RIVATNT2 (Ultra), RIVATNT2 (Vanta), RIVATNT2 M64,
	RIVATNT2 (Integrated), GeForce 256, GeForce DDR, Quadro, GeForce DDR,
	GeForce DDR, GeForce DDR GL, GeForce 2, GeForce 2, GeForce 2,
	Quadro 2
(II) Primary Device is: PCI 00:07:0
(--) Chipset mga2064w found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[1] -1	0x0c820000 - 0x0c83ffff (0x20000) MX[B]E
	[2] -1	0x0c865000 - 0x0c865fff (0x1000) MX[B]E
	[3] -1	0x0c800000 - 0x0c81ffff (0x20000) MX[B]E
	[4] -1	0x0c864000 - 0x0c864fff (0x1000) MX[B]E
	[5] -1	0x0c850000 - 0x0c8500ff (0x100) MX[B](B)
	[6] -1	0x0a000000 - 0x0bffffff (0x2000000) MX[B](B)
	[7] -1	0x09000000 - 0x09ffffff (0x1000000) MX[B](B)
	[8] -1	0x0c840000 - 0x0c84ffff (0x10000) MX[B](B)
	[9] -1	0x0c000000 - 0x0c7fffff (0x800000) MX[B](B)
	[10] -1	0x0c860000 - 0x0c863fff (0x4000) MX[B](B)
	[11] -1	0x00000000 - 0x000001ff (0x200) IX[B]E
	[12] -1	0x00008840 - 0x0000887f (0x40) IX[B]E
	[13] -1	0x00008800 - 0x0000883f (0x40) IX[B]E
	[14] -1	0x00008400 - 0x000084ff (0x100) IX[B]E
	[15] -1	0x00008000 - 0x000080ff (0x100) IX[B]E
(--) Chipset RIVATNT2 M64 found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[1] -1	0x0c820000 - 0x0c83ffff (0x20000) MX[B]E
	[2] -1	0x0c865000 - 0x0c865fff (0x1000) MX[B]E
	[3] -1	0x0c800000 - 0x0c81ffff (0x20000) MX[B]E
	[4] -1	0x0c864000 - 0x0c864fff (0x1000) MX[B]E
	[5] -1	0x0c850000 - 0x0c8500ff (0x100) MX[B](B)
	[6] -1	0x0a000000 - 0x0bffffff (0x2000000) MX[B](B)
	[7] -1	0x09000000 - 0x09ffffff (0x1000000) MX[B](B)
	[8] -1	0x0c840000 - 0x0c84ffff (0x10000) MX[B](B)
	[9] -1	0x0c000000 - 0x0c7fffff (0x800000) MX[B](B)
	[10] -1	0x0c860000 - 0x0c863fff (0x4000) MX[B](B)
	[11] -1	0x00000000 - 0x000001ff (0x200) IX[B]E
	[12] -1	0x00008840 - 0x0000887f (0x40) IX[B]E
	[13] -1	0x00008800 - 0x0000883f (0x40) IX[B]E
	[14] -1	0x00008400 - 0x000084ff (0x100) IX[B]E
	[15] -1	0x00008000 - 0x000080ff (0x100) IX[B]E
(WW) ****INVALID MEM ALLOCATION**** b: 0xc860000 e: 0xc863fff correcting
NonSys
	[0] -1	0x0a000000 - 0x0bffffff (0x2000000) MX[B]
	[1] -1	0x09000000 - 0x09ffffff (0x1000000) MX[B]
	[2] -1	0x0c820000 - 0x0c83ffff (0x20000) MX[B]
	[3] -1	0x0c865000 - 0x0c865fff (0x1000) MX[B]
	[4] -1	0x0c800000 - 0x0cffffff (0x800000) MX[B]
	[5] -1	0x0c864000 - 0x0c864fff (0x1000) MX[B]
	[6] -1	0x00008840 - 0x0000887f (0x40) IX[B]
	[7] -1	0x00008800 - 0x0000883f (0x40) IX[B]
	[8] -1	0x00008400 - 0x000084ff (0x100) IX[B]
	[9] -1	0x00008000 - 0x000080ff (0x100) IX[B]
(II) window:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) resSize:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) window fixed:
	[0] -1	0x00000000 - 0xffffffff (0x0) MX[B]
New PCI res 0 base: 0x0, size: 0x4000, type Mem
(II) resource ranges after probing:
	[0] -1	0x00000000 - 0x00003fff (0x4000) MX[B](B)
	[1] -1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[2] -1	0x0c820000 - 0x0c83ffff (0x20000) MX[B]E
	[3] -1	0x0c865000 - 0x0c865fff (0x1000) MX[B]E
	[4] -1	0x0c800000 - 0x0c81ffff (0x20000) MX[B]E
	[5] -1	0x0c864000 - 0x0c864fff (0x1000) MX[B]E
	[6] -1	0x0c850000 - 0x0c8500ff (0x100) MX[B](B)
	[7] -1	0x0a000000 - 0x0bffffff (0x2000000) MX[B](B)
	[8] -1	0x09000000 - 0x09ffffff (0x1000000) MX[B](B)
	[9] -1	0x0c840000 - 0x0c84ffff (0x10000) MX[B](B)
	[10] -1	0x0c000000 - 0x0c7fffff (0x800000) MX[B](B)
	[11] 0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[12] 0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[13] 0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[14] 1	0x000a0000 - 0x000affff (0x10000) MS[B]
	[15] 1	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[16] 1	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[17] -1	0x00000000 - 0x000001ff (0x200) IX[B]E
	[18] -1	0x00008840 - 0x0000887f (0x40) IX[B]E
	[19] -1	0x00008800 - 0x0000883f (0x40) IX[B]E
	[20] -1	0x00008400 - 0x000084ff (0x100) IX[B]E
	[21] -1	0x00008000 - 0x000080ff (0x100) IX[B]E
	[22] 0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[23] 0	0x000003c0 - 0x000003df (0x20) IS[B]
	[24] 1	0x000003b0 - 0x000003bb (0xc) IS[B]
	[25] 1	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) Setting vga for screen 1.
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 0.1.0
	ABI class: XFree86 Video Driver, version 0.2
(==) MGA(0): Depth 8, (==) framebuffer bpp 8
(**) MGA(0): Option "UseFBDev"
(--) MGA(0): Chipset: "mga2064w"
(II) MGA(0): Offscreen memory usage will be limited to 512 lines if the DRI is enabled.
(==) MGA(0): Using HW cursor
(**) MGA(0): Using framebuffer device
(II) Loading sub module "fbdevhw"
(II) LoadModule: "fbdevhw"
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 0.0.1
	ABI class: XFree86 Video Driver, version 0.2
(--) MGA(0): Linear framebuffer at 0xC000000
(EE) MGA(0): No valid MMIO address in PCI config space
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/libint10.a
(II) Module int10: vendor="The XFree86 Project"
	compiled for 4.0.1a, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.2
(II) NV(1): Initializing int10
(II) Machine type has 8/16 bit access
(--) NV(1): Chipset: "RIVATNT2 M64"
(==) NV(1): Depth 8, (==) framebuffer bpp 8
(==) NV(1): Default visual is PseudoColor
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Reloading /usr/X11R6/lib/modules/libvgahw.a
(==) NV(1): Using HW cursor
(--) NV(1): Linear framebuffer at 0xA000000
(--) NV(1): MMIO registers at 0x9000000

Fatal server error:
xf86MapVidMem: Could not mmap framebuffer (0x09101000,0x1000) (Invalid argument)


When reporting a problem related to a server crash, please send
the full server output, not just the last messages.
This can be found in the log file "/var/log/XFree86.0.log".
Please reports problems to xfree86@xfree86.org.


--------------030808050900020009000606--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
