Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbUDWVpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUDWVpv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 17:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUDWVpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 17:45:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:38879 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261551AbUDWVox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 17:44:53 -0400
X-Authenticated: #555161
Message-ID: <40898ADA.8020708@hasw.net>
Date: Fri, 23 Apr 2004 23:30:02 +0200
From: Sebastian Witt <se.witt@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, andre@linux-ide.org, frankt@promise.com
Subject: PROBLEM: Oops when using both channels of the PDC20262
Content-Type: multipart/mixed;
 boundary="------------090304000106040406080600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090304000106040406080600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm getting some Oopses with kernel 2.6.5 when there is high load on 
both channels of a Promise PDC20262 (Ultra66) card on a SMP machine 
(Tyan S1834, Via Apollo Pro chipset).

There are no problems when I use 2.6.1, but I have this problem
since 2.6.2.
It only occurs when I use the PDC20262, not when using the onboard
IDE-controller.

It is reproduceable after a few seconds when I use 'dd if=/dev/hde 
of=/dev/hdh bs=512'.
Using of=/dev/null also works, but it takes longer.

Mostly it reports smp_apic_timer_interrupt+1c/140, but the last time
I tried it, it also reports <__mask_IO_APIC_irq+40/e0>.

I've attached the logs and the ksymoops trace.

Regards,
Sebastian

--------------090304000106040406080600
Content-Type: text/plain;
 name="log1.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log1.log"

Un<aabbUlnn  ttll  hhttnnddhheennkkeleen kkee  ppaagg  ppggggiieegguueeeettu esstt vviirrt uuta  vvaarrttuueesls   ddddrrffdd00  00

ff dpprr0i

ti nppr eeiippii

gg eeii11::

5cc

11133pp55ec   00ppdd00  ==  000000033p06677   bbpp44ee 799  cc

44b77ooppcc::0002 [#1]
SMP 
CPU:    1
EIP:    0060:[<c0113e5c>]    Not tainted
EFLAGS: 00010006   (2.6.5) 
EIP is at smp_apic_timer_interrupt+0x1c/0x140
eax: 00000020   ebx: eff9e000   ecx: fffd0c2a   edx: eff9e000
esi: eff9e000   edi: c0104e10   ebp: 00000000   esp: eff9ff68
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=eff9e000 task=c17bd150)
Stack: 00000000 eff9e000 eff9e000 c0104e10 00000000 c0107cfe eff9e000 fffd0c2a 
       eff9e000 eff9e000 c0104e10 00000000 00000000 0000007b c17b007b ffffffef 
       c0104e3c 00000060 00000246 c0104ed6 00000002 00000000 00000000 00000b50 
Call Trace:
 [<c0104e10>] default_idle+0x0/0x40
 [<c0107cfe>] apic_timer_interrupt+0x1a/0x20
 [<c0104e10>] default_idle+0x0/0x40
 [<c0104e3c>] default_idle+0x2c/0x40
 [<c0104ed6>] cpu_idle+0x46/0x50
 [<c011d875>] printk+0x175/0x1b0

Code: 89 2d b0 d0 ff ff 8d 6c 24 18 8b 72 10 81 42 14 00 00 01 00 
 <1>Unable to handle kernel paging request at virtual address ffffd300
 printing eip:
c0113710
*pde = 00003067
*pte = b24b792c

--------------090304000106040406080600
Content-Type: text/plain;
 name="log2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log2.log"

Linux version 2.6.5 (hasw@server3) (gcc version 3.2.2) #6 SMP Fri Apr 23 21:35:28 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000030000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 0000000030000000 (usable)
768MB LOWMEM available.
found SMP MP-table at 000f5940
On node 0 totalpages: 196608
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192512 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI disabled because your bios is from 2000 and too old
You can enable it with acpi=force
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 6:8 APIC version 17
Processor #1 6:8 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Built 1 zonelists
Kernel command line: root=/dev/sda1 console=ttyS0,38400n8 console=tty0 mem=786432K
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 701.607 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 774832k/786432k available (1826k kernel code, 10856k reserved, 577k data, 348k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1380.35 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.88 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1400.83 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (2781.18 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 708.0459 MHz.
..... host bus clock speed is 101.0208 MHz.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0596] at 0000:00:07.0
PCI->APIC IRQ transform: (B0,I15,P0) -> 19
PCI->APIC IRQ transform: (B0,I17,P0) -> 17
PCI->APIC IRQ transform: (B0,I18,P0) -> 18
PCI->APIC IRQ transform: (B0,I19,P0) -> 19
PCI->APIC IRQ transform: (B0,I20,P0) -> 16
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
Initializing Cryptographic API
Activating ISA DMA hang workarounds.
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 34098H4, ATA DISK drive
hdb: ST340810A, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IC35L040AVER07-0, ATA DISK drive
hdd: LTN382, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20262: IDE controller at PCI slot 0000:00:11.0
PDC20262: chipset revision 1
PDC20262: 100% native mode on irq 17
PDC20262: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:DMA, hdh:DMA
hde: FUJITSU MPF3102AT, ATA DISK drive
hdf: FUJITSU MPF3102AT, ATA DISK drive
ide2 at 0xcc00-0xcc07,0xd002 on irq 17
hdg: FUJITSU MPF3102AT, ATA DISK drive
hdh: FUJITSU MPF3102AT, ATA DISK drive
ide3 at 0xd400-0xd407,0xd802 on irq 17
hda: max request size: 128KiB
hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
 hda: hda1
hdb: max request size: 128KiB
hdb: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
 hdb: hdb1
hdc: max request size: 128KiB
hdc: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=65535/16/63, UDMA(66)
 hdc: hdc1
hde: max request size: 128KiB
hde: 20015856 sectors (10248 MB) w/512KiB Cache, CHS=19857/16/63, UDMA(66)
 hde: hde1
hdf: max request size: 128KiB
hdf: 20015856 sectors (10248 MB) w/512KiB Cache, CHS=19857/16/63, UDMA(66)
 hdf: unknown partition table
hdg: max request size: 128KiB
hdg: 20015856 sectors (10248 MB) w/512KiB Cache, CHS=19857/16/63, UDMA(66)
 hdg: hdg1
hdh: max request size: 128KiB
hdh: 20015856 sectors (10248 MB) w/512KiB Cache, CHS=19857/16/63, UDMA(66)
 hdh: hdh1
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

(scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:6): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: IBM       Model: DCAS-34330        Rev: S61A
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:6:0: Tagged Queuing enabled.  Depth 253
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
arp_tables: (C) 2002 David S. Miller
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 348k freed
EXT3 FS on sda1, internal journal
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda1) for (hda1)
Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:12.0: 3Com PCI 3c905C Tornado at 0xe000. Vers LK1.1.19
ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
eth1: ns83820.c: 0x22c: 00000000, subsystem: 0000:0000
eth1: ns83820 v0.20: DP83820 v1.2: 00:50:fc:fe:42:d0 io=0xd9021000 irq=19 f=sg
eth1: link now 100 mbps, full duplex and up.
Bridge firewalling registered
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0325180(lo)
IPv6 over IPv4 tunneling driver
eth0: Setting promiscuous mode.
device eth0 entered promiscuous mode
device eth1 entered promiscuous mode
br0: port 2(eth1) entering learning state
br0: port 1(eth0) entering learning state
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (6144 buckets, 49152 max) - 300 bytes per conntrack
br0: topology change detected, propgating
br0: port 2(eth1) entering forwarding state
br0: topology change detected, propgating
br0: port 1(eth0) entering forwarding state
Adding 232932k swap on /dev/sda2.  Priority:-1 extents:1
Unable to handle kernel paging request at virtual address ffffc000
 printing eip:
c0114710
*pde = 00003067
*pte = ac00fe62
Oops: 0002 [#1]
SMP 
CPU:    0
EIP:    0060:[<c0114710>]    Not tainted
EFLAGS: 00010087   (2.6.5) 
EIP is at __mask_IO_APIC_irq+0x40/0xe0
eax: ffffd000   ebx: 00000086   ecx: 00000000   edx: 00003000
esi: 00000012   edi: c03b60cc   ebp: 00000032   esp: eacffc7c
ds: 007b   es: 007b   ss: 0068
Process dd (pid: 307, threadinfo=eacfe000 task=edd4a770)
Stack: 00000086 00000012 c03cb628 efcc29e0 c0114a13 00000011 c0356e20 c010a453 
       00000011 e3825080 c03cb6d4 c0217248 00000011 efcc28e0 efcbdc00 eacffd24 
       efcbdc00 eacffd24 c03c2ca0 000027d1 c021740d efcc29e0 ffffffff c0206169 
Call Trace:
 [<c0114a13>] mask_IO_APIC_irq+0x23/0x40
 [<c010a453>] disable_irq_nosync+0x53/0x55
 [<c0217248>] ide_do_request+0x1c8/0x370
 [<c021740d>] do_ide_request+0x1d/0x30
 [<c0206169>] generic_unplug_device+0x59/0x60
 [<c0206306>] blk_run_queues+0x86/0xa0
 [<c01549f5>] __wait_on_buffer+0xe5/0xf0
 [<c011b090>] autoremove_wake_function+0x0/0x50
 [<c011b090>] autoremove_wake_function+0x0/0x50
 [<c0156ab0>] __block_prepare_write+0x120/0x440
 [<c0157634>] block_prepare_write+0x34/0x50
 [<c015af90>] blkdev_get_block+0x0/0x60
 [<c0138b1b>] generic_file_aio_write_nolock+0x3db/0xad0
 [<c015af90>] blkdev_get_block+0x0/0x60
 [<c0107cfe>] apic_timer_interrupt+0x1a/0x20
 [<c01375b1>] file_read_actor+0xe1/0x100
 [<c01377ce>] __generic_file_aio_read+0x1fe/0x240
 [<c01374d0>] file_read_actor+0x0/0x100
 [<c0107cfe>] apic_timer_interrupt+0x1a/0x20
 [<c0137890>] generic_file_read+0x0/0xb0
 [<c013928e>] generic_file_write_nolock+0x7e/0xa0
 [<c013791e>] generic_file_read+0x8e/0xb0
 [<c0109769>] handle_IRQ_event+0x49/0x80
 [<c0109b08>] do_IRQ+0xb8/0x120
 [<c015c057>] blkdev_file_write+0x37/0x40
 [<c015359e>] vfs_write+0xbe/0x130
 [<c01536c2>] sys_write+0x42/0x70
 [<c010730f>] syscall_call+0x7/0xb

Code: 89 a8 00 f0 ff ff 8b 04 cd 44 5f 3b c0 8b 1f 25 ff 0f 00 00 
 <1>Unable to handle kernel paging request at virtual address ffffd300
 printing eip:
c0113710
*pde = 00003067
*pte = 8b13130a

--------------090304000106040406080600
Content-Type: text/plain;
 name="oops1.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops1.log"

ksymoops 2.4.9 on i686 2.6.1.  Options used
     -v /usr/src/linux-2.6.5/vmlinux (specified)
     -k /proc/kallsyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.5 (specified)
     -m /boot/System.map-2.6.5 (specified)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
11133pp55ec   00ppdd00  ==  000000033p06677   bbpp44ee 799  cc
44b77ooppcc::0002 [#1]
CPU:    1
EIP:    0060:[<c0113e5c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006   (2.6.5) 
eax: 00000020   ebx: eff9e000   ecx: fffd0c2a   edx: eff9e000
esi: eff9e000   edi: c0104e10   ebp: 00000000   esp: eff9ff68
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 eff9e000 eff9e000 c0104e10 00000000 c0107cfe eff9e000 fffd0c2a 
       eff9e000 eff9e000 c0104e10 00000000 00000000 0000007b c17b007b ffffffef 
       c0104e3c 00000060 00000246 c0104ed6 00000002 00000000 00000000 00000b50 
Call Trace:
 [<c0104e10>] default_idle+0x0/0x40
 [<c0107cfe>] apic_timer_interrupt+0x1a/0x20
 [<c0104e10>] default_idle+0x0/0x40
 [<c0104e3c>] default_idle+0x2c/0x40
 [<c0104ed6>] cpu_idle+0x46/0x50
 [<c011d875>] printk+0x175/0x1b0
Code: 89 2d b0 d0 ff ff 8d 6c 24 18 8b 72 10 81 42 14 00 00 01 00 


>>EIP; c0113e5c <smp_apic_timer_interrupt+1c/140>   <=====

>>ebx; eff9e000 <pg0+2fbc7000/3fc27000>
>>ecx; fffd0c2a <pg0+3fbf9c2a/3fc27000>
>>edx; eff9e000 <pg0+2fbc7000/3fc27000>
>>esi; eff9e000 <pg0+2fbc7000/3fc27000>
>>edi; c0104e10 <default_idle+0/40>
>>esp; eff9ff68 <pg0+2fbc8f68/3fc27000>

Trace; c0104e10 <default_idle+0/40>
Trace; c0107cfe <apic_timer_interrupt+1a/20>
Trace; c0104e10 <default_idle+0/40>
Trace; c0104e3c <default_idle+2c/40>
Trace; c0104ed6 <cpu_idle+46/50>
Trace; c011d875 <printk+175/1b0>

Code;  c0113e5c <smp_apic_timer_interrupt+1c/140>
00000000 <_EIP>:
Code;  c0113e5c <smp_apic_timer_interrupt+1c/140>   <=====
   0:   89 2d b0 d0 ff ff         mov    %ebp,0xffffd0b0   <=====
Code;  c0113e62 <smp_apic_timer_interrupt+22/140>
   6:   8d 6c 24 18               lea    0x18(%esp,1),%ebp
Code;  c0113e66 <smp_apic_timer_interrupt+26/140>
   a:   8b 72 10                  mov    0x10(%edx),%esi
Code;  c0113e69 <smp_apic_timer_interrupt+29/140>
   d:   81 42 14 00 00 01 00      addl   $0x10000,0x14(%edx)

 <1>Unable to handle kernel paging request at virtual address ffffd300
c0113710
*pde = 00003067

1 warning issued.  Results may not be reliable.

--------------090304000106040406080600
Content-Type: text/plain;
 name="oops2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops2.log"

ksymoops 2.4.9 on i686 2.6.1.  Options used
     -v /usr/src/linux-2.6.5/vmlinux (specified)
     -k /proc/kallsyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.5 (specified)
     -m /boot/System.map-2.6.5 (specified)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Machine check exception polling timer started.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:12.0: 3Com PCI 3c905C Tornado at 0xe000. Vers LK1.1.19
Unable to handle kernel paging request at virtual address ffffc000
c0114710
*pde = 00003067
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0114710>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010087   (2.6.5) 
eax: ffffd000   ebx: 00000086   ecx: 00000000   edx: 00003000
esi: 00000012   edi: c03b60cc   ebp: 00000032   esp: eacffc7c
ds: 007b   es: 007b   ss: 0068
Stack: 00000086 00000012 c03cb628 efcc29e0 c0114a13 00000011 c0356e20 c010a453 
       00000011 e3825080 c03cb6d4 c0217248 00000011 efcc28e0 efcbdc00 eacffd24 
       efcbdc00 eacffd24 c03c2ca0 000027d1 c021740d efcc29e0 ffffffff c0206169 
Call Trace:
 [<c0114a13>] mask_IO_APIC_irq+0x23/0x40
 [<c010a453>] disable_irq_nosync+0x53/0x55
 [<c0217248>] ide_do_request+0x1c8/0x370
 [<c021740d>] do_ide_request+0x1d/0x30
 [<c0206169>] generic_unplug_device+0x59/0x60
 [<c0206306>] blk_run_queues+0x86/0xa0
 [<c01549f5>] __wait_on_buffer+0xe5/0xf0
 [<c011b090>] autoremove_wake_function+0x0/0x50
 [<c011b090>] autoremove_wake_function+0x0/0x50
 [<c0156ab0>] __block_prepare_write+0x120/0x440
 [<c0157634>] block_prepare_write+0x34/0x50
 [<c015af90>] blkdev_get_block+0x0/0x60
 [<c0138b1b>] generic_file_aio_write_nolock+0x3db/0xad0
 [<c015af90>] blkdev_get_block+0x0/0x60
 [<c0107cfe>] apic_timer_interrupt+0x1a/0x20
 [<c01375b1>] file_read_actor+0xe1/0x100
 [<c01377ce>] __generic_file_aio_read+0x1fe/0x240
 [<c01374d0>] file_read_actor+0x0/0x100
 [<c0107cfe>] apic_timer_interrupt+0x1a/0x20
 [<c0137890>] generic_file_read+0x0/0xb0
 [<c013928e>] generic_file_write_nolock+0x7e/0xa0
 [<c013791e>] generic_file_read+0x8e/0xb0
 [<c0109769>] handle_IRQ_event+0x49/0x80
 [<c0109b08>] do_IRQ+0xb8/0x120
 [<c015c057>] blkdev_file_write+0x37/0x40
 [<c015359e>] vfs_write+0xbe/0x130
 [<c01536c2>] sys_write+0x42/0x70
 [<c010730f>] syscall_call+0x7/0xb
Code: 89 a8 00 f0 ff ff 8b 04 cd 44 5f 3b c0 8b 1f 25 ff 0f 00 00 


>>EIP; c0114710 <__mask_IO_APIC_irq+40/e0>   <=====

>>eax; ffffd000 <pg0+3fc26000/3fc27000>
>>edi; c03b60cc <irq_2_pin+cc/1500>
>>esp; eacffc7c <pg0+2a928c7c/3fc27000>

Trace; c0114a13 <mask_IO_APIC_irq+23/40>
Trace; c010a453 <disable_irq_nosync+53/55>
Trace; c0217248 <ide_do_request+1c8/370>
Trace; c021740d <do_ide_request+1d/30>
Trace; c0206169 <generic_unplug_device+59/60>
Trace; c0206306 <blk_run_queues+86/a0>
Trace; c01549f5 <__wait_on_buffer+e5/f0>
Trace; c011b090 <autoremove_wake_function+0/50>
Trace; c011b090 <autoremove_wake_function+0/50>
Trace; c0156ab0 <__block_prepare_write+120/440>
Trace; c0157634 <block_prepare_write+34/50>
Trace; c015af90 <blkdev_get_block+0/60>
Trace; c0138b1b <generic_file_aio_write_nolock+3db/ad0>
Trace; c015af90 <blkdev_get_block+0/60>
Trace; c0107cfe <apic_timer_interrupt+1a/20>
Trace; c01375b1 <file_read_actor+e1/100>
Trace; c01377ce <__generic_file_aio_read+1fe/240>
Trace; c01374d0 <file_read_actor+0/100>
Trace; c0107cfe <apic_timer_interrupt+1a/20>
Trace; c0137890 <generic_file_read+0/b0>
Trace; c013928e <generic_file_write_nolock+7e/a0>
Trace; c013791e <generic_file_read+8e/b0>
Trace; c0109769 <handle_IRQ_event+49/80>
Trace; c0109b08 <do_IRQ+b8/120>
Trace; c015c057 <blkdev_file_write+37/40>
Trace; c015359e <vfs_write+be/130>
Trace; c01536c2 <sys_write+42/70>
Trace; c010730f <syscall_call+7/b>

Code;  c0114710 <__mask_IO_APIC_irq+40/e0>
00000000 <_EIP>:
Code;  c0114710 <__mask_IO_APIC_irq+40/e0>   <=====
   0:   89 a8 00 f0 ff ff         mov    %ebp,0xfffff000(%eax)   <=====
Code;  c0114716 <__mask_IO_APIC_irq+46/e0>
   6:   8b 04 cd 44 5f 3b c0      mov    0xc03b5f44(,%ecx,8),%eax
Code;  c011471d <__mask_IO_APIC_irq+4d/e0>
   d:   8b 1f                     mov    (%edi),%ebx
Code;  c011471f <__mask_IO_APIC_irq+4f/e0>
   f:   25 ff 0f 00 00            and    $0xfff,%eax

 <1>Unable to handle kernel paging request at virtual address ffffd300
c0113710
*pde = 00003067

1 warning issued.  Results may not be reliable.

--------------090304000106040406080600
Content-Type: text/plain;
 name="ver"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ver"

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux server3 2.6.5 #2 SMP Sat Feb 14 01:52:40 CET 2004 i686 unknown unknown GNU/Linux
 
Gnu C                  3.2.2
Gnu make               3.80
binutils               2.13.2
util-linux             2.12
mount                  2.12
module-init-tools      0.9.10
e2fsprogs              1.32
xfsprogs               2.6.0
quota-tools            3.10.
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.2
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         raid5 xor md ipt_LOG ipt_limit ipt_state ip_conntrack iptable_filter ip_tables md5 ipv6 bridge ns83820 3c59x

--------------090304000106040406080600--

