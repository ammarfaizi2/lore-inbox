Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSILTZ4>; Thu, 12 Sep 2002 15:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSILTZ4>; Thu, 12 Sep 2002 15:25:56 -0400
Received: from [66.35.146.201] ([66.35.146.201]:15119 "EHLO int1.nea-fast.com")
	by vger.kernel.org with ESMTP id <S317081AbSILTZw> convert rfc822-to-8bit;
	Thu, 12 Sep 2002 15:25:52 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: walt <walt@nea-fast.com>
To: linux-kernel@vger.kernel.org
Subject: ext3 oops again - no dma this time
Date: Thu, 12 Sep 2002 15:31:26 -0400
User-Agent: KMail/1.4.3
Cc: akpm@zip.com.au, Andreas Dilger <adilger@clusterfs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209121531.26094.walt@nea-fast.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I managed to ooops ext3 again but this time with no dma.

mount -o loop -t iso9660 db.iso /tmp2/
cd /tmp2/
gunzip -c nea.dmp.gz > /opt/burn/nea.dmp

FYI - iso image is on hda, /opt is hdc


Some important info - 
> > FYI  - I ran into some reproducible problems before with ext3 and
> > possibly NFS. I had a 1365344k oracle database export gzipped down to
> > 263688k and then made into an ISO image. I'd  copy the file from the file
> > server
> > (2.4.3-SGI_XFS_1.0.1) via NFS , mount the ISO image, and burn it to CD
> > without any errors being reported. When I'd try gunzip the file from CD,
> > I'd get CRC errors. I then tried mounting the ISO image and running
> > gunzip and I'd get the same CRC errors.

I've included the oops message I got the last time( 2002-08-28) at the bottom
I'd be glad to provide more information!

Thanks!
-- 
Walter Anthony
System Administrator
National Electronic Attachment
Atlanta, Georgia 
1-800-782-5150 ext. 1608
 "If it's not broke....tweak it"


ksymoops 2.4.4 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Sep 12 14:34:38 walt kernel: Unable to handle kernel paging request at virtual 
address 01
64787c
Sep 12 14:34:38 walt kernel: c016bbd7
Sep 12 14:34:38 walt kernel: *pde = 00000000
Sep 12 14:34:38 walt kernel: Oops: 0000
Sep 12 14:34:38 walt kernel: CPU:    0
Sep 12 14:34:38 walt kernel: EIP:    0010:[<c016bbd7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 12 14:34:38 walt kernel: EFLAGS: 00010206
Sep 12 14:34:38 walt kernel: eax: cf9adeb0   ebx: 01647864   ecx: 00000040   
edx: 0000002
Sep 12 14:34:38 walt kernel: esi: cf1c4eb0   edi: 54484749   ebp: cddad8e0   
esp: cf9ade8
Sep 12 14:34:38 walt kernel: ds: 0018   es: 0018   ss: 0018
Sep 12 14:34:38 walt kernel: Process kjournald (pid: 138, stackpage=cf9ad000)
Sep 12 14:34:38 walt kernel: Stack: 00000000 00000000 00000000 0000002d 
cc128940 c2b7b340
 0000060a c030e3e4
Sep 12 14:34:38 walt kernel:        00000282 c030e3a0 00000000 c083a1a0 
cf4bee60 cf4bee00
 c4327600 c4327420
Sep 12 14:34:38 walt kernel:        c4327540 c4327360 c4327240 c4327300 
cc698480 cfb82360
 c0931f00 c7efb0e0
Sep 12 14:34:38 walt kernel: Call Trace:    [<c016eeb3>] [<c016ece0>] 
[<c0107166>] [<c016
ed00>]
Sep 12 14:34:38 walt kernel: Code: 8b 43 18 a9 04 00 00 00 75 41 83 e0 02 74 
1a f0 ff 43

>>EIP; c016bbd7 <journal_commit_transaction+3a7/1343>   <=====
Trace; c016eeb3 <kjournald+1b3/310>
Trace; c016ece0 <commit_timeout+0/10>
Trace; c0107166 <kernel_thread+26/30>
Code;  c016bbd7 <journal_commit_transaction+3a7/1343>
00000000 <_EIP>:
Code;  c016bbd7 <journal_commit_transaction+3a7/1343>   <=====
   0:   8b 43 18                  mov    0x18(%ebx),%eax   <=====
Code;  c016bbda <journal_commit_transaction+3aa/1343>
   3:   a9 04 00 00 00            test   $0x4,%eax
Code;  c016bbdf <journal_commit_transaction+3af/1343>
   8:   75 41                     jne    4b <_EIP+0x4b> c016bc22 
<journal_commit_transaction+3f2/1343>
Code;  c016bbe1 <journal_commit_transaction+3b1/1343>
   a:   83 e0 02                  and    $0x2,%eax
Code;  c016bbe4 <journal_commit_transaction+3b4/1343>
   d:   74 1a                     je     29 <_EIP+0x29> c016bc00 
<journal_commit_transaction+3d0/1343>
Code;  c016bbe6 <journal_commit_transaction+3b6/1343>
   f:   f0 ff 43 00               lock incl 0x0(%ebx)


1 warning issued.  Results may not be reliable.

root@walt scripts]# sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux walt 2.4.19 #2 SMP Fri Aug 9 12:15:24 EDT 2002 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         nfs lockd sunrpc 3c59x md rtc

[root@walt burn]# cat /proc/partitions
major minor  #blocks  name

  22     0    8257032 hdc
  22     1     208813 hdc1
  22     2    8040532 hdc2
   3     0    4224150 hda
   3     1     610438 hda1
   3     2     200812 hda2
   3     3    3405780 hda3

[root@walt /]# hdparm -v /dev/hda

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 525/255/63, sectors = 8448300, start = 0
 busstate     =  1 (on)

[root@walt /]# hdparm -v /dev/hdc

/dev/hdc:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1027/255/63, sectors = 16514064, start = 0
 busstate     =  1 (on)

[root@walt root]# grep -i dma 2.4.19-02
# CONFIG_BLK_DEV_IDEDMA_PCI is not set
# CONFIG_BLK_DEV_IDEDMA is not set
# CONFIG_BLK_DEV_ADMA is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_SCSI_EATA_DMA is not set


[root@walt root]# dmesg
Linux version 2.4.19 (root@walt) (gcc version 2.96 20000731 (Red Hat Linux 7.3 
2.96-110)) #1 SMP Thu Sep 12 12:10:39 EDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffd000 (usable)
 BIOS-e820: 000000000fffd000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
Advanced speculative caching feature not present
On node 0 totalpages: 65533
zone(0): 4096 pages.
zone(1): 61437 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=2.4.19-02 ro root=301 
BOOT_FILE=/boot/vmlinuz-2.4.19-02
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 267.275 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 532.48 BogoMIPS
Memory: 256720k/262132k available (1166k kernel code, 5024k reserved, 360k 
data, 268k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0080fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0080fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0080fbff 00000000 00000000 00000000
CPU:             Common caps: 0080fbff 00000000 00000000 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0080fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0080fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0080fbff 00000000 00000000 00000000
CPU:             Common caps: 0080fbff 00000000 00000000 00000000
CPU0: Intel Pentium II (Klamath) stepping 04
per-CPU timeslice cutoff: 1464.30 usecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 267.2944 MHz.
..... host bus clock speed is 66.8235 MHz.
cpu: 0, clocks: 668235, slice: 334117
CPU0<T0:668224,T1:334096,D:11,S:334117,C:668235>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf0750, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
PCI: Found IRQ 10 for device 00:04.2
PCI: Sharing IRQ 10 with 00:09.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: detected chipset, but driver not compiled in!
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
hda: FUJITSU MPC3043AT, ATA DISK drive
hdc: WDC WD84AA, ATA DISK drive
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 8448300 sectors (4326 MB), CHS=525/255/63
hdc: 16514064 sectors (8455 MB) w/2048KiB Cache, CHS=16383/16/63
Partition check:
 hda: hda1 hda2 hda3
 hdc: [PTBL] [1027/255/63] hdc1 hdc2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440LX chipset
agpgart: AGP aperture is 64M @ 0xe4000000
[drm] AGP 0.99 on Intel 440LX @ 0xe4000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:09.0
PCI: Sharing IRQ 10 with 00:04.2
scsi0 : AdvanSys SCSI 3.3G: PCI Ultra: IO 0xB000-0xB00F, IRQ 0xA
  Vendor: MATSHITA  Model: CD-R   CW-7502    Rev: 4.10
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TEAC      Model: CD-ROM CD-516S    Rev: 1.0D
  Type:   CD-ROM                             ANSI SCSI revision: 02
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 268k freed
Real Time Clock Driver v1.10e
Adding Swap: 208804k swap-space (priority -1)
Adding Swap: 200804k swap-space (priority -2)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide1(22,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
PCI: Found IRQ 11 for device 00:0b.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0b.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xa800. Vers LK1.1.16


OOOPS FROM LAST TIME WITH DMA -

Aug 28 10:16:55 walt kernel: Unable to handle kernel paging request at virtual 
address 01
38835e
Aug 28 10:16:55 walt kernel: c016bbd7
Aug 28 10:16:55 walt kernel: *pde = 00000000
Aug 28 10:16:55 walt kernel: Oops: 0000
Aug 28 10:16:55 walt kernel: CPU:    0
Aug 28 10:16:55 walt kernel: EIP:    0010:[<c016bbd7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 28 10:16:55 walt kernel: EFLAGS: 00013202
Aug 28 10:16:55 walt kernel: eax: cf967eb0   ebx: 01388346   ecx: 00000040   
edx: 0000001
Aug 28 10:16:55 walt kernel: esi: cf1c4eb0   edi: 8d505604   ebp: ce5df430   
esp: cf967e8
Aug 28 10:16:55 walt kernel: ds: 0018   es: 0018   ss: 0018
Aug 28 10:16:55 walt kernel: Process kjournald (pid: 139, stackpage=cf967000)
Aug 28 10:16:55 walt kernel: Stack: 00000000 00000000 00000000 00000014 
cce1b440 cafe5220
 000017fd 00000096
Aug 28 10:16:55 walt kernel:        c0195a1c c12e00cc c12e5480 c38c9600 
c38c9780 c38c9480
 c38c96c0 c38c9540
Aug 28 10:16:55 walt kernel:        c38c9120 c38c9a20 c38c9d20 c38c9660 
c38c9180 c38c9c60
 c38c9960 c38c9c00
Aug 28 10:16:55 walt kernel: Call Trace:    [<c0195a1c>] [<c016eeb3>] 
[<c016ece0>] [<c010
7166>] [<c016ed00>]
Aug 28 10:16:55 walt kernel: Code: 8b 43 18 a9 04 00 00 00 75 41 83 e0 02 74 
1a f0 ff 43

>>EIP; c016bbd7 <journal_commit_transaction+3a7/1343>   <=====
Trace; c0195a1c <account_io_end+3c/50>
Trace; c016eeb3 <kjournald+1b3/310>
Trace; c016ece0 <commit_timeout+0/10>
Code;  c016bbd7 <journal_commit_transaction+3a7/1343>
00000000 <_EIP>:
Code;  c016bbd7 <journal_commit_transaction+3a7/1343>   <=====
   0:   8b 43 18                  mov    0x18(%ebx),%eax   <=====
Code;  c016bbda <journal_commit_transaction+3aa/1343>
   3:   a9 04 00 00 00            test   $0x4,%eax
Code;  c016bbdf <journal_commit_transaction+3af/1343>
   8:   75 41                     jne    4b <_EIP+0x4b> c016bc22 
<journal_commit_transaction+3f2/1343>
Code;  c016bbe1 <journal_commit_transaction+3b1/1343>
   a:   83 e0 02                  and    $0x2,%eax
Code;  c016bbe4 <journal_commit_transaction+3b4/1343>
   d:   74 1a                     je     29 <_EIP+0x29> c016bc00 
<journal_commit_transaction+3d0/1343>
Code;  c016bbe6 <journal_commit_transaction+3b6/1343>
   f:   f0 ff 43 00               lock incl 0x0(%ebx)


1 warning issued.  Results may not be reliable.

