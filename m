Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265461AbUAHQJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265479AbUAHQJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:09:29 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:62424 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S265461AbUAHQIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 11:08:18 -0500
Date: Thu, 08 Jan 2004 08:07:32 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: linux-mm mailing list <linux-mm@kvack.org>, karoly.vegh@uta.at
Subject: [Bug 1812] New: Oops + processinfo related processes	hang 
Message-ID: <5470000.1073578052@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1812

           Summary: Oops + processinfo related processes hang
    Kernel Version: 2.6.1-rc1
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: karoly.vegh@uta.at


Distribution: Debian 3.0 (+ couple of sid packages)
Hardware Environment: Two PIII-700 CPUs, 1G RAM
Software Environment: gcc-2.95
Problem Description: after compiling a bigger piece of software (for example
linux-2.6.1-rc3) removing with 'rm' couple of files ends up in a Segmentation
Fault, and a kernel Oops, after what if I start again something bigger (like
recompiling the kernel) after a while it hangs, an I am not able to look at
processinfo related processes (they hang with the output, ps gives some info,
then dies like this:

[...]

root     20846  0.0  0.0  1720  792 pts/1    S    14:52   0:00 /usr/bin/make -f
/usr/share/kernel-package/rules DEBIAN_REVISION=0.1 kern
root       905  0.0  0.1  2244 1316 pts/1    S    15:05   0:00 /usr/bin/make
ARCH=i386 modules
root      3693  0.0  0.0  1852  928 pts/1    S    15:10   0:00 /usr/bin/make -f
scripts/Makefile.build obj=net
root      3697  0.0  0.1  2652 1704 pts/1    S    15:10   0:00 /usr/bin/make -f
scripts/Makefile.build obj=net/ipv4
root      3722  0.0  0.0  1856  860 pts/1    S    15:10   0:00 /usr/bin/make -f
scripts/Makefile.build obj=net/ipv4/ipvs
root      3841  0.0  0.0  2288  964 pts/1    S    15:10   0:00 /bin/sh -c set
-e; ?  echo '  CC [M]  net/ipv4/ipvs/ip_vs_proto_tcp.o'; g
root      3842  0.0  0.0  1564  420 pts/1    S    15:10   0:00 gcc
-Wp,-MD,net/ipv4/ipvs/.ip_vs_proto_tcp.o.d -nostdinc -iwithprefix inc
root      3843  0.0  0.1  3160 1912 pts/1    S    15:10   0:00
/usr/lib/gcc-lib/i386-linux/2.95.4/cpp0 -lang-c -nostdinc -Iinclude -Iinc
root      3844 99.9  1.1 13216 11960 pts/1   R    15:10   9:09
/usr/lib/gcc-lib/i386-linux/2.95.4/cc1 -quiet -dumpbase ip_vs_proto_tcp.c
root      3845  0.0  0.1  2480 1188 pts/1    S    15:10   0:00 as -Qy -o
net/ipv4/ipvs/.tmp_ip_vs_proto_tcp.o -

(here no more info, cannot ctrl+c the ps process, cannot ctrl+z the process...

the w command hangs the same way. 


Steps to reproduce: compile something big ... then delete something
(segmentation fault on 'rm') --> Oops ... do something big again (start
compiling again) .. after a while it hangs, and other processes as well, 
cannot connect per ssh anymore, ping is OK, dmesg on the box works, scp
works.

dmesg:

Linux version 2.6.1-rc1 (root@debora) (gcc version 2.95.4 20011002 (Debian
prerelease)) #2 SMP Mon Jan 5 17:08:23 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5770
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
ACPI disabled because your bios is from 2000 and too old
You can enable it with acpi=force
ACPI: RSDP (v000 VIA694                                    ) @ 0x000f70b0
ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
ACPI: MADT (v001 VIA694          0x00000000  0x00000000) @ 0x3fff56c0
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Linux ro root=302
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 732.412 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 1030832k/1048512k available (2637k kernel code, 16752k reserved, 1240k
data, 184k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1437.69 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0387fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0387fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU:     After all inits, caps: 0383fbf7 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.58 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1458.17 BogoMIPS
CPU:     After generic identify, caps: 0387fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0387fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU:     After all inits, caps: 0383fbf7 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (2895.87 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not
connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  1    1    0   1   0    1    1    79
 0b 001 01  1    1    0   1   0    1    1    81
 0c 001 01  1    1    0   1   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 732.0063 MHz.
..... host bus clock speed is 133.0102 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 32
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb3a0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20031002
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
Linux Kernel Card Services
  options:  [pci] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
matroxfb: Matrox Millennium G200 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x65536)
matroxfb: framebuffer at 0xD7000000, mapped to 0xf8805000, size 8388608
fb0: MATROX frame buffer device
fb0: initializing hardware
Starting balanced_irq
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.5 [Flags: R/O].
udf: registering filesystem
Initializing Cryptographic API
PCI: Enabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 80x30
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 32049H2, ATA DISK drive
hdb: Maxtor 32049H2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA CD-ROM XM-6702B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 40021632 sectors (20491 MB) w/2048KiB Cache, CHS=39704/16/63, UDMA(100)
 hda: hda1 hda2
hdb: max request size: 128KiB
hdb: 40021632 sectors (20491 MB) w/2048KiB Cache, CHS=39704/16/63, UDMA(100)
 hdb: hdb1
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Console: switching to colour frame buffer device 80x30
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1200.000 MB/sec
   8regs_prefetch:  1080.000 MB/sec
   32regs    :   836.000 MB/sec
   32regs_prefetch:   776.000 MB/sec
   pIII_sse  :  1444.000 MB/sec
   pII_mmx   :  1816.000 MB/sec
   p5_mmx    :  1912.000 MB/sec
raid5: using function: pIII_sse (1444.000 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
ip_conntrack version 2.1 (8191 buckets, 65528 max) - 308 bytes per conntrack
NET: Registered protocol family 1
NET: Registered protocol family 17
Software Suspend has malfunctioning SMP support. Disabled :(
PM: Reading pmdisk image.
PM: Resume from disk failed.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding 995988k swap on /dev/hda1.  Priority:-1 extents:1
crc32: no version for "struct_module" found: kernel tainted.
via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xec00, 00:50:ba:1f:a8:24, IRQ 11.
eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 41e1.
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
eth0: Setting full-duplex based on MII #8 link partner capability of 41e1.
Unable to handle kernel paging request at virtual address 81188bec
 printing eip:
c0144a96
*pde = 00000000
Oops: 0002 [#1]
CPU:    1
EIP:    0060:[<c0144a96>]    Tainted: GF 
EFLAGS: 00010287
EIP is at find_get_pages+0x56/0xac
eax: 81188be8   ebx: ca0dbf00   ecx: ec05ff34   edx: 00000000
esi: ec05ff24   edi: 00000010   ebp: ca0dbea0   esp: ca0dbe94
ds: 007b   es: 007b   ss: 0068
Process rm (pid: 20679, threadinfo=ca0da000 task=ea0a39b0)
Stack: ec05ff24 ca0dbef8 00000010 ca0dbec0 c01500bd ec05ff24 00001120 00000010 
       ca0dbf00 c1188c10 00001120 ca0dbf40 c01504bf ca0dbef8 ec05ff24 00001120 
       00000010 ec05fe88 c0444c20 ec324000 ca0dbf04 ca0dbef8 00000010 00000000 
Call Trace:
 [<c01500bd>] pagevec_lookup+0x1d/0x28
 [<c01504bf>] truncate_inode_pages+0xe7/0x264
 [<c0180909>] generic_delete_inode+0x91/0x1b4
 [<c0180be6>] generic_drop_inode+0x12/0x20
 [<c0180c5c>] iput+0x68/0x70
 [<c01754ed>] sys_unlink+0x109/0x148
 [<c010b52f>] syscall_call+0x7/0xb

Code: f0 ff 40 04 42 39 fa 72 f1 81 79 04 ad 4e ad de 74 08 0f 0b 
 <6>note: rm[20679] exited with preempt_count 1
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c01230db>] __might_sleep+0xa3/0xb0
 [<c0128580>] do_exit+0xf4/0x538
 [<c010c5f7>] die+0x133/0x134
 [<c011dfde>] do_page_fault+0x356/0x4ba
 [<c011dc88>] do_page_fault+0x0/0x4ba
 [<c011e89e>] __change_page_attr+0x22/0x1b4
 [<c011ea9b>] change_page_attr+0x6b/0xd0
 [<c011ec5d>] kernel_map_pages+0x2d/0x5a
 [<c0148366>] free_hot_cold_page+0x26/0xfc
 [<c010bf99>] error_code+0x2d/0x38
 [<c0144a96>] find_get_pages+0x56/0xac
 [<c01500bd>] pagevec_lookup+0x1d/0x28
 [<c01504bf>] truncate_inode_pages+0xe7/0x264
 [<c0180909>] generic_delete_inode+0x91/0x1b4
 [<c0180be6>] generic_drop_inode+0x12/0x20
 [<c0180c5c>] iput+0x68/0x70
 [<c01754ed>] sys_unlink+0x109/0x148
 [<c010b52f>] syscall_call+0x7/0xb

Adding 995988k swap on /dev/hda1.  Priority:-2 extents:1


free:

             total       used       free     shared    buffers     cached
Mem:       1031560    1029464       2096          0      19420     729640
-/+ buffers/cache:     280404     751156
Swap:       995988          0     995988

gcc:

Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)


/proc/cpiunfo:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 732.412
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx
fxsr sse
bogomips	: 1437.69

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 732.412
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx
fxsr sse
bogomips	: 1458.17


lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:0a.0 Ethernet controller: VIA Technologies, Inc. Ethernet Controller (rev 43)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 03)


.config:

# 
# Automatically generated make config: don't edit
# 
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

# 
# Code maturity level options
# 
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y

# 
# General setup
# 
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

# 
# Loadable module support
# 
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

# 
# Processor type and features
# 
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=32
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=m
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y

# 
# Power management options (ACPI, APM)
# 
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_DISK=y
CONFIG_PM_DISK_PARTITION="/dev/hda1"

# 
# ACPI (Advanced Configuration and Power Interface) Support
# 
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_RELAXED_AML is not set

# 
# APM (Advanced Power Management) BIOS Support
# 
# CONFIG_APM is not set

# 
# CPU Frequency scaling
# 
# CONFIG_CPU_FREQ is not set

# 
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
# 
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_USE_VECTOR is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

# 
# PCMCIA/CardBus support
# 
CONFIG_PCMCIA=y
# CONFIG_YENTA is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y

# 
# PCI Hotplug Support
# 
# CONFIG_HOTPLUG_PCI is not set

# 
# Executable file formats
# 
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

# 
# Device Drivers
# 

# 
# Generic Driver Options
# 
# CONFIG_FW_LOADER is not set

# 
# Memory Technology Devices (MTD)
# 
# CONFIG_MTD is not set

# 
# Parallel port support
# 
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
CONFIG_PARPORT_OTHER=y
# CONFIG_PARPORT_1284 is not set

# 
# Plug and Play support
# 
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

# 
# Protocols
# 
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set

# 
# Block devices
# 
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

# 
# ATA/ATAPI/MFM/RLL support
# 
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

# 
# Please see Documentation/ide.txt for help/info on IDE drives
# 
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

# 
# IDE chipset support/bugfixes
# 
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

# 
# SCSI device support
# 
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

# 
# SCSI support type (disk, tape, CD-ROM)
# 
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

# 
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
# 
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_REPORT_LUNS=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

# 
# SCSI low-level drivers
# 
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

# 
# PCMCIA SCSI adapter support
# 
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set

# 
# Old CD-ROM drivers (not SCSI, not IDE)
# 
# CONFIG_CD_NO_IDESCSI is not set

# 
# Multi-device support (RAID and LVM)
# 
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_MD_MULTIPATH=y
# CONFIG_BLK_DEV_DM is not set

# 
# Fusion MPT device support
# 

# 
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
# 
# CONFIG_IEEE1394 is not set

# 
# I2O device support
# 
# CONFIG_I2O is not set

# 
# Networking support
# 
CONFIG_NET=y

# 
# Networking options
# 
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

# 
# IP: Virtual Server Configuration
# 
CONFIG_IP_VS=m
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

# 
# IPVS transport protocol load balancing support
# 
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y

# 
# IPVS scheduler
# 
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

# 
# IPVS application helper
# 
CONFIG_IP_VS_FTP=m
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

# 
# IP: Netfilter Configuration
# 
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
# CONFIG_IP_NF_MATCH_IPRANGE is not set
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_SAME is not set
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
# CONFIG_IP_NF_TARGET_CLASSIFY is not set
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

# 
# SCTP Configuration (EXPERIMENTAL)
# 
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

# 
# QoS and/or fair queueing
# 
# CONFIG_NET_SCHED is not set

# 
# Network testing
# 
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

# 
# ARCnet devices
# 
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

# 
# Ethernet (10 or 100Mbit)
# 
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

# 
# Tulip family network device support
# 
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
CONFIG_VIA_RHINE=m
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_NET_POCKET is not set

# 
# Ethernet (1000 Mbit)
# 
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

# 
# Ethernet (10000 Mbit)
# 
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

# 
# Wireless LAN (non-hamradio)
# 
# CONFIG_NET_RADIO is not set

# 
# Token Ring devices
# 
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

# 
# Wan interfaces
# 
# CONFIG_WAN is not set

# 
# PCMCIA network device support
# 
# CONFIG_NET_PCMCIA is not set

# 
# Amateur Radio support
# 
# CONFIG_HAMRADIO is not set

# 
# IrDA (infrared) support
# 
# CONFIG_IRDA is not set

# 
# Bluetooth support
# 
# CONFIG_BT is not set

# 
# ISDN subsystem
# 
# CONFIG_ISDN_BOOL is not set

# 
# Telephony Support
# 
# CONFIG_PHONE is not set

# 
# Input device support
# 
CONFIG_INPUT=y

# 
# Userland interfaces
# 
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

# 
# Input I/O drivers
# 
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

# 
# Input Device Drivers
# 
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

# 
# Character devices
# 
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

# 
# Serial drivers
# 
# CONFIG_SERIAL_8250 is not set

# 
# Non-8250 serial port support
# 
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

# 
# I2C support
# 
# CONFIG_I2C is not set

# 
# I2C Algorithms
# 

# 
# I2C Hardware Bus support
# 

# 
# I2C Hardware Sensors Chip support
# 
# CONFIG_I2C_SENSOR is not set

# 
# Mice
# 
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

# 
# IPMI
# 
# CONFIG_IPMI_HANDLER is not set

# 
# Watchdog Cards
# 
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

# 
# Ftape, the floppy tape device driver
# 
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=m
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
CONFIG_DRM_MGA=m
# CONFIG_DRM_SIS is not set

# 
# PCMCIA character devices
# 
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

# 
# Multimedia devices
# 
# CONFIG_VIDEO_DEV is not set

# 
# Digital Video Broadcasting Devices
# 
# CONFIG_DVB is not set

# 
# Graphics support
# 
CONFIG_FB=y
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
# CONFIG_FB_MATROX_G450 is not set
CONFIG_FB_MATROX_G100A=y
CONFIG_FB_MATROX_G100=y
# CONFIG_FB_MATROX_MULTIHEAD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

# 
# Console display driver support
# 
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set

# 
# Logo configuration
# 
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

# 
# Sound
# 
# CONFIG_SOUND is not set

# 
# USB support
# 
CONFIG_USB=y
CONFIG_USB_DEBUG=y

# 
# Miscellaneous USB options
# 
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

# 
# USB Host Controller Drivers
# 
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m

# 
# USB Device Class drivers
# 
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

# 
# USB Human Interface Devices (HID)
# 
# CONFIG_USB_HID is not set

# 
# USB HID Boot Protocol drivers
# 
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

# 
# USB Imaging devices
# 
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

# 
# USB Multimedia devices
# 
# CONFIG_USB_DABUSB is not set

# 
# Video4Linux support is needed for USB Multimedia device support
# 

# 
# USB Network adaptors
# 
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

# 
# USB port drivers
# 
# CONFIG_USB_USS720 is not set

# 
# USB Serial Converter support
# 
# CONFIG_USB_SERIAL is not set

# 
# USB Miscellaneous drivers
# 
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

# 
# File systems
# 
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
CONFIG_XFS_RT=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_MINIX_FS=y
CONFIG_ROMFS_FS=y
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

# 
# CD-ROM/DVD Filesystems
# 
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y

# 
# DOS/FAT/NT Filesystems
# 
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

# 
# Pseudo filesystems
# 
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

# 
# Miscellaneous filesystems
# 
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set

# 
# Network File Systems
# 
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
CONFIG_NCP_FS=m
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_CODA_FS=m
# CONFIG_CODA_FS_OLD_API is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_AFS_FS=m
CONFIG_RXRPC=m

# 
# Partition Types
# 
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

# 
# Native Language Support
# 
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-2"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

# 
# Profiling support
# 
# CONFIG_PROFILING is not set

# 
# Kernel hacking
# 
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

# 
# Security options
# 
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=m
# CONFIG_SECURITY_ROOTPLUG is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
# CONFIG_SECURITY_SELINUX_MLS is not set

# 
# Cryptographic options
# 
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_TEST is not set

# 
# Library routines
# 
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y


uname -a :

Linux debora 2.6.1-rc1 #2 SMP Mon Jan 5 17:08:23 CET 2004 i686 unknown


I am not sure if this is an fs issue (segfaulting rm) or a memory issue (no
swap is used, though i reacreated the swappartition as well) but all the RAM is
used up.

