Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbUAVIUg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 03:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266002AbUAVIUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 03:20:34 -0500
Received: from grunt26.ihug.com.au ([203.109.249.146]:40161 "EHLO
	grunt26.ihug.com.au") by vger.kernel.org with ESMTP id S266001AbUAVIU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 03:20:27 -0500
From: Alan Turner <alan@suburbia.com.au>
Message-Id: <200401220819.i0M8J3jK017873@freddy.localdomain>
Subject: 2.4.24 oops in d_lookup
To: linux-kernel@vger.kernel.org
Date: Thu, 22 Jan 2004 19:19:03 +1100 (EST)
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I'm in the process of moving a 200 MHz pentium-MMX from NetBSD to linux.
It has run NetBSD without trouble for a few months now (including
rebuilding the whole NetBSD system).

I partially untarred a backup of the old filesystem (about 7 gig), but
tar reported errors which seemed to be due to tar not being able to run
mknod(2). Fair enough.

I began an rm process deleting the mostly-restored copy, and put it into
the background. Before the rm operation completed, I started another tar
process (one which avoided unpacking the dev files).

After a while the kernel oopsed, and the second tar process segfaulted.
The decoded oops and dmesg are appended below.

The filesystem in use is ext3. I fscked it after a reboot, and all
seemed well.

This is a debian 3.0 system.

Thanks very much for looking into this - if any more info is required, I
will provide it.

Cheers,
Alan




ksymoops 2.4.5 on i586 2.4.24.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.24/ (default)
     -m /boot/System.map-2.4.24 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

CPU:    0
EIP:    0010:[<c013e610>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c10924d8   ebx: ffffffef   ecx: 0000000d   edx: 692377d4
esi: c12cc520   edi: c0ec91a0   ebp: ffffffff   esp: c2295f38
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 460, stackpage=c2295000)
Stack: 00000000 c12cc520 c0ec91a0 c2295fac c10924d8 c19e4000 692377d4 0000000c
       c0135f14 c12cc520 c2295fac 00000000 c0136c48 c12cc520 c2295fac 00000000
       ffffffeb c2295fa4 c19e4000 c2295fa4 c0137d92 c2295fac c12cc520 c2294000
Call Trace:    [<c0135f14>] [<c0136c48>] [<c0137d92>] [<c0106c33>]
Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 24 24 39 43 0c 75


>>EIP; c013e610 <d_lookup+60/100>   <=====

>>eax; c10924d8 <_end+e20ac4/358e5ec>
>>ebx; ffffffef <END_OF_CODE+3c79ea70/????>
>>edx; 692377d4 Before first symbol
>>esi; c12cc520 <_end+105ab0c/358e5ec>
>>edi; c0ec91a0 <_end+c5778c/358e5ec>
>>ebp; ffffffff <END_OF_CODE+3c79ea80/????>
>>esp; c2295f38 <_end+2024524/358e5ec>

Trace; c0135f14 <cached_lookup+10/54>
Trace; c0136c48 <lookup_hash+44/8c>
Trace; c0137d92 <sys_unlink+6e/114>
Trace; c0106c33 <system_call+33/40>

Code;  c013e610 <d_lookup+60/100>
00000000 <_EIP>:
Code;  c013e610 <d_lookup+60/100>   <=====
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <=====
Code;  c013e613 <d_lookup+63/100>
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  c013e617 <d_lookup+67/100>
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  c013e61a <d_lookup+6a/100>
   a:   75 7c                     jne    88 <_EIP+0x88> c013e698 <d_lookup+e8/100>
Code;  c013e61c <d_lookup+6c/100>
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  c013e620 <d_lookup+70/100>
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  c013e623 <d_lookup+73/100>
  13:   75 00                     jne    15 <_EIP+0x15> c013e625 <d_lookup+75/100>


1 warning issued.  Results may not be reliable.



Linux version 2.4.24 (alan@cappuccino) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Wed Jan 21 04:20:40 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000003000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
48MB LOWMEM available.
On node 0 totalpages: 12288
zone(0): 4096 pages.
zone(1): 8192 pages.
zone(2): 0 pages.
DMI not present.
Kernel command line: auto BOOT_IMAGE=Linux ro root=305
Initializing CPU#0
Detected 198.951 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 397.31 BogoMIPS
Memory: 46728k/49152k available (867k kernel code, 2036k reserved, 209k data, 228k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller at PCI slot 00:07.1
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD800JB-00DUA3, ATA DISK drive
blk: queue c026cda0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=9729/255/63, (U)DMA
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 228k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 297160k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
Real Time Clock Driver v1.10e
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0x7f80, IRQ 9, 00:20:18:2D:8A:CE.
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #1 config 1000 status 782d advertising 05e1.
tulip0:  Advertising 01e1 on PHY 1, previously advertising 05e1.
eth1: Digital DS21143 Tulip rev 65 at 0x7c80, 00:40:C7:9A:14:26, IRQ 10.
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth1: Setting half-duplex based on MII#1 link partner capability of 0021.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.



-- 
Alan R. Turner | (02) 9481 8223 | 0413 190 128
Live never to be ashamed of anything you do or say.
