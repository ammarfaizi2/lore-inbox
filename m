Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264367AbUEMSUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbUEMSUi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 14:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUEMSUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 14:20:37 -0400
Received: from mx2.mail.ru ([194.67.23.122]:20998 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S264367AbUEMSUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 14:20:08 -0400
Message-ID: <40A3BD4E.5050900@list.ru>
Date: Thu, 13 May 2004 22:24:14 +0400
From: Andrew Gusev <ronne@list.ru>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug in IDE/ATAPI CDROM DRIVER
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jens Axboe,
I'm try to report bug.

[1.] ide-cd: cmd 0x5a timed out, hdd: lost interrupt
[2.] I'm have configuration file from good working kernel 2.6.5.
Patch kernel 2.6.5 to kernel 2.6.6. Do: make oldconfig. There is
changes in configuration files:
22a23
 > # CONFIG_POSIX_MQUEUE is not set
24a26
 > # CONFIG_AUDIT is not set
35a38
 > CONFIG_IOSCHED_CFQ=y
426,427d428
< # CONFIG_DECNET is not set
< # CONFIG_BRIDGE is not set
481a483
 > # CONFIG_IP_NF_RAW is not set
487a490
 > # CONFIG_BRIDGE is not set
488a492
 > # CONFIG_DECNET is not set
508a513,517
 > # CONFIG_NETPOLL is not set
 > # CONFIG_NET_POLL_CONTROLLER is not set
 > # CONFIG_HAMRADIO is not set
 > # CONFIG_IRDA is not set
 > # CONFIG_BT is not set
509a519,522
 > # CONFIG_DUMMY is not set
 > # CONFIG_BONDING is not set
 > # CONFIG_EQUALIZER is not set
 > # CONFIG_TUN is not set
515,518d527
< # CONFIG_DUMMY is not set
< # CONFIG_BONDING is not set
< # CONFIG_EQUALIZER is not set
< # CONFIG_TUN is not set
535d543
< # CONFIG_SIS190 is not set
542a551,566
 > # CONFIG_S2IO is not set
 >
 > #
 > # Token Ring devices
 > #
 > # CONFIG_TR is not set
 >
 > #
 > # Wireless LAN (non-hamradio)
 > #
 > # CONFIG_NET_RADIO is not set
 >
 > #
 > # Wan interfaces
 > #
 > # CONFIG_WAN is not set
555,564d578
<
< #
< # Wireless LAN (non-hamradio)
< #
< # CONFIG_NET_RADIO is not set
<
< #
< # Token Ring devices
< #
< # CONFIG_TR is not set
571,592d584
< # Wan interfaces
< #
< # CONFIG_WAN is not set
<
< #
< # Amateur Radio support
< #
< # CONFIG_HAMRADIO is not set
<
< #
< # IrDA (infrared) support
< #
< # CONFIG_IRDA is not set
<
< #
< # Bluetooth support
< #
< # CONFIG_BT is not set
< # CONFIG_NETPOLL is not set
< # CONFIG_NET_POLL_CONTROLLER is not set
<
< #
933a926
 > # CONFIG_USB_PEGASUS is not set
957a951
 > # CONFIG_USB_CYTHERM is not set
1006a1001
 > CONFIG_SYSFS=y
1104a1100
 > # CONFIG_4KSTACKS is not set
1121a1118
 > # CONFIG_LIBCRC32C is not set
1124a1122
 > CONFIG_X86_STD_RESOURCES=y


On boot new kernel, I see such things (dmesg):

ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:DMA
hda: QUANTUM FIREBALLP LM20.5, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdd: _NEC NR-7700A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 40132503 sectors (20547 MB) w/1900KiB Cache, CHS=39813/16/63, UDMA(66)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
ide-cd: cmd 0x5a timed out
hdd: lost interrupt
ide-cd: cmd 0x5a timed out
hdd: lost interrupt
ide-cd: cmd 0x5a timed out
hdd: lost interrupt
hdd: lost interrupt
hdd: lost interrupt
hdd: lost interrupt
ide-cd: cmd 0x3 timed out
hdd: lost interrupt
hdd: lost interrupt
hdd: lost interrupt
hdd: lost interrupt
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(25)
Uniform CD-ROM driver Revision: 3.20
hdd: lost interrupt
ide-cd: cmd 0x3 timed out
hdd: lost interrupt
ide-cd: cmd 0x25 timed out
hdd: lost interrupt
hdd: lost interrupt
ide-cd: cmd 0x3 timed out
hdd: lost interrupt
ide-floppy driver 0.99.newide

There is different between log file kernels 2.6.5 and 2.6.6:

kernels 2.6.5:

May 12 23:53:25 darkstar kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
May 12 23:53:25 darkstar kernel: ide: Assuming 33MHz system bus speed 
for PIO modes; override with idebus=xx
May 12 23:53:25 darkstar kernel: ICH: IDE controller at PCI slot 
0000:00:1f.1
May 12 23:53:25 darkstar kernel: ICH: chipset revision 2
May 12 23:53:25 darkstar kernel: ICH: not 100%% native mode: will probe 
irqs later
May 12 23:53:25 darkstar kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS 
settings: hda:DMA, hdb:pio
May 12 23:53:25 darkstar kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS 
settings: hdc:pio, hdd:DMA
May 12 23:53:25 darkstar kernel: hda: 40132503 sectors (20547 MB) 
w/1900KiB Cache, CHS=39813/16/63, UDMA(66)
May 12 23:53:25 darkstar kernel:  hda: hda1 hda2 < hda5 hda6 hda7 hda8 
hda9 >
May 12 23:53:25 darkstar kernel: Uniform CD-ROM driver Revision: 3.20

kernels 2.6.6:

May 12 23:48:08 darkstar kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00alpha2
May 12 23:48:08 darkstar kernel: ide: Assuming 33MHz system bus speed 
for PIO modes; override with idebus=xx
May 12 23:48:08 darkstar kernel: ICH: IDE controller at PCI slot 
0000:00:1f.1
May 12 23:48:08 darkstar kernel: ICH: chipset revision 2
May 12 23:48:08 darkstar kernel: ICH: not 100%% native mode: will probe 
irqs later
May 12 23:48:08 darkstar kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS 
settings: hda:DMA, hdb:pio
May 12 23:48:08 darkstar kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS 
settings: hdc:pio, hdd:DMA
May 12 23:48:08 darkstar kernel: hda: 40132503 sectors (20547 MB) 
w/1900KiB Cache, CHS=39813/16/63, UDMA(66)
May 12 23:48:08 darkstar kernel:  hda: hda1 hda2 < hda5 hda6 hda7 hda8 
hda9 >
May 12 23:48:08 darkstar kernel: ide-cd: cmd 0x5a timed out
May 12 23:48:08 darkstar last message repeated 2 times
May 12 23:48:08 darkstar kernel: ide-cd: cmd 0x3 timed out
May 12 23:48:08 darkstar kernel: Uniform CD-ROM driver Revision: 3.20
May 12 23:48:08 darkstar kernel: ide-cd: cmd 0x3 timed out
May 12 23:48:08 darkstar kernel: ide-cd: cmd 0x25 timed out
May 12 23:48:08 darkstar kernel: ide-cd: cmd 0x3 timed out

[3.] ide-cd.
[4.] Linux version 2.6.6 (metal@darkstar) (gcc version 3.2.3) #1 Sun Apr 
4 21:16:26 MSD 2004

[7.1] Slackware 9.1 script:
Linux darkstar 2.6.6 #1 Thu May 13 00:38:06 MSD 2004 i686 unknown 
unknown GNU/Linux
 
Gnu C                  3.2.3
Gnu make               3.80
binutils               2.14.90.0.6
util-linux             2.12
mount                  2.12
module-init-tools      0.9.14
e2fsprogs              1.34
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.3
Procps                 2.0.16
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         autofs4

[7.2]processor:
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 8
model name    : Pentium III (Coppermine)
stepping    : 3
cpu MHz        : 704.313
cache size    : 256 KB
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 2
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips    : 1392.64

[7.3]modules:
autofs4 15616 1 - Live 0xd399c000
[7.4.] driver and hardware information
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
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-407f : 0000:00:1f.0
  4008-400b : ACPI timer
  4010-4015 : ACPI CPU throttle
4080-40bf : 0000:00:1f.0
5000-500f : 0000:00:1f.3
c000-c007 : 0000:02:05.0
  c000-c007 : au8830
c400-c407 : 0000:02:05.0
  c400-c407 : au8830
d000-d01f : 0000:00:1f.2
f000-f00f : 0000:00:1f.1
  f000-f007 : ide0
  f008-f00f : ide1

/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbbff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-002e0ed4 : Kernel code
  002e0ed5-003908ff : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d7ffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
    d0000000-d1ffffff : rivafb
d8000000-dbffffff : 0000:00:00.0
dc000000-ddffffff : PCI Bus #01
  dc000000-dcffffff : 0000:01:00.0
    dc000000-dcffffff : rivafb
de000000-de03ffff : 0000:02:05.0
  de000000-de03ffff : au8830
ffb00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and 
Memory Controller Hub (rev 02)
    Subsystem: Intel Corp. 82815 815 Chipset Host Bridge and Memory 
Controller Hub
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
    Latency: 0
    Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
    Capabilities: [88] #09 [f104]
    Capabilities: [a0] AGP version 2.0
        Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
        Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev 02) 
(prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: dc000000-ddffffff
    Prefetchable memory behind bridge: d0000000-d7ffffff
    BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02) (prog-if 00 
[Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
    I/O behind bridge: 0000c000-0000cfff
    Memory behind bridge: de000000-de0fffff
    Prefetchable memory behind bridge: fff00000-000fffff
    BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02) (prog-if 80 
[Master])
    Subsystem: Intel Corp. 82801AA IDE
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Region 4: I/O ports at f000 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02) (prog-if 00 [UHCI])
    Subsystem: Intel Corp. 82801AA USB
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Interrupt: pin D routed to IRQ 15
    Region 4: I/O ports at d000 [size=32]

00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
    Subsystem: Intel Corp. 82801AA SMBus
    Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin B routed to IRQ 5
    Region 4: I/O ports at 5000 [size=16]

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 
MX/MX 400] (rev a1) (prog-if 00 [VGA])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (1250ns min, 250ns max)
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
    Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
    Expansion ROM at <unassigned> [disabled] [size=64K]
    Capabilities: [60] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [44] AGP version 2.0
        Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 
64bit- FW+ AGP3- Rate=x1,x2,x4
        Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

02:05.0 Multimedia audio controller: Aureal Semiconductor Vortex 2 (rev fe)
    Subsystem: Diamond Multimedia Systems Monster Sound II
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (1000ns min, 3000ns max), cache line size 08
    Interrupt: pin A routed to IRQ 10
    Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=256K]
    Region 1: I/O ports at c000 [size=8]
    Region 2: I/O ports at c400 [size=8]
    Capabilities: [dc] Power Management version 1
        Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
NO

[8] When reboot system with new kernel hard drive  suspended and wake up.
On kernel 2.6.5 there isn't such thing.

I write cdrecord dev=ATAPI -scanbus
On kernel 2.6.5 :
Cdrecord 2.00.3 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
Using libscg version 'schily-0.7'
scsibus0:
    0,0,0      0) *
    0,1,0      1) '_NEC    ' 'NR-7700A        ' '1.05' Removable CD-ROM
    0,2,0      2) *
    0,3,0      3) *
    0,4,0      4) *
    0,5,0      5) *
    0,6,0      6) *
    0,7,0      7) *

On kernel 2.6.6 :
Cdrecord go in endless.

Hope my letter wasn't trush:).

Andrew Gusev.

