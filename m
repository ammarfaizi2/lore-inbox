Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271081AbTGPTtt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 15:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271090AbTGPTtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 15:49:49 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:61968 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S271098AbTGPTsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 15:48:55 -0400
Message-ID: <3F15AFA3.9080001@free.fr>
Date: Wed, 16 Jul 2003 22:03:47 +0200
From: patrice <patrice.dietsch@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andre@linux-ide.org, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: bug report : IDE RW16x10/DVD seems detected by the system but is
 not present in /dev (devfs)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think I found a bug in the IDE driver. The bug report is following.

Thank you for help,

Patrice DIETSCH


#[1.] One line summary of the problem:

IDE RW16x10/DVD seems detected by the system but is not present in /dev (devfs)

#[2.] Full description of the problem/report:

In (bad) English (Sorry)
========================
After adding an IDE / COMPACT FLASH adapter (CFDISK.1C / PC Engines / http://www.pcengines.ch/cflash.htm) on the bus ide1 in SLAVE position, the COMBI IDE RW16x10 / DVD (MASTER) is not usable any more in /dev (hdc or scd0 when using ide-scsi). Without this adapter the COMBI is correctly detected and useful. The problem stays when I connect the COMBI in SLAVE and the adapter in MASTER.

On the other hand the card CF is correctly recognized and seems completely useful.

Additional information, when I boot the PC under Windows (XP fr / SP1) both devices are correctly recognized and completely useful. It does not seem to be a hardware problem.

By examining the dmesg file (cf. extracted) I noticed that the COMBI is indeed detected by the kernel, but it does not take into account it afterward.

...
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 6Y060L0, ATA DISK drive
hdb: Maxtor 6Y080L0, ATA DISK drive
hda: DMA disabled
blk: queue c03cb420, I/O limit 4095Mb (mask 0xffffffff)
hdb: DMA disabled
blk: queue c03cb55c, I/O limit 4095Mb (mask 0xffffffff)


>>>>>> the COMBI is detected <<<
>>>      
>>>
hdc: COMBI RW16x10/DVD, ATAPI CD/DVD-ROM drive

>>>>>> the flash Card is detected <<<
>>>      
>>>
hdd: Flash Card, CFA DISK drive

hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdd: set_drive_speed_status: error=0x04 { DriveStatusError }
ide1: Drive 1 didn't accept speed setting. Oh, well.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 120103200 sectors (61493 MB) w/2048KiB Cache, CHS=7476/255/63, UDMA(133)
hdb: host protected area => 1
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=9964/255/63, UDMA(133)
hdd: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdd: task_no_data_intr: error=0x04 { DriveStatusError }
hdd: 128000 sectors (66 MB) w/0KiB Cache, CHS=500/8/32
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 > p3 p4
 /dev/ide/host0/bus0/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
...


En français
===========
Après avoir rajouter un convertisseur IDE/Compact Flash (CFDISK.1C / PC Engines / http://www.pcengines.ch/cflash.htm) sur le bus ide1 en position SLAVE, le COMBI IDE RW16x10/DVD (position MASTER) n'est plus accessible dans /dev (hdc ou scd0 lorsque j'utilise ide-scsi (cas des exemples joints). Sans cet adaptateur le COMBI est correctement detecté et utilisable. Le problème reste lorsque je connecte le COMBI en SLAVE et le converstisseur en MASTER.

Par contre la carte CF est correctement reconnu et semble pleinement utilisable.

Information complémentaire, lorsque je boot le PC sous Windows (XP fr/SP1) les deux équipements sont correctement reconnus et pleinement utilisables. Cela ne semble donc pas être un problème hardware.

En examinant le fichier dmesg (cf. extrait) j'ai constaté que le COMBI est bien detecté par le noyau, mais il n'en tient pas compte par la suite.


#[3.] Keywords (i.e., modules, networking, kernel):

Kernel IDE/CompactFlash CD/DVD


#[4.] Kernel version (from /proc/version):

Linux version 2.4.21-0.13mdk (flepied@bi.mandrakesoft.com) (gcc version 3.2.2 (M
andrake Linux 9.1 3.2.2-3mdk)) #1 Fri Mar 14 15:08:06 EST 2003


#[5.] Output of Oops.. message (if applicable) with symbolic information
#     resolved (see Documentation/oops-tracing.txt)

n/a


#[6.] A small shell script or example program which triggers the
#     problem (if possible)

not possible


#[7.] Environment
#[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux condor2 2.4.21-0.13mdk #1 Fri Mar 14 15:08:06 EST 2003 i686 unknown unknown GNU/Linux

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11x
mount                  2.11x
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.0.24
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.7
Modules Loaded         udf ide-floppy ide-tape snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-via82xx snd-ac97-codec snd-pcm snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device snd-page-alloc snd soundcore nfsd af_packet floppy via-rhine mii ntfs nls_iso8859-15 nls_cp850 vfat fat supermount nls_iso8859-1 jfs ext3 jbd ide-cd cdrom ide-scsi scsi_mod hci_usb bluez scanner loop aes lvm-mod ehci-hcd usb-uhci usbcore rtc


#[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2700+
stepping        : 1
cpu MHz         : 2171.665
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4325.37


#[7.3.] Module information (from /proc/modules):

udf                    90464   0 (autoclean)
ide-floppy             15580   0 (autoclean)
ide-tape               48304   0 (autoclean)
snd-seq-oss            31104   0 (unused)
snd-seq-midi-event      5640   0 [snd-seq-oss]
snd-seq                42608   2 [snd-seq-oss snd-seq-midi-event]
snd-pcm-oss            43556   0
snd-mixer-oss          14488   0 [snd-pcm-oss]
snd-via82xx            14092   0
snd-ac97-codec         40160   0 [snd-via82xx]
snd-pcm                77536   0 [snd-pcm-oss snd-via82xx]
snd-timer              18376   0 [snd-seq snd-pcm]
snd-mpu401-uart         4396   0 [snd-via82xx]
snd-rawmidi            17600   0 [snd-mpu401-uart]
snd-seq-device          5832   0 [snd-seq-oss snd-seq snd-rawmidi]
snd-page-alloc          7732   0 [snd-via82xx snd-pcm]
snd                    40868   0 [snd-seq-oss snd-seq-midi-event snd-seq snd-pcm
-oss snd-mixer-oss snd-via82xx snd-ac97-codec snd-pcm snd-timer snd-mpu401-uart
snd-rawmidi snd-seq-device]
soundcore               6276   0 [snd]
nfsd                   74256   8 (autoclean)
af_packet              14952   0 (autoclean)
floppy                 55132   0
via-rhine              15056   1 (autoclean)
mii                     3832   0 (autoclean) [via-rhine]
ntfs                   76812   2 (autoclean)
nls_iso8859-15          4092   5 (autoclean)
nls_cp850               4316   3 (autoclean)
vfat                   11820   3 (autoclean)
fat                    37944   0 (autoclean) [vfat]
supermount             15296   2 (autoclean)
nls_iso8859-1           3516   7 (autoclean)
jfs                   154684   7 (autoclean)
ext3                   64704   4 (autoclean)
jbd                    48532   4 (autoclean) [ext3]
ide-cd                 33856   0
cdrom                  31648   0 [ide-cd]
ide-scsi               11280   0
scsi_mod              103284   1 [ide-scsi]
hci_usb                 8632   0 (unused)
bluez                  38020   1 [hci_usb]
scanner                10904   0
loop                   14132   0 (autoclean)
aes                    31808   0 (autoclean) [loop]
lvm-mod                61600  22
ehci-hcd               18568   0 (unused)
usb-uhci               24652   0 (unused)
usbcore                72992   1 [hci_usb scanner ehci-hcd usb-uhci]
rtc                     8060   0 (autoclean)

#[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

/proc/ioports

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
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
dc00-dcff : VIA Technologies, Inc. VT6102 [Rhine-II]
  dc00-dcff : via-rhine
e000-e0ff : VIA Technologies, Inc. VT8233 AC97 Audio Controller
  e000-e0ff : VIA8233
e400-e41f : VIA Technologies, Inc. USB
  e400-e41f : usb-uhci
e800-e81f : VIA Technologies, Inc. USB (#2)
  e800-e81f : usb-uhci
ec00-ec1f : VIA Technologies, Inc. USB (#3)
  ec00-ec1f : usb-uhci
fc00-fc0f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  fc00-fc07 : ide0
  fc08-fc0f : ide1

/proc/iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-00260a36 : Kernel code
  00260a37-0037831f : Kernel data
1fff0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
cdd00000-ddcfffff : PCI Bus #01
  d0000000-d7ffffff : nVidia Corporation NV11 [GeForce2 MX]
    d0000000-d3ffffff : vesafb
dde00000-dfefffff : PCI Bus #01
  de000000-deffffff : nVidia Corporation NV11 [GeForce2 MX]
dffffe00-dffffeff : VIA Technologies, Inc. VT6102 [Rhine-II]
  dffffe00-dffffeff : via-rhine
dfffff00-dfffffff : VIA Technologies, Inc. USB 2.0
  dfffff00-dfffffff : ehci-hcd
e0000000-e7ffffff : VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

#[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dde00000-dfefffff
	Prefetchable memory behind bridge: cdd00000-ddcfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7120
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 21
	Region 4: I/O ports at e400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7120
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at e800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7120
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 21
	Region 4: I/O ports at ec00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7120
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 21
	Region 0: Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7120
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 22
	Region 4: I/O ports at fc00 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 50)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7120
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 22
	Region 0: I/O ports at e000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7120
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at dc00 [size=256]
	Region 1: Memory at dffffe00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev b2) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at dfef0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>


#[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: none

#[7.7.] Other information that might be relevant to the problem
#       (please look in /proc and include all information that you
#       think to be relevant):

== dmesg file ==
================

Linux version 2.4.21-0.13mdk (flepied@bi.mandrakesoft.com) (gcc version 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk)) #1 Fri Mar 14 15:08:06 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
found SMP MP-table at 000fb930
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: VIA      Product ID: VT5440B      APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 3 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 1
Kernel command line: BOOT_IMAGE=Mdk-9.1 ro root=30f devfs=mount hdc=ide-scsi acpi=off
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 2171.665 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 4325.37 BogoMIPS
Memory: 515152k/524224k available (1410k kernel code, 8684k reserved, 1118k data, 136k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: CLK_CTL MSR was 6003d22f. Reprogramming to 2003d22f
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2700+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000080
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-17, 2-18, 2-19, 2-20 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 20.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
An unexpected IO-APIC was found. If this kernel release is less than
three months old please report this to linux-smp@vger.kernel.org
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 001 01  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    71
 0d 001 01  0    0    0   0   0    1    1    79
 0e 001 01  0    0    0   0   0    1    1    81
 0f 001 01  0    0    0   0   0    1    1    89
 10 001 01  1    1    0   1   0    1    1    91
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 001 01  1    1    0   1   0    1    1    99
 16 001 01  1    1    0   1   0    1    1    A1
 17 001 01  1    1    0   1   0    1    1    A9
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2171.7213 MHz.
..... host bus clock speed is 334.1108 MHz.
cpu: 0, clocks: 3341108, slice: 1670554
CPU0<T0:3341104,T1:1670544,D:6,S:1670554,C:3341108>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030122
ACPI: Disabled via command line (acpi=off)
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3177] at 00:11.0
PCI->APIC IRQ transform: (B0,I16,P0) -> 21
PCI->APIC IRQ transform: (B0,I16,P1) -> 21
PCI->APIC IRQ transform: (B0,I16,P2) -> 21
PCI->APIC IRQ transform: (B0,I16,P3) -> 21
PCI->APIC IRQ transform: (B0,I17,P0) -> 22
PCI->APIC IRQ transform: (B0,I17,P2) -> 22
PCI->APIC IRQ transform: (B0,I18,P0) -> 23
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI: Via IRQ fixup for 00:10.0, from 11 to 5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
vesafb: framebuffer at 0xd0000000, mapped to 0xe0800000, size 65536k
vesafb: mode is 800x600x16, linelength=1600, pages=3
vesafb: protected mode interface info at c000:c650
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Looking for splash picture.... found (800x600, 25593 bytes).
Console: switching to colour frame buffer device 80x16
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 6Y060L0, ATA DISK drive
hdb: Maxtor 6Y080L0, ATA DISK drive
hda: DMA disabled
blk: queue c03cb420, I/O limit 4095Mb (mask 0xffffffff)
hdb: DMA disabled
blk: queue c03cb55c, I/O limit 4095Mb (mask 0xffffffff)
hdc: COMBI RW16x10/DVD, ATAPI CD/DVD-ROM drive
hdd: Flash Card, CFA DISK drive
hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdd: set_drive_speed_status: error=0x04 { DriveStatusError }
ide1: Drive 1 didn't accept speed setting. Oh, well.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 120103200 sectors (61493 MB) w/2048KiB Cache, CHS=7476/255/63, UDMA(133)
hdb: host protected area => 1
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=9964/255/63, UDMA(133)
hdd: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdd: task_no_data_intr: error=0x04 { DriveStatusError }
hdd: 128000 sectors (66 MB) w/0KiB Cache, CHS=500/8/32
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 > p3 p4
 /dev/ide/host0/bus0/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 46k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Mounted devfs on /dev
Freeing unused kernel memory: 136k freed
VFS: Disk change detected on device 16:40
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
Real Time Clock Driver v1.10e
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 15:32:56 Mar 14 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xec00, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xe800, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 21
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
ehci-hcd 00:10.3: VIA Technologies, Inc. USB 2.0
ehci-hcd 00:10.3: irq 21, pci mem e4940f00
usb.c: new USB bus registered, assigned bus number 4
ehci-hcd 00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2002-Dec-20
hub.c: USB hub found
hub.c: 6 ports detected
usbdevfs: remount parameter error
LVM version 1.0.5+(22/07/2002) module loaded
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
hub.c: connect-debounce failed, port 1 disabled
loop: loaded (max 8 devices)
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
Adding Swap: 257000k swap-space (priority -1)
hub.c: new USB device 00:10.1-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x6bd/0x20fd) is not claimed by any active driver.
hub.c: new USB device 00:10.2-1, assigned address 2
usb-uhci.c: interrupt, status 2, frame# 1862
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: new USB device 00:10.2-1, assigned address 3
usb.c: USB device not accepting new address=3 (error=-110)
hub.c: new USB device 00:10.2-2, assigned address 4
usb.c: USB device 4 (vend/prod 0x45e/0x7e) is not claimed by any active driver.
usb.c: registered new driver usbscanner
scanner.c: 0.4.10:USB Scanner Driver
VFS: Disk change detected on device 16:40
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
BlueZ Core ver 2.2 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ HCI USB driver ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: registered new driver hci_usb
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
 /dev/ide/host0/bus1/target1/lun0: p1 p2 < p5 >
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
MSDOS FS: IO charset iso8859-15
MSDOS FS: Using codepage 850
MSDOS FS: IO charset iso8859-15
MSDOS FS: Using codepage 850
MSDOS FS: IO charset iso8859-15
MSDOS FS: Using codepage 850
NTFS driver 2.1.1a [Flags: R/O MODULE].
NTFS volume version 3.1.
NTFS volume version 3.1.
via-rhine.c:v1.10-LK1.1.15  November-22-2002  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xdc00, 00:10:dc:c8:6a:94, IRQ 23.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 0021.

== end dmesg file ==
====================

#[X.] Other notes, patches, fixes, workarounds:


