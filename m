Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130178AbRB1OGG>; Wed, 28 Feb 2001 09:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130179AbRB1OF4>; Wed, 28 Feb 2001 09:05:56 -0500
Received: from [200.43.18.234] ([200.43.18.234]:19976 "EHLO
	radius.telpin.com.ar") by vger.kernel.org with ESMTP
	id <S130178AbRB1OFq>; Wed, 28 Feb 2001 09:05:46 -0500
To: linux-kernel@vger.kernel.org
Subject: [OOPS 2.4.2] Unable to handle kernel NULL pointer dereference...
Message-ID: <983369119.3a9d059fde2bc@webmail.telpin.com.ar>
Date: Wed, 28 Feb 2001 11:05:19 -0300 (ARST)
From: Alberto Bertogli <albertogli@telpin.com.ar>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ983369119acb55289fd4ae5419bd247a3cf56c9ad"
User-Agent: IMP/PHP IMAP webmail program 2.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ983369119acb55289fd4ae5419bd247a3cf56c9ad
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Yesterday i got this oops with kernel 2.4.2 (SMP, without any additional 
patches).
Even though this is the first oops with 2.4.2, i got 3 oops in 4 days with 
2.4.1.

The machine was almost idle, running only mailsnarf, apache, postgresql and 
vmstat; without any load:
(output from vmstat):

r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
0  0  0   12     7428  24844   3980   0   0     0     0  586   912   0   2  98


Attached are the plain oops, the ksymoops'ed oops, the dmesg and the lsmod 
output (the only one module loaded, megaraid, is loaded at boot time).
If you need any other info, just ask.

Thanks,
        Alberto

---MOQ983369119acb55289fd4ae5419bd247a3cf56c9ad
Content-Type: text/plain; name="oops.plain"; name="oops.plain"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="oops.plain"


Unable to handle kernel NULL pointer dereference at virtual address 00000004
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011e039>]
EFLAGS: 00010082
eax: c3c80e84 ebx: 00000206 ecx: c0359f60 edx: 00000000
esi: 00000000 edi: c0308000 ebp: c0359f80 esp: c0309ef8
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage = c0309000)
Stack: 00000000 000000e0 c0308000 c01c9daa c0359f60 0065092c 00000000 00000000
       c0308000 c01c9cf8 c011e88f 00000000 00000000 00000000 c0308000 c035fec0
       c0302da4 00000001 c0348690 c011b14a c035f340 00000000 00000000 c011b02d
Call trace: [<c01c9daa>] [<c01c9cf8>] [<c011e88f>] [<c011b14a>] [<c011b02d>] [<c011aed6>] [<c010a9b3>]
       [<c01071c0>] [<c01071c0>] [<c01090b8>] [<c01071c0>] [<c01071c0>] [<c0100018>] [<c01071ec>] [<c010724e>]
       [<c0105000>] [<c01001d0>]

Code: 89 4a 04 89 11 89 41 04 89 08 c6 05 d5 2e c0 01 53 9d 89
Kernel panic: Aiee, killing interrupt handler
In interrupt handler - not syncing


---MOQ983369119acb55289fd4ae5419bd247a3cf56c9ad
Content-Type: text/plain; name="oops.parsed"; name="oops.parsed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="oops.parsed"


ksymoops 2.3.7 on i686 2.4.2.  Options used
     -V (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.2/ (specified)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000004
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011e039>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: c3c80e84 ebx: 00000206 ecx: c0359f60 edx: 00000000
esi: 00000000 edi: c0308000 ebp: c0359f80 esp: c0309ef8
ds: 0018 es: 0018 ss: 0018
Stack: 00000000 000000e0 c0308000 c01c9daa c0359f60 0065092c 00000000 00000000
       c0308000 c01c9cf8 c011e88f 00000000 00000000 00000000 c0308000 c035fec0
       c0302da4 00000001 c0348690 c011b14a c035f340 00000000 00000000 c011b02d
Call trace: [<c01c9daa>] [<c01c9cf8>] [<c011e88f>] [<c011b14a>] [<c011b02d>] [<c011aed6>] [<c010a9b3>]
       [<c01071c0>] [<c01071c0>] [<c01090b8>] [<c01071c0>] [<c01071c0>] [<c0100018>] [<c01071ec>] [<c010724e>]
       [<c0105000>] [<c01001d0>]
Code: 89 4a 04 89 11 89 41 04 89 08 c6 05 d5 2e c0 01 53 9d 89

>>EIP; c011e039 <mod_timer+c9/e4>   <=====
Trace; c01c9daa <rs_timer+b2/fc>
Trace; c01c9cf8 <rs_timer+0/fc>
Trace; c011e88f <timer_bh+24f/2a8>
Trace; c011b14a <bh_action+4e/ac>
Trace; c011b02d <tasklet_hi_action+51/7c>
Trace; c011aed6 <do_softirq+56/84>
Trace; c010a9b3 <do_IRQ+db/ec>
Trace; c01071c0 <default_idle+0/34>
Trace; c01071c0 <default_idle+0/34>
Trace; c01090b8 <ret_from_intr+0/20>
Trace; c01071c0 <default_idle+0/34>
Trace; c01071c0 <default_idle+0/34>
Trace; c0100018 <startup_32+18/cb>
Trace; c01071ec <default_idle+2c/34>
Trace; c010724e <cpu_idle+3a/50>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c01001d0 <L6+0/2>
Code;  c011e039 <mod_timer+c9/e4>
00000000 <_EIP>:
Code;  c011e039 <mod_timer+c9/e4>   <=====
   0:   89 4a 04                  movl   %ecx,0x4(%edx)   <=====
Code;  c011e03c <mod_timer+cc/e4>
   3:   89 11                     movl   %edx,(%ecx)
Code;  c011e03e <mod_timer+ce/e4>
   5:   89 41 04                  movl   %eax,0x4(%ecx)
Code;  c011e041 <mod_timer+d1/e4>
   8:   89 08                     movl   %ecx,(%eax)
Code;  c011e043 <mod_timer+d3/e4>
   a:   c6 05 d5 2e c0 01 53      movb   $0x53,0x1c02ed5
Code;  c011e04a <mod_timer+da/e4>
  11:   9d                        popf   
Code;  c011e04b <mod_timer+db/e4>
  12:   89 00                     movl   %eax,(%eax)

Kernel panic: Aiee, killing interrupt handler

---MOQ983369119acb55289fd4ae5419bd247a3cf56c9ad
Content-Type: text/plain; name="dmesg"; name="dmesg"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="dmesg"


Linux version 2.4.2 (root@sol) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 SMP Fri Feb 23 10:56:12 ARST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000007f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000080000 @ 00000000fff80000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000fdba0
hm, page 000fd000 reserved twice.
hm, page 000fe000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: POWEREDGE    APIC at: 0xFEE00000
Processor #3 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    Bootup CPU
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
Bus #0 is PCI   
Bus #1 is PCI   
Bus #2 is EISA  
I/O APIC #1 Version 17 at 0xFEC00000.
Int: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID 1, APIC INT 00
Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 1, APIC INT 01
Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 1, APIC INT 02
Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 1, APIC INT 03
Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 1, APIC INT 04
Int: type 0, pol 0, trig 0, bus 2, IRQ 05, APIC ID 1, APIC INT 05
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 1, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 1, APIC INT 07
Int: type 0, pol 0, trig 0, bus 2, IRQ 08, APIC ID 1, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 09, APIC ID 1, APIC INT 09
Int: type 0, pol 0, trig 0, bus 2, IRQ 0a, APIC ID 1, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 2, IRQ 0b, APIC ID 1, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 1, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 1, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 1, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 1, APIC INT 0f
Lint: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: BOOT_IMAGE=linux ro root=801
Initializing CPU#0
Detected 199.440 MHz processor.
Console: colour VGA+ 132x44
Calibrating delay loop... 397.31 BogoMIPS
Memory: 125884k/131072k available (1513k kernel code, 4800k reserved, 563k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
CPU: After generic, caps: 0000fbff 00000000 00000000 00000000
CPU: Common caps: 0000fbff 00000000 00000000 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
CPU: After generic, caps: 0000fbff 00000000 00000000 00000000
CPU: Common caps: 0000fbff 00000000 00000000 00000000
CPU0: Intel Pentium Pro stepping 07
per-CPU timeslice cutoff: 1460.32 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 3000000
Getting ID: c000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 9
Booting processor 1/0 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
CPU#1 (phys ID: 0) waiting for CALLOUT
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 398.13 BogoMIPS
Stack at about c1229fbc
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
CPU: After generic, caps: 0000fbff 00000000 00000000 00000000
CPU: Common caps: 0000fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium Pro stepping 07
CPU has booted.
Before bogomips.
Total of 2 processors activated (795.44 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 1 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0 not connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
number of MP IRQ sources: 16.
number of IO-APIC #1 registers: 16.
testing the IO APIC.......................

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  1    1    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  1    1    0   0   0    1    1    99
 0f 003 03  1    1    0   0   0    1    1    A1
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ10 -> 10
IRQ11 -> 11
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 199.4287 MHz.
..... host bus clock speed is 66.4761 MHz.
cpu: 0, clocks: 664761, slice: 221587
CPU0<T0:664752,T1:443152,D:13,S:221587,C:664761>
cpu: 1, clocks: 664761, slice: 221587
CPU1<T0:664752,T1:221568,D:10,S:221587,C:664761>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xf814d, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 83530kB/27843kB, 256 slots per queue
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
early initialization of device teql0 is deferred
Coda Kernel/Venus communications, v5.3.9, coda@cs.cmu.edu
NTFS version 000607
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:A0:C9:2D:E5:16, IRQ 14.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 352509-003, Physical connectors present: RJ45
  Primary interface chip DP83840 PHY #1.
  DP83840 specific setup, setting register 23 to 8462.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x49caa8d6).
  Receiver lock-up workaround activated.
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7880 Ultra SCSI host adapter> found at PCI 1/10/0
(scsi0) Wide Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Downloading sequencer code... 422 instructions downloaded
(scsi1) <Adaptec AIC-7860 Ultra SCSI host adapter> found at PCI 1/11/0
(scsi1) Narrow Channel, SCSI ID=7, 3/255 SCBs
(scsi1) Downloading sequencer code... 422 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7880 Ultra SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7860 Ultra SCSI host adapter>
(scsi0:0:0:0) Synchronous at 20.0 Mbyte/sec, offset 8.
  Vendor: QUANTUM   Model: ATLAS IV 18 WLS   Rev: 0909
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi1:0:3:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: NEC       Model: CD-ROM DRIVE:462  Rev: 1.14
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 35885168 512-byte hdwr sectors (18373 MB)
Partition check:
 sda: sda1 sda2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack (1024 buckets, 8192 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 666688k swap-space (priority -1)
megaraid: v107 (December 22, 1999)
megaraid: found 0x101e:0x9010: in 01:0d.0
scsi2 : Found a MegaRAID controller at 0xe090, IRQ: 15
megaraid: Couldn't register I/O range!
megaraid: v107 (December 22, 1999)
megaraid: found 0x101e:0x9010: in 01:0d.0
scsi2 : Found a MegaRAID controller at 0xe090, IRQ: 15
megaraid: [U.75:1.44] detected 1 logical drives
scsi2 : AMI MegaRAID U.75 254 commands 16 targs 2 chans 8 luns
scsi2: scanning channel 1 for devices.
  Vendor: DELL      Model: 6UW BACKPLANE     Rev: 7   
  Type:   Processor                          ANSI SCSI revision: 02
scsi2: scanning channel 2 for devices.
scsi2: scanning virtual channel for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID5  8176R  Rev: U.75
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi2, channel 2, id 0, lun 0
SCSI device sdb: 16744448 512-byte hdwr sectors (8573 MB)
 sdb: sdb1
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
mailsnarf uses obsolete (PF_INET,SOCK_PACKET)
device eth0 entered promiscuous mode

---MOQ983369119acb55289fd4ae5419bd247a3cf56c9ad
Content-Type: text/plain; name="lsmod"; name="lsmod"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="lsmod"


Module                  Size  Used by
megaraid               11776   1 

---MOQ983369119acb55289fd4ae5419bd247a3cf56c9ad--
