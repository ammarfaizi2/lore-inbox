Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWAQVeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWAQVeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 16:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWAQVeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 16:34:16 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:43992 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932440AbWAQVeP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 16:34:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b616eB48nLDQjfHNYe7PoR37Bowu6iYCd7AI6W+G4TR7BjQ1PkZZQdii8r5wBv/PIwaG1A6hDZvn+QaCJzcw2VTWVa2WAbiPrvAerjJb13j0iq0l18MBRbzsFvhsqOEWkBg42TFe2E6sRGkRhn1gcUBO/hQrstqhMhE76PinumM=
Message-ID: <3282373b0601171334m7a568a5fma5bf2f2a1954a320@mail.gmail.com>
Date: Tue, 17 Jan 2006 13:34:14 -0800
From: Tim Chen <tim.c.chen@intel.com>
To: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Fwd: Boot problem with [PATCH] x86_64: Allow kernel page tables upto the end of memory
In-Reply-To: <3282373b0601171332k1c26f390xa6f53a2198c7b674@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3282373b0601171309g466a288rfbe8f705f20dd98a@mail.gmail.com>
	 <3282373b0601171332k1c26f390xa6f53a2198c7b674@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

With this patch in 2.6.15-git12,
(http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6c5acd160a10c76e8debf4f8fa8256d7c914f290),
I found that kernel could no longer boot when I include "mem=1G" boot
option on a dual Xeon machine that has more than 4G of memory.  The
machine boots normally without "mem=1G" specified or when the patch is
backed out.
I have included the boot log of the failed boot and the normal boot for your
reference.  The table_start was relocated from 0x8000 to 0x100000000
with the patch applied.

Regards,
Tim Chen

----Failed Boot with mem=1G option------------------
root (hd0,0)
  Filesystem type is ext2fs, partition type 0x83
kernel /boot/vmlinuz-2.6.15-git12 ro root=LABEL=/ mem=1G profile=2 console=ttyS
0,38400
   [Linux-bzImage, setup=0x1c00, size=0x194b02]
initrd /boot/initrd-2.6.15-git12.img
   [Linux-initrd @ 0x37f39000, 0xb6728 bytes]

----Normal Boot without mem=1G option----------------
root (hd0,0)
  Filesystem type is ext2fs, partition type 0x83
kernel /boot/vmlinuz-2.6.15-git12 ro root=LABEL=/ profile=2 console=ttyS0,38400

   [Linux-bzImage, setup=0x1c00, size=0x198a5c]
initrd /boot/initrd-2.6.15-git12.img
   [Linux-initrd @ 0x37f39000, 0xb6727 bytes]

Bootdata ok (command line is ro root=LABEL=/ profile=2 console=ttyS0,38400 )
Linux version 2.6.15-git12 (tim@linux-c01) (gcc version 3.4.3 20050227
(Red Hat 3.4.3-22)) #3 6BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ebaf0 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dffd0000 (usable)
  BIOS-e820: 00000000dffd0000 - 00000000dffdf000 (ACPI data)
  BIOS-e820: 00000000dffdf000 - 00000000e0000000 (ACPI NVS)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
ACPI: PM-Timer IO Port: 0x408
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:4 APIC version 20
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec80400] gsi_base[48])
IOAPIC[2]: apic_id 10, version 32, address 0xfec80400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat
ACPI: HPET id: 0x8086a202 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at f1000000 (gap: f0000000:fc00000)
Checking aperture...
Built 1 zonelists
Kernel command line: ro root=LABEL=/ profile=2 console=ttyS0,38400
kernel profiling enabled (shift: 2)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 3400.165 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Placing software IO TLB between 0x57a8000 - 0x97a8000
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Memory: 4049008k/4718592k available (2340k kernel code, 143904k
reserved, 929k data, 204k init)Calibrating delay using timer specific
routine.. 6806.26 BogoMIPS (lpj=13612521)
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
Booting processor 1/4 APIC 0x6
Initializing CPU#1
Calibrating delay using timer specific routine.. 6800.42 BogoMIPS (lpj=13600853)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
CPU1: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 03
Booting processor 2/4 APIC 0x1
Initializing CPU#2
Calibrating delay using timer specific routine.. 6800.53 BogoMIPS (lpj=13601062)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU2: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 03
Booting processor 3/4 APIC 0x7
Initializing CPU#3
Calibrating delay using timer specific routine.. 6800.49 BogoMIPS (lpj=13600991)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
CPU3: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 03
Brought up 4 CPUs
time.c: Using HPET/TSC based timekeeping.
testing NMI watchdog ... OK.
migration_cost=4,1601
checking if image is initramfs... it is
DMI not present or invalid.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0500-053f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs *7)
ACPI: PCI Interrupt Link [LNKB] (IRQs *7)
ACPI: PCI Interrupt Link [LNKC] (IRQs *7)
ACPI: PCI Interrupt Link [LNKD] (IRQs *7)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
hpet0: at MMIO 0xfed00000 (virtual 0xffffffffff5fe000), IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
PCI: Bridge: 0000:02:00.0
  IO window: c000-dfff
  MEM window: fe300000-fe6fffff
  PREFETCH window: ff900000-ff9fffff
PCI: Bridge: 0000:02:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: c000-dfff
  MEM window: fe300000-fe8fffff
  PREFETCH window: ff900000-ffafffff
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: fe900000-fe9fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: fea00000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: b000-bfff
  MEM window: fc200000-fe2fffff
  PREFETCH window: f1000000-f10fffff
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 47 (level, low) -> IRQ 177
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:02:00.2[B] -> GSI 71 (level, low) -> IRQ 185
ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 169
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Intel E7520/7320/7525 detected.<6>Disabling irq balancing and affinity
IRQ lockup detection disabled
Real Time Clock Driver v1.12ac
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.101 (c) Dave Jones
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin
is 60 seconds).
Hangcheck: Using monotonic_clock().
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:04:01.0[A] -> GSI 24 (level, low) -> IRQ 193
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: TEAC DW-552G, ATAPI CD/DVD-ROM drive
ide1: I/O resource 0x170-0x177 not free.
ide1: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 52X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:04:03.0[A] -> GSI 30 (level, low) -> IRQ 201
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

  Vendor: MAXTOR    Model: ATLAS10K4_73WLS   Rev: DFV0
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:5: asynchronous
scsi0:A:5:0: Tagged Queuing enabled.  Depth 32
 target0:0:5: Beginning Domain Validation
 target0:0:5: wide asynchronous
  target0:0:5: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS (6.25 ns, offset 127)
 target0:0:5: Ending Domain Validation
  Vendor: MAXTOR    Model: ATLAS10K4_73WLS   Rev: DFV0
  Type:   Direct-Access                      ANSI SCSI revision: 03
 target0:0:6: asynchronous
scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
 target0:0:6: Beginning Domain Validation
 target0:0:6: wide asynchronous
  target0:0:6: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS (6.25 ns, offset 127)
 target0:0:6: Ending Domain Validation
GSI 21 sharing vector 0xD1 and IRQ 21
ACPI: PCI Interrupt 0000:04:03.1[B] -> GSI 31 (level, low) -> IRQ 209
scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

ata_piix 0000:00:1f.2: combined mode detected (p=0, s=1)
GSI 22 sharing vector 0xD9 and IRQ 22
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 217
ata: 0x1f0 IDE port busy
ata1: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFC08 irq 15
ATA: abnormal status 0x7F on port 0x177
ata1: disabling port
scsi2 : ata_piix
SCSI device sda: 143666192 512-byte hdwr sectors (73557 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back w/ FUA
SCSI device sda: 143666192 512-byte hdwr sectors (73557 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back w/ FUA
  sda: sda1 sda2
sd 0:0:5:0: Attached scsi disk sda
SCSI device sdb: 143666192 512-byte hdwr sectors (73557 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back w/ FUA
SCSI device sdb: 143666192 512-byte hdwr sectors (73557 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back w/ FUA
  sdb: sdb1 sdb2
sd 0:0:6:0: Attached scsi disk sdb
mice: PS/2 mouse device common for all mice
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Freeing unused kernel memory: 204k freed
input: AT Translated Set 2 keyboard as /class/input/input0
Red Hat nash version 4.2.1.3 starting
Mounted /proc filesystem
Mounting sysfs
Creating /dev
Starting udev
Creating root device
Mounting root fikjournald starting.  Commit interval 5 seconds
lesystem
SwitchEXT3-fs: mounted filesystem with ordered data mode.
ing to new root
INIT: version 2.85 booting
                Welcome to Red Hat Enterprise Linux AS
                Press 'I' to enter interactive startup.
Starting udev:  [  OK  ]
Initializing hardware...  storage network audio done[  OK  ]
raidautorun: failed to open /dev/md0: 6
Configuring kernel parameters:  [  OK  ]
Setting clock  (localtime): Tue Jan 17 10:57:42 PST 2006 [  OK  ]
Setting hostname linux-c01:  [  OK  ]
Checking root filesystem
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/sda1
/: clean, 973853/8470656 files, 5976529/16908288 blocks
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Checking filesystems
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /mnt/stp] fsck.ext3 -a /dev/sdb1
/dev/sdb1: clean, 140/5029888 files, 562819/10040617 blocks
[  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling local filesystem quotas:  [  OK  ]
Enabling swap space:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
/etc/rc3.d/S00microcode_ctl: microcode device /dev/cpu/microcode doesn't exist?
Checking for new hardware [  OK  ]
FATAL: Module acpi not found.
Starting pcmcia:  [  OK  ]
Setting network parameters:  [  OK  ]
Bringing up loopback interface:  [  OK  ]
Bringing up interface eth0:  [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting irqbalance: [  OK  ]
Starting portmap: [  OK  ]
Starting NFS statd: [  OK  ]
Starting NFS4 idmapd: FATAL: Module sunrpc not found.
FATAL: Error running install command for sunrpc
Mounting other filesystems:  [  OK  ]
Starting automount: No Mountpoints Defined[  OK  ]
Starting smartd: [  OK  ]
Starting acpi daemon: [  OK  ]
Starting sshd:[  OK  ]
Starting xinetd: [  OK  ]
Starting console mouse services: [  OK  ]
Starting crond: [  OK  ]
Starting xfs: [  OK  ]
Starting anacron: [  OK  ]
Starting atd: [  OK  ]
Starting system message bus: [  OK  ]
Starting HAL daemon: [  OK  ]
