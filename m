Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129466AbRB0CLA>; Mon, 26 Feb 2001 21:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129446AbRB0CKs>; Mon, 26 Feb 2001 21:10:48 -0500
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:16140 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S129464AbRB0CKO>; Mon, 26 Feb 2001 21:10:14 -0500
Date: Mon, 26 Feb 2001 19:10:09 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4 kernels - "attempt to access beyond end of device"
Message-ID: <20010226191007.A15716@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have right now on hands a system with PDC20265 controller, not used
as "raid", and it gives me a hard time.  It looks like that after some
number of megabytes copied to a disk, where "number" seems to be
somewhere between 100 and 150, something in a kernel internal structures
get overwritten and the whole thing just blows up.  After an oops mostly
anything will end up with errors so even a clean reboot will likely
be not possible.

In particular this prevents me from installing the recent Red Hat public
beta with its kernel based on 2.4.1.  I tried also some other variants
of 2.4 kernels and so far results are the same.  If there is something
left in logs then I see messages of that sort (21:01 is /dev/hde1).

21:01: rw=0, want=536992869, limit=4506201
attempt to access beyond end of device
21:01: rw=0, want=536992870, limit=4506201
attempt to access beyond end of device

The following log file is for 2.4.2-ac5.  It has less extraneous
stuff like LVM, and RAID, and USB support, and whatever...
These were effects of an attempt to copy from one vfat to another
vfat file system.  Below is also decoded oops.


Linux version 2.4.2-ac5 (root@smok.home.front) (gcc version 2.96 20000731 (Red Hat Linux 7.0)) #4 Mon Feb 26 18:11:13 MST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009dc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000002400 @ 000000000009dc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 000000001feec000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000003000 @ 000000001ffec000 (ACPI data)
 BIOS-e820: 0000000000010000 @ 000000001ffef000 (reserved)
 BIOS-e820: 0000000000001000 @ 000000001ffff000 (ACPI NVS)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
On node 0 totalpages: 131052
zone(0): 4096 pages.
zone(1): 126956 pages.
zone(2): 0 pages.
Kernel command line: initrd=initrd.img root=/dev/hdg3 BOOT_IMAGE=vmlinuz auto
Initializing CPU#0
Detected 1109.899 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2215.11 BogoMIPS
Memory: 513140k/524208k available (920k kernel code, 10672k reserved, 351k data, 176k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1150, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI: Found IRQ 9 for device 00:09.0
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:04.3
PCI: The same IRQ used for device 00:0d.0
PCI: Found IRQ 11 for device 00:0c.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 341080kB/210008kB, 1024 slots per queue
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 10 for device 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x6800-0x6807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x6808-0x680f, BIOS settings: hdg:DMA, hdh:pio
hda: CREATIVE CD5233E, ATAPI CD/DVD-ROM drive
hde: IBM-DTLA-307045, ATA DISK drive
hdg: IBM-DTLA-307045, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0x8000-0x8007,0x7802 on irq 10
ide3 at 0x7400-0x7407,0x7002 on irq 10
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
hdg: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
hda: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hde: [PTBL] [5606/255/63] hde1
 hdg: [PTBL] [5606/255/63] hdg1 hdg2 hdg3 hdg4 < hdg5 hdg6 hdg7 hdg8 hdg9 hdg10 hdg11 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 279k freed
loop: loaded (max 8 devices)
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem).
ncr53c8xx: at PCI bus 0, device 10, function 0
ncr53c8xx: 53c810 detected 
ncr53c810-0: rev 0x2 on pci bus 0 device 10 function 0 irq 5
ncr53c810-0: ID 7, Fast-10, Parity Checking
ncr53c810-0: restart (scsi reset).
scsi0 : ncr53c8xx - version 3.3b
  Vendor: FUJITSU   Model: M2952S-512        Rev: 0122
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: DEC       Model: DSP3210S          Rev: X442
  Type:   Direct-Access                      ANSI SCSI revision: 02
ncr53c810-0-<2,0>: tagged command queue depth set to 8
ncr53c810-0-<4,0>: tagged command queue depth set to 8
Attached scsi disk sda at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 4, lun 0
ncr53c810-0-<2,0>: sync_msgout: 1-3-1-19-8.
ncr53c810-0-<2,0>: sync msgin: 1-3-1-19-8.
ncr53c810-0-<2,0>: sync: per=25 scntl3=0x10 ofs=8 fak=0 chg=0.
ncr53c810-0-<2,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 8)
SCSI device sda: 4693462 512-byte hdwr sectors (2403 MB)
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
ncr53c810-0-<4,0>: sync_msgout: 1-3-1-19-8.
ncr53c810-0-<4,0>: sync msgin: 1-3-1-19-8.
ncr53c810-0-<4,0>: sync: per=25 scntl3=0x10 ofs=8 fak=0 chg=0.
ncr53c810-0-<4,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 8)
SCSI device sdb: 4197520 512-byte hdwr sectors (2149 MB)
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
via-rhine.c:v1.08b-LK1.1.7  8/9/2000  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Enabling device 00:09.0 (0094 -> 0097)
PCI: Found IRQ 9 for device 00:09.0
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:04.3
PCI: The same IRQ used for device 00:0d.0
eth0: VIA VT3043 Rhine at 0x9400, 00:50:ba:c1:64:d9, IRQ 9.
eth0: MII PHY found at address 8, status 0x7809 advertising 05e1 Link 0000.
PCI: Enabling device 00:0c.0 (0094 -> 0097)
PCI: Found IRQ 11 for device 00:0c.0
eth1: VIA VT3043 Rhine at 0x8800, 00:50:ba:ab:60:64, IRQ 11.
eth1: MII PHY found at address 8, status 0x782d advertising 05e1 Link 0000.
VFS: Mounted root (ext2 filesystem) readonly.
change_root: old root has d_count=3
Trying to unmount old root ... okay
Freeing unused kernel memory: 176k freed
Adding Swap: 136512k swap-space (priority -1)
Filesystem panic (dev 22:02).
  fat_free: deleting beyond EOF
  File system has been set read-only
attempt to access beyond end of device
21:01: rw=0, want=536992869, limit=4506201
attempt to access beyond end of device
21:01: rw=0, want=536992870, limit=4506201
attempt to access beyond end of device
21:01: rw=0, want=536992870, limit=4506201
attempt to access beyond end of device
21:01: rw=0, want=536992871, limit=4506201
attempt to access beyond end of device
21:01: rw=0, want=536992871, limit=4506201
attempt to access beyond end of device
21:01: rw=0, want=536992872, limit=4506201
attempt to access beyond end of device
21:01: rw=0, want=536992872, limit=4506201
attempt to access beyond end of device
21:01: rw=0, want=536992873, limit=4506201
attempt to access beyond end of device
21:01: rw=0, want=536992869, limit=4506201
attempt to access beyond end of device
21:01: rw=0, want=536992870, limit=4506201
attempt to access beyond end of device
21:01: rw=0, want=536992870, limit=4506201
attempt to access beyond end of device
21:01: rw=0, want=536992871, limit=4506201
attempt to access beyond end of device
21:01: rw=0, want=536992871, limit=4506201
attempt to access beyond end of device
21:01: rw=0, want=536992872, limit=4506201
attempt to access beyond end of device
21:01: rw=0, want=536992872, limit=4506201
attempt to access beyond end of device
21:01: rw=0, want=536992873, limit=4506201
Unable to handle kernel paging request at virtual address 08000004
 printing eip:
c0130fbe
*pde = 0b120067
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0130fbe>]
EFLAGS: 00010206
eax: c18a0000   ebx: 00006b93   ecx: 00000003   edx: 08000000
esi: 00007fff   edi: 0000000f   ebp: 00007562   esp: debe9e14
ds: 0018   es: 0018   ss: 0018
Process cp (pid: 586, stackpage=debe9000)
Stack: 2202cd48 00000000 00000200 c13ecd48 00000000 c0131e36 00002202 00007562 
       00000200 c13ecd48 00000000 c0132177 ceeb6640 00000000 c0132198 ceed7de0 
       ceed7de0 cec6e000 debe9e6c 00000200 00000008 ceed7de0 00000002 00011ead 
Call Trace: [<c0131e36>] [<c0132177>] [<c0132198>] [<c012a85e>] [<c013179f>] [<c0132860>] [<c015a4f0>] 
       [<c015bf45>] [<c015a4f0>] [<c0124ddc>] [<c015a641>] [<c015a619>] [<c012fbd6>] [<c0108fb3>] 

Code: 39 6a 04 75 f5 66 8b 42 08 25 ff ff 00 00 3b 44 24 20 75 e6 

And here are results of ksymoops:

Error (pclose_local): find_objects pclose failed 0x100
Unable to handle kernel paging request at virtual address 08000004
c0130fbe
*pde = 0b120067
Oops: 0000
CPU:    0
EIP:    0010:[<c0130fbe>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c18a0000   ebx: 00006b93   ecx: 00000003   edx: 08000000
esi: 00007fff   edi: 0000000f   ebp: 00007562   esp: debe9e14
ds: 0018   es: 0018   ss: 0018
Process cp (pid: 586, stackpage=debe9000)
Stack: 2202cd48 00000000 00000200 c13ecd48 00000000 c0131e36 00002202 00007562 
       00000200 c13ecd48 00000000 c0132177 ceeb6640 00000000 c0132198 ceed7de0 
       ceed7de0 cec6e000 debe9e6c 00000200 00000008 ceed7de0 00000002 00011ead 
Call Trace: [<c0131e36>] [<c0132177>] [<c0132198>] [<c012a85e>] [<c013179f>] [<c0132860>] [<c015a4f0>] 
       [<c015bf45>] [<c015a4f0>] [<c0124ddc>] [<c015a641>] [<c015a619>] [<c012fbd6>] [<c0108fb3>] 
Code: 39 6a 04 75 f5 66 8b 42 08 25 ff ff 00 00 3b 44 24 20 75 e6 

>>EIP; c0130fbe <get_hash_table+7e/b0>   <=====
Trace; c0131e36 <unmap_underlying_metadata+26/70>
Trace; c0132177 <__block_prepare_write+e7/2c0>
Trace; c0132198 <__block_prepare_write+108/2c0>
Trace; c012a85e <nr_free_buffer_pages+e/60>
Trace; c013179f <balance_dirty_state+f/50>
Trace; c0132860 <cont_prepare_write+1f0/2b0>
Trace; c015a4f0 <fat_get_block+0/100>
Trace; c015bf45 <fat_prepare_write+25/30>
Trace; c015a4f0 <fat_get_block+0/100>
Trace; c0124ddc <generic_file_write+3ac/5d0>
Trace; c015a641 <default_fat_file_write+21/60>
Trace; c015a619 <fat_file_write+29/30>
Trace; c012fbd6 <sys_write+96/d0>
Trace; c0108fb3 <system_call+33/40>
Code;  c0130fbe <get_hash_table+7e/b0>
00000000 <_EIP>:
Code;  c0130fbe <get_hash_table+7e/b0>   <=====
   0:   39 6a 04                  cmp    %ebp,0x4(%edx)   <=====
Code;  c0130fc1 <get_hash_table+81/b0>
   3:   75 f5                     jne    fffffffa <_EIP+0xfffffffa> c0130fb8 <get_hash_table+78/b0>
Code;  c0130fc3 <get_hash_table+83/b0>
   5:   66 8b 42 08               mov    0x8(%edx),%ax
Code;  c0130fc7 <get_hash_table+87/b0>
   9:   25 ff ff 00 00            and    $0xffff,%eax
Code;  c0130fcc <get_hash_table+8c/b0>
   e:   3b 44 24 20               cmp    0x20(%esp,1),%eax
Code;  c0130fd0 <get_hash_table+90/b0>
  12:   75 e6                     jne    fffffffa <_EIP+0xfffffffa> c0130fb8 <get_hash_table+78/b0>


3 errors issued.  Results may not be reliable.

Here is a similar one, from another kernel (2.4.1-0.1.9 Red Hat from
"Wolverine"), with what looks like cdrom code inside.  As far as I can
tell no VFAT stuff was involved this time.

Unable to handle kernel paging request at virtual address 08000004
c0134336
*pde = 1d3a7067
Oops: 0000
CPU:    0
EIP:    0010:[<c0134336>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c18a0000   ebx: 00000009   ecx: 000014e0   edx: 08000000
esi: 00040008   edi: 00002202   ebp: 0000000f   esp: dd311e14
ds: 0018   es: 0018   ss: 0018
Process cp (pid: 791, stackpage=dd311000)
Stack: 000014e0 00000000 00000e00 cb2b0da0 00000c00 c013517b 00002202 00040008 
       00000200 cb2b0da0 00000c00 c0135517 cbd54420 00000000 c0135538 cb2b0d40 
       cb2b0f80 cb2ac000 dd311e6c 00000200 000016ae cb2b0d40 06b60600 00001000 
Call Trace: [<c013517b>] [<c0135517>] [<c0135538>] [<c0134b0c>] [<c0134b5c>] [<e086d5f0>] [<c0135cfa>] 
       [<e086d5f0>] [<e086efd5>] [<e086d5f0>] [<c0127ad9>] [<e086d731>] [<e086d709>] [<c0132fe6>] [<c0109007>] 
Code: 39 72 04 75 f5 0f b7 42 08 3b 44 24 20 75 eb 66 39 7a 0c 75 

>>EIP; c0134336 <get_hash_table+66/90>   <=====
Trace; c013517b <unmap_underlying_metadata+1b/60>
Trace; c0135517 <__block_prepare_write+117/300>
Trace; c0135538 <__block_prepare_write+138/300>
Trace; c0134b0c <balance_dirty_state+c/50>
Trace; c0134b5c <balance_dirty+c/40>
Trace; e086d5f0 <[cdrom]cdrom_ioctl+ab0/e20>
Trace; c0135cfa <cont_prepare_write+22a/370>
Trace; e086d5f0 <[cdrom]cdrom_ioctl+ab0/e20>
Trace; e086efd5 <[cdrom]cdrom_sysctl_info+5a5/5d0>
Trace; e086d5f0 <[cdrom]cdrom_ioctl+ab0/e20>
Trace; c0127ad9 <generic_file_write+3a9/5f0>
Trace; e086d731 <[cdrom]cdrom_ioctl+bf1/e20>
Trace; e086d709 <[cdrom]cdrom_ioctl+bc9/e20>
Trace; c0132fe6 <sys_write+96/d0>
Trace; c0109007 <system_call+33/38>
Code;  c0134336 <get_hash_table+66/90>
00000000 <_EIP>:
Code;  c0134336 <get_hash_table+66/90>   <=====
   0:   39 72 04                  cmp    %esi,0x4(%edx)   <=====
Code;  c0134339 <get_hash_table+69/90>
   3:   75 f5                     jne    fffffffa <_EIP+0xfffffffa> c0134330 <get_hash_table+60/90>
Code;  c013433b <get_hash_table+6b/90>
   5:   0f b7 42 08               movzwl 0x8(%edx),%eax
Code;  c013433f <get_hash_table+6f/90>
   9:   3b 44 24 20               cmp    0x20(%esp,1),%eax
Code;  c0134343 <get_hash_table+73/90>
   d:   75 eb                     jne    fffffffa <_EIP+0xfffffffa> c0134330 <get_hash_table+60/90>
Code;  c0134345 <get_hash_table+75/90>
   f:   66 39 7a 0c               cmp    %di,0xc(%edx)
Code;  c0134349 <get_hash_table+79/90>
  13:   75 00                     jne    15 <_EIP+0x15> c013434b <get_hash_table+7b/90>

Anybody with an insight to offer?

  Michal
  michal@harddata.com
