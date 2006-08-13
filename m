Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWHMRgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWHMRgz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 13:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWHMRgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 13:36:55 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:18919 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751350AbWHMRgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 13:36:54 -0400
Message-ID: <44DF6395.8030307@free.fr>
Date: Sun, 13 Aug 2006 19:38:29 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.4) Gecko/20060405 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc4-mm1
References: <20060813012454.f1d52189.akpm@osdl.org>
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------040105050702050201090907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040105050702050201090907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Le 13.08.2006 10:24, Andrew Morton a écrit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> 
> - Warning: all the Serial ATA Kconfig options have been renamed.  If you
>   blindly run `make oldconfig' you won't have any disks.
> 

Tried pata_via : it could not identify my DVD drive (LG HL-DT-ST DVDRAM GSA-4165B):

Here is an excerpt from dmesg:

  libata version 2.00 loaded.
  pata_via 0000:00:04.1: version 0.1.13
  ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xD800 irq 14
  ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xD808 irq 15
  scsi0 : pata_via
  input: AT Translated Set 2 keyboard as /class/input/input0
  ata1.00: ATA-5, max UDMA/100, 78165360 sectors: LBA
  ata1.00: ata1: dev 0 multi count 16
  ata1.01: ATA-7, max UDMA/133, 160086528 sectors: LBA
  ata1.01: ata1: dev 1 multi count 16
  ata1.00: configured for UDMA/100
  ata1.01: configured for UDMA/100
  scsi1 : pata_via
  input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
  ata2.00: failed to IDENTIFY (device reports illegal type, err_mask=0x0)  <=======  here
  ata2.01: ATAPI, max MWDMA2, CDB intr
  ata2.01: configured for MWDMA2
  scsi 0:0:0:0: Direct access     ATA      ST340016A        3.75 PQ: 0 ANSI: 5
  scsi 0:0:1:0: Direct access     ATA      Maxtor 6Y080L0   YAR4 PQ: 0 ANSI: 5
  scsi 1:0:1:0: CD/DVD            E-IDE    CD-950E/AKU      A4Q  PQ: 0 ANSI: 5

And here is an except from dmesg-2.6.18-rc3-mm2 with via via82cxxx driver:

  VP_IDE: chipset revision 6
  VP_IDE: not 100% native mode: will probe irqs later
  VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:04.1
      ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
      ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
  Probing IDE interface ide0...
  input: AT Translated Set 2 keyboard as /class/input/input0
  input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
  hda: ST340016A, ATA DISK drive
  hdb: Maxtor 6Y080L0, ATA DISK drive
  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
  hda: max request size: 128KiB
  hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
  hda: cache flushes not supported
   hda: hda1 hda2 hda3 < hda5 hda6 hda7 > hda4
  hdb: max request size: 128KiB
  hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
  hdb: cache flushes supported
   hdb: hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 hdb9 >
  Probing IDE interface ide1...
  hdc: HL-DT-ST DVDRAM GSA-4165B, ATAPI CD/DVD-ROM drive
  hdd: CD-950E/AKU, ATAPI CD/DVD-ROM drive
  ide1 at 0x170-0x177,0x376 on irq 15

Full dmesg attached.
~~
laurent

--------------040105050702050201090907
Content-Type: text/plain;
 name="dmesg-2.6.18-rc4-mm1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.18-rc4-mm1"

Linux version 2.6.18-rc4-mm1 (laurent@antares.localdomain) (gcc version 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #91 Sun Aug 13 12:14:47 CEST 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000001feec000 end: 000000001ffec000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000001ffec000 size: 0000000000003000 end: 000000001ffef000 type: 3
copy_e820_map() start: 000000001ffef000 size: 0000000000010000 end: 000000001ffff000 type: 2
copy_e820_map() start: 000000001ffff000 size: 0000000000001000 end: 0000000020000000 type: 4
copy_e820_map() start: 00000000ffff0000 size: 0000000000010000 end: 0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131052
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 126956 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6a80
ACPI: RSDT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x1ffec000
ACPI: FADT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x1ffec080
ACPI: BOOT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x1ffec040
ACPI: DSDT (v001   ASUS A7V133-C 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
Detected 1410.372 MHz processor.
Built 1 zonelists.  Total pages: 131052
Kernel command line: root=/dev/vglinux1/lvroot video=vesafb:ywrap,mtrr splash=silent resume=/dev/hdb6 netconsole=@192.163.0.3/,@192.168.0.1/00:0E:9B:91:ED:72
netconsole: local port 6665
netconsole: local IP 192.163.0.3
netconsole: interface eth0
netconsole: remote port 6666
netconsole: remote IP 192.168.0.1
netconsole: remote ethernet address 00:0e:9b:91:ed:72
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01407000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 904 kB
 per task-struct memory footprint: 1200 bytes
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                    double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                  initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |  ok  |
           recursive read-lock #2:             |  ok  |             |  ok  |
            mixed read-write-lock:             |  ok  |             |  ok  |
            mixed write-read-lock:             |  ok  |             |  ok  |
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
      hard-irq read-recursion/123:  ok  |
      soft-irq read-recursion/123:  ok  |
      hard-irq read-recursion/132:  ok  |
      soft-irq read-recursion/132:  ok  |
      hard-irq read-recursion/213:  ok  |
      soft-irq read-recursion/213:  ok  |
      hard-irq read-recursion/231:  ok  |
      soft-irq read-recursion/231:  ok  |
      hard-irq read-recursion/312:  ok  |
      soft-irq read-recursion/312:  ok  |
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
-------------------------------------------------------
Good, all 218 testcases passed! |
---------------------------------
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 514020k/524208k available (1613k kernel code, 9564k reserved, 1194k data, 160k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
    vmalloc : 0xe0800000 - 0xfffb5000   ( 503 MB)
    lowmem  : 0xc0000000 - 0xdffec000   ( 511 MB)
      .init : 0xc03c2000 - 0xc03ea000   ( 160 kB)
      .data : 0xc029374e - 0xc03be1f8   (1194 kB)
      .text : 0xc0100000 - 0xc029374e   (1613 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2824.46 BogoMIPS (lpj=5648933)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000420 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP 1600+ stepping 02
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
 tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:
Table [DSDT](id 0005) - 356 Objects with 38 Devices 115 Methods 24 Regions
ACPI Namespace successfully loaded at root c0572630
ACPI: setting ELCR to 0200 (from 0c20)
evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
checking if image is initramfs... it is
Freeing initrd memory: 398k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
Setting up standard PCI resources
evgpeblk-0951 [04] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 4 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:.......................................................
Initialized 23/24 Regions 2/2 Fields 19/19 Buffers 11/14 Packages (365 nodes)
Initializing Device/Processor/Thermal objects by executing _INI methods:
Executed 0 _INI methods requiring 0 _STA executions (examined 41 objects)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region e200-e27f claimed by vt82c686 HW-mon
PCI quirk: region e800-e80f claimed by vt82c686 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [20060707]
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: c6000000-c7efffff
  PREFETCH window: c7f00000-cfffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 7, 655360 bytes)
TCP bind hash table entries: 8192 (order: 6, 360448 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Simple Boot Flag at 0x3a set to 0x1
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 16 throttling states)
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
eth0: RealTek RTL-8029 found at 0xa400, IRQ 10, 00:40:95:46:6E:2D.
netconsole: device eth0 not up yet, forcing it
netconsole: carrier detect appears untrustworthy, waiting 4 seconds

=================================
[ INFO: inconsistent lock state ]
2.6.18-rc4-mm1 #91
---------------------------------
inconsistent {in-softirq-W} -> {softirq-on-W} usage.
swapper/1 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&dev->_xmit_lock){-+..}, at: [<c025353f>] netpoll_send_skb+0x6b/0xdb
{in-softirq-W} state was registered at:
  [<c012c793>] __lock_acquire+0x3e1/0x9aa
  [<c012d021>] lock_acquire+0x60/0x80
  [<c0292638>] _spin_lock+0x19/0x28
  [<c02550f6>] dev_watchdog+0x11/0xaf
  [<c011da6d>] run_timer_softirq+0xed/0x145
  [<c011a8e4>] __do_softirq+0x46/0x9c
  [<c011a964>] do_softirq+0x2a/0x42
  [<c011acda>] irq_exit+0x31/0x33
  [<c0104f39>] do_IRQ+0x97/0xa6
  [<c0103699>] common_interrupt+0x25/0x2c
  [<c0101aa5>] cpu_idle+0x3c/0x51
  [<c0100553>] rest_init+0x1e/0x23
  [<c03c26cd>] start_kernel+0x2e2/0x2e4
  [<c0100199>] 0xc0100199
  [<ffffffff>] 0xffffffff
irq event stamp: 623920
hardirqs last  enabled at (623919): [<c0292900>] _spin_unlock_irqrestore+0x36/0x3c
hardirqs last disabled at (623920): [<c0292951>] _spin_lock_irqsave+0xf/0x32
softirqs last  enabled at (623880): [<c024bb29>] dev_mc_upload+0x36/0x3a
softirqs last disabled at (623876): [<c0292652>] _spin_lock_bh+0xb/0x2d

other info that might help us debug this:
1 lock held by swapper/1:
 #0:  (&dev->_xmit_lock){-+..}, at: [<c025353f>] netpoll_send_skb+0x6b/0xdb

stack backtrace:
 [<c0103894>] show_trace_log_lvl+0x12/0x25
 [<c0103975>] show_trace+0xd/0x10
 [<c01040aa>] dump_stack+0x19/0x1b
 [<c012b6b9>] print_usage_bug+0x1d1/0x1de
 [<c012bbc9>] mark_lock+0x22d/0x349
 [<c012bd2c>] mark_held_locks+0x47/0x65
 [<c012be39>] trace_hardirqs_on+0xef/0x119
 [<c0223eaa>] ei_start_xmit+0x258/0x27e
 [<c025355d>] netpoll_send_skb+0x89/0xdb
 [<c0254201>] netpoll_send_udp+0x1fd/0x208
 [<c0224070>] write_msg+0x42/0x6a
 [<c0116823>] __call_console_drivers+0x3b/0x48
 [<c0116884>] _call_console_drivers+0x54/0x58
 [<c0116a46>] release_console_sem+0x122/0x1ed
 [<c0116da7>] register_console+0x190/0x197
 [<c022401a>] init_netconsole+0x4e/0x62
 [<c01003b4>] init+0x88/0x209
 [<c0292be1>] kernel_thread_helper+0x5/0xb
 =======================
netconsole: network logging started
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
Using IPI Shortcut mode
ACPI: (supports S0 S1 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
Freeing unused kernel memory: 160k freed
Write protecting the kernel read-only data: 712k
Time: tsc clocksource has been installed.
Time: acpi_pm clocksource has been installed.
SCSI subsystem initialized
libata version 2.00 loaded.
pata_via 0000:00:04.1: version 0.1.13
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xD800 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xD808 irq 15
scsi0 : pata_via
input: AT Translated Set 2 keyboard as /class/input/input0
ata1.00: ATA-5, max UDMA/100, 78165360 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATA-7, max UDMA/133, 160086528 sectors: LBA 
ata1.01: ata1: dev 1 multi count 16
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
scsi1 : pata_via
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
ata2.00: failed to IDENTIFY (device reports illegal type, err_mask=0x0)
ata2.01: ATAPI, max MWDMA2, CDB intr
ata2.01: configured for MWDMA2
scsi 0:0:0:0: Direct access     ATA      ST340016A        3.75 PQ: 0 ANSI: 5
scsi 0:0:1:0: Direct access     ATA      Maxtor 6Y080L0   YAR4 PQ: 0 ANSI: 5
scsi 1:0:1:0: CD/DVD            E-IDE    CD-950E/AKU      A4Q  PQ: 0 ANSI: 5
SCSI device sda: 78165360 512-byte hdwr sectors (40021 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 78165360 512-byte hdwr sectors (40021 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 > sda4
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 sdb8 sdb9 >
sd 0:0:1:0: Attached scsi disk sdb
sr0: scsi3-mmc drive: 0x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:1:0: Attached scsi CD-ROM sr0
device-mapper: ioctl: 4.8.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:04.2: UHCI Host Controller
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:04.2: irq 5, io base 0x0000d400
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.18-rc4-mm1 uhci_hcd
usb usb1: SerialNumber: 0000:00:04.2
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
warning: process `sleep' used the obsolete sysctl system call
ACPI: PCI Interrupt 0000:00:04.3[D] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:04.3: UHCI Host Controller
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:04.3: irq 5, io base 0x0000d000
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.18-rc4-mm1 uhci_hcd
usb usb2: SerialNumber: 0000:00:04.3
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
usb 1-2: new low speed USB device using uhci_hcd and address 2
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[5]  MMIO=[c5800000-c58007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
usb 1-2: new device found, idVendor=044f, idProduct=b303
usb 1-2: new device strings: Mfr=4, Product=30, SerialNumber=0
usb 1-2: Product: FireStorm Dual Analog 2
usb 1-2: Manufacturer: THRUSTMASTER
usb 1-2: configuration #1 chosen from 1 choice
ohci1394: fw-host0: Running dma failed because Node ID is not valid
input: THRUSTMASTER FireStorm Dual Analog 2 as /class/input/input2
input: USB HID v1.10 Gamepad [THRUSTMASTER FireStorm Dual Analog 2] on usb-0000:00:04.2-2
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
warning: process `date' used the obsolete sysctl system call
ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
input: PC Speaker as /class/input/input3
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
parport0: Printer, HEWLETT-PACKARD DESKJET 710C
parport_pc: VIA parallel port: io=0x378, irq=7
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00308d0120e085ca]
lp0: using parport0 (interrupt-driven).
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: AGP aperture is 256M @ 0xd0000000
Using specific hotkey driver
EXT3 FS on dm-4, internal journal
Adding 64220k swap on /dev/sda5.  Priority:2 extents:1 across:64220k
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
reiserfs: using flush barriers
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
ReiserFS: dm-1: Using r5 hash to sort names
ReiserFS: dm-6: found reiserfs format "3.6" with standard journal
ReiserFS: dm-6: using ordered data mode
reiserfs: using flush barriers
ReiserFS: dm-6: journal params: device dm-6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-6: checking transaction log (dm-6)
ReiserFS: dm-6: Using r5 hash to sort names
Loading Reiser4. See www.namesys.com for a description of Reiser4.
ps_hash_table: 32 buckets
d_cursor_hash_table: 256 buckets
z_hash_table: 8192 buckets
z_hash_table: 8192 buckets
j_hash_table: 16384 buckets
loading reiser4 bitmap......done (34 jiffies)
d_cursor_hash_table: 256 buckets
z_hash_table: 8192 buckets
z_hash_table: 8192 buckets
j_hash_table: 16384 buckets
loading reiser4 bitmap......done (33 jiffies)
ReiserFS: sda7: found reiserfs format "3.6" with standard journal
ReiserFS: sda7: using ordered data mode
reiserfs: using flush barriers
ReiserFS: sda7: journal params: device sda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda7: checking transaction log (sda7)
ReiserFS: sda7: Using r5 hash to sort names
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
reiserfs: using flush barriers
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
loop: loaded (max 8 devices)
warning: process `ls' used the obsolete sysctl system call
warning: process `prcsys' used the obsolete sysctl system call
warning: process `prcsys' used the obsolete sysctl system call
Using specific hotkey driver
ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
NET: Registered protocol family 17
ReiserFS: dm-5: found reiserfs format "3.6" with standard journal
ReiserFS: dm-5: using ordered data mode
reiserfs: using flush barriers
ReiserFS: dm-5: journal params: device dm-5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-5: checking transaction log (dm-5)
ReiserFS: dm-5: Using r5 hash to sort names
UDF-fs: No VRS found
attempt to access beyond end of device
sda3: rw=0, want=68, limit=2
attempt to access beyond end of device
sda3: rw=0, want=1252, limit=2
attempt to access beyond end of device
sda3: rw=0, want=1028, limit=2
UDF-fs: No partition found (1)
FAT: bogus number of reserved sectors
VFS: Can't find a valid FAT filesystem on dev sda3.
UDF-fs: No partition found (1)
FAT: bogus number of reserved sectors
VFS: Can't find a valid FAT filesystem on dev sda6.
UDF-fs: No VRS found
attempt to access beyond end of device
sdb2: rw=0, want=68, limit=2
attempt to access beyond end of device
sdb2: rw=0, want=1252, limit=2
attempt to access beyond end of device
sdb2: rw=0, want=1028, limit=2
UDF-fs: No partition found (1)
FAT: bogus number of reserved sectors
VFS: Can't find a valid FAT filesystem on dev sdb2.
UDF-fs: No VRS found
attempt to access beyond end of device
sdb2: rw=0, want=68, limit=2
attempt to access beyond end of device
sdb2: rw=0, want=1252, limit=2
attempt to access beyond end of device
sdb2: rw=0, want=1028, limit=2
UDF-fs: No partition found (1)
FAT: bogus number of reserved sectors
VFS: Can't find a valid FAT filesystem on dev sdb2.
UDF-fs: No VRS found
UDF-fs: No VRS found
FAT: bogus number of reserved sectors
VFS: Can't find a valid FAT filesystem on dev sdb6.
UDF-fs: No VRS found
FAT: bogus number of reserved sectors
VFS: Can't find a valid FAT filesystem on dev sdb7.
UDF-fs: No partition found (1)
FAT: bogus number of reserved sectors
VFS: Can't find a valid FAT filesystem on dev sdb8.

--------------040105050702050201090907--
