Return-Path: <linux-kernel-owner+w=401wt.eu-S1751008AbXACSBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbXACSBM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 13:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbXACSBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 13:01:12 -0500
Received: from cthulhu.lanfear.net ([206.124.137.179]:46331 "EHLO
	cthulhu.lanfear.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbXACSBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 13:01:08 -0500
X-Greylist: delayed 1841 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 13:01:07 EST
Date: Wed, 3 Jan 2007 09:30:24 -0800
From: Mark Wagner <mark@lanfear.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: sata_sil24 lockups under heavy i/o
Message-ID: <20070103173024.GB17650@freddy.lanfear.net>
Reply-To: Mark Wagner <mark@lanfear.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

sata_sil24 lockups under heavy i/o

[2.] Full description of the problem/report:

I have a PCI-based sata_sil24 card. It has 4 ports. It was functioning
well with two disks attached. Once I attached 2 additional disks (for
a total of 4) and started heavy i/o (extending a software raid5 device)
the system began locking up for a few minutes at a time. After the
system recovers the disk transfer speed is reduced from UDMA/100 to
UDMA/66 or UDMA/44.

[3.] Keywords (i.e., modules, networking, kernel):

libata sata_sil24

[4.] Kernel version (from /proc/version):

Linux version 2.6.19-gentoo-r2 (root@cthulhu) (gcc version 4.1.1 (Gentoo
4.1.1-r3)) #1 Tue Dec 19 22:55:21 PST 2006

[5.] Most recent kernel version which did not have the bug:

Unknown.

[8.1.] Software (add the output of the ver_linux script here)

Linux cthulhu 2.6.19-gentoo-r2 #1 Tue Dec 19 22:55:21 PST 2006 i686 AMD
Athlon(tm) Processor AuthenticAMD GNU/Linux

Gnu C                  4.1.1
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
Linux C Library        > libc.2.4
Dynamic linker (ldd)   2.4
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.12
Sh-utils               6.7
udev                   103
Modules Loaded         w83781d hwmon_vid lp usbhid 8250_pnp 8250
serial_core parport_pc pcspkr parport uhci_hcd via686a i2c_isa usbcore
i2c_viapro i2c_core

[8.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1410.226
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
mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2822.62

[8.3.] Module information (from /proc/modules):

w83781d 28008 1 - Live 0xfa367000
hwmon_vid 2240 1 w83781d, Live 0xf887d000
lp 8452 0 - Live 0xfa24c000
usbhid 32288 1 - Live 0xfa257000
8250_pnp 8704 0 - Live 0xf883b000
8250 17252 1 8250_pnp, Live 0xf8851000
serial_core 14976 1 8250, Live 0xf884c000
parport_pc 28644 1 - Live 0xfa202000
pcspkr 2240 0 - Live 0xf883f000
parport 30600 2 lp,parport_pc, Live 0xf8872000
uhci_hcd 16776 0 - Live 0xf8822000
via686a 13320 0 - Live 0xf8841000
i2c_isa 3584 2 w83781d,via686a, Live 0xf8839000
usbcore 99524 4 usbhid,uhci_hcd, Live 0xf8858000
i2c_viapro 6932 0 - Live 0xf882d000
i2c_core 15952 4 w83781d,via686a,i2c_isa,i2c_viapro, Live 0xf8828000

[8.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
  03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0778-077a : parport0
0cf8-0cff : PCI conf1
7800-783f : 0000:00:11.0
  7800-7807 : ide2
  7808-780f : ide3
  7810-783f : PDC20265
8000-8003 : 0000:00:11.0
8400-8407 : 0000:00:11.0
8800-8803 : 0000:00:11.0
  8802-8802 : ide2
9000-9007 : 0000:00:11.0
  9000-9007 : ide2
9400-947f : 0000:00:0b.0
9800-980f : 0000:00:0a.0
  9800-980f : sata_sil24
a000-a0ff : 0000:00:09.1
  a000-a0ff : sym53c8xx
a400-a4ff : 0000:00:09.0
  a400-a4ff : sym53c8xx
d000-d01f : 0000:00:04.3
  d000-d01f : uhci_hcd
d400-d41f : 0000:00:04.2
  d400-d41f : uhci_hcd
d800-d80f : 0000:00:04.1
  d800-d807 : ide0
  d808-d80f : ide1
e200-e27f : 0000:00:04.4
e400-e47f : pnp 00:12
e800-e80f : 0000:00:04.4
  e800-e807 : vt596_smbus

00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf3ff : Video ROM
000d0000-000d27ff : Adapter ROM
000d4000-000d47ff : Adapter ROM
000d8000-000dbfff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ffebfff : System RAM
  00100000-002efefe : Kernel code
  002efeff-003acf43 : Kernel data
3ffec000-3ffeefff : ACPI Tables
3ffef000-3fffefff : reserved
3ffff000-3fffffff : ACPI Non-volatile Storage
50000000-5007ffff : 0000:00:0a.0
50080000-5009ffff : 0000:00:0b.0
500a0000-500affff : 0000:00:09.0
500b0000-500bffff : 0000:00:09.1
500c0000-500cffff : 0000:00:11.0
d2000000-d201ffff : 0000:00:11.0
d2800000-d280007f : 0000:00:0b.0
d3000000-d3007fff : 0000:00:0a.0
  d3000000-d3007fff : sata_sil24
d3800000-d380007f : 0000:00:0a.0
  d3800000-d380007f : sata_sil24
d4000000-d4000fff : 0000:00:09.1
  d4000000-d4000fff : sym53c8xx
d4800000-d48000ff : 0000:00:09.1
  d4800000-d48000ff : sym53c8xx
d5000000-d5000fff : 0000:00:09.0
  d5000000-d5000fff : sym53c8xx
d5800000-d58000ff : 0000:00:09.0
  d5800000-d58000ff : sym53c8xx
d6000000-d7cfffff : PCI Bus #01
  d6000000-d6ffffff : 0000:01:00.0
d7f00000-e3ffffff : PCI Bus #01
  d7fe0000-d7ffffff : 0000:01:00.0
  d8000000-dfffffff : 0000:01:00.0
    d8000000-dfffffff : vesafb
e4000000-e7ffffff : 0000:00:00.0
ffff0000-ffffffff : reserved

[8.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Subsystem: ASUSTeK Computer Inc. A7V133/A7V133-C Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 8
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: d6000000-d7cfffff
	Prefetchable memory behind bridge: d7f00000-e3ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: ASUSTeK Computer Inc. A7V133/A7V133-C Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: ASUSTeK Computer Inc. A7V133/A7V133-C Mainboard
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)
	Subsystem: LSI Logic / Symbios Logic Unknown device 1001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 16000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at a400 [size=256]
	Region 1: Memory at d5800000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at d5000000 (32-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at 500a0000 [disabled] [size=64K]

00:09.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)
	Subsystem: LSI Logic / Symbios Logic Unknown device 1001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 16000ns max), Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at a000 [size=256]
	Region 1: Memory at d4800000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at d4000000 (32-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at 500b0000 [disabled] [size=64K]

00:0a.0 RAID bus controller: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller (rev 01)
	Subsystem: Silicon Image, Inc. Unknown device 6124
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at d3800000 (64-bit, non-prefetchable) [size=128]
	Region 2: Memory at d3000000 (64-bit, non-prefetchable) [size=32K]
	Region 4: I/O ports at 9800 [size=16]
	[virtual] Expansion ROM at 50000000 [disabled] [size=512K]
	Capabilities: [64] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO+ RBC=512 OST=12
		Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=12 DMCRS=128 RSCEM- 266MHz- 533MHz-
	Capabilities: [54] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

00:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 9400 [size=128]
	Region 1: Memory at d2800000 (32-bit, non-prefetchable) [size=128]
	[virtual] Expansion ROM at 50080000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Mass storage controller: Promise Technology, Inc. PDC20265 (FastTrak100 Lite/Ultra100) (rev 02)
	Subsystem: Promise Technology, Inc. Ultra100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 9000 [size=8]
	Region 1: I/O ports at 8800 [size=4]
	Region 2: I/O ports at 8400 [size=8]
	Region 3: I/O ports at 8000 [size=4]
	Region 4: I/O ports at 7800 [size=64]
	Region 5: Memory at d2000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at 500c0000 [size=64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV34GL [Quadro FX 500/600 PCI] (rev a1) (prog-if 00 [VGA])
	Subsystem: nVidia Corporation Unknown device 01ba
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at d7fe0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

[8.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: EXABYTE  Model: VXA-2            Rev: 1003
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6V300F0   Rev: VA11
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6V300F0   Rev: VA11
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3300620AS      Rev: 3.AA
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi5 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3300620AS      Rev: 3.AA
  Type:   Direct-Access                    ANSI SCSI revision: 05

[8.7.] Other information

/proc/interrupts

          CPU0
  0:   20507744    XT-PIC-XT        timer
  1:        262    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  5:     962175    XT-PIC-XT        sym53c8xx, uhci_hcd:usb1,
uhci_hcd:usb2
  7:       3678    XT-PIC-XT        parport0
  8:          2    XT-PIC-XT        rtc
 10:    9153035    XT-PIC-XT        ide2, eth0
 11:         30    XT-PIC-XT        sym53c8xx
 12:    1026266    XT-PIC-XT        libata
 14:     840214    XT-PIC-XT        ide0
 15:     569928    XT-PIC-XT        ide1
NMI:      11264
LOC:   20506755
ERR:        234
MIS:          0

Output of dmesg:

Linux version 2.6.19-gentoo-r2 (root@cthulhu) (gcc version 4.1.1 (Gentoo 4.1.1-r3)) #1 Tue Dec 19 22:55:21 PST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffec000 (usable)
 BIOS-e820: 000000003ffec000 - 000000003ffef000 (ACPI data)
 BIOS-e820: 000000003ffef000 - 000000003ffff000 (reserved)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
Entering add_active_range(0, 0, 262124) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   262124
early_node_map[1] active PFN ranges
    0:        0 ->   262124
On node 0 totalpages: 262124
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 255 pages used for memmap
  HighMem zone: 32493 pages, LIFO batch:7
DMI 2.3 present.
Allocating PCI resources starting at 50000000 (gap: 40000000:bfff0000)
Detected 1410.226 MHz processor.
Built 1 zonelists.  Total pages: 260077
Kernel command line: root=/dev/hda3 nmi_watchdog=1 video=vesafb:ywrap,mtrr,1024x768-16@72 splash=verbose,theme:emergence console=tty1 lapic
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Enabling fast FPU save and restore... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034748k/1048496k available (1983k kernel code, 13024k reserved, 756k data, 172k init, 130992k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffaf000 - 0xfffff000   ( 320 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc03b0000 - 0xc03db000   ( 172 kB)
      .data : 0xc02efeff - 0xc03acf44   ( 756 kB)
      .text : 0xc0100000 - 0xc02efeff   (1983 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2822.62 BogoMIPS (lpj=14113144)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0183fbff c1c7fbff 00000000 00000420 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: AMD Athlon(tm) Processor stepping 04
Checking 'hlt' instruction... OK.
checking if image is initramfs... it is
Freeing initrd memory: 792k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc4f0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc520, dseg 0xf0000
PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver
SCSI subsystem initialized
libata version 2.00 loaded.
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
PCI quirk: region e200-e27f claimed by vt82c686 HW-mon
PCI quirk: region e800-e80f claimed by vt82c686 SMB
Boot video device is 0000:01:00.0
PCI: Using IRQ router VIA [1106/0686] at 0000:00:04.0
PCI: setting IRQ 10 as level-triggered
PCI: Found IRQ 10 for device 0000:00:0b.0
PCI: Sharing IRQ 10 with 0000:00:11.0
spurious 8259A interrupt: IRQ7.
PCI: BIOS reporting unknown device 00:48
PCI: Device 0000:00:09.1 not found by BIOS
pnp: 00:12: ioport range 0xe400-0xe47f has been reserved
pnp: 00:12: ioport range 0xe800-0xe83f could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: d6000000-d7cfffff
  PREFETCH window: d7f00000-e3ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered (default)
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
Real Time Clock Driver v1.12ac
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: AGP aperture is 64M @ 0xe4000000
[drm] Initialized drm 1.0.1 20051102
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using get_cycles().
vesafb: unrecognized option mtrr
vesafb: NVIDIA Corporation, NV34 Board - q162-4nz, Chip Rev    (OEM: NVIDIA)
vesafb: VBE version: 3.0
vesafb: protected mode interface info at c000:f0c0
vesafb: pmi: set display start = c00cf0f6, set palette = c00cf160
vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da 
vesafb: VBIOS/hardware doesn't support DDC transfers
vesafb: no monitor limits have been set
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=12288
Console: switching to colour frame buffer device 128x48
fbsplash: console 0 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 0
vesafb: framebuffer at 0xd8000000, mapped to 0xf8880000, using 24576k, total 131072k
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: PS/2 Controller [PNP0303] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PCI: Enabling device 0000:00:0b.0 (0014 -> 0017)
PCI: Found IRQ 10 for device 0000:00:0b.0
PCI: Sharing IRQ 10 with 0000:00:11.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at f8816000.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
input: AT Translated Set 2 keyboard as /class/input/input0
hda: MAXTOR STM3160812A, ATA DISK drive
hda: IRQ probe failed (0xfffffef8)
hdb: WDC WD1600JB-00EVA0, ATA DISK drive
hdb: IRQ probe failed (0xfffffef8)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: IC35L120AVVA07-0, ATA DISK drive
hdc: IRQ probe failed (0xffffbef8)
hdd: WDC WD1200JB-00GVA0, ATA DISK drive
hdd: IRQ probe failed (0xffffbef8)
ide1 at 0x170-0x177,0x376 on irq 15
PDC20265: IDE controller at PCI slot 0000:00:11.0
PCI: Found IRQ 10 for device 0000:00:11.0
PCI: Sharing IRQ 10 with 0000:00:0b.0
PDC20265: chipset revision 2
PDC20265: ROM enabled at 0x500c0000
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7800-0x7807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x7808-0x780f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: IC35L120AVVA07-0, ATA DISK drive
ide2 at 0x9000-0x9007,0x8802 on irq 10
Probing IDE interface ide3...
Probing IDE interface ide3...
hda: max request size: 512KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdb: max request size: 512KiB
hdb: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1
hdc: max request size: 128KiB
hdc: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3
hdd: max request size: 512KiB
hdd: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hdd: cache flushes supported
 hdd: hdd1 hdd2 hdd3
hde: max request size: 128KiB
hde: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
hde: cache flushes supported
 hde: hde1 hde2 hde3
PCI: setting IRQ 5 as level-triggered
PCI: Found IRQ 5 for device 0000:00:09.0
PCI: Sharing IRQ 5 with 0000:00:04.2
PCI: Sharing IRQ 5 with 0000:00:04.3
sym0: <875> rev 0x14 at pci 0000:00:09.0 irq 5
sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.3
scsi 0:0:4:0: Sequential-Access EXABYTE  VXA-2            1003 PQ: 0 ANSI: 2
 target0:0:4: Beginning Domain Validation
 target0:0:4: asynchronous
 target0:0:4: wide asynchronous
 target0:0:4: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
 target0:0:4: Domain Validation skipping write tests
 target0:0:4: Ending Domain Validation
PCI: setting IRQ 11 as level-triggered
PCI: Found IRQ 11 for device 0000:00:09.1
sym1: <875> rev 0x14 at pci 0000:00:09.1 irq 11
sym1: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: SCSI BUS has been reset.
scsi1 : sym-2.2.3
st: Version 20050830, fixed bufsize 32768, s/g segs 256
st 0:0:4:0: Attached scsi tape st0
st0: try direct i/o: yes (alignment 512 B)
st 0:0:4:0: Attached scsi generic sg0 type 1
sata_sil24 0000:00:0a.0: version 0.3
PCI: setting IRQ 12 as level-triggered
PCI: Found IRQ 12 for device 0000:00:0a.0
ata1: SATA max UDMA/100 cmd 0xF8830000 ctl 0x0 bmdma 0x0 irq 12
ata2: SATA max UDMA/100 cmd 0xF8832000 ctl 0x0 bmdma 0x0 irq 12
ata3: SATA max UDMA/100 cmd 0xF8834000 ctl 0x0 bmdma 0x0 irq 12
ata4: SATA max UDMA/100 cmd 0xF8836000 ctl 0x0 bmdma 0x0 irq 12
scsi2 : sata_sil24
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 586114704 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 0
ata1.00: configured for UDMA/100
scsi3 : sata_sil24
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7, max UDMA/133, 586114704 sectors: LBA48 NCQ (depth 31/32)
ata2.00: ata2: dev 0 multi count 0
ata2.00: configured for UDMA/100
scsi4 : sata_sil24
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 31/32)
ata3.00: configured for UDMA/100
scsi5 : sata_sil24
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth 31/32)
ata4.00: configured for UDMA/100
scsi 2:0:0:0: Direct-Access     ATA      Maxtor 6V300F0   VA11 PQ: 0 ANSI: 5
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 2:0:0:0: Attached scsi disk sda
sd 2:0:0:0: Attached scsi generic sg1 type 0
scsi 3:0:0:0: Direct-Access     ATA      Maxtor 6V300F0   VA11 PQ: 0 ANSI: 5
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3
sd 3:0:0:0: Attached scsi disk sdb
sd 3:0:0:0: Attached scsi generic sg2 type 0
scsi 4:0:0:0: Direct-Access     ATA      ST3300620AS      3.AA PQ: 0 ANSI: 5
SCSI device sdc: 586072368 512-byte hdwr sectors (300069 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 586072368 512-byte hdwr sectors (300069 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3
sd 4:0:0:0: Attached scsi disk sdc
sd 4:0:0:0: Attached scsi generic sg3 type 0
scsi 5:0:0:0: Direct-Access     ATA      ST3300620AS      3.AA PQ: 0 ANSI: 5
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2 sdd3
sd 5:0:0:0: Attached scsi disk sdd
sd 5:0:0:0: Attached scsi generic sg4 type 0
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
raid6: int32x1    492 MB/s
raid6: int32x2    560 MB/s
raid6: int32x4    518 MB/s
raid6: int32x8    416 MB/s
raid6: mmxx1     1164 MB/s
raid6: mmxx2     1974 MB/s
raid6: sse1x1    1060 MB/s
raid6: sse1x2    1675 MB/s
raid6: using algorithm sse1x2 (1675 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: measuring checksumming speed
   8regs     :  1910.400 MB/sec
   8regs_prefetch:  1808.800 MB/sec
   32regs    :  1584.800 MB/sec
   32regs_prefetch:  1588.000 MB/sec
   pII_mmx   :  3846.800 MB/sec
   p5_mmx    :  5118.400 MB/sec
raid5: using function: p5_mmx (5118.400 MB/sec)
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Testing NMI watchdog ... OK.
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
Time: tsc clocksource has been installed.
md: invalid raid superblock magic on sdc3
md: sdc3 has invalid sb, not importing!
md: invalid raid superblock magic on sdd3
md: sdd3 has invalid sb, not importing!
md: autorun ...
md: considering sdd2 ...
md:  adding sdd2 ...
md: sdd1 has different UUID to sdd2
md:  adding sdc2 ...
md: sdc1 has different UUID to sdd2
md: sdb3 has different UUID to sdd2
md:  adding sdb2 ...
md: sdb1 has different UUID to sdd2
md: sda3 has different UUID to sdd2
md:  adding sda2 ...
md: sda1 has different UUID to sdd2
md: hde3 has different UUID to sdd2
md: hde2 has different UUID to sdd2
md: hde1 has different UUID to sdd2
md: hdd3 has different UUID to sdd2
md: hdd2 has different UUID to sdd2
md: hdd1 has different UUID to sdd2
md: hdc3 has different UUID to sdd2
md: hdc2 has different UUID to sdd2
md: hdc1 has different UUID to sdd2
md: hda6 has different UUID to sdd2
md: hda5 has different UUID to sdd2
md: created md4
md: bind<sda2>
md: bind<sdb2>
md: bind<sdc2>
md: bind<sdd2>
md: running: <sdd2><sdc2><sdb2><sda2>
raid5: device sdb2 operational as raid disk 0
raid5: device sda2 operational as raid disk 1
raid5: allocated 2116kB for md4
raid5: raid level 5 set md4 active with 2 out of 2 devices, algorithm 2
RAID5 conf printout:
 --- rd:2 wd:2
 disk 0, o:1, dev:sdb2
 disk 1, o:1, dev:sda2
md4: bitmap initialized from disk: read 12/12 pages, set 0 bits, status: 0
created bitmap (187 pages) for device md4
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md: sdb3 has different UUID to sdd1
md:  adding sdb1 ...
md: sda3 has different UUID to sdd1
md:  adding sda1 ...
md: hde3 has different UUID to sdd1
md: hde2 has different UUID to sdd1
md: hde1 has different UUID to sdd1
md: hdd3 has different UUID to sdd1
md: hdd2 has different UUID to sdd1
md: hdd1 has different UUID to sdd1
md: hdc3 has different UUID to sdd1
md: hdc2 has different UUID to sdd1
md: hdc1 has different UUID to sdd1
md: hda6 has different UUID to sdd1
md: hda5 has different UUID to sdd1
md: created md3
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1><sdb1><sda1>
raid5: device sdd1 operational as raid disk 3
raid5: device sdc1 operational as raid disk 2
raid5: device sdb1 operational as raid disk 0
raid5: device sda1 operational as raid disk 1
raid5: allocated 4196kB for md3
raid5: raid level 5 set md3 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:4
 disk 0, o:1, dev:sdb1
 disk 1, o:1, dev:sda1
 disk 2, o:1, dev:sdc1
 disk 3, o:1, dev:sdd1
md3: bitmap initialized from disk: read 12/12 pages, set 0 bits, status: 0
created bitmap (187 pages) for device md3
md: considering sdb3 ...
md:  adding sdb3 ...
md:  adding sda3 ...
md: hde3 has different UUID to sdb3
md: hde2 has different UUID to sdb3
md: hde1 has different UUID to sdb3
md: hdd3 has different UUID to sdb3
md: hdd2 has different UUID to sdb3
md: hdd1 has different UUID to sdb3
md: hdc3 has different UUID to sdb3
md: hdc2 has different UUID to sdb3
md: hdc1 has different UUID to sdb3
md: hda6 has different UUID to sdb3
md: hda5 has different UUID to sdb3
md: created md5
md: bind<sda3>
md: bind<sdb3>
md: running: <sdb3><sda3>
raid5: device sdb3 operational as raid disk 0
raid5: device sda3 operational as raid disk 1
raid5: allocated 2116kB for md5
raid5: raid level 5 set md5 active with 2 out of 2 devices, algorithm 2
RAID5 conf printout:
 --- rd:2 wd:2
 disk 0, o:1, dev:sdb3
 disk 1, o:1, dev:sda3
md5: bitmap initialized from disk: read 12/12 pages, set 0 bits, status: 0
created bitmap (187 pages) for device md5
md: considering hde3 ...
md:  adding hde3 ...
md: hde2 has different UUID to hde3
md: hde1 has different UUID to hde3
md:  adding hdd3 ...
md: hdd2 has different UUID to hde3
md: hdd1 has different UUID to hde3
md:  adding hdc3 ...
md: hdc2 has different UUID to hde3
md: hdc1 has different UUID to hde3
md: hda6 has different UUID to hde3
md:  adding hda5 ...
md: created md2
md: bind<hda5>
md: bind<hdc3>
md: bind<hdd3>
md: bind<hde3>
md: running: <hde3><hdd3><hdc3><hda5>
raid5: device hde3 operational as raid disk 3
raid5: device hdd3 operational as raid disk 2
raid5: device hdc3 operational as raid disk 1
raid5: device hda5 operational as raid disk 0
raid5: allocated 4196kB for md2
raid5: raid level 5 set md2 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:4
 disk 0, o:1, dev:hda5
 disk 1, o:1, dev:hdc3
 disk 2, o:1, dev:hdd3
 disk 3, o:1, dev:hde3
md: considering hde2 ...
md:  adding hde2 ...
md: hde1 has different UUID to hde2
md:  adding hdd2 ...
md: hdd1 has different UUID to hde2
md:  adding hdc2 ...
md: hdc1 has different UUID to hde2
md:  adding hda6 ...
md: created md1
md: bind<hda6>
md: bind<hdc2>
md: bind<hdd2>
md: bind<hde2>
md: running: <hde2><hdd2><hdc2><hda6>
raid5: device hde2 operational as raid disk 3
raid5: device hdd2 operational as raid disk 2
raid5: device hdc2 operational as raid disk 1
raid5: device hda6 operational as raid disk 0
raid5: allocated 4196kB for md1
raid5: raid level 5 set md1 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:4
 disk 0, o:1, dev:hda6
 disk 1, o:1, dev:hdc2
 disk 2, o:1, dev:hdd2
 disk 3, o:1, dev:hde2
md: considering hde1 ...
md:  adding hde1 ...
md:  adding hdd1 ...
md:  adding hdc1 ...
md: created md0
md: bind<hdc1>
md: bind<hdd1>
md: bind<hde1>
md: running: <hde1><hdd1><hdc1>
raid5: device hde1 operational as raid disk 3
raid5: device hdd1 operational as raid disk 2
raid5: device hdc1 operational as raid disk 1
raid5: allocated 4196kB for md0
raid5: raid level 5 set md0 active with 3 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:3
 disk 1, o:1, dev:hdc1
 disk 2, o:1, dev:hdd1
 disk 3, o:1, dev:hde1
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 172k freed
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
i2c_adapter i2c-9191: sensors disabled - enable with force_addr=0xe200
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
PCI: Found IRQ 5 for device 0000:00:04.2
PCI: Sharing IRQ 5 with 0000:00:04.3
PCI: Sharing IRQ 5 with 0000:00:09.0
uhci_hcd 0000:00:04.2: UHCI Host Controller
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:04.2: irq 5, io base 0x0000d400
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
input: PC Speaker as /class/input/input1
PCI: Found IRQ 5 for device 0000:00:04.3
PCI: Sharing IRQ 5 with 0000:00:04.2
PCI: Sharing IRQ 5 with 0000:00:09.0
uhci_hcd 0000:00:04.3: UHCI Host Controller
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:04.3: irq 5, io base 0x0000d000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
usb 1-1: new low speed USB device using uhci_hcd and address 2
parport_pc: VIA parallel port: io=0x378, irq=7
usb 1-1: configuration #1 chosen from 1 choice
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:03: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
usbcore: registered new interface driver hiddev
hiddev96: USB HID v1.10 Device [American Power Conversion Back-UPS XS 1500 LCD FW:837.H4 .D USB FW:H4 ] on usb-0000:00:04.2-1
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
EXT3 FS on hda3, internal journal
lp0: using parport0 (interrupt-driven).
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2008116k swap on /dev/hda2.  Priority:-1 extents:1 across:2008116k
eth0:  setting full-duplex.
device eth0 entered promiscuous mode
process `named' is using obsolete setsockopt SO_BSDCOMPAT
fbsplash: console 1 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 1
fbsplash: console 2 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 2
fbsplash: console 3 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 3
fbsplash: console 4 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 4
fbsplash: console 5 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 5
fbsplash: console 6 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 6
fbsplash: console 7 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 7
fbsplash: console 8 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 8
fbsplash: console 9 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 9
fbsplash: console 10 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 10
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cd8 media 8880 dma 000000a0 fifo 0000
  Flags; bus-master 1, dirty 203390(14) current 203406(14)
  Transmit list 01bea840 vs. c1beaac0.
eth0: command 0x3002 did not complete! Status=0x9000
  0: @c1bea200  length 800005ea status 0c0105ea
  1: @c1bea2a0  length 800005ea status 0c0105ea
  2: @c1bea340  length 800005ea status 0c0105ea
  3: @c1bea3e0  length 800005ea status 0c0105ea
  4: @c1bea480  length 800005ea status 0c0105ea
  5: @c1bea520  length 800005ea status 0c0105ea
  6: @c1bea5c0  length 800005ea status 0c0105ea
  7: @c1bea660  length 800005ea status 0c0105ea
  8: @c1bea700  length 800005ea status 0c0105ea
  9: @c1bea7a0  length 800005ea status 0c0105ea
  10: @c1bea840  length 800005ea status 0c0105ea
  11: @c1bea8e0  length 8000009e status 0c00009e
  12: @c1bea980  length 800005ea status 8c0005ea
  13: @c1beaa20  length 800005ea status 8c0005ea
  14: @c1beaac0  length 800005ea status 0c0105ea
  15: @c1beab60  length 800005ea status 0c0105ea
eth0: Resetting the Tx ring pointer.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cd8 media 8880 dma 000000a0 fifo 0000
  Flags; bus-master 1, dirty 203434(10) current 203450(10)
  Transmit list 01beab60 vs. c1bea840.
  0: @c1bea200  length 800005ea status 0c0005ea
  1: @c1bea2a0  length 800005ea status 0c0005ea
  2: @c1bea340  length 800005ea status 0c0005ea
  3: @c1bea3e0  length 800005ea status 0c0005ea
  4: @c1bea480  length 800005ea status 0c0005ea
  5: @c1bea520  length 80000456 status 0c000456
  6: @c1bea5c0  length 800005ea status 0c0005ea
  7: @c1bea660  length 800005ea status 0c0005ea
  8: @c1bea700  length 80000576 status 8c000576
  9: @c1bea7a0  length 800001a3 status 8c0001a3
  10: @c1bea840  length 800005ea status 0c0105ea
  11: @c1bea8e0  length 800005ea status 0c0105ea
  12: @c1bea980  length 800005ea status 0c0105ea
  13: @c1beaa20  length 800005ea status 0c0105ea
  14: @c1beaac0  length 800005ea status 0c0105ea
  15: @c1beab60  length 800005ea status 0c0005ea
eth0: Resetting the Tx ring pointer.
ata2.00: exception Emask 0x0 SAct 0x7 SErr 0x0 action 0x6 frozen
ata2.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: hard resetting port
ata1.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 frozen
ata1.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: hard resetting port
ata3.00: exception Emask 0x0 SAct 0x7 SErr 0x0 action 0x6 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: hard resetting port
ata4.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 frozen
ata4.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4: hard resetting port
ata2: softreset failed (SRST command error)
ata2: follow-up softreset failed, retrying in 5 secs
ata1: softreset failed (SRST command error)
ata1: follow-up softreset failed, retrying in 5 secs
ata3: softreset failed (SRST command error)
ata3: follow-up softreset failed, retrying in 5 secs
ata4: softreset failed (SRST command error)
ata4: follow-up softreset failed, retrying in 5 secs
ata2: hard resetting port
ata1: hard resetting port
ata3: hard resetting port
ata4: hard resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: failed to set xfermode (err_mask=0x120)
ata2.00: limiting speed to UDMA/66
ata2: failed to recover some devices, retrying in 5 secs
ata1.00: failed to set xfermode (err_mask=0x120)
ata1.00: limiting speed to UDMA/66
ata1: failed to recover some devices, retrying in 5 secs
ata3: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive 0x7)
ATA: abnormal status 0xC7 on port 0xF8834007
ATA: abnormal status 0xC7 on port 0xF8834007
ATA: abnormal status 0xC1 on port 0xF8836007
ATA: abnormal status 0xC1 on port 0xF8836007
ata3.00: configured for UDMA/100
ata3: EH complete
ata4.00: configured for UDMA/100
ata4: EH complete
ata2: hard resetting port
ata1: hard resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/66
ata1: EH complete
ata2.00: configured for UDMA/66
ata2: EH complete
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sdc: 586072368 512-byte hdwr sectors (300069 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cd8 media 8880 dma 000000a0 fifo 0000
  Flags; bus-master 1, dirty 232152(8) current 232168(8)
  Transmit list 01beab60 vs. c1bea700.
  0: @c1bea200  length 800005ea status 0c0005ea
  1: @c1bea2a0  length 800005ea status 0c0005ea
  2: @c1bea340  length 800005ea status 0c0005ea
  3: @c1bea3e0  length 800005ea status 0c0005ea
  4: @c1bea480  length 80000456 status 0c000456
  5: @c1bea520  length 800005ea status 0c0005ea
  6: @c1bea5c0  length 800005ea status 8c0005ea
  7: @c1bea660  length 800005ea status 8c0005ea
  8: @c1bea700  length 800005ea status 0c0105ea
  9: @c1bea7a0  length 800005ea status 0c0105ea
  10: @c1bea840  length 800005ea status 0c0105ea
  11: @c1bea8e0  length 80000162 status 0c010162
  12: @c1bea980  length 800005ea status 0c0105ea
  13: @c1beaa20  length 800005ea status 0c0105ea
  14: @c1beaac0  length 800005ea status 0c0105ea
  15: @c1beab60  length 800005ea status 0c0005ea
eth0: Resetting the Tx ring pointer.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cd8 media 8880 dma 000000a0 fifo 0000
  Flags; bus-master 1, dirty 232152(8) current 232168(8)
  Transmit list 01bea700 vs. c1bea700.
  0: @c1bea200  length 800005ea status 0c0005ea
  1: @c1bea2a0  length 800005ea status 0c0005ea
  2: @c1bea340  length 800005ea status 0c0005ea
  3: @c1bea3e0  length 800005ea status 0c0005ea
  4: @c1bea480  length 80000456 status 0c000456
  5: @c1bea520  length 800005ea status 0c0005ea
  6: @c1bea5c0  length 800005ea status 8c0005ea
  7: @c1bea660  length 800005ea status 8c0005ea
  8: @c1bea700  length 800005ea status 0c0105ea
  9: @c1bea7a0  length 800005ea status 0c0105ea
  10: @c1bea840  length 800005ea status 0c0105ea
  11: @c1bea8e0  length 80000162 status 0c010162
  12: @c1bea980  length 800005ea status 0c0105ea
  13: @c1beaa20  length 800005ea status 0c0105ea
  14: @c1beaac0  length 800005ea status 0c0105ea
  15: @c1beab60  length 800005ea status 0c0005ea
eth0: Resetting the Tx ring pointer.
ata2.00: exception Emask 0x0 SAct 0x7 SErr 0x0 action 0x6 frozen
ata2.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: hard resetting port
ata1.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 frozen
ata1.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: hard resetting port
ata3.00: exception Emask 0x0 SAct 0x7 SErr 0x0 action 0x6 frozen
ata3.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3.00: tag 2 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata3: hard resetting port
ata4.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 frozen
ata4.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4: hard resetting port
ata2: softreset failed (SRST command error)
ata2: follow-up softreset failed, retrying in 5 secs
ata1: softreset failed (SRST command error)
ata1: follow-up softreset failed, retrying in 5 secs
ata3: softreset failed (SRST command error)
ata3: follow-up softreset failed, retrying in 5 secs
ata4: softreset failed (SRST command error)
ata4: follow-up softreset failed, retrying in 5 secs
ata2: hard resetting port
ata1: hard resetting port
ata3: hard resetting port
ata4: hard resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: failed to set xfermode (err_mask=0x120)
ata2.00: limiting speed to UDMA/44
ata2: failed to recover some devices, retrying in 5 secs
ata1.00: failed to set xfermode (err_mask=0x120)
ata1.00: limiting speed to UDMA/44
ata1: failed to recover some devices, retrying in 5 secs
ata3: spurious interrupt (slot_stat 0x0 active_tag -84148995 sactive 0x7)
ATA: abnormal status 0xC7 on port 0xF8834007
ATA: abnormal status 0xC7 on port 0xF8834007
ATA: abnormal status 0xC1 on port 0xF8836007
ATA: abnormal status 0xC1 on port 0xF8836007
ata3.00: configured for UDMA/100
ata3: EH complete
ata4.00: configured for UDMA/100
ata4: EH complete
ata2: hard resetting port
ata1: hard resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/44
ata1: EH complete
ata2.00: configured for UDMA/44
ata2: EH complete
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sdc: 586072368 512-byte hdwr sectors (300069 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdd: 586072368 512-byte hdwr sectors (300069 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back



-- 
Mark Wagner mark@lanfear.net
