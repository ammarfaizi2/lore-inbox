Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbTKDNr5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 08:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbTKDNr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 08:47:57 -0500
Received: from mcree.ikk.sztaki.hu ([193.225.87.6]:33975 "EHLO
	mcree.ikk.sztaki.hu") by vger.kernel.org with ESMTP id S262225AbTKDNrn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 08:47:43 -0500
From: Erno Rigo <mcree@freemail.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel: ata1: DMA timeout, stat 0x1
Date: Tue, 4 Nov 2003 14:48:43 +0100
User-Agent: KMail/1.5.4
Cc: jgarzik@redhat.com
References: <200311041351.44607.mcree@freemail.hu> <200311041401.33726.mcree@freemail.hu>
In-Reply-To: <200311041401.33726.mcree@freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311041448.43973.mcree@freemail.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 November 2003 14:01, Erno Rigo wrote:

This is the first place where errors appear:

CPU: AMD Athlon(TM) XP 2100+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1970, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/3227] at 0000:00:11.0
PCI: Found IRQ 11 for device 0000:00:0d.0
PCI: Sharing IRQ 11 with 0000:00:0d.1
PCI: Sharing IRQ 11 with 0000:01:00.0
PCI: Found IRQ 3 for device 0000:00:0f.1
IRQ routing conflict for 0000:00:0f.0, have irq 9, want irq 3
IRQ routing conflict for 0000:00:10.0, have irq 9, want irq 3
IRQ routing conflict for 0000:00:10.1, have irq 9, want irq 3
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
pty: 256 Unix98 ptys configured

> On Tuesday 04 November 2003 13:51, Erno Rigo wrote:
>
> Hmm... Additional information...
>
> libata version 0.75 loaded.
> sata_via version 0.11
> PCI: Found IRQ 3 for device 0000:00:0f.0
> IRQ routing conflict for 0000:00:0f.0, have irq 9, want irq 3
> PCI: Sharing IRQ 3 with 0000:00:0f.1
> IRQ routing conflict for 0000:00:10.0, have irq 9, want irq 3
> IRQ routing conflict for 0000:00:10.1, have irq 9, want irq 3
> ata1: SATA max UDMA/133 cmd 0xD000 ctl 0xB802 bmdma 0xA800 irq 9
> ata2: SATA max UDMA/133 cmd 0xB400 ctl 0xB002 bmdma 0xA808 irq 9
> ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003
> 88:407f
> ata1: dev 0 ATA, max UDMA/133, 234441648 sectors (lba48)
> ata1: dev 0 configured for UDMA/133
> scsi0 : sata_via
> ATA: abnormal status 0x7F on port 0xB407
> ata2: thread exiting
> scsi1 : sata_via
>   Vendor: ATA       Model: ST3120026AS       Rev: 0.75
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
> SCSI device sda: drive cache: write through
>  /dev/scsi/host0/bus0/target0/lun0: p1
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
>
> > Hello!
> >
> > [1.] One line summary of the problem:
> >
> > kernel: ata1: DMA timeout, stat 0x1
> >
> > [2.] Full description of the problem/report:
> >
> > I've just purchased a VIA KT600 based mainboard and a Seagate Barracuda
> > 120G SATA drive. The controller and the drive is properly recognized, but
> > after a while, independent of the workload, I get the above error, and
> > the drive bails out. (It's unaccessible from the point I get the
> > message).
> >
> > I've also tried the backport in 2.4.22-ac4, it's a bit more verbose, and
> > complains about a 'scsi Media Sense error' before the dma timeout.
> >
> > [3.] Keywords (i.e., modules, networking, kernel):
> >
> > VIA, SATA
> >
> > [4.] Kernel version (from /proc/version):
> >
> > Linux version 2.6.0-test9 (root@mcree) (gcc version 3.3.2 20030908
> > (Debian prerelease)) #6 Tue Nov 4 13:11:19 CET 2003
> >
> > [5.] Output of Oops.. message (if applicable) with symbolic information
> >      resolved (see Documentation/oops-tracing.txt)
> >
> > N/A
> >
> > [6.] A small shell script or example program which triggers the
> >      problem (if possible)
> >
> > Normal usage. (Sometimes I can cp tens of gigabytes, sometimes I can't
> > even change to a directory)
> >
> > [7.] Environment
> > [7.1.] Software (add the output of the ver_linux script here)
> >
> > Linux mcree 2.6.0-test9 #6 Tue Nov 4 13:11:19 CET 2003 i686 GNU/Linux
> >
> > Gnu C                  3.3.2
> > Gnu make               3.80
> > util-linux             2.12
> > mount                  2.12
> > module-init-tools      0.9.15-pre2
> > e2fsprogs              1.35-WIP
> > Linux C Library        2.3.2
> > Dynamic linker (ldd)   2.3.2
> > Procps                 3.1.12
> > Net-tools              1.60
> > Console-tools          0.2.3
> > Sh-utils               5.0.90
> > Modules Loaded
> >
> > [7.2.] Processor information (from /proc/cpuinfo):
> >
> > processor       : 0
> > vendor_id       : AuthenticAMD
> > cpu family      : 6
> > model           : 8
> > model name      : AMD Athlon(TM) XP 2100+
> > stepping        : 1
> > cpu MHz         : 1734.223
> > cache size      : 256 KB
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 1
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> > mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> > bogomips        : 3416.06
> >
> > [7.3.] Module information (from /proc/modules):
> >
> > empty
> >
> > [7.4.] Loaded driver and hardware information (/proc/ioports,
> > /proc/iomem)
> >
> > [root@mcree| /usr/src/linux-2.6.0-test9/scripts]#cat /proc/ioports
> > 0000-001f : dma1
> > 0020-0021 : pic1
> > 0040-005f : timer
> > 0060-006f : keyboard
> > 0070-0077 : rtc
> > 0080-008f : dma page reg
> > 00a0-00a1 : pic2
> > 00c0-00df : dma2
> > 00f0-00ff : fpu
> > 0170-0177 : ide1
> > 01f0-01f7 : ide0
> > 0376-0376 : ide1
> > 0378-037a : parport0
> > 03c0-03df : vga+
> > 03f6-03f6 : ide0
> > 03f8-03ff : serial
> > 0cf8-0cff : PCI conf1
> > 8400-84ff : 0000:00:13.0
> >   8400-84ff : tulip
> > 8800-881f : 0000:00:10.3
> > 9000-901f : 0000:00:10.2
> > 9400-941f : 0000:00:10.1
> > 9800-981f : 0000:00:10.0
> > a000-a00f : 0000:00:0f.1
> >   a000-a007 : ide0
> >   a008-a00f : ide1
> > a400-a4ff : 0000:00:0f.0
> >   a400-a4ff : libata
> > a800-a80f : 0000:00:0f.0
> >   a800-a80f : libata
> > b000-b003 : 0000:00:0f.0
> >   b000-b003 : libata
> > b400-b407 : 0000:00:0f.0
> >   b400-b407 : libata
> > b800-b803 : 0000:00:0f.0
> >   b800-b803 : libata
> > d000-d007 : 0000:00:0f.0
> >   d000-d007 : libata
> > d400-d43f : 0000:00:0e.0
> > d800-d8ff : 0000:00:09.0
> >
> > [root@mcree| /usr/src/linux-2.6.0-test9/scripts]#cat /proc/iomem
> > 00000000-0009d7ff : System RAM
> > 0009d800-0009ffff : reserved
> > 000a0000-000bffff : Video RAM area
> > 000c0000-000c7fff : Video ROM
> > 000f0000-000fffff : System ROM
> > 00100000-1fffbfff : System RAM
> >   00100000-0034aa64 : Kernel code
> >   0034aa65-004195ff : Kernel data
> > 1fffc000-1fffefff : ACPI Tables
> > 1ffff000-1fffffff : ACPI Non-volatile Storage
> > ea800000-ea8003ff : 0000:00:13.0
> >   ea800000-ea8003ff : tulip
> > eb000000-eb0000ff : 0000:00:10.4
> > eb800000-eb803fff : 0000:00:09.0
> > ec000000-edefffff : PCI Bus #01
> >   ec000000-ecffffff : 0000:01:00.0
> > ee000000-ee000fff : 0000:00:0d.1
> > ee800000-ee800fff : 0000:00:0d.0
> >   ee800000-ee800fff : bttv0
> > ef700000-f7ffffff : PCI Bus #01
> >   ef800000-ef87ffff : 0000:01:00.0
> >   f0000000-f7ffffff : 0000:01:00.0
> > f8000000-fbffffff : 0000:00:00.0
> > fec00000-fec00fff : reserved
> > fee00000-fee00fff : reserved
> > ffff0000-ffffffff : reserved
> >
> > [7.5.] PCI information ('lspci -vvv' as root)
> >
> > [root@mcree| /usr/src/linux-2.6.0-test9/scripts]#lspci -vvv
> > 00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host
> > Bridge (rev 80)
> >         Subsystem: Asustek Computer, Inc.: Unknown device 807f
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort+ >SERR- <PERR-
> >         Latency: 0
> >         Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
> >         Capabilities: [80] AGP version 3.5
> >                 Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64-
> > HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
> >                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
> > Rate=<none>
> >         Capabilities: [c0] Power Management version 2
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > 00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198 (prog-if
> > 00 [Normal decode])
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort+ >SERR- <PERR-
> >         Latency: 0
> >         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> >         I/O behind bridge: 0000e000-0000dfff
> >         Memory behind bridge: ec000000-edefffff
> >         Prefetchable memory behind bridge: ef700000-f7ffffff
> >         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
> >         Capabilities: [80] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > 00:09.0 Ethernet controller: 3Com Corporation: Unknown device 1700 (rev
> > 12) Subsystem: Asustek Computer, Inc.: Unknown device 80eb
> >         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (5750ns min, 7750ns max), cache line size 08
> >         Interrupt: pin A routed to IRQ 5
> >         Region 0: Memory at eb800000 (32-bit, non-prefetchable)
> > [disabled] [size=16K]
> >         Region 1: I/O ports at d800 [disabled] [size=256]
> >         Capabilities: [48] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2
> > +,D3hot+,D3cold+)
> >                 Status: D0 PME-Enable- DSel=7 DScale=1 PME-
> >         Capabilities: [50] Vital Product Data
> >
> > 00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video
> > Capture (rev 11)
> >         Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo
> > receiver) Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (4000ns min, 10000ns max)
> >         Interrupt: pin A routed to IRQ 11
> >         Region 0: Memory at ee800000 (32-bit, prefetchable) [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > 00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
> > (rev 11)
> >         Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo
> > receiver, audio section)
> >         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (1000ns min, 63750ns max)
> >         Interrupt: pin A routed to IRQ 11
> >         Region 0: Memory at ee000000 (32-bit, prefetchable) [disabled]
> > [size=4K]
> >         Capabilities: [44] Vital Product Data
> >         Capabilities: [4c] Power Management version 2
> >                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > 00:0e.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
> >         Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
> >         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (3000ns min, 32000ns max)
> >         Interrupt: pin A routed to IRQ 0
> >         Region 0: I/O ports at d400 [disabled] [size=64]
> >         Capabilities: [dc] Power Management version 1
> >                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > 00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3149
> > (rev 80)
> >         Subsystem: Asustek Computer, Inc.: Unknown device 80ed
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32
> >         Interrupt: pin A routed to IRQ 9
> >         Region 0: I/O ports at d000 [size=8]
> >         Region 1: I/O ports at b800 [size=4]
> >         Region 2: I/O ports at b400 [size=8]
> >         Region 3: I/O ports at b000 [size=4]
> >         Region 4: I/O ports at a800 [size=16]
> >         Region 5: I/O ports at a400 [size=256]
> >         Capabilities: [c0] Power Management version 2
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > 00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
> > Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
> >         Subsystem: Asustek Computer, Inc.: Unknown device 80ed
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32
> >         Interrupt: pin A routed to IRQ 3
> >         Region 4: I/O ports at a000 [size=16]
> >         Capabilities: [c0] Power Management version 2
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > 00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00
> > [UHCI])
> >         Subsystem: Asustek Computer, Inc.: Unknown device 80ed
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32, cache line size 08
> >         Interrupt: pin A routed to IRQ 9
> >         Region 4: I/O ports at 9800 [size=32]
> >         Capabilities: [80] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> > PME(D0+,D1+,D2 +,D3hot+,D3cold+)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > 00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00
> > [UHCI])
> >         Subsystem: Asustek Computer, Inc.: Unknown device 80ed
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32, cache line size 08
> >         Interrupt: pin A routed to IRQ 9
> >         Region 4: I/O ports at 9400 [size=32]
> >         Capabilities: [80] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> > PME(D0+,D1+,D2 +,D3hot+,D3cold+)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > 00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00
> > [UHCI])
> >         Subsystem: Asustek Computer, Inc.: Unknown device 80ed
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32, cache line size 08
> >         Interrupt: pin B routed to IRQ 11
> >         Region 4: I/O ports at 9000 [size=32]
> >         Capabilities: [80] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> > PME(D0+,D1+,D2 +,D3hot+,D3cold+)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > 00:10.3 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00
> > [UHCI])
> >         Subsystem: Asustek Computer, Inc.: Unknown device 80ed
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32, cache line size 08
> >         Interrupt: pin B routed to IRQ 11
> >         Region 4: I/O ports at 8800 [size=32]
> >         Capabilities: [80] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> > PME(D0+,D1+,D2 +,D3hot+,D3cold+)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if
> > 20 [EHCI])
> >         Subsystem: Asustek Computer, Inc.: Unknown device 80ed
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32, cache line size 08
> >         Interrupt: pin C routed to IRQ 10
> >         Region 0: Memory at eb000000 (32-bit, non-prefetchable)
> > [size=256] Capabilities: [80] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> > PME(D0+,D1+,D2 +,D3hot+,D3cold+)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > 00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
> >         Subsystem: Asustek Computer, Inc.: Unknown device 80ed
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping+ SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 0
> >         Capabilities: [c0] Power Management version 2
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > 00:13.0 Ethernet controller: Accton Technology Corporation EN-1216
> > Ethernet Adapter (rev 11)
> >         Subsystem: Standard Microsystems Corp [SMC]: Unknown device 1255
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 32 (63750ns min, 63750ns max), cache line size 08
> >         Interrupt: pin A routed to IRQ 5
> >         Region 0: I/O ports at 8400 [size=256]
> >         Region 1: Memory at ea800000 (32-bit, non-prefetchable) [size=1K]
> >         Expansion ROM at <unassigned> [disabled] [size=128K]
> >         Capabilities: [c0] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA
> > PME(D0+,D1+,D2 +,D3hot+,D3cold+)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >
> > 01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX
> > 440] (rev a3) (prog-if 00 [VGA])
> >         Subsystem: ABIT Computer Corp. Abit Siluro GeForce4MX440
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 64 (1250ns min, 250ns max)
> >         Interrupt: pin A routed to IRQ 11
> >         Region 0: Memory at ec000000 (32-bit, non-prefetchable)
> > [size=16M] Region 1: Memory at f0000000 (32-bit, prefetchable)
> > [size=128M] Region 2: Memory at ef800000 (32-bit, prefetchable)
> > [size=512K] Expansion ROM at ef7e0000 [disabled] [size=128K]
> >         Capabilities: [60] Power Management version 2
> >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> > PME(D0-,D1-,D2-,D3hot-,D3cold-)
> >                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >         Capabilities: [44] AGP version 2.0
> >                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64-
> > HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
> >                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
> > Rate=<none>
> >
> > [7.6.] SCSI information (from /proc/scsi/scsi)
> >
> > [root@mcree| /usr/src/linux-2.6.0-test9/scripts]#cat /proc/scsi/scsi
> > Attached devices:
> > Host: scsi0 Channel: 00 Id: 00 Lun: 00
> >   Vendor: ATA      Model: ST3120026AS      Rev: 0.75
> >   Type:   Direct-Access                    ANSI SCSI revision: 05
> >
> >
> > [7.7.] Other information that might be relevant to the problem
> >        (please look in /proc and include all information that you
> >        think to be relevant):
> >
> > [root@mcree| /usr/src/linux-2.6.0-test9/scripts]#hdparm
> > /dev/scsi/host0/bus0/ target0/lun0/disc
> >
> > /dev/scsi/host0/bus0/target0/lun0/disc:
> >  readonly     =  0 (off)
> >
> > (Hangs here in kernel mode - unable to kill -9 it)
> >
> > [X.] Other notes, patches, fixes, workarounds:
> >
> > Please CC your additional questions to mcree@freemail.hu, as I'm not on
> > the kernel mailing list.

-- 
McRee
