Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTDDKTu (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 05:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTDDKTt (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 05:19:49 -0500
Received: from www.kiskapu.hu ([195.56.65.3]:32911 "EHLO leeloo.kiskapu.hu")
	by vger.kernel.org with ESMTP id S263522AbTDDKR6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 05:17:58 -0500
Date: Fri, 4 Apr 2003 12:34:13 +0200 (CEST)
From: "Erno Rigo [McRee]" <mcree@kiskapu.hu>
To: andre@linux-ide.org
Cc: andre@linuxdiskcert.org, linux-kernel@vger.kernel.org
Subject: PROBLEM: hpt372 - drive drops out using dma
Message-ID: <Pine.LNX.4.53.0304041144110.12259@leeloo.kiskapu.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

[1.] hpt372 - driver drops out using dma

[2.] I've just purchased an abit-kd7-raid with an integrated hpt372
controller. I've configured the kernel and experimented the system bios
and pci slot order settings many ways - allways with the same result:
after few random read accesses (movie or mp3 playing, copying files) my
maxtor ide drive simply fails to respond to any read or reset requests.
When i disable dma with hdparm -d0, the problem disappears, but that's a
bit expensive workaround.  The system is working good with the 'official'
hpt372 generic scsi driver
(http://www.highpoint-tech.com/hpt3xx-opensource-v131.tgz), but i cannot
totally disable hpt372 recognition during bootup ('HPT372: detected
chipset, but driver not compiled in!') witch causes a very slow bootup
procedure caused by 'hde: lost interrupt'-s.

[3.] ide, hpt372

[4.] Linux version 2.4.20 (root@mcree) (gcc version 2.95.4 20011002
(Debian prerelease)) #7 2003. ápr. 4., péntek, 11.03.00 CEST

[5.]
output of hdparm -I /dev/hde _before_ the dropout:
-----8<-----------------------------------------------------------------------
/dev/hde:

non-removable ATA device, with non-removable media
        Model Number:           Maxtor 4G120J6
        Serial Number:          G60AQ60E
        Firmware Revision:      GAK819K0
Standards:
        Supported: 1 2 3 4 5 6
        Likely used: 6
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        bytes/track:    0               (obsolete)
        bytes/sector:   0               (obsolete)
        current sector capacity: 16514064
        LBA user addressable sectors = 240121728
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 2048.0kB   ECC bytes: 57   Queue depth: 1
        Standby timer values: spec'd by standard, no device specific minimum
        r/w multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: 3
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    look-ahead
           *    write cache
           *    Power Management feature set
                SMART feature set
                SET MAX security extension
           *    Advanced Power Management feature set
           *    DOWNLOAD MICROCODE cmd
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct
-----8<-----------------------------------------------------------------------

Output of hdparm -I /dev/hde _after_ the dropout:
-----8<-----------------------------------------------------------------------
/dev/hde:

removable ATA device, with non-removable media
Standards:
	Likely used: 1
Configuration:
	Logical 	max 	current
	cylinders
	heads
	sectors/track
	bytes/track:
	bytes/sector:
	LBA user addressable sectors = 0
Capabilities:
	no IORDY
	Cannot perform double-word IO
	r/w multiple sector transfer: not supported
	DMA: not supported
	PIO: pio0
-----8<-----------------------------------------------------------------------

my syslog:
-----8<-----------------------------------------------------------------------
Apr  4 10:44:22 mcree kernel: hde: dma_intr: status=0xff { Busy }
Apr  4 10:44:22 mcree kernel: hde: DMA disabled
Apr  4 10:44:57 mcree kernel: ide2: reset timed-out, status=0xff
Apr  4 10:44:57 mcree kernel: hde: status timeout: status=0xff { Busy }
Apr  4 10:44:57 mcree kernel: hde: drive not ready for command
Apr  4 10:45:27 mcree kernel: ide2: reset timed-out, status=0xff
Apr  4 10:45:27 mcree kernel: end_request: I/O error, dev 21:05 (hde), sector 58956
Apr  4 10:45:27 mcree kernel: end_request: I/O error, dev 21:05 (hde), sector 61700
Apr  4 10:45:27 mcree kernel: end_request: I/O error, dev 21:05 (hde), sector 61701
Apr  4 10:45:27 mcree kernel: end_request: I/O error, dev 21:05 (hde), sector 61702
Apr  4 10:45:27 mcree kernel: end_request: I/O error, dev 21:05 (hde), sector 61703
[...various errors resulting in 'filesystem panic'...]
-----8<-----------------------------------------------------------------------

slow bootup caused by unwanted hpt372 (and attached drive) recognition (i
turned off CONFIG_BLK_DEV_HPT34X in order to be able to use the 'official'
hpt driver, but i still want to use my primary vt8235 controller) - note
the 'lost interrupt'-s and the drive recognition:
-----8<-----------------------------------------------------------------------
Apr  4 11:36:01 mcree kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Apr  4 11:36:01 mcree kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Apr  4 11:36:01 mcree kernel: VP_IDE: IDE controller on PCI bus 00 dev 89
Apr  4 11:36:01 mcree kernel: VP_IDE: chipset revision 6
Apr  4 11:36:01 mcree kernel: VP_IDE: not 100%% native mode: will probe irqs later
Apr  4 11:36:01 mcree kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Apr  4 11:36:01 mcree kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
Apr  4 11:36:01 mcree kernel:     ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:pio
Apr  4 11:36:01 mcree kernel:     ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:DMA, hdd:DMA
Apr  4 11:36:01 mcree kernel: HPT372: IDE controller on PCI bus 00 dev 98
Apr  4 11:36:01 mcree kernel: HPT372: detected chipset, but driver not compiled in!
Apr  4 11:36:01 mcree kernel: HPT372: chipset revision 5
Apr  4 11:36:01 mcree kernel: HPT372: not 100%% native mode: will probe irqs later
Apr  4 11:36:01 mcree kernel:     ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:pio, hdf:pio
Apr  4 11:36:01 mcree kernel:     ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio
Apr  4 11:36:01 mcree kernel: hda: ST360015A, ATA DISK drive
Apr  4 11:36:01 mcree kernel: hdc: ASUS CRW-1610A, ATAPI CD/DVD-ROM drive
Apr  4 11:36:01 mcree kernel: hdd: Pioneer DVD-ROM ATAPIModel DVD-106S 012, ATAPI CD/DVD-ROM drive
Apr  4 11:36:01 mcree kernel: hde: Maxtor 4G120J6, ATA DISK drive
Apr  4 11:36:01 mcree kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Apr  4 11:36:01 mcree kernel: ide1 at 0x170-0x177,0x376 on irq 15
Apr  4 11:36:01 mcree kernel: ide2 at 0xd800-0xd807,0xdc02 on irq 18
Apr  4 11:36:01 mcree kernel: blk: queue c03980c4, I/O limit 4095Mb (mask 0xffffffff)
Apr  4 11:36:01 mcree kernel: hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=7297/255/63, UDMA(100)
Apr  4 11:36:01 mcree kernel: hde: lost interrupt
Apr  4 11:36:01 mcree last message repeated 3 times
Apr  4 11:36:01 mcree kernel: hde: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63
Apr  4 11:36:01 mcree kernel: Partition check:
Apr  4 11:36:01 mcree kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
Apr  4 11:36:01 mcree kernel:  /dev/ide/host2/bus0/target0/lun0:hde: lost interrupt
Apr  4 11:36:01 mcree kernel: hde: lost interrupt
Apr  4 11:36:01 mcree kernel:  p1 <hde: lost interrupt
Apr  4 11:36:01 mcree kernel:  p5 >
Apr  4 11:36:01 mcree kernel: Floppy drive(s): fd0 is 1.44M
Apr  4 11:36:01 mcree kernel: FDC 0 is a post-1991 82077
Apr  4 11:36:01 mcree kernel: loop: loaded (max 8 devices)
-----8<-----------------------------------------------------------------------

The 'official' driver works ok. after the above 'slow boot':
-----8<-----------------------------------------------------------------------
Apr  4 11:36:01 mcree kernel: Device Driver for HPT37x2 ATA RAID Controller
Apr  4 11:36:01 mcree kernel: Version 1.31, Compiled Apr  4 2003 10:58:27
Apr  4 11:36:01 mcree kernel: Found Controller: HPT372 UDMA/ATA133 RAID Controller
Apr  4 11:36:01 mcree kernel: scsi1 : hpt37x2
Apr  4 11:36:01 mcree kernel:   Vendor: Maxtor 4  Model: G120J6            Rev: GAK8
Apr  4 11:36:01 mcree kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Apr  4 11:36:01 mcree kernel: Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Apr  4 11:36:01 mcree kernel: SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
Apr  4 11:36:01 mcree kernel:  /dev/scsi/host1/bus0/target0/lun0: p1 < p5 >
-----8<-----------------------------------------------------------------------

[6.]
It was impossible not to reproduce the problem. 8)
The drive functioned properly for a small (but random) amount of time,
then crashed.

[7.]
[7.1.]
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux mcree 2.4.20 #7 2003. ápr. 4., péntek, 11.03.00 CEST i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
reiserfsprogs          3.x.1b
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         hpt37x2 nvidia

[7.2.]
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2100+
stepping        : 1
cpu MHz         : 1734.084
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3460.30

[7.3.]
hpt37x2                55584   1
nvidia               1546144  10

[7.4.]
cat /proc/ioports
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
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-c0ff : Accton Technology Corporation EN-1216 Ethernet Adapter
  c000-c0ff : tulip
c400-c43f : Ensoniq 5880 AudioPCI
  c400-c43f : es1371
c800-c81f : VIA Technologies, Inc. USB
cc00-cc1f : VIA Technologies, Inc. USB (#2)
d000-d01f : VIA Technologies, Inc. USB (#3)
d400-d40f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  d400-d407 : ide0
  d408-d40f : ide1
d800-d807 : Triones Technologies, Inc. HPT366/368/370/370A/372
  d800-d807 : ide2
dc00-dc03 : Triones Technologies, Inc. HPT366/368/370/370A/372
  dc02-dc02 : ide2
e000-e007 : Triones Technologies, Inc. HPT366/368/370/370A/372
e400-e403 : Triones Technologies, Inc. HPT366/368/370/370A/372
e800-e8ff : Triones Technologies, Inc. HPT366/368/370/370A/372
  e800-e807 : ide2
  e808-e80f : ide3
  e810-e8ff : HPT372

cat /proc/iomem
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d3bff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0029b44f : Kernel code
  0029b450-0031d4f7 : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : nVidia Corporation NV17 [GeForce4 MX440]
  d8000000-d807ffff : nVidia Corporation NV17 [GeForce4 MX440]
e0000000-e3ffffff : PCI device 1106:3189 (VIA Technologies, Inc.)
e4000000-e5ffffff : PCI Bus #01
  e4000000-e4ffffff : nVidia Corporation NV17 [GeForce4 MX440]
e6020000-e60203ff : Accton Technology Corporation EN-1216 Ethernet Adapter
  e6020000-e60203ff : tulip
e6021000-e6021fff : Brooktree Corporation Bt878 Video Capture
  e6021000-e6021fff : bttv
e6022000-e6022fff : Brooktree Corporation Bt878 Audio Capture
e6023000-e60230ff : VIA Technologies, Inc. USB 2.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.]
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189
        Subsystem: ABIT Computer Corp.: Unknown device 1401
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b168 (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Accton Technology Corporation EN-1216 Ethernet Adapter (rev 11)
        Subsystem: Standard Microsystems Corp [SMC]: Unknown device 1255
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min, 63750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at c000 [size=256]
        Region 1: Memory at e6020000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
        Subsystem: Pinnacle Systems Inc.: Unknown device 0012
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at e6021000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
        Subsystem: Pinnacle Systems Inc.: Unknown device 0012
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at e6022000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at c400 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 80) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1401
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 80) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1401
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 0
        Region 4: I/O ports at cc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 80) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1401
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin C routed to IRQ 0
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev 82) (prog-if 20)
        Subsystem: ABIT Computer Corp.: Unknown device 1401
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 0
        Region 0: Memory at e6023000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3177
        Subsystem: VIA Technologies, Inc.: Unknown device 3177
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at d400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 RAID bus controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 05)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d800 [size=8]
        Region 1: I/O ports at dc00 [size=4]
        Region 2: I/O ports at e000 [size=8]
        Region 3: I/O ports at e400 [size=4]
        Region 4: I/O ports at e800 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0171 (rev a3) (prog-if 00 [VGA])
        Subsystem: ABIT Computer Corp.: Unknown device 8f00
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 2: Memory at d8000000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=<none>

[7.6.]
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ASUS     Model: CRW-1610A        Rev: 1.10
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: PIONEER  Model: DVD-ROM DVD-106  Rev: 1.22
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: Maxtor 4 Model: G120J6           Rev: GAK8
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.]
None.

Erno Rigo
