Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVELFVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVELFVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 01:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVELFVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 01:21:46 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:3821 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261159AbVELFV0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 01:21:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CvsLbHVPbaxOUH9TVCOpeoPzlR5H6OLttDuM8OMyj35tcyfEZwQ+alMLWThA4GHmjerrsgAUOAPg9N7y+39B3OqP+S8EoJEGbYu1IDoogdn0yZb8QqauiG1J94DzbYqiEQfuwoPYR+QSWcxCq4mjSqWhdt8twCH1CLJFhEbAzZw=
Message-ID: <b75952a705051122213b901b82@mail.gmail.com>
Date: Thu, 12 May 2005 01:21:26 -0400
From: Tim Carr <xaphod@gmail.com>
Reply-To: Tim Carr <xaphod@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: usb-ohci: ServerWorks OSB4/CSB5 + SMP = error
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

(Please personally cc me on any reply, many thanks!)

I have an HP Netserver LP1000r, which has a ServerWorks OSB4/CSB5 USB
chipset. When I originally received the machine it had one CPU, so I
didn't have SMP compiled into the kernel. If I booted with APIC
enabled the USB didn't work (same error as below), whereas if I booted
with noapic it worked fine.

Now i've upgraded the machine to 2 CPUs and I've compiled in SMP, and
I've taken out "noapic". USB is broken again, here's the dmesg output:

ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd 0000:00:0f.2: ServerWorks OSB4/CSB5 OHCI USB Controller
ohci_hcd 0000:00:0f.2: request interrupt 33 failed
ohci_hcd 0000:00:0f.2: init 0000:00:0f.2 fail, -38
ohci_hcd: probe of 0000:00:0f.2 failed with error -38

Looks like this is a similar problem to a discussion Linus and Duncan
(Laurie) had way back in 2001, which I read here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0101.2/0192.html

I've googled my heart out, and I although occasionally I find people
with the same problem, they always solve it with "noapic". I want both
SMP *and* USB ! :)

Many thanks for any help, and i'm of course happy to spray loads
configuration output, you have but to ask. Below is dmesg and lspci
output in case it helps.

(Please personally cc me on any reply, many thanks!)

Tim Carr
xaphod@gmail.com
--------------------------------------------

lspci:

0000:00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
0000:00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
0000:00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro
100] (rev 08)
0000:00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 65)
0000:00:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro
100] (rev 08)
0000:00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
0000:00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
0000:01:05.0 SCSI storage controller: LSI Logic / Symbios Logic
53c1010 Ultra3 SCSI Adapter (rev 01)
0000:01:05.1 SCSI storage controller: LSI Logic / Symbios Logic
53c1010 Ultra3 SCSI Adapter (rev 01)


dmesg:

Linux version 2.6.11.7TC1 (root@tdot-uw.dyndns.org) (gcc version 3.3.5
(Debian 1:3.3.5-8)) #2 SMP Fri Apr 22 18:30:11 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e9400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001ffffc00 (ACPI data)
 BIOS-e820: 000000001ffffc00 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f7570
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7520
ACPI: RSDT (v001 HP     HWPC213  0x0604001f  PTL 0x00000000) @ 0x1fffc8f7
ACPI: FADT (v001 HP     HWPC213  0x0604001f PTL  0x00000001) @ 0x1ffffb05
ACPI: MADT (v001 PTLTD    APIC   0x0604001f  LTP 0x00000000) @ 0x1ffffb79
ACPI: BOOT (v001 HP     HWPC213  0x0604001f  PTL 0x00000001) @ 0x1ffffbd9
ACPI: DSDT (v001     HP  HWPC213 0x0604001f MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x03] enabled)
Processor #3 6:8 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: HP       Product ID: LP 1Kr/2Kr   APIC at: 0xFEE00000
I/O APIC #1 Version 17 at 0xFEC00000.
I/O APIC #2 Version 17 at 0xFEC01000.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Processors: 2
Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=linux
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec01000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 933.975 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515940k/524224k available (1707k kernel code, 7788k reserved,
511k data, 404k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1843.20 BogoMIPS (lpj=921600)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0387fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0387fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040
00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 732.12 usecs.
task migration cache decay timeout: 1 msecs.
Booting processor 1/3 eip 2000
Initializing CPU#1
Calibrating delay loop... 1863.68 BogoMIPS (lpj=931840)
CPU: After generic identify, caps: 0387fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0387fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040
00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3706.88 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=-1 pin2=0
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0 attaching sched-domain:
 domain 0: span 3
  groups: 1 2
CPU1 attaching sched-domain:
 domain 0: span 3
  groups: 2 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfda11, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered peer bus 01
PCI->APIC IRQ transform: 0000:00:02.0[A] -> IRQ 22
PCI->APIC IRQ transform: 0000:00:08.0[A] -> IRQ 23
PCI->APIC IRQ transform: 0000:00:0f.2[A] -> IRQ 33
PCI->APIC IRQ transform: 0000:01:05.0[A] -> IRQ 24
PCI->APIC IRQ transform: 0000:01:05.1[B] -> IRQ 25
Simple Boot Flag at 0x35 set to 0x1
apm: BIOS not found.
Initializing Cryptographic API
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
e100: eth0: e100_probe: addr 0xfb001000, irq 22, MAC addr 00:30:6E:05:A1:2B
e100: eth1: e100_probe: addr 0xfb003000, irq 23, MAC addr 00:30:6E:05:A1:2C
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks OSB4: IDE controller at PCI slot 0000:00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1880-0x1887, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1888-0x188f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 6Y160P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 1024KiB
hda: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, (U)DMA
hda: cache flushes supported
 hda: hda1 hda2
sym0: <1010-33> rev 0x1 at pci 0000:01:05.0 irq 24
sym0: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18n
  Vendor: HP        Model: 18.2GB C 80-8C42  Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:0:0: tagged command queuing enabled, command queue depth 16.
 target0:0:0: Beginning Domain Validation
sym0:0: wide asynchronous.
sym0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
 target0:0:0: Ending Domain Validation
  Vendor: SDR       Model: GEM318            Rev: 0
  Type:   Processor                          ANSI SCSI revision: 02
 target0:0:11: Beginning Domain Validation
 target0:0:11: Ending Domain Validation
sym1: <1010-33> rev 0x1 at pci 0000:01:05.1 irq 25
sym1: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi1 : sym-2.1.18n
SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
atkbd.c: Failed to enable keyboard on isa0060/serio0
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86,
might be trying access hardware directly.
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
Starting balanced_irq
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 404k freed
NET: Registered protocol family 1
Adding 506036k swap on /dev/sda3.  Priority:-1 extents:1
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 252 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 4
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd 0000:00:0f.2: ServerWorks OSB4/CSB5 OHCI USB Controller
ohci_hcd 0000:00:0f.2: request interrupt 33 failed
ohci_hcd 0000:00:0f.2: init 0000:00:0f.2 fail, -38
ohci_hcd: probe of 0000:00:0f.2 failed with error -38
<SNIP>
