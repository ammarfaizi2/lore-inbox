Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264635AbSJOKRT>; Tue, 15 Oct 2002 06:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264637AbSJOKRT>; Tue, 15 Oct 2002 06:17:19 -0400
Received: from carmen.cats.ms ([62.153.217.19]:40709 "EHLO carmen.cats.ms")
	by vger.kernel.org with ESMTP id <S264635AbSJOKRH>;
	Tue, 15 Oct 2002 06:17:07 -0400
From: "Kai Henningsen" <kai@cats.ms>
Organization: Spuentrup CTI
To: linux-kernel@vger.kernel.org
Date: Tue, 15 Oct 2002 12:22:55 +0200
MIME-Version: 1.0
Subject: PROBLEM: 2.4.1[89]: System hangs after "spurious 8259A interrupt: IRQ7"
Reply-to: support-kai@cats.ms
Message-ID: <3DAC089F.13653.6B67D6FF@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From looking through the archives, it seems more people have this 
problem.

I do *NOT* have any NVIDIA code in my kernels.
The problem is *NOT* connected with X.

In fact, the system hangs so soon (typically before or during fsck) 
that I have no usefull 2.4 boot messages to offer - they scroll away 
and then the keyboard locks. (And I can't make too extensive tests on 
this machine, unfortunately, as it's an important server.)

2.2.20 runs without any problems. I *really* want to have this 
machine on 2.4, though ...

Information extracted under 2.2.20:

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1260.034
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 psn mmxext mmx fxsr 3dnowext 3dnow
bogomips        : 2510.02

# cat /proc/modules
ipx                    12944   7 (autoclean)
tulip                  29640   4
usb-uhci               18492   0 (unused)
usbcore                46672   1 [usb-uhci]
dummy                    964   0 (unused)
3c59x                  20740   1
sg                     15056   0 (unused)
# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0778-077a : parport0
6400-647f : eth0
6800-68fe : aic7xxx
7800-787f : eth4
8000-807f : eth3
8400-847f : eth2
8800-887f : eth1
b000-b013 : usb-uhci
b400-b413 : usb-uhci
b800-b807 : ide0
b808-b80f : ide1
# cat /proc/interrupts
           CPU0
  0:      93089          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          3          XT-PIC  rtc
  9:       7728          XT-PIC  usb-uhci, usb-uhci, eth0, eth1, 
eth2, eth3, eth4
 11:         48          XT-PIC  aic7xxx
 13:          1          XT-PIC  fpu
 14:     154718          XT-PIC  ide0
 15:     117969          XT-PIC  ide1
NMI:          0
# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] 
(rev 03)
	Subsystem: Asustek Computer, Inc.: Unknown device 8042
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e6000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 
AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e3800000-e5dfffff
	Prefetchable memory behind bridge: e5f00000-e5ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super 
South] (rev 40)
	Subsystem: Asustek Computer, Inc.: Unknown device 8042
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at b800
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) 
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at b400
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) 
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at b000
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev 40)
	Subsystem: Asustek Computer, Inc.: Unknown device 8042
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 PCI bridge: Digital Equipment Corporation DECchip 21050 (rev 
02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 00007000-00008fff
	Memory behind bridge: e1800000-e37fffff
	Prefetchable memory behind bridge: e5f00000-e5efffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:0c.0 SCSI storage controller: Adaptec AHA-294x / AIC-7871 (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 6800
	Region 1: Memory at e1000000 (32-bit, non-prefetchable)

00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX 
[Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 6400
	Region 1: Memory at e0800000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-
,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 
20265 (rev 02)
	Subsystem: Promise Technology, Inc.: Unknown device 4d33
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 6000
	Region 1: I/O ports at 5800
	Region 2: I/O ports at 5400
	Region 3: I/O ports at 5000
	Region 4: I/O ports at 4800
	Region 5: Memory at e0000000 (32-bit, non-prefetchable)
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP 
(rev 27) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e4000000 (32-bit, non-prefetchable)
	Region 1: I/O ports at d800
	Region 2: Memory at e3800000 (32-bit, non-prefetchable)
	Expansion ROM at e5fe0000 [disabled]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-
,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 
21040 [Tulip] (rev 24)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 8800
	Region 1: Memory at e3000000 (32-bit, non-prefetchable)

02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 
21040 [Tulip] (rev 24)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 8400
	Region 1: Memory at e2800000 (32-bit, non-prefetchable)

02:06.0 Ethernet controller: Digital Equipment Corporation DECchip 
21040 [Tulip] (rev 24)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 8000
	Region 1: Memory at e2000000 (32-bit, non-prefetchable)

02:07.0 Ethernet controller: Digital Equipment Corporation DECchip 
21040 [Tulip] (rev 24)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 7800
	Region 1: Memory at e1800000 (32-bit, non-prefetchable)

# cat /var/log/dmesg
Linux version 2.2.20-lisbeth.53 (root@lisbeth) (gcc version 2.7.2.3) 
#1 Mon Feb 25 10:39:37 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0009f000 @ 00000000 (usable)
 BIOS-e820: 1feec000 @ 00100000 (usable)
Detected 1260034 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2510.02 BogoMIPS
Memory: 516728k/524208k available (1408k kernel code, 412k reserved, 
5588k data, 72k init)
Dentry hash table entries: 65536 (order 7, 512k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 131072 (order 7, 512k)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: L1 I Cache: 64K  L1 D Cache: 64K
CPU: L2 Cache: 256K
CPU: AMD Athlon(tm) Processor stepping 02
Checking 386/387 coupling... OK, FPU using exception 16 error 
reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xf1150
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: 00:48 [1011/0001]: Bridge optimization (00)
    Cache L2: Not supported.
    CPU-PCI posted write: off -> on.
    CPU-Memory posted write: off -> on.
    PCI-Memory posted write: off -> on.
    PCI burst: off -> on.
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 524288 bhash 65536)
NET4: AppleTalk 0.18 for Linux NET4.0
Initializing RT netlink socket
Starting kswapd v 1.5 
parport0: PC-style at 0x378 (0x778) [SPP,ECP,ECPEPP,ECPPS2]
parport0: detected irq 7; use procfs to enable interrupt-driven 
operation.
Serial driver version 4.27 with DETECT_IRQ enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 2048 Unix98 ptys configured
lp0: using parport0 (polling).
Software Watchdog Timer: 0.05, timer margin: 60 sec
Real Time Clock Driver v1.09
loop: registered device at major 7
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
ide0: VIA Bus-Master (U)DMA Timing Config Success
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
ide1: VIA Bus-Master (U)DMA Timing Config Success
hda: IC35L060AVER07-0, ATA DISK drive
hdb: IC35L120AVVA07-0, ATA DISK drive
hdc: IC35L060AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: IC35L060AVER07-0, 58644MB w/1916kB Cache, CHS=7476/255/63
hdb: IC35L120AVVA07-0, 117800MB w/1863kB Cache, CHS=15017/255/63
hdc: IC35L060AVER07-0, 58644MB w/1916kB Cache, CHS=7476/255/63
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
md driver 0.36.6 MAX_MD_DEV=4, MAX_REAL=8
(scsi0) <Adaptec AHA-294X SCSI host adapter> found at PCI 0/12/0
(scsi0) Narrow Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Downloading sequencer code... 415 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 
5.1.33/3.2.4
       <Adaptec AHA-294X SCSI host adapter>
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
scsi : 2 hosts.
  Vendor: SONY      Model: CD-ROM CDU-76S    Rev: 1.1c
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
(scsi0:0:0:1) Synchronous at 5.0 Mbyte/sec, offset 15.
  Vendor: HP        Model: HP35480A          Rev: T603
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Detected scsi tape st0 at scsi0, channel 0, id 3, lun 0
(scsi0:0:3:1) Synchronous at 5.0 Mbyte/sec, offset 8.
scsi : detected 1 SCSI tape 1 SCSI cdrom total.
Uniform CD-ROM driver Revision: 3.11
Partition check:
 hda: hda1 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 >
 hdb: hdb1 hdb2
 hdc: hdc1 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 hdc11 hdc12 hdc13 >
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 72k freed
Adding Swap: 1445808k swap-space (priority -1)
Adding Swap: 1445808k swap-space (priority -2)
3c59x.c 18Feb01 Donald Becker and others 
http://www.scyld.com/network/vortex.html
eth0: 3Com 3c905B Cyclone 100baseTx at 0x6400,  00:50:04:f5:47:95, 
IRQ 9
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate 
interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.237 $ time 10:42:28 Feb 25 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: USB new device connect, assigned device number 1
usb.c: kmalloc IF df1ba060, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: b400
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface df1ba060
usb.c: kusbd: /sbin/hotplug add 1
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 1 enable change, status 300
hub.c: port 2 enable change, status 300
usb.c: kusbd policy returned 0x200
usb-uhci.c: USB UHCI at I/O 0xb000, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
usb.c: USB new device connect, assigned device number 1
usb.c: kmalloc IF df1ba420, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: b000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface df1ba420
usb.c: kusbd: /sbin/hotplug add 1
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 1 enable change, status 300
hub.c: port 2 enable change, status 300
usb.c: kusbd policy returned 0x200
tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
eth1: Digital DC21040 Tulip rev 36 at 0x8800, 00:00:92:93:40:D0, IRQ 
9.
eth2: Digital DC21040 Tulip rev 36 at 0x8400, EEPROM not present, 
00:00:92:93:40:D1, IRQ 9.
eth3: Digital DC21040 Tulip rev 36 at 0x8000, EEPROM not present, 
00:00:92:93:40:D2, IRQ 9.
eth4: Digital DC21040 Tulip rev 36 at 0x7800, EEPROM not present, 
00:00:92:93:40:D3, IRQ 9.
eth0: Initial media type Autonegotiate.
eth0: MII #24 status 786d, link partner capability 45e1, setting full-
duplex.
eth1: No link beat found.
eth2: No link beat found.
eth3: No link beat found.
eth4: No link beat found.


Regards - Kai Henningsen

-- 
http://www.cats.ms
Spuentrup CTI       Fon: +49 700 CALL CATS (=22 55 22 87)
Windbreede 12       Fax: +49 251 322312 99
D-48157 Muenster    Mob: +49 161 322312 1
Germany             GSM: +49 171 7755060

