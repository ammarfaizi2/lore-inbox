Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268026AbTBMMCF>; Thu, 13 Feb 2003 07:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268027AbTBMMCF>; Thu, 13 Feb 2003 07:02:05 -0500
Received: from mta01ps.bigpond.com ([144.135.25.133]:971 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S268026AbTBMMB6> convert rfc822-to-8bit; Thu, 13 Feb 2003 07:01:58 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: PROBLEM: CD-RW doesn't work well in 2.4.21-pre4(-ac4)
Date: Thu, 13 Feb 2003 23:12:04 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302132312.04499.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
CD/RW doesn't work well in 2.4.21-pre4 and 2.4.21-pre4-ac4, while it's fine 
with 2.4.20 (and 2.4.19, and before).

[2.] Full description of the problem/report:
When I try to burn, the cdrecord utility errors out and fails. I see some 
kernel error messages at the same time. And yes I tried using different media 
too.

Here is the entire cdrecord session:
[root@localhost data]# cdrecord -v dev=0,0,0 speed=4 blank=fast backup.iso
Cdrecord 1.10 (i686-pc-linux-gnu) Copyright (C) 1995-2001 J?rg Schilling
TOC Type: 1 = CD-ROM
scsidev: '0,0,0'
scsibus: 0 target: 0 lun: 0
Linux sg driver version: 3.1.24
Using libscg version 'schily-0.5'
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'RICOH   '
Identifikation : 'CD-R/RW MP7083A '
Revision       : '1.20'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : SWABAUDIO
Drive buf size : 1343488 = 1312 KB
FIFO size      : 4194304 = 4096 KB
Track 01: data   18 MB
Total size:      21 MB (02:06.74) = 9506 sectors
Lout start:      21 MB (02:08/56) = 9506 sectors
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 5
  Reference speed: 2
  Is not unrestricted
  Is erasable
  ATIP start of lead in:  -11615 (97:27/10)
  ATIP start of lead out: 335925 (74:41/00)
  speed low: 0 speed high: 4
  power mult factor: 4 5
  recommended erase/write power: 3
  A2 values: 00 00 00
Disk type:    Phase change
Manuf. index: 18
Manufacturer: Plasmon Data systems Ltd.
Blocks total: 335925 Blocks current: 149736 Blocks remaining: 140230
Starting to write CD/DVD at speed 4 in write mode for single session.
Last chance to quit, starting real write in 0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
Blanking PMA, TOC, pregap
cdrecord: Input/output error. blank unit: scsi sendcmd: no error
CDB:  A1 01 00 00 00 00 00 00 00 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 06 00 00 00 00 0C 00 00 00 00 29 00 00 00
Sense Key: 0x6 Unit Attention, Segment 0
Sense Code: 0x29 Qual 0x00 (power on, reset, or bus device reset occurred) Fru 
0x0
Sense flags: Blk 0 (not valid)
cmd finished after 25.134s timeout 9600s
cdrecord: Cannot blank disk, aborting.
cdrecord: fifo had 64 puts and 0 gets.
cdrecord: fifo was 0 times empty and 0 times full, min fill was 100%.

Here is what I find in the kernel logs:
scsi : aborting command due to timeout : pid 287, scsi0, channel 0, id 0, lun 
0
Test Unit Ready 00 00 00 00 00
scsi : aborting command due to timeout : pid 287, scsi0, channel 0, id 0, lun 
0
Test Unit Ready 00 00 00 00 00
SCSI host 0 abort (pid 287) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
hdb: DMA disabled
hdb: ATAPI reset complete
scsi : aborting command due to timeout : pid 287, scsi0, channel 0, id 0, lun 
0
Test Unit Ready 00 00 00 00 00
SCSI host 0 abort (pid 287) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
hda: ATAPI reset complete
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command

While I see identical scsi error messages on 2.4.20, cdrecord completes the cd 
burning successfully.

 [3.] Keywords (i.e., modules, networking, kernel):
ide-scsi, scsi_mod, sg, cdrom etc..

[4.] Kernel version (from /proc/version):
Linux version 2.4.21-pre4 (hari@localhost.localdomain) (gcc version 3.2 
20020903 (Red Hat Linux 8.0 3.2-7)) #12 Thu Feb 13 21:39:46 EST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)
I use cdrecord utility.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux localhost.localdomain 2.4.21-pre4 #12 Thu Feb 13 21:39:46 EST 2003 i686 
athlon i386 GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         ipt_state ip_conntrack ppp_deflate zlib_inflate 
zlib_deflate ppp_async serial ppp_generic slhc sr_mod emu10k1 ac97_codec 
soundcore radeon agpgart af_packet ipt_REJECT iptable_filter ip_tables 
ide-scsi scsi_mod ide-cd cdrom raid0 md rtc unix

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1200.072
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2392.06

[7.3.] Module information (from /proc/modules):
ipt_state               1080  36 (autoclean)
ip_conntrack           26592   1 (autoclean) [ipt_state]
ppp_deflate             4472   1 (autoclean)
zlib_inflate           21476   0 (autoclean) [ppp_deflate]
zlib_deflate           20984   0 (autoclean) [ppp_deflate]
ppp_async               9376   1 (autoclean)
serial                 50532   1 (autoclean)
ppp_generic            20060   3 (autoclean) [ppp_deflate ppp_async]
slhc                    7076   1 (autoclean) [ppp_generic]
sr_mod                 15960   0 (autoclean)
emu10k1                63560   0 (autoclean)
ac97_codec             13576   0 (autoclean) [emu10k1]
soundcore               6532   4 (autoclean) [emu10k1]
radeon                 87608   5
agpgart                20252   3
af_packet              11464   0 (autoclean)
ipt_REJECT              3928   0 (autoclean)
iptable_filter          2412   1 (autoclean)
ip_tables              14648   3 [ipt_state ipt_REJECT iptable_filter]
ide-scsi               12080   0
scsi_mod               98964   2 [sr_mod ide-scsi]
ide-cd                 35484   0
cdrom                  33312   0 [sr_mod ide-cd]
raid0                   3912   4 (autoclean)
md                     51968   8 [raid0]
rtc                     8476   0 (autoclean)
unix                   17832 173 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports:
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
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
9000-9fff : PCI Bus #01
  9000-90ff : ATI Technologies Inc Radeon VE QY
a000-a003 : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Controller
a400-a40f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  a400-a407 : ide0
  a408-a40f : ide1
a800-a81f : VIA Technologies, Inc. USB
ac00-ac1f : VIA Technologies, Inc. USB (#2)
c000-c01f : Creative Labs SB Live! EMU10k1
  c000-c01f : EMU10K1
c400-c407 : Creative Labs SB Live! MIDI/Game Port

/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-001e6dca : Kernel code
  001e6dcb-0021a2df : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d7ffffff : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System 
Controller
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : ATI Technologies Inc Radeon VE QY
e0000000-e1ffffff : PCI Bus #01
  e1000000-e100ffff : ATI Technologies Inc Radeon VE QY
e2000000-e2000fff : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System 
Controller
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System 
Controller (rev 12)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at e2000000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at a000 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP Bridge 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE 
(rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at a400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at a800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at ac00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at c000 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
06)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at c400 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY (prog-if 
00 [VGA])
        Subsystem: Unknown device 1787:0202
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 9000 [size=256]
        Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=15 SBA+ AGP+ 64bit- FW- Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: RICOH    Model: CD-R/RW MP7083A  Rev: 1.20
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
.config (relevant IDE and SCSI sections): 
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y

Kernel boot log (only IDE and SCSI section):
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALL CX10.2A, ATA DISK drive
hdb: RICOH CD-R/RW MP7083A, ATAPI CD/DVD-ROM drive
hda: DMA disabled
blk: queue c0277460, I/O limit 4095Mb (mask 0xffffffff)
hdb: DMA disabled
hdc: SAMSUNG SV1022D, ATA DISK drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-113 0113, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
blk: queue c02778ac, I/O limit 4095Mb (mask 0xffffffff)
hdd: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=1247/255/63
hdc: host protected area => 1
hdc: 19931184 sectors (10205 MB) w/472KiB Cache, CHS=19773/16/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
 hdc:<6> [PTBL] [1240/255/63] hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 >
[...]
hdd: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: RICOH     Model: CD-R/RW MP7083A   Rev: 1.20
  Type:   CD-ROM                             ANSI SCSI revision: 02
[...]
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
cdrom: This disc doesn't have any tracks I recognize!

As long as I remember every kernel version between 2.2.18 to 2.4.20 (including 
nearly every pre release too) I don't recollect ever linux had failed to burn 
a CD. Honestly, I used to say everyone Linux never failed to burn a CD on my 
computer. I burn a backup copy of my home drive approximately every alternate 
week for the past couple of years using the same drive. And yes this is the 
very first time it failed.

Please cc me on reply, Thanks.
-- 
Hari
harisri@bigpond.com

