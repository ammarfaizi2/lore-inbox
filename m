Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313120AbSDDJ6P>; Thu, 4 Apr 2002 04:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313121AbSDDJ6I>; Thu, 4 Apr 2002 04:58:08 -0500
Received: from [217.141.151.75] ([217.141.151.75]:8466 "EHLO
	mail.tecnofarmaci.it") by vger.kernel.org with ESMTP
	id <S313120AbSDDJ5y> convert rfc822-to-8bit; Thu, 4 Apr 2002 04:57:54 -0500
Subject: PROBLEM: SCSI emulation failure
From: Ottaviano Incani <incani@tecnofarmaci.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.1 
Date: 04 Apr 2002 12:01:17 +0200
Message-Id: <1017914477.1555.40.camel@era.tf.xrg>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PROBLEM: SCSI emulation failure

DESCRIPTION: We tried to make a Philips CD-RW 1610A work
under Kernel 2.4.2-2 (RedHat 7.1), but we didn't succed.

The drive works fine as a IDE CD-ROM, we can mount it as usual.
The problem arises when we try (following the instructions reported in
the CD-Writing howto) to emulate the drive as a SCSI device. In this
case, we are able neither to mount nor to burn CDs.

Actions performed:

(1) Append the following line to /etc/lilo.conf and update:
	append="hdc=ide-scsi"

(2) Append the following lines to /etc/modules.conf
options ide-cd ignore=hdc
alias scd0 sr_mod
pre-install sg modprobe ide-scsi
pre-install sr_mod modprobe ide-scsi
pre-install ide-scsi modprobe ide-cd

(3) Reboot the system

(4) Cdrecord 1.9-6 seems to recognize the drive, but when we try to
    burn, the program hangs and we must reboot the system.

$ cdrecord -scanbus # outs the following:
Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
Linux sg driver version: 3.1.17
Using libscg version 'schily-0.1'
scsibus0:
        0,0,0     0) 'PHILIPS ' 'CDRW1610A       ' '02B0' Removable CD-ROM
        0,1,0     1) *
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *
$ cdrecord dev=0,0,0 -prcap # outs the following:
Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
scsidev: '0,0,0'
scsibus: 0 target: 0 lun: 0
Linux sg driver version: 3.1.17
Using libscg version 'schily-0.1'
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'PHILIPS '
Identifikation : 'CDRW1610A       '
Revision       : '02B0'
Device seems to be: Generic mmc CD-RW.

Drive capabilities, per page 2A:

  Does read CD-R media
  Does write CD-R media
  Does read CD-RW media
  Does write CD-RW media

  ... ... ... (omissis) ... ... ...

  Maximum read  speed in kB/s: 7056
  Current read  speed in kB/s: 7056
  Maximum write speed in kB/s: 2822
  Current write speed in kB/s: 2822
  Buffer size in KB: 8192



KEYWORDS: SCSI emulations, modules, CD-RW. 


KERNEL VERSION: 2.4.2-2

SYSTEM INFORMATION:

$ cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 9
model name	: AMD-K6(tm) 3D+ Processor
stepping	: 1
cpu MHz		: 400.919
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips	: 799.53

$ cat /proc/modules
sg                     26592   0 (autoclean)
loop                    8960   0 (unused)
nfsd                   69984   8 (autoclean)
autofs                 11136   1 (autoclean)
nfs                    76800   3 (autoclean)
lockd                  52336   1 (autoclean) [nfsd nfs]
sunrpc                 62448   1 (autoclean) [nfsd nfs lockd]
3c509                   7696   1 (autoclean)
ipchains               38944   0 (unused)
ide-scsi                8352   0
scsi_mod               94336   2 [sg ide-scsi]
ide-cd                 27104   0
cdrom                  27392   0 [ide-cd]
usb-uhci               20848   0 (unused)
usbcore                49632   1 [usb-uhci]

$ cat /proc/ioports
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
0300-030f : 3c509
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
e000-e00f : VIA Technologies, Inc. Bus Master IDE
  e000-e007 : ide0
  e008-e00f : ide1
e400-e41f : VIA Technologies, Inc. UHCI USB
  e400-e41f : usb-uhci

$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-00254ea7 : Kernel code
  00254ea8-0026becb : Kernel data
d0000000-d3ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
d4000000-d7ffffff : S3 Inc. 86c764/765 [Trio32/64/64V+]
ffff0000-ffffffff : reserved

$ lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 16
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
	Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at e000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e400 [size=32]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:08.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (rev 53) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

$ cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: PHILIPS  Model: CDRW1610A        Rev: 02B0
  Type:   CD-ROM                           ANSI SCSI revision: 02

$ dmesg # last, very long output!
Linux version 2.4.2-2 (root@porky.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-79)) #1 Sun Apr 8 19:37:14 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000007f00000 @ 0000000000100000 (usable)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone DMA has max 32 cached pages.
zone(1): 28672 pages.
zone Normal has max 224 cached pages.
zone(2): 0 pages.
zone HighMem has max 1 cached pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=307 BOOT_FILE=/boot/vmlinuz-2.4.2-2 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 400.919 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 799.53 BogoMIPS
Memory: 126492k/131072k available (1363k kernel code, 4192k reserved, 92k data, 232k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.5.0 initialized
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb480, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Disabled enhanced CPU to PCI posting #2
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 83912kB/27970kB, 256 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:pio
hda: SAMSUNG SV0432A 010, ATA DISK drive
hdb: IBM-DJAA-31700, ATA DISK drive
hdc: PHILIPS CDRW1610A, ATAPI CD/DVD-ROM drive
hdd: HITACHI CDR-7730, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 8421840 sectors (4312 MB) w/482KiB Cache, CHS=524/255/63, UDMA(33)
hdb: 3334464 sectors (1707 MB) w/96KiB Cache, CHS=827/64/63, DMA
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
 hdb: hdb1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md.c: sizeof(mdp_super_t) = 4096
autodetecting RAID arrays
autorun ...
... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 232k freed
Adding Swap: 273064k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 19:51:15 Apr  8 2001
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
hdd: ATAPI 4X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PHILIPS   Model: CDRW1610A         Rev: 02B0
  Type:   CD-ROM                             ANSI SCSI revision: 02
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
Winbond chip at EFER=0x3f0 key=0x87 devid=fc devrev=21 oldid=0c
Winbond chip type 83877TF
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
parport0: PC-style at 0x378 [PCSPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
ip_conntrack (1024 buckets, 8192 max)
eth0: 3c509 at 0x300, BNC port, address  00 60 8c 92 a0 37, IRQ 11.
3c509.c:1.16 (2.2) 2/3/98 becker@cesdis.gsfc.nasa.gov.
eth0: Setting Rx mode to 1 addresses.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
Winbond chip at EFER=0x3f0 key=0x87 devid=fc devrev=21 oldid=0c
Winbond chip type 83877TF
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
parport0: PC-style at 0x378 [PCSPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
loop: loaded (max 8 devices)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 0x/0x writer tray
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
Device not ready.  Make sure there is a disc in the drive.
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
loop: loaded (max 8 devices)
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
Device not ready.  Make sure there is a disc in the drive.
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 0x/0x writer tray
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 18000002
sd0b:00: old sense key None
Non-extended sense class 0 code 0x0
 I/O error: dev 0b:00, sector 64
isofs_read_super: bread failed, dev=0b:00, iso_blknum=16, block=16


