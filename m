Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTJHSxn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 14:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbTJHSxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 14:53:43 -0400
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:15612
	"EHLO columba.www.eur.3com.com") by vger.kernel.org with ESMTP
	id S261506AbTJHSxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 14:53:38 -0400
Message-ID: <3F845D30.6070706@jburgess.uklinux.net>
Date: Wed, 08 Oct 2003 19:53:36 +0100
From: Jon Burgess <mplayer@jburgess.uklinux.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-gb, en-us
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: P4C800E-Dlx: ICH5/S-ATA and Intel Pro onboard network incompatibility?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have experienced similar issues getting native SATA to work on a 
Gigabyte 8IG1000-Pro board which also uses the ICH5.

I can make it work for me by doing either of the following:
- Running an SMP kernel (which also gets the P4 HT working)
- Running UP kernel, but with the LAPIC_UP + IOAPIC enabled.

I tried lots of various other combinations enabling/disabling ACPI etc, 
but nothing else appeared to make it work/fail.

The symptoms are the same whether I use the ide/ide-piix driver or 
libata driver. The same thing occurs on 2.4 and 2.6.

When things go wrong, the machine locks as soon as it tries to read the 
partition table from the drive. I have attached one such failed boot 
trace. This shows it failing when I specify "nolapic". More log files 
showing good and bad boots are available on request.

It looks like the cause may be an IRQ routing issue. I have seen many 
fixes proposed for ACPI / IRQ routing recently, I am open to suggestions 
for fixes to try which might make it work with other kernel configs.

	Jon

Linux version 2.4.23pre1 (root@localhost.localdomain) (gcc version 3.2.2 
20030222 (Red Hat Linux 3.2.2-5)) #5 Fri Aug 29 21:28:58 BST 2003
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001eff0000 (usable)
  BIOS-e820: 000000001eff0000 - 000000001eff3000 (ACPI NVS)
  BIOS-e820: 000000001eff3000 - 000000001f000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
495MB LOWMEM available.
found SMP MP-table at 000f4c10
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 126960
zone(0): 4096 pages.
zone(1): 122864 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 GBT                                       ) @ 0x000f6840
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1eff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1eff3040
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1eff7280
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 Pentium 4(tm) XEON(tm) APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] 
trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] 
trigger[0x3])
Using ACPI (MADT) for SMP configuration information
Kernel command line: ro root=/dev/sda2 console=ttyS0,38400 console=tty0 
nolapic
Initializing CPU#0
Detected 2411.647 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4810.34 BogoMIPS
Memory: 499408k/507840k available (1404k kernel code, 8044k reserved, 
534k data, 124k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
BIOS bug, local APIC #0 not detected!...
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030813
PCI: PCI BIOS revision 2.10 entry at 0xfa650, last bus=1
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
PCI: Probing PCI hardware
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
apm: overridden by ACPI.
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Asus Laptop ACPI Extras version 0.24a
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 00:1f.1
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hdb: C/H/S=29427/16/255 from BIOS ignored
hda: ST320413A, ATA DISK drive
hdb: Maxtor 96147H6, ATA DISK drive
blk: queue c0347980, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c0347abc, I/O limit 4095Mb (mask 0xffffffff)
hdc: SAMSUNG CDRW/DVD SM-348B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 39102336 sectors (20020 MB) w/1024KiB Cache, CHS=2434/255/63, UDMA(100)
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 120064896 sectors (61473 MB) w/2048KiB Cache, CHS=119112/16/63, 
UDMA(100)
Partition check:
  hda: hda1 hda2 hda3
  hdb: hdb1
SCSI subsystem driver Revision: 1.00
ata1: SATA max UDMA/133 cmd 0xC400 ctl 0xC802 bmdma 0xD400 irq 18
ata2: SATA max UDMA/133 cmd 0xCC00 ctl 0xD002 bmdma 0xD408 irq 18
ata1: dev 0 ATA, max UDMA/133, 156301488 sectors
ata1: dev 0 configured for UDMA/133
ata2: thread exiting
scsi0 : ata_piix
scsi1 : ata_piix
   Vendor: ATA       Model: ST380023AS        Rev: 0.71
   Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
  sda:<3>ata1: DMA timeout, stat 0x64

