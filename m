Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262776AbUKRQIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbUKRQIQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 11:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbUKRQHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 11:07:34 -0500
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:10477 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S262776AbUKRQCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 11:02:50 -0500
Date: Thu, 18 Nov 2004 19:02:48 +0300
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-rc2 OOPS on boot with 3ware + reiserfs
Message-ID: <20041118160248.GA5922@tentacle.sectorb.msk.ru>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <20041117165851.GA18044@tentacle.sectorb.msk.ru> <Pine.LNX.4.58.0411170935040.2222@ppc970.osdl.org> <20041118103526.GC26240@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20041118103526.GC26240@suse.de>
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.6.9-rc2-mm1
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 11:35:26AM +0100, Jens Axboe wrote:
> On Wed, Nov 17 2004, Linus Torvalds wrote:
> > 
> > Jens, did you see this one?
> 
> Vladimir, is this completely reproducable? Does -rc1 work correctly (or
> which was the last version you tested)? I haven't been able to spot any
> errors in this path so far.

It happens 100% when smartd tries to fetch SMART info from
disks connected to 3ware controller.
Seems like using obsolete 3ware API has something to do with this.
It does happen with -rc1 too.
Here is a complete dmesg output:

=== BEFORE smartd

Linux version 2.6.10-rc2 (vsavkin@behemoth) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #1 SMP Wed Nov 17 17:04:35 MSK 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)
 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fa6f0
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 Acer                                  ) @ 0x000fe030
ACPI: RSDT (v001 Acer   M25C     0x00000002 Acer 0x00000000) @ 0x3fff0000
ACPI: FADT (v001 Acer   M25C     0x00000002 Acer 0x00000000) @ 0x3fff009a
ACPI: MADT (v001 Acer   M25C     0x00000002 Acer 0x00000000) @ 0x3fff002c
ACPI: DSDT (v001   Acer   M25C   0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: ACER     Product ID: M25C         APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
I/O APIC #3 Version 17 at 0xFEC01000.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Processors: 2
Built 1 zonelists
Kernel command line: BOOT_IMAGE=nov ro root=801 init=/bin/sh
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 733.389 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035112k/1048512k available (2190k kernel code, 12752k reserved, 720k data, 444k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1445.88 BogoMIPS (lpj=722944)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps:        0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.61 usecs.
task migration cache decay timeout: 1 msecs.
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay loop... 1462.27 BogoMIPS (lpj=731136)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps:        0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (2908.16 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:
 domain 0: span 3
  groups: 1 2
CPU1:
 domain 0: span 3
  groups: 2 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0220, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered peer bus 01
PCI->APIC IRQ transform: (B0,I11,P0) -> 17
PCI->APIC IRQ transform: (B0,I13,P0) -> 16
PCI->APIC IRQ transform: (B1,I3,P0) -> 19
PCI->APIC IRQ transform: (B1,I3,P1) -> 18
PCI->APIC IRQ transform: (B1,I6,P0) -> 20
PCI->APIC IRQ transform: (B1,I8,P0) -> 22
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 5.5.4-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
e100: eth1: e100_probe: addr 0x43200000, irq 17, MAC addr 00:00:E2:3B:72:D0
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
ide0: Wait for ready failed before probe !
Probing IDE interface ide1...
ide1: Wait for ready failed before probe !
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

elevator: using anticipatory as default io scheduler
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
  Vendor: SEAGATE   Model: ST336607LC        Rev: 0003
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 16
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

3ware Storage Controller device driver for Linux v1.26.02.000.
scsi2 : 3ware Storage Controller
3w-xxxx: scsi2: Found a 3ware Storage Controller at 0x5080, IRQ: 22.
  Vendor: 3ware     Model: Logical Disk 0    Rev: 1.2 
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: 3ware     Model: Logical Disk 11   Rev: 1.2 
  Type:   Direct-Access                      ANSI SCSI revision: 00
libata version 1.10 loaded.
SCSI device sda: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 1465185024 512-byte hdwr sectors (750175 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1
Attached scsi disk sdc at scsi2, channel 0, id 11, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi2, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg2 at scsi2, channel 0, id 11, lun 0,  type 0
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
NET: Registered protocol family 1
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
Starting balanced_irq
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 444k freed
Adding 1959920k swap on /dev/sda2.  Priority:-1 extents:1
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
ReiserFS: sda5: found reiserfs format "3.6" with standard journal
ReiserFS: sda5: using ordered data mode
ReiserFS: sda5: journal params: device sda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda5: checking transaction log (sda5)
ReiserFS: sda5: replayed 1 transactions in 0 seconds
ReiserFS: sda5: Using r5 hash to sort names
ReiserFS: sda6: found reiserfs format "3.6" with standard journal
ReiserFS: sda6: using ordered data mode
ReiserFS: sda6: journal params: device sda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda6: checking transaction log (sda6)
ReiserFS: sda6: replayed 3 transactions in 0 seconds
ReiserFS: sda6: Using r5 hash to sort names
ReiserFS: sda6: Removing [1915 1387 0x0 SD]..done
ReiserFS: sda6: There were 1 uncompleted unlinks/truncates. Completed
ReiserFS: sda7: found reiserfs format "3.6" with standard journal
ReiserFS: sda7: using ordered data mode
ReiserFS: sda7: journal params: device sda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda7: checking transaction log (sda7)
ReiserFS: sda7: replayed 1 transactions in 0 seconds
ReiserFS: sda7: Using r5 hash to sort names
ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
ReiserFS: sdb1: using ordered data mode
ReiserFS: sdb1: journal params: device sdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb1: checking transaction log (sdb1)
ReiserFS: sdb1: replayed 1 transactions in 0 seconds
ReiserFS: sdb1: Using r5 hash to sort names
ReiserFS: sdc1: found reiserfs format "3.6" with standard journal
ReiserFS: sdc1: using ordered data mode
ReiserFS: sdc1: journal params: device sdc1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdc1: checking transaction log (sdc1)
ReiserFS: sdc1: replayed 1 transactions in 0 seconds
ReiserFS: sdc1: Using r5 hash to sort names
ip_tables: (C) 2000-2002 Netfilter core team
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
vlan0173: add 01:00:5e:00:00:01 mcast address to master interface
vlan0169: add 01:00:5e:00:00:01 mcast address to master interface

=== AFTER smartd

program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
scsi: unknown opcode 0x4d
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
scsi: unknown opcode 0x80
3w-xxxx: SCSI_IOCTL_SEND_COMMAND deprecated, please update your 3ware tools.
arq->state 2
Badness in as_requeue_request at drivers/block/as-iosched.c:1478
 [<c01032a7>] dump_stack+0x17/0x20
 [<c02388c6>] as_requeue_request+0x66/0xe0
 [<c022fc66>] elv_requeue_request+0x26/0x50
 [<c027b6d9>] scsi_request_fn+0x269/0x370
 [<c0232685>] blk_insert_request+0x95/0xb0
 [<c027a4e4>] scsi_queue_insert+0x64/0xa0
 [<c027662e>] scsi_dispatch_cmd+0x16e/0x1d0
 [<c027b653>] scsi_request_fn+0x1e3/0x370
 [<c0231d6e>] __generic_unplug_device+0x2e/0x30
 [<c0231d88>] generic_unplug_device+0x18/0x30
 [<c02328a2>] blk_execute_rq+0x82/0xb0
 [<c0236726>] sg_scsi_ioctl+0x1f6/0x2c0
 [<c02368d7>] scsi_cmd_ioctl+0xe7/0x400
 [<c02a6fb4>] sd_ioctl+0xa4/0xd0
 [<c0234a45>] blkdev_ioctl+0x75/0x3cf
 [<c0160fbc>] sys_ioctl+0xbc/0x210
 [<c0102483>] syscall_call+0x7/0xb

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

