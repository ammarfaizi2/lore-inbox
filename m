Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261999AbTDACY7>; Mon, 31 Mar 2003 21:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbTDACY7>; Mon, 31 Mar 2003 21:24:59 -0500
Received: from ns.conceptual.net.au ([203.190.192.15]:15261 "EHLO
	conceptual.net.au") by vger.kernel.org with ESMTP
	id <S261999AbTDACYw>; Mon, 31 Mar 2003 21:24:52 -0500
Message-ID: <3E88FA24.7040406@seme.com.au>
Date: Tue, 01 Apr 2003 10:32:04 +0800
From: Brad Campbell <brad@seme.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: via-rhine problem on EPIAV-1Ghz 2.4.21-pre6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SFilter: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day all,
I have a problem with the via-rhine on this board timing out.
Seems to be the same problem that keeps cropping up in the archives.
I also tried the via-supplied linuxfet driver, but that locked up solid
under full load, whereas the kernel driver just kept pausing and reseting.
This is easy to reproduce and will die on demand :p)


I have inlined lspci -v, dmesg of boot and the error occuring, a dmesg
snip of the linuxfet driver errors, ifconfig and my .config.
I can perform any sort of testing required on this box.
Oh, I forgot lsmod..
modules loaded. nfsd, lockd, sunrpc, tulip, via-rhine, mii


00:00.0 Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] 
(rev 05)
	Subsystem: VIA Technologies, Inc.: Unknown device aa03
	Flags: bus master, medium devsel, latency 8
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP] 
(prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e8000000-eaffffff
	Capabilities: <available only to root>

00:11.0 ISA bridge: VIA Technologies, Inc. VT8231 [PCI-to-ISA Bridge] 
(rev 10)
	Subsystem: VIA Technologies, Inc.: Unknown device aa03
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: <available only to root>

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc.: Unknown device aa03
	Flags: bus master, medium devsel, latency 32
	I/O ports at d000 [size=16]
	Capabilities: <available only to root>

00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1e) 
(prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc.: Unknown device aa03
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at d400 [size=32]
	Capabilities: <available only to root>

00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1e) 
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at d800 [size=32]
	Capabilities: <available only to root>

00:11.4 Bridge: VIA Technologies, Inc. VT8235 Power Management (rev 10)
	Subsystem: VIA Technologies, Inc. VT8235 Power Management
	Flags: medium devsel
	Capabilities: <available only to root>

00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 40)
	Subsystem: VIA Technologies, Inc.: Unknown device aa03
	Flags: medium devsel, IRQ 10
	I/O ports at dc00 [size=256]
	I/O ports at e000 [size=4]
	I/O ports at e400 [size=4]
	Capabilities: <available only to root>

00:12.0 Ethernet controller: VIA Technologies, Inc. Ethernet Controller 
(rev 51)
	Subsystem: VIA Technologies, Inc.: Unknown device 0102
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at e800 [size=256]
	Memory at ec001000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:14.0 Ethernet controller: Digital Equipment Corporation DECchip 
21142/43 (rev 41)
	Subsystem: Ruby Tech Corp.: Unknown device 1430
	Flags: bus master, medium devsel, latency 32, IRQ 15
	I/O ports at ec00 [size=128]
	Memory at ec000000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1 
(rev 6a) (prog-if 00 [VGA])
	Subsystem: Trident Microsystems CyberBlade/i1
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
	Memory at e9800000 (32-bit, non-prefetchable) [size=8M]
	Memory at ea000000 (32-bit, non-prefetchable) [size=128K]
	Memory at e9000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

Linux version 2.4.21-pre6 (brad@bkserver) (gcc version 2.95.4 20011002 
(Debian prerelease)) #3 Tue Apr 1 09:56:34 WST 2003
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000077f0000 (usable)
  BIOS-e820: 00000000077f0000 - 00000000077f3000 (ACPI NVS)
  BIOS-e820: 00000000077f3000 - 0000000007800000 (ACPI data)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
119MB LOWMEM available.
On node 0 totalpages: 30704
zone(0): 4096 pages.
zone(1): 26608 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=2421 root=301
Initializing CPU#0
Detected 1000.059 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1992.29 BogoMIPS
Memory: 119248k/122816k available (1014k kernel code, 3184k reserved, 
287k data, 224k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: L1 I Cache: 64K (32 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 64K (32 bytes/line)
CPU:     After generic, caps: 00803135 80803035 00000000 00000000
CPU:             Common caps: 00803135 80803035 00000000 00000000
CPU: Centaur VIA C3 Ezra stepping 09
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb170, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1106/0601] at 00:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1 C2, 2 throttling states
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
ACPI: Thermal Zone found
parport0: PC-style at 0x378 [PCSPP,EPP]
parport0: faking semi-colon
parport0: Printer, Hewlett-Packard HP LaserJet 2100 Series
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci00:11.1
     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
hda: ST380011A, ATA DISK drive
blk: queue c02a6c60, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, 
UDMA(100)
Partition check:
  hda: hda1 hda2 hda3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 224k freed
Adding Swap: 498004k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
via-rhine.c:v1.10-LK1.1.16  February-15-2003  Written by Donald Becker
   http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xe800, 00:40:63:ca:a7:a6, IRQ 11.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 3000 status 782d advertising 01e1.
eth1: Digital DS21143 Tulip rev 65 at 0xec00, 00:40:C7:97:3E:5C, IRQ 15.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
eth0: Reset did not complete in 5 us. Trying harder.
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.


eth0      Link encap:Ethernet  HWaddr 00:40:63:CA:A7:A6
           inet addr:192.168.0.100  Bcast:192.168.0.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:36518 errors:0 dropped:0 overruns:0 frame:0
           TX packets:48793 errors:8 dropped:0 overruns:3 carrier:0
           collisions:0 txqueuelen:100
           RX bytes:2564604 (2.4 MiB)  TX bytes:71386977 (68.0 MiB)
           Interrupt:11 Base address:0xe800

eth1      Link encap:Ethernet  HWaddr 00:40:C7:97:3E:5C
           inet addr:192.168.1.100  Bcast:192.168.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:48238 errors:0 dropped:0 overruns:0 frame:0
           TX packets:37679 errors:0 dropped:0 overruns:0 carrier:0
           collisions:151 txqueuelen:100
           RX bytes:68440857 (65.2 MiB)  TX bytes:2844893 (2.7 MiB)
           Interrupt:15 Base address:0xec00

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           UP LOOPBACK RUNNING  MTU:16436  Metric:1
           RX packets:64 errors:0 dropped:0 overruns:0 frame:0
           TX packets:64 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:4368 (4.2 KiB)  TX bytes:4368 (4.2 KiB)

Apr  1 10:13:27 bkserver kernel: linuxfet.c : v3.28 11/15/2001
Apr  1 10:13:27 bkserver kernel:   The PCI BIOS has not enabled the 
device at 0/144!  Updating PCI command 0003->0007.
Apr  1 10:13:27 bkserver kernel: eth0: VIA PCI 10/100Mb Fast Ethernet 
Adapter
Apr  1 10:13:27 bkserver kernel: eth0: IO Address = 0xe800, MAC Address 
= 00:40:63:ca:a7:a6, IRQ = 11.
Apr  1 10:13:41 bkserver kernel: eth0: netdev_open() irq 11.
Apr  1 10:13:41 bkserver kernel: eth0: Autonegotiation result: 100Mbps 
full duplex mode.
Apr  1 10:13:41 bkserver kernel: eth0: Done netdev_open(), status 0c1a 
MII status: 786d.
Apr  1 10:16:34 bkserver kernel: eth0: Shutting down ethercard, status 
was 0c1a.
Apr  1 10:16:45 bkserver kernel: eth0: netdev_open() irq 11.
Apr  1 10:16:45 bkserver kernel: eth0: Autonegotiation result: 100Mbps 
full duplex mode.
Apr  1 10:16:45 bkserver kernel: eth0: Done netdev_open(), status 0c1a 
MII status: 786d.
Apr  1 10:17:02 bkserver kernel: eth0: Transmit error, Tx status 8800.
Apr  1 10:17:02 bkserver kernel: eth0: Transmitter underrun, increasing 
Tx threshold setting to 01.
Apr  1 10:17:02 bkserver kernel: eth0: Transmit error, Tx status 8800.
Apr  1 10:17:02 bkserver kernel: eth0: Transmitter underrun, increasing 
Tx threshold setting to 02.
Apr  1 10:17:02 bkserver kernel: eth0: Transmit error, Tx status 8800.
Apr  1 10:17:02 bkserver kernel: eth0: Transmitter underrun, increasing 
Tx threshold setting to 03.
Apr  1 10:18:54 bkserver kernel: eth0: Transmit error, Tx status 8800.
Apr  1 10:18:54 bkserver kernel: eth0: Transmitter underrun, increasing 
Tx threshold setting to 04.

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MCYRIXIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_HAS_TSC=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BUSMGR=y
CONFIG_ACPI_SYS=y
CONFIG_ACPI_CPU=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_CMBATT=y
CONFIG_ACPI_THERMAL=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=y
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_TULIP=m
CONFIG_VIA_RHINE=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_ISO8859_1=m
CONFIG_VGA_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SOUND_VIA82CXXX=m

-- 
Brad....
  /"\
  \ /     ASCII RIBBON CAMPAIGN
   X      AGAINST HTML MAIL
  / \

