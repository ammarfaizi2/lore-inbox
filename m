Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266270AbRGEULR>; Thu, 5 Jul 2001 16:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266267AbRGEUK6>; Thu, 5 Jul 2001 16:10:58 -0400
Received: from winds.org ([209.115.81.9]:65040 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S266266AbRGEUKq>;
	Thu, 5 Jul 2001 16:10:46 -0400
Date: Thu, 5 Jul 2001 16:10:46 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: <linux-kernel@vger.kernel.org>
Subject: [OOPS] insmod, 2.4.6-ac1
Message-ID: <Pine.LNX.4.33.0107051606460.13920-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting up the system normally today, my first try with 2.4.6-ac1 yielded the
following OOPS:


ksymoops 2.4.0 on i686 2.4.6-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6-ac1/ (default)
     -m /boot/System.map-2.4.6-ac1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /boot/System.map-2.4.6-ac1 failed
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01245a7>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c0298edc   ebx: c40fc2b4   ecx: 00000007   edx: c40fc2b4
esi: 00000202   edi: c40fc2b4   ebp: c6ac5f2c   esp: c6ac5ec4
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 576, stackpage=c6ac5000)
Stack: c40fc2b4 00000202 00000007 c6ac5f2c c41a3220 c0124829 c40fc2b4 00000007
       c88c2000 00000000 c88c206f c88c268f 0000006c 00000007 c88c2bc0 c02991f4
       c88c2000 00000000 c88c206f c88c206f 00000d90 c1044010 00000207 00000000
Call Trace: [<c0124829>] [<c01130dd>] [<c0106a2b>]
Code: 0f 0b f6 c5 10 0f 85 ae 01 00 00 a1 28 fd 2e c0 f7 d8 89 ce

>>EIP; c01245a7 <kmem_cache_destroy+e3/2a4>   <=====
Trace; c0124829 <kmalloc+6d/88>
Trace; c01130dd <inter_module_put+6c9/76c>
Trace; c0106a2b <__up_wakeup+fa7/22f4>
Code;  c01245a7 <kmem_cache_destroy+e3/2a4>
00000000 <_EIP>:
Code;  c01245a7 <kmem_cache_destroy+e3/2a4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01245a9 <kmem_cache_destroy+e5/2a4>
   2:   f6 c5 10                  test   $0x10,%ch
Code;  c01245ac <kmem_cache_destroy+e8/2a4>
   5:   0f 85 ae 01 00 00         jne    1b9 <_EIP+0x1b9> c0124760 <kmem_cache_destroy+29c/2a4>
Code;  c01245b2 <kmem_cache_destroy+ee/2a4>
   b:   a1 28 fd 2e c0            mov    0xc02efd28,%eax
Code;  c01245b7 <kmem_cache_destroy+f3/2a4>
  10:   f7 d8                     neg    %eax
Code;  c01245b9 <kmem_cache_destroy+f5/2a4>
  12:   89 ce                     mov    %ecx,%esi


1 warning and 1 error issued.  Results may not be reliable.

DMESG: (from the working 2.4.5-ac13 version)

Linux version 2.4.5-ac13 (xxx) (gcc version 2.95.3) #2 Tue Jun 19 09:11:23 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6c00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000040fd800 (usable)
 BIOS-e820: 00000000040fd800 - 00000000040ff800 (ACPI data)
 BIOS-e820: 00000000040ff800 - 00000000040ffc00 (ACPI NVS)
 BIOS-e820: 00000000040ffc00 - 0000000008000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=803 hdd=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 698.400 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1392.64 BogoMIPS
Memory: 126328k/131072k available (1320k kernel code, 4344k reserved, 390k data, 196k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd993, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
NTFS version 1.1.15
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Serial driver version 5.05b (2001-05-03) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
block: queued sectors max/low 83888kB/27962kB, 256 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0x14a8-0x14af, BIOS settings: hdc:DMA, hdd:pio
hdc: Lite-On LTN483S 48x Max, ATAPI CD/DVD-ROM drive
hdd: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 48X CD-ROM drive, 120kB Cache
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
PCI: Found IRQ 11 for device 00:0d.0
PCI: The same IRQ used for device 01:00.0
3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905C Tornado at 0x1400,  00:01:02:35:2e:06, IRQ 11
  product code 454e rev 00.14 date 02-10-00
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
eth0: scatter/gather enabled. h/w checksums enabled
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:0f.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec 2940 Ultra2 SCSI adapter (OEM)>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs

  Vendor: QUANTUM   Model: ATLAS 10K 18WLS   Rev: UCH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:2): 80.000MB/s transfers (40.000MHz, offset 31, 16bit)
scsi0:0:2:0: Tagged Queuing enabled.  Depth 8
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PLEXTOR   Model: CD-R   PX-W1210A  Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 2, lun 0
SCSI device sda: 35566499 512-byte hdwr sectors (18210 MB)
Partition check:
 sda: sda1 sda2 sda3
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
fatfs: bogus logical sector size 0
You didn't specify the type of your ufs filesystem

mount -t ufs -o ufstype=sun|sunx86|44bsd|old|hp|nextstep|netxstep-cd|openstep ...

>>>WARNING<<< Wrong ufstype may corrupt your filesystem, default is ufstype=old
ufs_read_super: bad magic number
reiserfs: checking transaction log (device 08:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 196k freed
Adding Swap: 136544k swap-space (priority -1)

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

