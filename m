Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265182AbTLKRsQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 12:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbTLKRsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 12:48:02 -0500
Received: from avs.xs4all.nl ([213.84.37.64]:3712 "EHLO airraid.toptracker.com")
	by vger.kernel.org with ESMTP id S265182AbTLKRrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 12:47:05 -0500
Message-ID: <3FD8AD99.3010108@bioscoopagenda.net>
Date: Thu, 11 Dec 2003 18:47:05 +0100
From: Arjan van Staalduijnen <linuxkernel@bioscoopagenda.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: fatal I/O errors on IDE (ATA) device during heavy disc usage
 (2.6.0-test11 kernel)
Content-Type: multipart/mixed;
 boundary="------------040707080506010609060902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040707080506010609060902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

[1.] Fatal I/O errors on IDE (ATA) device during heavy disc usage.

[2.] A few days ago I ran into a reproducable problem when I do a 
specific, disc-intense operation. In my system I use three harddisks, 
all connected to the built-in U-ATA controller.

A few days ago I started attempting inserting a fair amount of records 
into a MySQL 3.23.58 database (standard Red Hat 7.3 updated build), but 
after some time it will result in I/O errors, especially on the 
partition the MySQL-databases are physically stored on. The system will 
not freeze up, but it has become unusable then - no way to recover but 
doing a reboot. So far (a couple of times) I've only noticed the I/O 
errors to be indicating I/O errors for /dev/hdg, which has the slave 
disc attached. This occurs on that disc even though /dev/hde is 
identical (hardware-wise) and should have an equal amount of I/O, 
because of the mirrored partitions being mirrored between these two discs.

I first noticed this problem last weekend, running a 2.6.0-test9 kernel, 
but the problem still occurs under a 2.6.0-test11 kernel. I had been 
running this system under 2.6.0-test9 for some time without problems 
(but under relatively low I/O).

[3.] Keywords: IDE, ATA, I/O error, raid

[4.] Kernel versions used:
Linux version 2.6.0-test9 (root@airraid.toptracker.com) (gcc version 
2.96 20000731 (Red Hat Linux 7.3 2.96-113)) #1 Thu Nov 13 21:53:51 CET 2003
Linux version 2.6.0-test11 (root@airraid.toptracker.com) (gcc version 
2.96 20000731 (Red Hat Linux 7.3 2.96-113)) #1 Thu Dec 11 14:07:13 CET 2003

[5.] The kernel doesn't panic nor oops, but the errors reported are (in 
random order here, since I don't know which comes first):
raid1: hdg2: redirecting sector 4945832 to another mirror
end_request: I/O error, /dev/hdg, sector 5877602
EXT3-fs error (device md2) in start_transaction: Journal has aborted
All messages repeat. After a reboot and the fscks, the system will 
rebuild it's raid arrays...

[6.] I'm unable to produce a shell script which triggers the problem. 
I've attached the .config file for the kernel I use. I've experienced 
this problem with kernels both having multi-mode for IDE/ATA-2 discs 
enabled and disabled.

[7.1] ver_linux output:
Linux airraid.toptracker.com 2.6.0-test11 #1 Thu Dec 11 14:07:13 CET 
2003 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      0.9.12
e2fsprogs              1.27
reiserfsprogs          3.x.0j
quota-tools            3.06.
nfs-utils              0.3.3
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         e1000 3c59x

[7.2] /proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 807.372
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
bogomips        : 1589.24

[7.3] /proc/modules:
e1000 74912 0 - Live 0xf0aa6000
3c59x 32648 0 - Live 0xf0a84000

[7.4] /proc/ioports:
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial
03c0-03df : vga+
03f8-03ff : serial
0cf8-0cff : PCI conf1
8400-843f : 0000:00:11.0
   8400-8407 : ide2
   8408-840f : ide3
   8410-843f : PDC20265
8800-8803 : 0000:00:11.0
   8802-8802 : ide3
9000-9007 : 0000:00:11.0
   9000-9007 : ide3
9400-9403 : 0000:00:11.0
   9402-9402 : ide2
9800-9807 : 0000:00:11.0
   9800-9807 : ide2
a000-a07f : 0000:00:0d.0
   a000-a07f : 0000:00:0d.0
a400-a43f : 0000:00:0a.0
   a400-a43f : e1000
d000-d01f : 0000:00:04.3
   d000-d01f : uhci_hcd
d400-d41f : 0000:00:04.2
   d400-d41f : uhci_hcd
d800-d80f : 0000:00:04.1
   d800-d807 : ide0
   d808-d80f : ide1
e200-e27f : 0000:00:04.4
e400-e4ff : 0000:00:04.4
   e400-e47f : pnp 00:12
e800-e80f : 0000:00:04.4
   e800-e807 : viapro-smbus

/proc/iomem:
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cc000-000ce7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-2ffebfff : System RAM
   00100000-0033dab1 : Kernel code
   0033dab2-003dd53f : Kernel data
2ffec000-2ffeefff : ACPI Tables
2ffef000-2fffefff : reserved
2ffff000-2fffffff : ACPI Non-volatile Storage
de800000-de81ffff : 0000:00:11.0
df000000-df00007f : 0000:00:0d.0
df800000-df81ffff : 0000:00:0a.0
   df800000-df81ffff : e1000
e0000000-e001ffff : 0000:00:0a.0
   e0000000-e001ffff : e1000
e2000000-e2ffffff : 0000:00:0c.0
e4000000-e7ffffff : 0000:00:00.0
ffff0000-ffffffff : reserved

[7.5] lspci -vvv:
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] 
(rev 02)
         Subsystem: Asustek Computer, Inc. A7V Mainboard
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
         Latency: 8
         Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000e000-0000dfff
         Memory behind bridge: e0f00000-e0efffff
         Prefetchable memory behind bridge: e4000000-e3ffffff
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 22)
         Subsystem: Asustek Computer, Inc. A7V Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master 
IDE (rev 10) (prog-if 8a [Master SecP PriP])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at d800 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 5
         Region 4: I/O ports at d400 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 5
         Region 4: I/O ports at d000 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
         Subsystem: Asustek Computer, Inc. A7V Mainboard
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin ? routed to IRQ 9
         Capabilities: [68] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet 
Controller (rev 02)
         Subsystem: Intel Corp. PRO/1000 MT Desktop Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (63750ns min), cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=128K]
         Region 1: Memory at df800000 (32-bit, non-prefetchable) [size=128K]
         Region 2: I/O ports at a400 [size=64]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [e4] PCI-X non-bridge device.
                 Command: DPERE- ERO+ RBC=0 OST=0
                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, 
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
         Capabilities: [f0] Message Signalled Interrupts: 64bit+ 
Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000

00:0c.0 VGA compatible controller: Cirrus Logic GD 5430/40 [Alpine] (rev 
47) (prog-if 00 [VGA])
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Region 0: Memory at e2000000 (32-bit, prefetchable) [size=16M]
         Expansion ROM at e1000000 [disabled] [size=16M]

00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 30)
         Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2500ns min, 2500ns max), cache line size 08
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at a000 [size=128]
         Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 
(rev 02)
         Subsystem: Promise Technology, Inc. Ultra100
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at 9800 [size=8]
         Region 1: I/O ports at 9400 [size=4]
         Region 2: I/O ports at 9000 [size=8]
         Region 3: I/O ports at 8800 [size=4]
         Region 4: I/O ports at 8400 [size=64]
         Region 5: Memory at de800000 (32-bit, non-prefetchable) [size=128K]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [58] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6] No SCSI devices, nor SCSI support compiled into the kernel.

[7.7] /etc/sysconfig/harddisks relevant info:
USE_DMA=1
MULTIPLE_IO=16
EIDE_32BIT=1
LOOKAHEAD=1
EXTRA_PARAMS='-S180 -W1 -u1'

I've played around with disabling sleep on the two master discs, 
disabling DMA on all discs, changing 32bit support to 32bit with sync, 
all to no effect.

mount:
/dev/hde1 on / type ext3 (rw)
none on /proc type proc (rw)
/dev/md1 on /usr type ext3 (rw,noatime)
/dev/md2 on /var type ext3 (rw,noatime)
/dev/md0 on /misc type reiserfs (rw,noatime)
/dev/hdh6 on /misc2 type reiserfs (rw,noatime)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /dev/shm type tmpfs (rw)

/etc/raidtab:
raiddev                 /dev/md0
raid-level              1
nr-raid-disks           2
persistent-superblock   1
chunk-size              8

device                  /dev/hde6
raid-disk               0
device                  /dev/hdg6
raid-disk               1


raiddev                 /dev/md1
raid-level              1
nr-raid-disks           2
persistent-superblock   1
chunk-size              8

device                  /dev/hde2
raid-disk               0
device                  /dev/hdg2
raid-disk               1

raiddev                 /dev/md2
raid-level              1
nr-raid-disks           2
persistent-superblock   1
chunk-size              8

device                  /dev/hde5
raid-disk               0
device                  /dev/hdg5
raid-disk               1

raiddev                 /dev/md3
raid-level              1
nr-raid-disks           2
persistent-superblock   1
chunk-size              8

device                  /dev/hdg1
raid-disk               1
device                  /dev/hde1
raid-disk               0
failed-disk             0

raiddev                 /dev/md5
raid-level              0
nr-raid-disks           2
persistent-superblock   0
chunk-size              8

device                  /dev/hde3
raid-disk               0
device                  /dev/hdg3
raid-disk               1


/dev/hda to /dev/hdd are unused (no devices attached), but the 
controller is detected during bootup. During boot I always see errors 
for hda and hdb (dmesg output snippet):

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:04.1
     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
hda: IRQ probe failed (0xfffffd3a)
hda: IRQ probe failed (0xfffffdba)
hda: no response (status = 0x0a), resetting drive
hda: IRQ probe failed (0xfffffdba)
hda: no response (status = 0x0a)
hdb: IRQ probe failed (0xfffffdba)
hdb: IRQ probe failed (0xfffffdba)
hdb: no response (status = 0x0a), resetting drive
hdb: IRQ probe failed (0xfffffdba)
hdb: no response (status = 0x0a)
PDC20265: IDE controller at PCI slot 0000:00:11.0
PDC20265: chipset revision 2
PDC20265: 100% native mode on irq 11
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
     ide2: BM-DMA at 0x8400-0x8407, BIOS settings: hde:DMA, hdf:pio
     ide3: BM-DMA at 0x8408-0x840f, BIOS settings: hdg:DMA, hdh:DMA
hde: IC35L120AVV207-1, ATA DISK drive
ide2 at 0x9800-0x9807,0x9402 on irq 11
hdg: IC35L120AVV207-1, ATA DISK drive
hdh: IC35L120AVVA07-0, ATA DISK drive
ide3 at 0x9000-0x9007,0x8802 on irq 11
pnp: the driver 'ide' has been registered
hda: IRQ probe failed (0xfffff5ba)
hda: no response (status = 0x0a), resetting drive
hda: no response (status = 0xa1)
hdb: no response (status = 0xa1), resetting drive
hdb: no response (status = 0xa1)
hde: max request size: 1024KiB
hde: 241254720 sectors (123522 MB) w/7965KiB Cache, CHS=16383/255/63, 
UDMA(100)
  hde: hde1 hde2 hde3 hde4 < hde5 hde6 >
hdg: max request size: 1024KiB
hdg: 241254720 sectors (123522 MB) w/7965KiB Cache, CHS=16383/255/63, 
UDMA(100)
  hdg: hdg1 hdg2 hdg3 hdg4 < hdg5 hdg6 >
hdh: max request size: 128KiB
hdh: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=65535/16/63, 
UDMA(100)
  hdh: hdh1 hdh2 hdh3 hdh4 < hdh5 hdh6 >


I have no idea if this is a kernel bug, a hardware problem or some 
over-enthousiasticly tuned harddisk option, but I wouldn't know which 
option would trigger this problem. I have not been overclocked the 
hardware (even though the 800MHz cpu seems to be set to 807MHz).


Regards,

Arjan

PS. I am not subscribed to the linux-kernel mailinglist, so if you wish 
to respond, please send me a CC.

--------------040707080506010609060902
Content-Type: text/plain;
 name="dot-config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dot-config"

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_PROC_INTF=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_24_API=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_PNP=y
CONFIG_PNP_DEBUG=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_INET_IPCOMP=y
CONFIG_NETFILTER=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_XFRM=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_NET_PCI=y
CONFIG_E1000=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_VIAPRO=y
CONFIG_I2C_SENSOR=y
CONFIG_SENSORS_VIA686A=y
CONFIG_HW_RANDOM=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_PRINTER=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_XFS_FS=m
CONFIG_MINIX_FS=m
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_CRAMFS=m
CONFIG_UFS_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_SMB_FS=m
CONFIG_CIFS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_DEFLATE=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--------------040707080506010609060902--

