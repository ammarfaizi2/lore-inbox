Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284902AbSAZOcg>; Sat, 26 Jan 2002 09:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbSAZOc2>; Sat, 26 Jan 2002 09:32:28 -0500
Received: from [148.122.8.188] ([148.122.8.188]:2052 "EHLO empire.e")
	by vger.kernel.org with ESMTP id <S284902AbSAZOcR>;
	Sat, 26 Jan 2002 09:32:17 -0500
Message-ID: <3C52BDEC.7010007@freenix.no>
Date: Sat, 26 Jan 2002 15:32:12 +0100
From: frode <frode@freenix.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Oops on 2.4.17 - unable to handle kernel paging request - possibly NFS related?
Content-Type: multipart/mixed;
 boundary="------------040209090602050907030609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040209090602050907030609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

To put an end to all the oopses I have been getting lately, I stopped using the 
NVdriver kernel module, hoping it was to blame for all the problems. But no...

I did 'apt-get source -d ssh' on my box, and it locked up right after it was 
'Reading package Lists..' and 'Building Dependency Tree'.

The ksymoops trace show a lot of 'nfs_*' function names, so I guess this must be 
NFS related? My /var/cache/apt and /var/lib/apt are NFS mounted from another 
2.4.17 box running nfs-kernel-server. Both machines had an uptime of about 1 
hour. The nfs server is still running without any errors.

While the apt-get process was in state 'D' and unkillable, everything else 
seemed to keep running. I attach the output of 'dmesg', 'dmesg |ksymoops', 
'lsmod' and 'free'.


And now for something completely different:
Loading the 'ppp_deflate' module taints the kernel ('P').
It seems this is because it has a MODULE_LICENSE("BSD without advertisement 
clause"), which is not recognized by insmod v2.4.12. I think it's strange for a 
module from the standard kernel tarball to taint the kernel. Is this a bug or a 
feature? :)



--------------040209090602050907030609
Content-Type: text/plain;
 name="ksymoops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops.txt"

ksymoops 2.4.3 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

cpu: 0, clocks: 2000084, slice: 1000042
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
Unable to handle kernel paging request at virtual address 65726198
c014429c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c014429c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a83
eax: c017f790   ebx: 65726170   ecx: 0000000f   edx: d7f80000
esi: 65726170   edi: c017f790   ebp: 0003630b   esp: ce25bddc
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 6049, stackpage=ce25b000)
Stack: 00000000 d7fbe9f0 0003630b d3a4e400 c01446b0 d3a4e400 0003630b d7fbe9f0 
       c017f790 ce25be38 00000000 ce25be78 ce25be38 ce25bee4 c017f915 d3a4e400 
       0003630b c017f790 ce25be38 ce25be78 d3a4e400 ce25bee4 ce25be78 ce25bee4 
Call Trace: [<c01446b0>] [<c017f790>] [<c017f915>] [<c017f790>] [<c017f8b2>] 
   [<c017d1ed>] [<c013a953>] [<c013affe>] [<c013a6ad>] [<c013b25a>] [<c013b635>] 
   [<c01387a9>] [<c0106e8b>] 
Code: 39 6e 28 75 ef 8b 44 24 14 39 86 98 00 00 00 75 e3 85 ff 74 

>>EIP; c014429c <find_inode+1c/50>   <=====
Trace; c01446b0 <iget4+40/d0>
Trace; c017f790 <nfs_find_actor+0/60>
Trace; c017f914 <__nfs_fhget+54/c0>
Trace; c017f790 <nfs_find_actor+0/60>
Trace; c017f8b2 <nfs_fhget+42/50>
Trace; c017d1ec <nfs_lookup+9c/d0>
Trace; c013a952 <real_lookup+52/c0>
Trace; c013affe <link_path_walk+51e/760>
Trace; c013a6ac <getname+5c/a0>
Trace; c013b25a <path_walk+1a/20>
Trace; c013b634 <__user_walk+34/50>
Trace; c01387a8 <sys_lstat64+18/70>
Trace; c0106e8a <system_call+32/38>
Code;  c014429c <find_inode+1c/50>
00000000 <_EIP>:
Code;  c014429c <find_inode+1c/50>   <=====
   0:   39 6e 28                  cmp    %ebp,0x28(%esi)   <=====
Code;  c014429e <find_inode+1e/50>
   3:   75 ef                     jne    fffffff4 <_EIP+0xfffffff4> c0144290 <find_inode+10/50>
Code;  c01442a0 <find_inode+20/50>
   5:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  c01442a4 <find_inode+24/50>
   9:   39 86 98 00 00 00         cmp    %eax,0x98(%esi)
Code;  c01442aa <find_inode+2a/50>
   f:   75 e3                     jne    fffffff4 <_EIP+0xfffffff4> c0144290 <find_inode+10/50>
Code;  c01442ac <find_inode+2c/50>
  11:   85 ff                     test   %edi,%edi
Code;  c01442ae <find_inode+2e/50>
  13:   74 00                     je     15 <_EIP+0x15> c01442b0 <find_inode+30/50>


1 warning issued.  Results may not be reliable.

--------------040209090602050907030609
Content-Type: text/plain;
 name="lsmod.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsmod.txt"

Module                  Size  Used by    Not tainted
nls_iso8859-1           2848   3 (autoclean)
nls_cp437               4384   3 (autoclean)
emu10k1                58720   2
ac97_codec              9824   0 [emu10k1]
sound                  57004   0 [emu10k1]
3c59x                  25512   1

--------------040209090602050907030609
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.4.17 (root@kingdom.e) (gcc version 2.95.4 20011006 (Debian prerelease)) #1 Sat Dec 22 12:17:05 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017fec000 (usable)
 BIOS-e820: 0000000017fec000 - 0000000017fef000 (ACPI data)
 BIOS-e820: 0000000017fef000 - 0000000017fff000 (reserved)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 98284
zone(0): 4096 pages.
zone(1): 94188 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: BOOT_IMAGE=VMLinuz4kb ro root=345 bootfs=ext3 mem=nopentium
Initializing CPU#0
Detected 750.037 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 1497.49 BogoMIPS
Memory: 383608k/393136k available (1531k kernel code, 9140k reserved, 583k data, 220k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0183fbff c1c3fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 750.0320 MHz.
..... host bus clock speed is 200.0084 MHz.
cpu: 0, clocks: 2000084, slice: 1000042
CPU0<T0:2000080,T1:1000032,D:6,S:1000042,C:2000084>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1010, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: Printer, EPSON Stylus COLOR 850
parport_pc: Via 686A parallel port: io=0x378
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
lp0: console ready
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.1
ppdev: user-space parallel port driver
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 21) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DPTA-372050, ATA DISK drive
hdb: QUANTUM FIREBALLP LM20.5, ATA DISK drive
hdc: _NEC DV-5700A, ATAPI CD/DVD-ROM drive
hdd: CR-4801TE, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=2495/255/63, UDMA(66)
hdb: 40132503 sectors (20548 MB) w/1900KiB Cache, CHS=2498/255/63, UDMA(66)
Partition check:
 hda: hda1 hda2 < hda5 >
 hdb: hdb1 < hdb5 hdb6 hdb7 hdb8 > hdb2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: _NEC      Model: DV-5700A          Rev: 1.91
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MITSUMI   Model: CR-4801TE         Rev: 2.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 17x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 8x/8x writer cd/rw xa/form2 cdda tray
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Adding Swap: 160608k swap-space (priority -1)
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,69), internal journal
PCI: Found IRQ 9 for device 00:0d.0
PCI: Sharing IRQ 9 with 00:04.2
PCI: Sharing IRQ 9 with 00:04.3
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0d.0: 3Com PCI 3c900 Cyclone 10Mbps Combo at 0x9800. Vers LK1.1.16
Creative EMU10K1 PCI Audio Driver, version 0.16, 12:25:52 Dec 22 2001
PCI: Found IRQ 10 for device 00:0b.0
emu10k1: EMU10K1 rev 6 model 0x8027 found, IO at 0xa400-0xa41f, IRQ 10
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,66), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,70), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
lp0: compatibility mode
lp0: compatibility mode
lp0: compatibility mode
VFS: Disk change detected on device sr(11,0)
spurious 8259A interrupt: IRQ7.
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
VFS: Disk change detected on device sr(11,0)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
Unable to handle kernel paging request at virtual address 65726198
 printing eip:
c014429c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c014429c>]    Not tainted
EFLAGS: 00010a83
eax: c017f790   ebx: 65726170   ecx: 0000000f   edx: d7f80000
esi: 65726170   edi: c017f790   ebp: 0003630b   esp: ce25bddc
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 6049, stackpage=ce25b000)
Stack: 00000000 d7fbe9f0 0003630b d3a4e400 c01446b0 d3a4e400 0003630b d7fbe9f0 
       c017f790 ce25be38 00000000 ce25be78 ce25be38 ce25bee4 c017f915 d3a4e400 
       0003630b c017f790 ce25be38 ce25be78 d3a4e400 ce25bee4 ce25be78 ce25bee4 
Call Trace: [<c01446b0>] [<c017f790>] [<c017f915>] [<c017f790>] [<c017f8b2>] 
   [<c017d1ed>] [<c013a953>] [<c013affe>] [<c013a6ad>] [<c013b25a>] [<c013b635>] 
   [<c01387a9>] [<c0106e8b>] 

Code: 39 6e 28 75 ef 8b 44 24 14 39 86 98 00 00 00 75 e3 85 ff 74 
 <7>VFS: Disk change detected on device sr(11,0)
VFS: Disk change detected on device sr(11,0)
sr0: CDROM not ready.  Make sure there is a disc in the drive.

--------------040209090602050907030609
Content-Type: text/plain;
 name="free.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="free.txt"

             total       used       free     shared    buffers     cached
Mem:        383828     370252      13576          0      20868     243964
-/+ buffers/cache:     105420     278408
Swap:       160608       3992     156616

--------------040209090602050907030609--

