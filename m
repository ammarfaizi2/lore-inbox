Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279617AbRKFPCh>; Tue, 6 Nov 2001 10:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279615AbRKFPC2>; Tue, 6 Nov 2001 10:02:28 -0500
Received: from ns.suse.de ([213.95.15.193]:55565 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279617AbRKFPCL>;
	Tue, 6 Nov 2001 10:02:11 -0500
Date: Tue, 6 Nov 2001 16:02:00 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: oops with 2.4.13-ac8
Message-ID: <20011106160200.A7291@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this seems to happen with some load, but I did not find the exact trigger.


smirnow:~ # Oops: 0002
CPU:    0
EIP:    0010:[<c011946b>]    Not tainted
EFLAGS: 00010046
eax: 00000000   ebx: 51eb851f   ecx: 000128be   edx: 00000001
esi: 40079000   edi: 00000000   ebp: c5a23d50   esp: c5a23cc4
ds: 0018   es: 0018   ss: 0018
Process rpm (pid: 3373, stackpage=c5a22000)
Stack: 40079000 00000001 00000000 c011953d 40079000 00000000 00000001 00000000 
       00002e94 c5a23d50 00000000 c011985f 00000000 c010a8dd c5a23d50 c024b668 
       20000001 c0107eaf 00000000 00000000 c5a23d50 00000000 c0272900 00000000 
Call Trace: [<c011953d>] [<c011985f>] [<c010a8dd>] [<c0107eaf>] [<c0108016>] 
   [<c0121b62>] [<c01218a6>] [<c0121be7>] [<c0121b34>] [<c012e05b>] [<c0106cfb>] 
   [<c0106cfb>] 

Code: 01 bc 30 fc 00 00 00 01 94 30 00 01 00 00 89 f8 03 86 e8 00 
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 
ksymoops 2.4.2 on i686 2.4.13-ac8.  Options used
     -v linux-2.4.13-ac8/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.13-ac8/ (default)
     -m linux-2.4.13-ac8/System.map (specified)

Reading Oops report from the terminal
CPU:    0
EIP:    0010:[<c011946b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: 51eb851f   ecx: 000128be   edx: 00000001
esi: 40079000   edi: 00000000   ebp: c5a23d50   esp: c5a23cc4
ds: 0018   es: 0018   ss: 0018
Process rpm (pid: 3373, stackpage=c5a22000)
Stack: 40079000 00000001 00000000 c011953d 40079000 00000000 00000001 00000000
       00002e94 c5a23d50 00000000 c011985f 00000000 c010a8dd c5a23d50 c024b668
       20000001 c0107eaf 00000000 00000000 c5a23d50 00000000 c0272900 00000000
Call Trace: [<c011953d>] [<c011985f>] [<c010a8dd>] [<c0107eaf>] [<c0108016>]
   [<c0121b62>] [<c01218a6>] [<c0121be7>] [<c0121b34>] [<c012e05b>] [<c0106cfb>]
   [<c0106cfb>]
Code: 01 bc 30 fc 00 00 00 01 94 30 00 01 00 00 89 f8 03 86 e8 00

>>EIP; c011946a <update_one_process+1a/d4>   <=====
Trace; c011953c <update_process_times+18/88>
Trace; c011985e <do_timer+22/6c>
Trace; c010a8dc <timer_interrupt+d0/18c>
Trace; c0107eae <handle_IRQ_event+2e/58>
Trace; c0108016 <do_IRQ+6a/a8>
Trace; c0121b62 <file_read_actor+2e/54>
Trace; c01218a6 <do_generic_file_read+212/4a0>
Trace; c0121be6 <generic_file_read+5e/7c>
Trace; c0121b34 <file_read_actor+0/54>
Trace; c012e05a <sys_read+8e/c4>
Trace; c0106cfa <system_call+2e/34>
Trace; c0106cfa <system_call+2e/34>
Code;  c011946a <update_one_process+1a/d4>
00000000 <_EIP>:
Code;  c011946a <update_one_process+1a/d4>   <=====
   0:   01 bc 30 fc 00 00 00      add    %edi,0xfc(%eax,%esi,1)   <=====
Code;  c0119470 <update_one_process+20/d4>
   7:   01 94 30 00 01 00 00      add    %edx,0x100(%eax,%esi,1)
Code;  c0119478 <update_one_process+28/d4>
   e:   89 f8                     mov    %edi,%eax
Code;  c011947a <update_one_process+2a/d4>
  10:   03 86 e8 00 00 00         add    0xe8(%esi),%eax

 <0>Kernel panic: Aiee, killing interrupt handler!
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux smirnow 2.4.13-ac8 #1 Tue Nov 6 12:06:13 CET 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.29
util-linux             2.11i
mount                  2.11i
modutils               2.4.8
e2fsprogs              1.24a
reiserfsprogs          3.x.0k-pre9
PPP                    2.4.1
isdn4k-utils           3.1pre2
Linux C Library        x    1 root     root      1384168 Sep 20 05:52 /lib/libc.so.6
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         evdev input uhci usbcore

Linux version 2.4.13-ac8 (root@smirnow) (gcc version 2.95.3 20010315 (SuSE)) #1 Tue Nov 6 12:06:13 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ffd000 (usable)
 BIOS-e820: 0000000007ffd000 - 0000000007fff000 (ACPI data)
 BIOS-e820: 0000000007fff000 - 0000000008000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 32765
zone(0): 4096 pages.
zone(1): 28669 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=ac ro root=803 BOOT_FILE=/root/linux-2.4.13-ac8/arch/i386/boot/bzImage console=ttyS0,38400
Initializing CPU#0
Detected 400.918 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 799.53 BogoMIPS
Memory: 126780k/131060k available (1039k kernel code, 3892k reserved, 371k data, 56k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Deschutes) stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 84138kB/28046kB, 256 slots per queue
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PCI: Found IRQ 10 for device 00:0a.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0a.0: 3Com PCI 3c595 Vortex 100baseTx at 0xb800. Vers LK1.1.16
00:0a.0: Overriding PCI latency timer (CFLT) setting of 32, new value is 248.
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 15 for device 00:06.0
PCI: Sharing IRQ 15 with 00:04.2
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 31, 16bit)
  Vendor: TEAC      Model: CD-ROM CD-532S    Rev: 1.0A
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Partition check:
 sda: sda1 sda2 sda3
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
(scsi0:A:6): 20.000MB/s transfers (20.000MHz, offset 16)
sr0: scsi3-mmc drive: 372x/372x caddy
Uniform CD-ROM driver Revision: 3.12
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 56k freed
INIT: version 2.78 booting



Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
