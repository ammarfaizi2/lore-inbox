Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265699AbUAPVdc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 16:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUAPVdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 16:33:20 -0500
Received: from estreet.com ([66.17.141.33]:27593 "EHLO estreet.com")
	by vger.kernel.org with ESMTP id S265699AbUAPVcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 16:32:42 -0500
Subject: Oops with ksymoops trace
From: Collin Starkweather <collin.starkweather@collinstarkweather.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-DynRWLJEs4bzk2J7mcra"
Message-Id: <1074288537.9850.561.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 16 Jan 2004 14:28:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DynRWLJEs4bzk2J7mcra
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I'm new to compiling kernels and on a recent compile received an oops. 
Per linux/Documentation/oops-tracing.txt I would like to submit the
issue but don't quite know exactly where it should go.

I am using Gentoo 1.4 with the 2.4.22-gentoo-r5 kernel (the latest and
greatest) from the gentoo-sources ebuild with a single Pentium III
(Coppermine) processor.

(I do have a 2.4.19 kernel that works just fine but I didn't save the
.config so unfortunately I can't refer back to check whether there are
any configuration differences that might account for the oops.)

I attached a set of relevant files:

  oops.txt: The text of the oops message
  ksymoops.txt: The output from ksymoops < oops.txt
  dmesg.txt: The dmesg output
  var-log-kernel.txt: The contents of /var/log/kernel after boot
  proc-cpuinfo.txt: The contents of /proc/cpuinfo
  proc-pci.txt: The contents of /proc/pci
  proc-meminfo.txt: The contents of /proc/meminfo
  gcc.txt: The version of gcc used to compile the kernel
  binutils.txt: The version of binutils used to compile the kernel

I also noticed this link

  http://www.ussg.iu.edu/hypermail/linux/kernel/0106.2/0808.html

which seemed to indicate a similar problem noted with the 2.4.5 kernel,
also with a Pentium III (Coppermine) running against an Adaptec AIC-7XXX
SCSI controller with SMP enabled, though the thread doesn't seem to lead
to a resolution.  It us notable that I have SMP enabled but I am only
running one processor.

Please let me know if there is a more appropriate forum to deliver this
oops trace to.

Thanks!

-Collin

-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Collin Starkweather, Ph.D.  collin.starkweather@collinstarkweather.com
University of Colorado                         Department of Economics
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


--=-DynRWLJEs4bzk2J7mcra
Content-Disposition: attachment; filename=oops.txt
Content-Type: text/plain; name=oops.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Oops: 0000
CPU:    0
EIP:    0010:[<c025317d>]    Not tainted
EFLAGS: 00010206
eax: 0000010c   ebx: 000003e8   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000024   ebp: 000003ff   esp: c18e9f20
ds: 0018   es: 0018   ss: 0018
Process ps (pid: 568, stackpage=c18e9000)
Stack: 000003e8 c025339b 0000010c c01964cc c0232fe0 c1bffa10 00000004 dfd10720 
       00000202 00000158 00008df8 df8dd110 000003ff c1932000 000003ff c02512b0 
       c1932000 c18e9f88 00000000 000003ff c18e9f84 00000000 c18e8000 df8dd110 
Call Trace:    [<c025339b>] [<c0232fe0>] [<c02512b0>] [<c0225fc8>] [<c01eb397>]

Code: 8b 08 89 c8 c1 e8 1f 31 d0 83 e0 01 01 c2 89 d0 31 d2 0f a4 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000010c
 printing eip:
c025317d
*pde = 00000000

--=-DynRWLJEs4bzk2J7mcra
Content-Disposition: attachment; filename=ksymoops.txt
Content-Type: text/plain; name=ksymoops.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

www oops # ksymoops -k /proc/ksyms -l /proc/modules -o /lib/modules/2.4.22-gentoo-r5/ -m /usr/src/linux/System.map < oops.txt 
ksymoops 2.4.9 on i686 2.4.22-gentoo-r5.  Options used
-V (default)
-k /proc/ksyms (specified)
-l /proc/modules (specified)
-o /lib/modules/2.4.22-gentoo-r5/ (specified)
-m /usr/src/linux/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Oops: 0000
CPU:    0
EIP:    0010:[<c025317d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 0000010c   ebx: 000003e8   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000024   ebp: 000003ff   esp: c18e9f20
ds: 0018   es: 0018   ss: 0018
Process ps (pid: 568, stackpage=c18e9000)
Stack: 000003e8 c025339b 0000010c c01964cc c0232fe0 c1bffa10 00000004 dfd10720 
00000202 00000158 00008df8 df8dd110 000003ff c1932000 000003ff c02512b0 
c1932000 c18e9f88 00000000 000003ff c18e9f84 00000000 c18e8000 df8dd110 
Call Trace:    [<c025339b>] [<c0232fe0>] [<c02512b0>] [<c0225fc8>] [<c01eb397>]
Code: 8b 08 89 c8 c1 e8 1f 31 d0 83 e0 01 01 c2 89 d0 31 d2 0f a4 


>>EIP; c025317d <get_64bits+11/34>   <=====

Trace; c025339b <uptime_read_proc+5b/12c>
Trace; c0232fe0 <open_namei+108/85c>
Trace; c02512b0 <proc_file_read+b4/1b8>
Trace; c0225fc8 <sys_read+88/144>
Trace; c01eb397 <ret+0/5>

Code;  c025317d <get_64bits+11/34>
00000000 <_EIP>:
Code;  c025317d <get_64bits+11/34>   <=====
0:   8b 08                     mov    (%eax),%ecx   <=====
Code;  c025317f <get_64bits+13/34>
2:   89 c8                     mov    %ecx,%eax
Code;  c0253181 <get_64bits+15/34>
4:   c1 e8 1f                  shr    $0x1f,%eax
Code;  c0253184 <get_64bits+18/34>
7:   31 d0                     xor    %edx,%eax
Code;  c0253186 <get_64bits+1a/34>
9:   83 e0 01                  and    $0x1,%eax
Code;  c0253189 <get_64bits+1d/34>
c:   01 c2                     add    %eax,%edx
Code;  c025318b <get_64bits+1f/34>
e:   89 d0                     mov    %edx,%eax
Code;  c025318d <get_64bits+21/34>
10:   31 d2                     xor    %edx,%edx
Code;  c025318f <get_64bits+23/34>
12:   0f a4 00 00               shld   $0x0,%eax,(%eax)

<1>Unable to handle kernel NULL pointer dereference at virtual address 0000010c
c025317d
*pde = 00000000

1 warning issued.  Results may not be reliable.
www oops # 
www oops # file /proc/modules 
/proc/modules: empty
www oops #           


--=-DynRWLJEs4bzk2J7mcra
Content-Disposition: attachment; filename=dmesg.txt
Content-Type: text/plain; name=dmesg.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.4.22-gentoo-r5 (root@www) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r3, propolice)) #1 SMP Thu Jan 15 18:27:49 GMT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffd0000 (usable)
 BIOS-e820: 000000001ffd0000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 131024
zone(0): 4096 pages.
zone(1): 126928 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 AMI                                       ) @ 0x000ff980
ACPI: RSDT (v001 RCC    RCCNILE  0x00000001 MSFT 0x01000000) @ 0x1fff0000
ACPI: FADT (v001 RCC    RCCNILE  0x00000001 MSFT 0x01000000) @ 0x1fff0030
ACPI: MADT (v001 RCC    RCCNILE  0x00000001 MSFT 0x01000000) @ 0x1fff00b0
ACPI: DSDT (v001    RCC  CNB30LE 0x00000100 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium(tm) Pro APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x3] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x3] lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: CNB30LE      APIC at: 0xFEE00000
I/O APIC #4 Version 17 at 0xFEC00000.
I/O APIC #5 Version 17 at 0xFEC01000.
Enabling APIC mode: Flat.	Using 2 I/O APICs
Processors: 1
Kernel command line: root=/dev/sda5
Initializing CPU#0
Detected 997.793 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1970.17 BogoMIPS
Memory: 510424k/524096k available (2019k kernel code, 9064k reserved, 435k data, 136k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.70 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-3, 4-5, 4-9, 4-11, 5-2, 5-3, 5-4, 5-5, 5-6, 5-10, 5-11, 5-12, 5-13, 5-14, 5-15 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 17.
number of IO-APIC #4 registers: 16.
number of IO-APIC #5 registers: 16.
testing the IO APIC.......................

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 001 01  0    0    0   0   0    1    1    41
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    49
 07 001 01  0    0    0   0   0    1    1    51
 08 001 01  0    0    0   0   0    1    1    59
 09 000 00  1    0    0   0   0    0    0    00
 0a 001 01  1    1    0   1   0    1    1    61
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    69
 0d 001 01  0    0    0   0   0    1    1    71
 0e 001 01  0    0    0   0   0    1    1    79
 0f 001 01  0    0    0   0   0    1    1    81

IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  1    1    0   1   0    1    1    89
 01 001 01  1    1    0   1   0    1    1    91
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 03F 0F  1    0    0   0   0    0    2    79
 07 001 01  1    1    0   1   0    1    1    99
 08 001 01  1    1    0   1   0    1    1    A1
 09 001 01  1    1    0   1   0    1    1    A9
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ10 -> 0:10
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ23 -> 1:7
IRQ24 -> 1:8
IRQ25 -> 1:9
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 997.0214 MHz.
..... host bus clock speed is 132.0961 MHz.
cpu: 0, clocks: 132961, slice: 66480
CPU0<T0:132960,T1:66480,D:0,S:66480,C:132961>
migration_task 0 on cpu=0
PCI: PCI BIOS revision 2.10 entry at 0xfda65, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered primary peer bus 01 [IRQ]
PCI->APIC IRQ transform: (B0,I4,P0) -> 23
PCI->APIC IRQ transform: (B0,I7,P0) -> 17
PCI->APIC IRQ transform: (B0,I8,P0) -> 16
PCI->APIC IRQ transform: (B0,I15,P0) -> 10
PCI->APIC IRQ transform: (B1,I4,P0) -> 24
PCI->APIC IRQ transform: (B1,I4,P1) -> 25
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:02:B3:87:25:B6, IRQ 17.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eth1: Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2), 00:02:B3:87:25:B7, IRQ 16.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: no supported devices found.
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] Initialized radeon 1.7.0 20020828 on minor 1
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

(scsi1:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
(scsi1:A:1): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: IBM       Model: DDYS-T36950M      Rev: SC4D
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DDYS-T36950M      Rev: SC4D
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: ESG-SHV   Model: SCA HSBP M14      Rev: 0.01
  Type:   Processor                          ANSI SCSI revision: 02
scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
scsi1:A:1:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 1, lun 0
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
Partition check:
 /dev/scsi/host1/bus0/target0/lun0: p1 p4 < p5 p6 p7 p8 p9 >
SCSI device sdb: 71687340 512-byte hdwr sectors (36704 MB)
 /dev/scsi/host1/bus0/target1/lun0: p1 p4 < p5 p6 p7 p8 p9 >
es1371: version v0.32 time 18:30:55 Jan 15 2004
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver hub
host/uhci.c: USB Universal Host Controller Interface driver v1.1
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 136k freed
Adding Swap: 1052216k swap-space (priority -1)
EXT3 FS 2.4-0.9.19+htree+orlov, 19 August 2002 on sd(8,5), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19+htree+orlov, 19 August 2002 on sd(8,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19+htree+orlov, 19 August 2002 on sd(8,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19+htree+orlov, 19 August 2002 on sd(8,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Unable to handle kernel NULL pointer dereference at virtual address 0000010c
 printing eip:
c025317d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c025317d>]    Not tainted
EFLAGS: 00010206
eax: 0000010c   ebx: 000003e8   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000024   ebp: 000003ff   esp: c18e5f20
ds: 0018   es: 0018   ss: 0018
Process ps (pid: 568, stackpage=c18e5000)
Stack: 000003e8 c025339b 0000010c c01964cc c0232fe0 c18cbc10 00000004 dfd0b720 
       00000202 0000015a 00008dfa df8dd110 000003ff c192f000 000003ff c02512b0 
       c192f000 c18e5f88 00000000 000003ff c18e5f84 00000000 c18e4000 df8dd110 
Call Trace:    [<c025339b>] [<c0232fe0>] [<c02512b0>] [<c0225fc8>] [<c01eb397>]

Code: 8b 08 89 c8 c1 e8 1f 31 d0 83 e0 01 01 c2 89 d0 31 d2 0f a4 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000010c
 printing eip:
c025317d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c025317d>]    Not tainted
EFLAGS: 00010206
eax: 0000010c   ebx: 000003e8   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000025   ebp: 000003ff   esp: c19cff20
ds: 0018   es: 0018   ss: 0018
Process ps (pid: 760, stackpage=c19cf000)
Stack: 000003e8 c025339b 0000010c c01964cc c0232fe0 c18cbc10 00000004 dfd0b220 
       00000206 00000170 000091f8 df8dd110 000003ff c18c3000 000003ff c02512b0 
       c18c3000 c19cff88 00000000 000003ff c19cff84 00000000 c19ce000 df8dd110 
Call Trace:    [<c025339b>] [<c0232fe0>] [<c02512b0>] [<c0225fc8>] [<c01eb397>]

Code: 8b 08 89 c8 c1 e8 1f 31 d0 83 e0 01 01 c2 89 d0 31 d2 0f a4 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000010c
 printing eip:
c025317d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c025317d>]    Not tainted
EFLAGS: 00010206
eax: 0000010c   ebx: 000003e8   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 0000002c   ebp: 000003ff   esp: c19d5f20
ds: 0018   es: 0018   ss: 0018
Process ps (pid: 1152, stackpage=c19d5000)
Stack: 000003e8 c025339b 0000010c c01964cc c0232fe0 c18cbc10 00000004 c2e253e0 
       00000202 000003bd 0000af9d df8dd110 000003ff c1665000 000003ff c02512b0 
       c1665000 c19d5f88 00000000 000003ff c19d5f84 00000000 c19d4000 df8dd110 
Call Trace:    [<c025339b>] [<c0232fe0>] [<c02512b0>] [<c0225fc8>] [<c01eb397>]

Code: 8b 08 89 c8 c1 e8 1f 31 d0 83 e0 01 01 c2 89 d0 31 d2 0f a4 
 

--=-DynRWLJEs4bzk2J7mcra
Content-Disposition: attachment; filename=var-log-kernel.txt
Content-Type: text/plain; name=var-log-kernel.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan 14 20:24:39 [kernel] invalidate: busy buffer
Jan 14 20:36:15 [kernel] Linux version 2.4.19-gentoo-r10 (root@insane) (gcc version 3.2.2) #1 Sun Jun 1 18:36:57 MDT 2003
Jan 14 20:46:38 [kernel] end_request: I/O error, dev 02:00 (floppy), sector 0
Jan 14 20:47:37 [kernel] EXT2-fs error (device fd(2,0)): ext2_check_page: bad entry in directory #2: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0, name_len=0
Jan 14 20:48:18 [kernel] EXT2-fs warning: mounting fs with errors, running e2fsck is recommended
Jan 14 20:48:22 [kernel] EXT2-fs error (device fd(2,0)): ext2_check_page: bad entry in directory #2: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0, name_len=0
Jan 14 20:52:02 [kernel] VFS: Can't find ext2 filesystem on dev fd(2,0).
Jan 14 20:52:43 [kernel] invalidate: busy buffer
Jan 14 21:02:07 [kernel] Linux version 2.4.19-gentoo-r10 (root@insane) (gcc version 3.2.2) #1 Sun Jun 1 18:36:57 MDT 2003
Jan 14 21:16:08 [kernel] (scsi1:A:0:0): Locking max tag count at 128
Jan 14 21:50:26 [kernel] Linux version 2.4.19-gentoo-r10 (root@insane) (gcc version 3.2.2) #1 Sun Jun 1 18:36:57 MDT 2003
Jan 14 22:29:49 [kernel] Linux version 2.4.19-gentoo-r10 (root@insane) (gcc version 3.2.2) #1 Sun Jun 1 18:36:57 MDT 2003
Jan 15 13:28:34 [kernel] end_request: I/O error, dev 02:00 (floppy), sector 0
Jan 15 13:55:49 [kernel] Linux version 2.4.19-gentoo-r10 (root@insane) (gcc version 3.2.2) #1 Sun Jun 1 18:36:57 MDT 2003
Jan 15 13:55:49 [kernel]     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Jan 15 13:55:49 [kernel] Floppy drive(s): fd0 is 1.44M
Jan 15 13:55:49 [kernel] FDC 0 is a post-1991 82077
Jan 15 13:55:49 [kernel] loop: loaded (max 8 devices)
Jan 15 13:55:49 [kernel] eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
Jan 15 13:55:49 [kernel] eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Jan 15 13:55:49 [kernel] eth0: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:02:B3:87:25:B6, IRQ 10.
Jan 15 13:55:49 [kernel]   Board assembly 000000-000, Physical connectors present: RJ45
Jan 15 13:55:49 [kernel]   Primary interface chip i82555 PHY #1.
Jan 15 13:55:49 [kernel]   General self-test: passed.
Jan 15 13:55:49 [kernel]   Serial sub-system self-test: passed.
Jan 15 13:55:49 [kernel]   Internal registers self-test: passed.
Jan 15 14:07:22 [kernel] Linux version 2.4.19-gentoo-r10 (root@insane) (gcc version 3.2.2) #1 Sun Jun 1 18:36:57 MDT 2003
Jan 15 14:07:22 [kernel] ..... CPU clock speed is 997.4144 MHz.
Jan 15 14:07:22 [kernel] ..... host bus clock speed is 132.9884 MHz.
Jan 15 14:07:22 [kernel] cpu: 0, clocks: 1329884, slice: 664942
Jan 15 14:07:22 [kernel] CPU0<T0:1329872,T1:664928,D:2,S:664942,C:1329884>
Jan 15 14:07:22 [kernel] mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Jan 15 14:07:22 [kernel] mtrr: detected mtrr type: Intel
Jan 15 14:07:22 [kernel] PCI: PCI BIOS revision 2.10 entry at 0xfda65, last bus=1
Jan 15 14:07:22 [kernel] PCI: Using configuration type 1
Jan 15 14:07:22 [kernel] PCI: Probing PCI hardware
Jan 15 14:07:22 [kernel] PCI: Discovered primary peer bus 01 [IRQ]
Jan 15 14:07:22 [kernel] isapnp: Scanning for PnP cards...
Jan 15 14:07:22 [kernel] isapnp: No Plug & Play device found
Jan 15 14:07:22 [kernel] Linux NET4.0 for Linux 2.4
Jan 15 14:07:22 [kernel] Based upon Swansea University Computer Society NET3.039
Jan 15 14:07:22 [kernel] Initializing RT netlink socket
Jan 15 14:07:22 [kernel] Starting kswapd
Jan 15 14:07:22 [kernel] Journalled Block Device driver loaded
Jan 15 14:07:22 [kernel] Detected PS/2 Mouse Port.
Jan 15 14:07:22 [kernel] pty: 256 Unix98 ptys configured
Jan 15 14:07:22 [kernel] Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Jan 15 14:07:22 [kernel] ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jan 15 14:07:22 [kernel] Uniform Multi-Platform E-IDE driver Revision: 6.31
Jan 15 14:07:22 [kernel] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jan 15 14:07:22 [kernel] ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
Jan 15 14:07:22 [kernel] ServerWorks OSB4: detected chipset, but driver not compiled in!
Jan 15 14:54:42 [kernel] Linux version 2.4.19-gentoo-r10 (root@insane) (gcc version 3.2.2) #1 Sun Jun 1 18:36:57 MDT 2003
Jan 15 14:54:42 [kernel] BIOS-provided physical RAM map:
Jan 15 15:21:48 [kernel] Linux version 2.4.19-gentoo-r10 (root@insane) (gcc version 3.2.2) #1 Sun Jun 1 18:36:57 MDT 2003
Jan 15 15:21:48 [kernel]   Type:   Processor                          ANSI SCSI revision: 02
Jan 15 15:21:48 [kernel] scsi1:A:0:0: Tagged Queuing enabled.  Depth 253
Jan 15 15:21:48 [kernel] scsi1:A:1:0: Tagged Queuing enabled.  Depth 253
Jan 15 15:21:48 [kernel] Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Jan 15 15:25:38 [kernel] (scsi1:A:0:0): Locking max tag count at 128
Jan 15 16:37:35 [kernel] Linux version 2.4.19-gentoo-r10 (root@insane) (gcc version 3.2.2) #1 Sun Jun 1 18:36:57 MDT 2003
Jan 15 16:57:34 [kernel] (scsi1:A:0:0): Locking max tag count at 128
Jan 15 17:45:00 [kernel] Linux version 2.4.19-gentoo-r10 (root@insane) (gcc version 3.2.2) #1 Sun Jun 1 18:36:57 MDT 2003
Jan 15 18:19:54 [kernel] (scsi1:A:0:0): Locking max tag count at 128
Jan 15 18:43:57 [kernel] Linux version 2.4.22-gentoo-r5 (root@www) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r3, propolice)) #1 SMP Thu Jan 15 18:27:49 GMT 2004
Jan 15 18:43:57 [kernel] Enabling APIC mode: Flat._Using 2 I/O APICs
Jan 15 18:44:04 [kernel] Unable to handle kernel NULL pointer dereference at virtual address 0000010c
Jan 15 18:55:13 [kernel] Linux version 2.4.19-gentoo-r10 (root@insane) (gcc version 3.2.2) #1 Sun Jun 1 18:36:57 MDT 2003
Jan 15 19:11:15 [kernel] Linux version 2.4.22-gentoo-r5 (root@www) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r3, propolice)) #1 SMP Thu Jan 15 18:27:49 GMT 2004
Jan 15 19:11:15 [kernel] Enabling APIC mode: Flat._Using 2 I/O APICs
Jan 15 19:11:23 [kernel] Unable to handle kernel NULL pointer dereference at virtual address 0000010c
Jan 15 19:11:23 [kernel]  printing eip:

--=-DynRWLJEs4bzk2J7mcra
Content-Disposition: attachment; filename=proc-cpuinfo.txt
Content-Type: text/plain; name=proc-cpuinfo.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 10
cpu MHz		: 997.944
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1970.17


--=-DynRWLJEs4bzk2J7mcra
Content-Disposition: attachment; filename=proc-pci.txt
Content-Type: text/plain; name=proc-pci.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

PCI devices found:
  Bus  0, device   0, function  1:
    Host bridge: ServerWorks CNB20LE Host Bridge (#2) (rev 6).
      Master Capable.  Latency=16.  
  Bus  0, device   0, function  0:
    Host bridge: ServerWorks CNB20LE Host Bridge (rev 6).
      Master Capable.  Latency=32.  
  Bus  0, device   4, function  0:
    VGA compatible controller: ATI Technologies Inc Rage XL (rev 39).
      IRQ 23.
      Master Capable.  Latency=64.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xfd000000 [0xfdffffff].
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xfeaff000 [0xfeafffff].
  Bus  0, device   7, function  0:
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 8).
      IRQ 17.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xfeafd000 [0xfeafdfff].
      I/O at 0xd400 [0xd43f].
      Non-prefetchable 32 bit memory at 0xfe900000 [0xfe9fffff].
  Bus  0, device   8, function  0:
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2) (rev 8).
      IRQ 16.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xfeafc000 [0xfeafcfff].
      I/O at 0xd000 [0xd03f].
      Non-prefetchable 32 bit memory at 0xfe700000 [0xfe7fffff].
  Bus  0, device  15, function  0:
    ISA bridge: ServerWorks OSB4 South Bridge (rev 81).
  Bus  0, device  15, function  1:
    IDE interface: ServerWorks OSB4 IDE Controller (rev 0).
      Master Capable.  Latency=64.  
      I/O at 0xffa0 [0xffaf].
  Bus  0, device  15, function  2:
    USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 4).
      IRQ 10.
      Master Capable.  Latency=64.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xfeafb000 [0xfeafbfff].
  Bus  1, device   4, function  1:
    SCSI storage controller: Adaptec AIC-7899P U160/m (#2) (rev 1).
      IRQ 25.
      Master Capable.  Latency=64.  Min Gnt=40.Max Lat=25.
      I/O at 0xe800 [0xe8ff].
      Non-prefetchable 64 bit memory at 0xfebfe000 [0xfebfefff].
  Bus  1, device   4, function  0:
    SCSI storage controller: Adaptec AIC-7899P U160/m (rev 1).
      IRQ 24.
      Master Capable.  Latency=64.  Min Gnt=40.Max Lat=25.
      I/O at 0xe400 [0xe4ff].
      Non-prefetchable 64 bit memory at 0xfebfd000 [0xfebfdfff].

--=-DynRWLJEs4bzk2J7mcra
Content-Disposition: attachment; filename=proc-meminfo.txt
Content-Type: text/plain; name=proc-meminfo.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

www root # cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  527507456 54874112 472633344        0  8822784 17379328
Swap: 1077469184        0 1077469184
MemTotal:       515144 kB
MemFree:        461556 kB
MemShared:           0 kB
Buffers:          8616 kB
Cached:          16972 kB
SwapCached:          0 kB
Active:          38552 kB
Inact_dirty:        84 kB
Inact_clean:       256 kB
Inact_target:     7776 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       515144 kB
LowFree:        461556 kB
SwapTotal:     1052216 kB
SwapFree:      1052216 kB
Committed_AS:    90180 kB
www root # 


--=-DynRWLJEs4bzk2J7mcra
Content-Disposition: attachment; filename=gcc.txt
Content-Type: text/plain; name=gcc.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

*  sys-devel/gcc
      Latest version available: 3.2.3-r3
      Latest version installed: 3.2.3-r3
      Size of downloaded files: 20,716 kB
      Homepage:    http://www.gnu.org/software/gcc/gcc.html
      Description: The GNU Compiler Collection. Includes C/C++ and java compilers

--=-DynRWLJEs4bzk2J7mcra
Content-Disposition: attachment; filename=binutilts.txt
Content-Type: text/plain; name=binutilts.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

*  sys-devel/binutils
      Latest version available: 2.14.90.0.6-r6
      Latest version installed: 2.14.90.0.6-r6
      Size of downloaded files: 10,155 kB
      Homepage:    http://sources.redhat.com/binutils/
      Description: Tools necessary to build programs

--=-DynRWLJEs4bzk2J7mcra--

