Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286934AbSAXPyw>; Thu, 24 Jan 2002 10:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288498AbSAXPyo>; Thu, 24 Jan 2002 10:54:44 -0500
Received: from ti200710a082-0599.bb.online.no ([148.122.10.87]:4356 "EHLO
	empire.e") by vger.kernel.org with ESMTP id <S286934AbSAXPyj>;
	Thu, 24 Jan 2002 10:54:39 -0500
Message-ID: <3C502E3A.9070909@freenix.no>
Date: Thu, 24 Jan 2002 16:54:34 +0100
From: frode <frode@freenix.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020113
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: OOPS: kernel BUG at transaction.c:1857 on 2.4.17 while rm'ing 700mb file on ext3 partition.
Content-Type: multipart/mixed;
 boundary="------------070006040601000009020607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070006040601000009020607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello!

I got the following error while rm'ing a 700mb file from an ext3 partition:

Assertion failure in journal_unmap_buffer() at transaction.c:1857:
"transaction == journal->j_running_transaction"

I use the 'mem=nopentium' option on the lilo prompt while booting, hoping to 
reduce the rather large amount of oopses I have had recently, as I read 
something about AMD Athlons and AGP causing troubles.

Here's what happened:
1. I used dd if=/dev/cdrom of=image.iso to copy a cd to my harddisk
    (onto an ext3 partition)
2. I mounted this image on loopback to verify the image was ok, then
    umounted it again
3. I used cdrecord to burn the iso with my ide cd writer
4. I mounted the cd to verify it was ok, then umounted it.
5. I typed 'rm image.iso' to remove the image from my harddisk.

Just as I had typed 'rm image.iso', I got the error message printed above on all 
terminals. The system seemed to be running fine still, with xmms still playing 
and X running. So i saved the output from 'dmesg', 'dmesg | ksymoops', 'free', 
'lsmod', and 'lspci' onto a different partition. (see attached files).

I use ext3 on all my linux partitions. /home had about 230mb free space when the 
700mb file was on it, but df still showed 230mb after trying to rm it. Then, 
when I did an 'ls /home', the xterms locked up, so I ctrl-alt-backspaced XFree 
and logged in on the VT again which worked until I tried accessing anything on 
the /home partition. Then I did  alt-sysrq-s and alt-sysrq-b. Upon reboot, the 
journal was played back on the /home partition and the 700mb file reappeared. I 
rm'ed it without getting any errors and free space is again back up to about 930mb.

If it's of any interest, the ext3 partitions were converted from ext2 about a 
month ago.

- Frode


--------------070006040601000009020607
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
Kernel command line: BOOT_IMAGE=VMLinuz ro root=345 bootfs=ext3 mem=nopentium
Initializing CPU#0
Detected 750.044 MHz processor.
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
..... CPU clock speed is 750.0392 MHz.
..... host bus clock speed is 200.0104 MHz.
cpu: 0, clocks: 2000104, slice: 1000052
CPU0<T0:2000096,T1:1000032,D:12,S:1000052,C:2000104>
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
spurious 8259A interrupt: IRQ7.
NVRM: loading NVIDIA NVdriver Kernel Module  1.0.2313  Tue Nov 27 12:01:24 PST 2001
VFS: Disk change detected on device sr(11,0)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
VFS: Disk change detected on device sr(11,0)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
VFS: Disk change detected on device sr(11,0)
ISO 9660 Extensions: Microsoft Joliet Level 1
ISOFS: changing to secondary root
VFS: Disk change detected on device sr(11,0)
ISO 9660 Extensions: Microsoft Joliet Level 1
ISOFS: changing to secondary root
Assertion failure in journal_unmap_buffer() at transaction.c:1857: "transaction == journal->j_running_transaction"
kernel BUG at transaction.c:1857!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c015ea1b>]    Tainted: P 
EFLAGS: 00010282
eax: 00000022   ebx: 5444542d   ecx: c02f8ca0   edx: 00001fd6
esi: c6c86ab0   edi: cddfd6c0   ebp: 00000001   esp: cfa53e98
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 2318, stackpage=cfa53000)
Stack: c0293d60 00000741 cddfd6c0 00000002 cddfd6c0 00001000 c015eb6e c1643e00 
       cddfd6c0 c11202c0 00000000 cfa53f44 00000000 c1643e94 00000001 cddfd6c0 
       c0156ae2 c1643e00 c11202c0 00000000 c0125739 c11202c0 00000000 c0125763 
Call Trace: [<c015eb6e>] [<c0156ae2>] [<c0125739>] [<c0125763>] [<c01258c6>] 
   [<c0125971>] [<c014485e>] [<c0142e4c>] [<c013c69d>] [<c013c778>] [<c0106e8b>] 

Code: 0f 0b 83 c4 08 53 56 e8 99 fe ff ff 89 c5 83 c4 08 f6 47 18 
 

--------------070006040601000009020607
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

cpu: 0, clocks: 2000104, slice: 1000052
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
kernel BUG at transaction.c:1857!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c015ea1b>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000022   ebx: 5444542d   ecx: c02f8ca0   edx: 00001fd6
esi: c6c86ab0   edi: cddfd6c0   ebp: 00000001   esp: cfa53e98
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 2318, stackpage=cfa53000)
Stack: c0293d60 00000741 cddfd6c0 00000002 cddfd6c0 00001000 c015eb6e c1643e00 
       cddfd6c0 c11202c0 00000000 cfa53f44 00000000 c1643e94 00000001 cddfd6c0 
       c0156ae2 c1643e00 c11202c0 00000000 c0125739 c11202c0 00000000 c0125763 
Call Trace: [<c015eb6e>] [<c0156ae2>] [<c0125739>] [<c0125763>] [<c01258c6>] 
   [<c0125971>] [<c014485e>] [<c0142e4c>] [<c013c69d>] [<c013c778>] [<c0106e8b>] 
Code: 0f 0b 83 c4 08 53 56 e8 99 fe ff ff 89 c5 83 c4 08 f6 47 18 

>>EIP; c015ea1a <journal_unmap_buffer+fa/1b0>   <=====
Trace; c015eb6e <journal_flushpage+9e/140>
Trace; c0156ae2 <ext3_flushpage+22/30>
Trace; c0125738 <do_flushpage+18/30>
Trace; c0125762 <truncate_complete_page+12/50>
Trace; c01258c6 <truncate_list_pages+126/190>
Trace; c0125970 <truncate_inode_pages+40/70>
Trace; c014485e <iput+ae/200>
Trace; c0142e4c <d_delete+4c/70>
Trace; c013c69c <vfs_unlink+13c/170>
Trace; c013c778 <sys_unlink+a8/120>
Trace; c0106e8a <system_call+32/38>
Code;  c015ea1a <journal_unmap_buffer+fa/1b0>
00000000 <_EIP>:
Code;  c015ea1a <journal_unmap_buffer+fa/1b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015ea1c <journal_unmap_buffer+fc/1b0>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c015ea1e <journal_unmap_buffer+fe/1b0>
   5:   53                        push   %ebx
Code;  c015ea20 <journal_unmap_buffer+100/1b0>
   6:   56                        push   %esi
Code;  c015ea20 <journal_unmap_buffer+100/1b0>
   7:   e8 99 fe ff ff            call   fffffea5 <_EIP+0xfffffea5> c015e8be <journal_try_to_free_buffers+9e/a0>
Code;  c015ea26 <journal_unmap_buffer+106/1b0>
   c:   89 c5                     mov    %eax,%ebp
Code;  c015ea28 <journal_unmap_buffer+108/1b0>
   e:   83 c4 08                  add    $0x8,%esp
Code;  c015ea2a <journal_unmap_buffer+10a/1b0>
  11:   f6 47 18 00               testb  $0x0,0x18(%edi)


1 warning issued.  Results may not be reliable.

--------------070006040601000009020607
Content-Type: text/plain;
 name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.txt"

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 21)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:09.0 Multimedia video controller: 3Dfx Interactive, Inc. Voodoo (rev 02)
00:0a.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium] (rev 01)
00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
00:0b.1 Input device controller: Creative Labs SB Live! (rev 06)
00:0d.0 Ethernet controller: 3Com Corporation 3c900B-Combo [Etherlink XL Combo] (rev 04)
01:00.0 VGA compatible controller: nVidia Corporation GeForce 256 (rev 10)

--------------070006040601000009020607
Content-Type: text/plain;
 name="lsmod.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsmod.txt"

Module                  Size  Used by    Tainted: P  
NVdriver              816864  14  (autoclean)
nls_iso8859-1           2848   3  (autoclean)
nls_cp437               4384   3  (autoclean)
emu10k1                58720   2 
ac97_codec              9824   0  [emu10k1]
sound                  57004   0  [emu10k1]
3c59x                  25512   1 

--------------070006040601000009020607
Content-Type: text/plain;
 name="free.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="free.txt"

             total       used       free     shared    buffers     cached
Mem:        383828     249824     134004          0       6072     161672
-/+ buffers/cache:      82080     301748
Swap:       160608      23072     137536

--------------070006040601000009020607--

