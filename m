Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267372AbTAXOwo>; Fri, 24 Jan 2003 09:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267674AbTAXOwo>; Fri, 24 Jan 2003 09:52:44 -0500
Received: from winds.org ([207.48.83.9]:29198 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S267372AbTAXOwk>;
	Fri, 24 Jan 2003 09:52:40 -0500
Date: Fri, 24 Jan 2003 10:01:51 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] linux-2.4.21-pre3-ac4 @ free_pages_ok()
Message-ID: <Pine.LNX.4.44.0301240958340.15579-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen this oops report before, but since nobody's posted a fix for it or
anything, I figured I'll post the one I saw. I got a series of two oopses after
untarring a 200MB tarfile. (The system has 512MB of memory and was recently
booted into 2.4.21-pre3-ac4).  Here they are, plus boot-dmesg at the bottom.

Kernel was compiled with gcc 2.95.3.

 -Byron


Unable to handle kernel NULL pointer dereference at virtual address 00000004
c0128791
*pde = 1b443067
Oops: 0002
CPU:    0
EIP:    0010:[<c0128791>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c154c2fc   ecx: c154c2fc   edx: cd8ce000
esi: c154c2fc   edi: 00000000   ebp: 00000200   esp: cd8cfe90
ds: 0018   es: 0018   ss: 0018
Process tar (pid: 993, stackpage=cd8cf000)
Stack: ded3d8c0 c154c2fc 00000020 00000200 ded3d8c0 ded3d8c0 c0128bd3 c012809c 
       00000020 000001d2 00000020 00000006 00000006 cd8ce000 00002a19 000001d2 
       c02e3ef4 c01281f2 00000006 0000000d 00000006 00000020 000001d2 c02e3ef4 
Call Trace:    [<c0128bd3>] [<c012809c>] [<c01281f2>] [<c0128252>] [<c01288fb>]
  [<c0128ae2>] [<c0124821>] [<c01288c6>] [<c012483d>] [<c012d746>] [<c0106a83>]
Code: 89 58 04 89 03 8d 4a 5c 89 4b 04 89 5a 5c 89 7b 0c ff 42 68 

>>EIP; c0128791 <__free_pages_ok+f1/10c>   <=====
Trace; c0128bd3 <__free_pages+1b/1c>
Trace; c012809c <shrink_cache+2c4/2ec>
Trace; c01281f2 <shrink_caches+56/7c>
Trace; c0128252 <try_to_free_pages_zone+3a/5c>
Trace; c01288fb <balance_classzone+33/104>
Trace; c0128ae2 <__alloc_pages+116/164>
Trace; c0124821 <generic_file_write+3e9/6e8>
Trace; c01288c6 <_alloc_pages+16/18>
Trace; c012483d <generic_file_write+405/6e8>
Trace; c012d746 <sys_write+96/f0>
Trace; c0106a83 <system_call+33/38>
Code;  c0128791 <__free_pages_ok+f1/10c>
00000000 <_EIP>:
Code;  c0128791 <__free_pages_ok+f1/10c>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c0128794 <__free_pages_ok+f4/10c>
   3:   89 03                     mov    %eax,(%ebx)
Code;  c0128796 <__free_pages_ok+f6/10c>
   5:   8d 4a 5c                  lea    0x5c(%edx),%ecx
Code;  c0128799 <__free_pages_ok+f9/10c>
   8:   89 4b 04                  mov    %ecx,0x4(%ebx)
Code;  c012879c <__free_pages_ok+fc/10c>
   b:   89 5a 5c                  mov    %ebx,0x5c(%edx)
Code;  c012879f <__free_pages_ok+ff/10c>
   e:   89 7b 0c                  mov    %edi,0xc(%ebx)
Code;  c01287a2 <__free_pages_ok+102/10c>
  11:   ff 42 68                  incl   0x68(%edx)




Unable to handle kernel NULL pointer dereference at virtual address 00000004
c0128791
*pde = 1b443067
Oops: 0002
CPU:    0
EIP:    0010:[<c0128791>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c1253f38   ecx: c1253f54   edx: cd8ce000
esi: 00000000   edi: 00000000   ebp: 00526000   esp: cd8cfce4
ds: 0018   es: 0018   ss: 0018
Process tar (pid: 993, stackpage=cd8cf000)
Stack: c1253f38 00000000 db443498 00526000 00010000 c00b9fe0 c0128bd3 c0128f3f 
       c1253f38 c011ed10 c1253f38 00002000 c011f0e3 0d8b5067 dc155780 dc269460 
       00002000 00126000 cd904004 00526000 cd904004 00000001 00000000 00128000 
Call Trace:    [<c0128bd3>] [<c0128f3f>] [<c011ed10>] [<c011f0e3>] [<c0121642>]
  [<c0111f0e>] [<c0116022>] [<c0107056>] [<c010fd27>] [<c010fa28>] [<c01a6fa3>]
  [<c01a78cf>] [<c0199e51>] [<c0106b74>] [<c0128791>] [<c0128bd3>] [<c012809c>]
  [<c01281f2>] [<c0128252>] [<c01288fb>] [<c0128ae2>] [<c0124821>] [<c01288c6>]
  [<c012483d>] [<c012d746>] [<c0106a83>]
Code: 89 58 04 89 03 8d 4a 5c 89 4b 04 89 5a 5c 89 7b 0c ff 42 68 

>>EIP; c0128791 <__free_pages_ok+f1/10c>   <=====
Trace; c0128bd3 <__free_pages+1b/1c>
Trace; c0128f3f <free_page_and_swap_cache+33/38>
Trace; c011ed10 <__free_pte+40/48>
Trace; c011f0e3 <zap_page_range+17f/228>
Trace; c0121642 <exit_mmap+c6/128>
Trace; c0111f0e <mmput+4a/60>
Trace; c0116022 <do_exit+7a/218>
Trace; c0107056 <die+56/58>
Trace; c010fd27 <do_page_fault+2ff/42c>
Trace; c010fa28 <do_page_fault+0/42c>
Trace; c01a6fa3 <is_tree_node+37/4c>
Trace; c01a78cf <search_by_key+917/e00>
Trace; c0199e51 <inode2sd+85/94>
Trace; c0106b74 <error_code+34/3c>
Trace; c0128791 <__free_pages_ok+f1/10c>
Trace; c0128bd3 <__free_pages+1b/1c>
Trace; c012809c <shrink_cache+2c4/2ec>
Trace; c01281f2 <shrink_caches+56/7c>
Trace; c0128252 <try_to_free_pages_zone+3a/5c>
Trace; c01288fb <balance_classzone+33/104>
Trace; c0128ae2 <__alloc_pages+116/164>
Trace; c0124821 <generic_file_write+3e9/6e8>
Trace; c01288c6 <_alloc_pages+16/18>
Trace; c012483d <generic_file_write+405/6e8>
Trace; c012d746 <sys_write+96/f0>
Trace; c0106a83 <system_call+33/38>
Code;  c0128791 <__free_pages_ok+f1/10c>
00000000 <_EIP>:
Code;  c0128791 <__free_pages_ok+f1/10c>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c0128794 <__free_pages_ok+f4/10c>
   3:   89 03                     mov    %eax,(%ebx)
Code;  c0128796 <__free_pages_ok+f6/10c>
   5:   8d 4a 5c                  lea    0x5c(%edx),%ecx
Code;  c0128799 <__free_pages_ok+f9/10c>
   8:   89 4b 04                  mov    %ecx,0x4(%ebx)
Code;  c012879c <__free_pages_ok+fc/10c>
   b:   89 5a 5c                  mov    %ebx,0x5c(%edx)
Code;  c012879f <__free_pages_ok+ff/10c>
   e:   89 7b 0c                  mov    %edi,0xc(%ebx)
Code;  c01287a2 <__free_pages_ok+102/10c>
  11:   ff 42 68                  incl   0x68(%edx)




Linux version 2.4.21-pre3-ac4 (root@btmaster) (gcc version 2.95.3) #2 Wed Jan 15 11:47:22 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff71000 (usable)
 BIOS-e820: 000000001ff71000 - 000000001ff73000 (ACPI NVS)
 BIOS-e820: 000000001ff73000 - 000000001ff94000 (ACPI data)
 BIOS-e820: 000000001ff94000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130929
zone(0): 4096 pages.
zone(1): 126833 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=301 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 1992.656 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3971.48 BogoMIPS
Memory: 515164k/523716k available (1580k kernel code, 8168k reserved, 458k data, 248k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfbdf8, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
PCI: Found IRQ 9 for device 00:1f.1
PCI: Sharing IRQ 9 with 00:1d.2
PCI: Sharing IRQ 9 with 02:0c.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 4.4.19-k1
Copyright (c) 1999-2002 Intel Corporation.
PCI: Found IRQ 9 for device 02:0c.0
PCI: Sharing IRQ 9 with 00:1d.2
PCI: Sharing IRQ 9 with 00:1f.1
eth0: Intel(R) PRO/1000 Network Connection
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Found IRQ 9 for device 00:1f.1
PCI: Sharing IRQ 9 with 00:1d.2
PCI: Sharing IRQ 9 with 02:0c.0
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD200BB-75DEA0, ATA DISK drive
blk: queue c03682e0, I/O limit 4095Mb (mask 0xffffffff)
hdc: HL-DT-ST GCE-8481B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: setmax LBA 39102336, native  39062500
hda: 39062500 sectors (20000 MB) w/2048KiB Cache, CHS=2431/255/63, UDMA(100)
Partition check:
 hda: hda1 hda2
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HL-DT-ST  Model: CD-RW GCE-8481B   Rev: C102
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ide: no cache flush required.
FAT: bogus logical sector size 0
ide: no cache flush required.
ide: no cache flush required.
UDF-fs DEBUG lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not supported: rc=-22
UDF-fs DEBUG super.c:1421:udf_read_super: Multi-session=0
UDF-fs DEBUG super.c:410:udf_vrs: Starting at sector 16 (2048 byte sectors)
UDF-fs DEBUG super.c:1157:udf_check_valid: Failed to read byte 32768. Assuming open disc. Skipping validity check
UDF-fs DEBUG misc.c:285:udf_read_tagged: location mismatch block 256, tag 0 != 256
UDF-fs DEBUG super.c:1211:udf_load_partition: No Anchor block found
UDF-fs: No partition found (1)
ide: no cache flush required.
reiserfs: checking transaction log (device 03:01) ...
Warning, log replay starting on readonly filesystem
reiserfs: replayed 2 transactions in 2 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 248k freed
Adding Swap: 128512k swap-space (priority -1)
ide: no cache flush required.
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
svgalib_helper: device1: vendor:10de id:002d
device1: region0, base=fc000000 len=16777216 type=0
device1: region1, base=f8000000 len=33554432 type=8
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
 
-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

