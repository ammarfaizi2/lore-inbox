Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbSAEXJ2>; Sat, 5 Jan 2002 18:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286347AbSAEXJX>; Sat, 5 Jan 2002 18:09:23 -0500
Received: from [206.46.170.235] ([206.46.170.235]:17855 "EHLO
	pop008pub.verizon.net") by vger.kernel.org with ESMTP
	id <S286343AbSAEXJL>; Sat, 5 Jan 2002 18:09:11 -0500
Message-ID: <3C37878F.9090409@verizon.net>
Date: Sat, 05 Jan 2002 18:09:03 -0500
From: Stephen Clark <sclark46@verizon.net>
Reply-To: sclark46@verizon.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: sched-01-2.4.17-B0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I get the following crash when using the B0 patch with 2.4.17.

System comes up ok, I log into KDE that works. I then try to start 
mozilla session, a few seconds later the screen goes black and the 
system reboots.

Anything I can do to help trouble shoot?

Steve


Jan  5 17:54:21 joker kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Jan  5 17:54:21 joker kernel:  printing eip:
Jan  5 17:54:21 joker kernel: c0110c80
Jan  5 17:54:21 joker kernel: *pde = 00000000
Jan  5 17:54:21 joker kernel: Oops: 0002
Jan  5 17:54:21 joker kernel: CPU:    0
Jan  5 17:54:21 joker kernel: EIP:    0010:[try_to_wake_up+1136/1216]    
Not tainted
Jan  5 17:54:21 joker kernel: EIP:    0010:[<c0110c80>]    Not tainted
Jan  5 17:54:21 joker kernel: EFLAGS: 00010046
Jan  5 17:54:21 joker kernel: eax: c0355790   ebx: 00000000   ecx: 
00000000   edx: d964602c
Jan  5 17:54:21 joker kernel: esi: d9646000   edi: 000001f0   ebp: 
dc371e50   esp: dc371e14
Jan  5 17:54:21 joker kernel: ds: 0018   es: 0018   ss: 0018
Jan  5 17:54:25 joker kernel: Process mozilla-bin (pid: 1269, 
stackpage=dc371000)
Jan  5 17:54:25 joker kernel: Stack: dc3702d0 00000200 c01134f3 da591ac0 
c035545c 0000001f c02f4b1c dc370000
Jan  5 17:54:25 joker kernel:        db715980 db715980 c0355100 00000246 
c0356f28 000004f6 000001f0 dc371e60
Jan  5 17:54:25 joker kernel:        c0112c7b d9646000 00000000 d9646000 
c0113cba dfc21ac0 00003130 401e5148
Jan  5 17:54:25 joker kernel: Call Trace: [copy_files+211/688] 
[wake_up_process+11/16] [do_fork+1514/1680] [do_no_page+77/272] 
[sys_clone+33/48]
Jan  5 17:54:25 joker kernel: Call Trace: [<c01134f3>] [<c0112c7b>] 
[<c0113cba>] [<c012123d>] [<c0105891>]
Jan  5 17:54:25 joker kernel:    [exec_modprobe+0/128] 
[system_call+51/56] [exec_modprobe+0/128] [kernel_thread+29/48] 
[request_module+157/416] [exec_modprobe+0/128]
Jan  5 17:54:25 joker kernel:    [<c011f3f0>] [<c0106c8b>] [<c011f3f0>] 
[<c01054bd>] [<c011f50d>] [<c011f3f0>]
Jan  5 17:54:25 joker kernel:    [sock_create+144/256] 
[sys_socket+24/80] [sys_socketcall+96/464] [do_page_fault+0/1184] 
[error_code+52/60] [system_call+51/56]
Jan  5 17:54:25 joker kernel:    [<c020aca0>] [<c020ad28>] [<c020b960>] 
[<c0110000>] [<c0106d7c>] [<c0106c8b>]
Jan  5 17:54:25 joker kernel:
Jan  5 17:54:25 joker kernel: Code: 89 11 8b 46 24 8b 55 d4 0f b3 42 0c 
ff 02 89 56 34 8b 4d ec





dmesg from my stable kernel
Linux version 2.4.17 (root@joker.seclark.com) (gcc version 2.96 20000731 
(Red Hat Linux 7.1 2.96-85)) #22 Tue Dec 18 09:27:15 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=l-2.4.17rh71 ro root=803 ramdisk=0 
BOOT_FILE=/boot/vmlinuz-2.4.17rc1 pci=biosirq
Initializing CPU#0
Detected 1463.038 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2916.35 BogoMIPS
Memory: 513032k/524224k available (1559k kernel code, 10804k reserved, 
558k data, 236k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383f9ff c1cbf9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383f9ff c1cbf9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:             Common caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: AMD Athlon(tm) XP 1700+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb540, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1106/3099] at 00:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD102AA, ATA DISK drive
hdb: Maxtor 91366U4, ATA DISK drive
hdc: Maxtor 53073H4, ATA DISK drive
hdd: CD-ROM 50X L, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 20044080 sectors (10263 MB) w/2048KiB Cache, CHS=1247/255/63, UDMA(66)
hdb: 26684784 sectors (13663 MB) w/2048KiB Cache, CHS=1661/255/63, UDMA(66)
hdc: 60030432 sectors (30736 MB) w/2048KiB Cache, CHS=59554/16/63, UDMA(100)
hdd: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4
 hdb: hdb1 hdb2 hdb3
 hdc: hdc1 hdc2 hdc3 hdc4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
tulip0:  MII transceiver #1 config 3100 status 7829 advertising 01e1.
eth0: Lite-On 82c168 PNIC rev 32 at 0xd400, 00:A0:CC:26:9F:55, IRQ 10.
via-rhine.c:v1.10-LK1.1.12  03/11/2001  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth1: VIA VT6102 Rhine-II at 0xd7002000, 00:50:2c:00:ef:bd, IRQ 11.
eth1: MII PHY found at address 1, status 0x782d advertising 01e1 Link 45e1.
PPP generic driver version 2.4.1
Universal TUN/TAP device driver 1.4 (C)1999-2001 Maxim Krasnyansky
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT266 chipset
agpgart: AGP aperture is 256M @ 0xc0000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xc0000000 256MB
[drm] Initialized r128 2.1.6 20010405 on minor 0
SCSI subsystem driver Revision: 1.00
scsi: ***** BusLogic SCSI Driver Version 2.1.15 of 17 August 1998 *****
scsi: Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
scsi0: Configuring BusLogic Model BT-948 PCI Ultra SCSI Host Adapter
scsi0:   Firmware Version: 5.06I, I/O Address: 0xD000, IRQ Channel: 11/Level
scsi0:   PCI Bus: 0, Device: 8, Address: 0xD7000000, Host Adapter SCSI ID: 7
scsi0:   Parity Checking: Enabled, Extended Translation: Enabled
scsi0:   Synchronous Negotiation: Fast, Wide Negotiation: Disabled
scsi0:   Disconnect/Reconnect: Enabled, Tagged Queuing: Enabled
scsi0:   Scatter/Gather Limit: 128 of 8192 segments, Mailboxes: 211
scsi0:   Driver Queue Depth: 211, Host Adapter Queue Depth: 192
scsi0:   Tagged Queue Depth: Automatic, Untagged Queue Depth: 3
scsi0:   Error Recovery Strategy: Default, SCSI Bus Reset: Enabled
scsi0:   SCSI Bus Termination: Enabled, SCAM: Disabled
scsi0: *** BusLogic BT-948 Initialized Successfully ***
scsi0 : BusLogic BT-948
  Vendor: IBM       Model: DCAS-32160        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0: Target 0: Queue Depth 28, Synchronous at 10.0 MB/sec, offset 15
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 4226725 512-byte hdwr sectors (2164 MB)
 sda: sda1 sda2 sda3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
Linux IP multicast router 0.06 plus PIM-SM
klips_info:ipsec_init: KLIPS startup, FreeS/WAN IPSec version: 1.94
ip_conntrack (4095 buckets, 32760 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
TCP: Hash tables configured (established 32768 bind 32768)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
Linux IP multicast router 0.06 plus PIM-SM
klips_info:ipsec_init: KLIPS startup, FreeS/WAN IPSec version: 1.94
ip_conntrack (4095 buckets, 32760 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
scsi0: Tagged Queuing now active for Target 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sd(8,3): orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 16670
EXT3-fs: sd(8,3): 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 236k freed
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,3), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.



