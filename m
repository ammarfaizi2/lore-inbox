Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262683AbREOIfK>; Tue, 15 May 2001 04:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262681AbREOIev>; Tue, 15 May 2001 04:34:51 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.36.1]:51211 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S262680AbREOIek>; Tue, 15 May 2001 04:34:40 -0400
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200105150834.SAA08720@mercury.physics.adelaide.edu.au>
Subject: Kernel 2.2.19 + VIA chipset + strange behaviour
To: linux-kernel@vger.kernel.org
Date: Tue, 15 May 2001 18:04:35 +0930 (CST)
Cc: jwoithe@physics.adelaide.edu.au
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people

We are currently running a 900MHz Athlon at 900MHz with a VIA chipset
mainboard.  We have been experiencing strange problems and a number of
kernel panics.  The debugged oopes from three of these are included at the
end of this message.

My first question is whether this could be related to the VIA disk
corruption bug which has been much talked about.  Does this also affect
2.2.x or is it strictly a 2.4.x problem at this stage?

Please CC me replies since the kernel list archive I watch has a habbit of
missing some posts.

It should also be noted that every now and then I've seen ext2fs filesystem
errors on the console.  badblocks does not report anything as bad.

On to the oopes.  First a bit of machine info:

auster:~/auster>cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 900.072
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 psn mmxext mmx fxsr 3dnowext 3dnow
bogomips        : 1795.68

auster:~/auster> lspci
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:07.0 ISA bridge: VIA Technologies, Inc.: Unknown device 0686 (rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
00:07.4 Class 0c05: VIA Technologies, Inc.: Unknown device 3057 (rev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc.: Unknown device 3058 (rev 20)
00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
01:00.0 VGA compatible controller: Nvidia Corporation: Unknown device 002d (rev 15)
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:07.0 ISA bridge: VIA Technologies, Inc.: Unknown device 0686 (rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
00:07.4 Class 0c05: VIA Technologies, Inc.: Unknown device 3057 (rev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc.: Unknown device 3058 (rev 20)
00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
01:00.0 VGA compatible controller: Nvidia Corporation: Unknown device 002d (rev 15)

auster:~/auster>dmesg
Linux version 2.2.19 (root@auster) (gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #1 Fri Mar 30 14:42:37 CST 2001
USER-provided physical RAM map:
 USER: 0009f000 @ 00000000 (usable)
 USER: 1ff00000 @ 00100000 (usable)
Detected 900072 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1795.68 BogoMIPS
Memory: 517400k/524288k available (1016k kernel code, 412k reserved, 5396k
data, 64k init)
Dentry hash table entries: 65536 (order 7, 512k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 131072 (order 7, 512k)
CPU: L1 I Cache: 64K  L1 D Cache: 64K
CPU: L2 Cache: 256K
CPU: AMD Athlon(tm) Processor stepping 02
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfdb71
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 524288 bhash 65536)
Starting kswapd v 1.5 
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MPF3102AT, ATA DISK drive
hdc: ATAPI-CD ROM-DRIVE-50MAX, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: FUJITSU MPF3102AT, 9773MB w/512kB Cache, CHS=1245/255/63
hdc: ATAPI 50X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
scsi : 0 hosts.
scsi : detected total.
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
auster:~/auster>dmesg
Linux version 2.2.19 (root@auster) (gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #1 Fri Mar 30 14:42:37 CST 2001
USER-provided physical RAM map:
 USER: 0009f000 @ 00000000 (usable)
 USER: 1ff00000 @ 00100000 (usable)
Detected 900072 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1795.68 BogoMIPS
Memory: 517400k/524288k available (1016k kernel code, 412k reserved, 5396k
data, 64k init)
Dentry hash table entries: 65536 (order 7, 512k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 131072 (order 7, 512k)
CPU: L1 I Cache: 64K  L1 D Cache: 64K
CPU: L2 Cache: 256K
CPU: AMD Athlon(tm) Processor stepping 02
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfdb71
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 524288 bhash 65536)
Starting kswapd v 1.5 
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MPF3102AT, ATA DISK drive
hdc: ATAPI-CD ROM-DRIVE-50MAX, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: FUJITSU MPF3102AT, 9773MB w/512kB Cache, CHS=1245/255/63
hdc: ATAPI 50X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
scsi : 0 hosts.
scsi : detected total.
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 64k freed
Adding Swap: 530104k swap-space (priority -1)
parport0: PC-style at 0x378 (0x778) [SPP,ECP,ECPPS2]
parport0: detected irq 7; use procfs to enable interrupt-driven operation.
lp0: using parport0 (polling).
tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
eth0: Lite-On 82c168 PNIC rev 32 at 0xbc00, 00:A0:CC:D4:DE:9F, IRQ 10.
eth0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.


Oops #1:
  These happened as someone was trying to umount a CDROM.  The machine was
  not locked by these oopses.

ksymoops 2.4.1 on i686 2.2.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.19/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 0000001c
current->tss.cr3 = 02448000, %cr3 = 02448000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0125e8c>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: 00000000   ecx: 00001600   edx: 00001600
esi: 00000e7a   edi: 00000000   ebp: 00000000   esp: cc279f20
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 8526, process nr: 52, stackpage=cc279000)
Stack: 00001600 00000001 00000000 1600d160 c01c2685 00001600 00000000 c0244600 
       d9dfac40 d9dfac40 00001600 00001600 c0197d59 d9dfac40 00000000 c0187c20 
       d9dfac40 00000000 c0244600 d9dfac40 00000000 c0125267 d9dfac40 00000000 
Call Trace: [<c01c2685>] [<c0197d59>] [<c0187c20>] [<c0125267>] [<c01283cc>] [<c012849f>] [<c01284b8>] 
       [<c0109054>] 
Code: 8b 6b 1c 66 8b 54 24 16 66 39 53 0c 75 3c 8b 43 18 a8 04 74 

>>EIP; c0125e8c <__invalidate_buffers+38/98>   <=====
Trace; c01c2685 <cdrom_release+f5/124>
Trace; c0197d59 <ide_cdrom_release+11/18>
Trace; c0187c20 <ide_release+40/4c>
Trace; c0125267 <blkdev_release+23/2c>
Trace; c01283cc <umount_dev+78/a0>
Trace; c012849f <sys_umount+ab/b8>
Trace; c01284b8 <sys_oldumount+c/10>
Trace; c0109054 <system_call+34/38>
Code;  c0125e8c <__invalidate_buffers+38/98>
00000000 <_EIP>:
Code;  c0125e8c <__invalidate_buffers+38/98>   <=====
   0:   8b 6b 1c                  movl   0x1c(%ebx),%ebp   <=====
Code;  c0125e8f <__invalidate_buffers+3b/98>
   3:   66 8b 54 24 16            movw   0x16(%esp,1),%dx
Code;  c0125e94 <__invalidate_buffers+40/98>
   8:   66 39 53 0c               cmpw   %dx,0xc(%ebx)
Code;  c0125e98 <__invalidate_buffers+44/98>
   c:   75 3c                     jne    4a <_EIP+0x4a> c0125ed6 <__invalidate_buffers+82/98>
Code;  c0125e9a <__invalidate_buffers+46/98>
   e:   8b 43 18                  movl   0x18(%ebx),%eax
Code;  c0125e9d <__invalidate_buffers+49/98>
  11:   a8 04                     testb  $0x4,%al
Code;  c0125e9f <__invalidate_buffers+4b/98>
  13:   74 00                     je     15 <_EIP+0x15> c0125ea1 <__invalidate_buffers+4d/98>

Unable to handle kernel NULL pointer dereference at virtual address 0000001c
current->tss.cr3 = 11dd5000, %cr3 = 11dd5000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0125e8c>]
EFLAGS: 00010202
eax: 00000000   ebx: 00000000   ecx: c0201fe8   edx: 00001600
esi: 00000ea4   edi: 00000000   ebp: 00000000   esp: dd373ec8
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 8555, process nr: 40, stackpage=dd373000)
Stack: 00001600 08051600 00000000 16001600 c01251e8 00001600 00000001 dffecc20 
       00000000 00001600 c01c2146 00001600 dffecb60 c0244600 c0187b68 c0197d39 
       deb26c40 dd373f68 c0244600 deb26c40 c0187bbc deb26c40 dd373f68 c0244600 
Call Trace: [<c01251e8>] [<c01c2146>] [<c0187b68>] [<c0197d39>] [<c0187bbc>] [<c01289ec>] [<c0187b68>] 
       [<c0109054>] 
Code: 8b 6b 1c 66 8b 54 24 16 66 39 53 0c 75 3c 8b 43 18 a8 04 74 

>>EIP; c0125e8c <__invalidate_buffers+38/98>   <=====
Trace; c01251e8 <check_disk_change+7c/98>
Trace; c01c2146 <cdrom_open+b2/bc>
Trace; c0187b68 <ide_open+0/78>
Trace; c0197d39 <ide_cdrom_open+35/44>
Trace; c0187bbc <ide_open+54/78>
Trace; c01289ec <sys_mount+200/2fc>
Trace; c0187b68 <ide_open+0/78>
Trace; c0109054 <system_call+34/38>
Code;  c0125e8c <__invalidate_buffers+38/98>
00000000 <_EIP>:
Code;  c0125e8c <__invalidate_buffers+38/98>   <=====
   0:   8b 6b 1c                  movl   0x1c(%ebx),%ebp   <=====
Code;  c0125e8f <__invalidate_buffers+3b/98>
   3:   66 8b 54 24 16            movw   0x16(%esp,1),%dx
Code;  c0125e94 <__invalidate_buffers+40/98>
   8:   66 39 53 0c               cmpw   %dx,0xc(%ebx)
Code;  c0125e98 <__invalidate_buffers+44/98>
   c:   75 3c                     jne    4a <_EIP+0x4a> c0125ed6 <__invalidate_buffers+82/98>
Code;  c0125e9a <__invalidate_buffers+46/98>
   e:   8b 43 18                  movl   0x18(%ebx),%eax
Code;  c0125e9d <__invalidate_buffers+49/98>
  11:   a8 04                     testb  $0x4,%al
Code;  c0125e9f <__invalidate_buffers+4b/98>
  13:   74 00                     je     15 <_EIP+0x15> c0125ea1 <__invalidate_buffers+4d/98>

2 warnings issued.  Results may not be reliable.


Oops #2:
  Nothing specific triggered this oops, although there *might* have been
  a CDROM umount operation pending or just complete.  The machine was locked
  solid following this oops.

ksymoops 2.4.1 on i686 2.2.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.19/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 01000000
current->tss.cr3 = 1f7f0000, %cr3 = 1f7f0000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0125dc0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: 00000007   ecx: 00000400   edx: 01000000
esi: 0000000d   edi: 00000301   ebp: 00000bb7   esp: d5cbee4
ds: 0018   es: 0018   ss: 0018
Process syslogd (pid: 67, process nr: 8, stackpage=d5cb5000)
Stack: d5c83b90 00000000 00071f80 c0125e00 00000301 00000bb7 00000400 00000000
       c013ae76 00000301 00000bb7 00000400 00000079 00000000 c013b002 d5c83b90
       d29811e4 00000000 00000001 00000000 d5c83b90 00000000 d5af2b40 c013b082
Call Trace: [<c0125e00>] [<c013ae76>] [<c013b002>] [<c013b082>] [<c013b19b>] [<c0125990>] [<c0109054>] 
Code: 8b 00 39 6a 04 75 15 8b 4c 24 20 39 4a 08 75 0c 66 39 7a 0c

>>EIP; c0125dc0 <find_buffer+68/90>   <=====
Trace; c0125e00 <get_hash_table+18/48>
Trace; c013ae76 <sync_block+2e/d8>
Trace; c013b002 <sync_indirect+4e/80>
Trace; c013b082 <sync_dindirect+4e/80>
Trace; c013b19b <ext2_sync_file+67/a4>
Trace; c0125990 <sys_fsync+7c/a8>
Trace; c0109054 <system_call+34/38>
Code;  c0125dc0 <find_buffer+68/90>
00000000 <_EIP>:
Code;  c0125dc0 <find_buffer+68/90>   <=====
   0:   8b 00                     movl   (%eax),%eax   <=====
Code;  c0125dc2 <find_buffer+6a/90>
   2:   39 6a 04                  cmpl   %ebp,0x4(%edx)
Code;  c0125dc5 <find_buffer+6d/90>
   5:   75 15                     jne    1c <_EIP+0x1c> c0125ddc <find_buffer+84/90>
Code;  c0125dc7 <find_buffer+6f/90>
   7:   8b 4c 24 20               movl   0x20(%esp,1),%ecx
Code;  c0125dcb <find_buffer+73/90>
   b:   39 4a 08                  cmpl   %ecx,0x8(%edx)
Code;  c0125dce <find_buffer+76/90>
   e:   75 0c                     jne    1c <_EIP+0x1c> c0125ddc <find_buffer+84/90>
Code;  c0125dd0 <find_buffer+78/90>
  10:   66 39 7a 0c               cmpw   %di,0xc(%edx)

Kernel Panic: Free list corrupted

2 warnings issued.  Results may not be reliable.


Oops #3:
  Around the time this happened, IDL (one particular application we use
  here) started giving segfaults when anything was typed at its prompt.
  This was the only symptom that something odd was happening at this time;
  the machine kept functioning.

ksymoops 2.4.1 on i686 2.2.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.19/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address 0200001c
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012fdaf>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: d30a4638   ebx: d30a4600   ecx: d30a4638   edx: d30a4638
esi: 02000000   edi: ffffffff   ebp: 00000000   esp: dffe5fac
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, process nr: 4, stackpage=dffe5000)
Stack: 00000030 00000008 ffffffff c0130110 0000064c ffffffff c0120f74 00000005 
       00000030 dffe4000 c01d028e dffe41c9 c0120fef 00000030 00000f00 dfffbfb4 
       c0106000 c0107b97 00000000 00000f00 c0215fd8 
Call Trace: [<c0130110>] [<c0120f74>] [<c01d028e>] [<c0120fef>] [<c0106000>] [<c0107b97>] 
Code: 83 7e 1c 01 0f 94 c0 89 c5 81 e5 ff 00 00 00 8b 43 50 85 c0

>>EIP; c012fdaf <prune_dcache+ab/154>   <=====
Trace; c0130110 <shrink_dcache_memory+34/38>
Trace; c0120f74 <try_to_free_pages+74/8c>
Trace; c01d028e <tvecs+1aee/3420>
Trace; c0120fef <kswapd+63/98>
Trace; c0106000 <get_options+0/74>
Trace; c0107b97 <kernel_thread+23/30>
Code;  c012fdaf <prune_dcache+ab/154>
00000000 <_EIP>:
Code;  c012fdaf <prune_dcache+ab/154>   <=====
   0:   83 7e 1c 01               cmpl   $0x1,0x1c(%esi)   <=====
Code;  c012fdb3 <prune_dcache+af/154>
   4:   0f 94 c0                  sete   %al
Code;  c012fdb6 <prune_dcache+b2/154>
   7:   89 c5                     movl   %eax,%ebp
Code;  c012fdb8 <prune_dcache+b4/154>
   9:   81 e5 ff 00 00 00         andl   $0xff,%ebp
Code;  c012fdbe <prune_dcache+ba/154>
   f:   8b 43 50                  movl   0x50(%ebx),%eax
Code;  c012fdc1 <prune_dcache+bd/154>
  12:   85 c0                     testl  %eax,%eax

2 warnings issued.  Results may not be reliable.

-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple     *
*   and danced naked on a harpsicord singing 'subtle plans are here again'" *
