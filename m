Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWALDtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWALDtp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 22:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWALDtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 22:49:45 -0500
Received: from tornado.reub.net ([202.89.145.182]:32156 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750773AbWALDto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 22:49:44 -0500
Message-ID: <43C5D1CA.7000400@reub.net>
Date: Thu, 12 Jan 2006 16:49:30 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060110)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, neilb@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       htejun@gmail.com
Subject: Re: 2.6.15-mm2
References: <43C4E2BE.6050800@reub.net> <20060111030529.0bc03e0a.akpm@osdl.org> <20060111111313.GD3389@suse.de> <43C4EEA4.3050502@reub.net> <20060111115616.GE3389@suse.de> <43C518BC.5090903@reub.net> <20060111145201.GS3389@suse.de> <20060111145504.GT3389@suse.de> <43C55B31.5000201@reub.net> <20060111194517.GE5373@suse.de> <20060111195349.GF5373@suse.de>
In-Reply-To: <20060111195349.GF5373@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/01/2006 8:53 a.m., Jens Axboe wrote:
> On Wed, Jan 11 2006, Jens Axboe wrote:
>> At least it shows that the problem is indeed barrier related. I don't
>> have the start of this thread, so can you please send me the output from
>> dmesg from this kernel boot? I'm curious whether the fallback triggers,
>> or if it's the barrier that fails instead.
> 
> Or even better, please boot with this patch applied on top of the kernel
> you just booted (the new one, with the md patch applied).
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 4c5127e..07aee66 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1492,6 +1492,7 @@ static int sd_revalidate_disk(struct gen
>  		ordered = QUEUE_ORDERED_DRAIN;
>  
>  	blk_queue_ordered(sdkp->disk->queue, ordered, sd_prepare_flush);
> +	printk("%s: ordered set to %d\n", disk->disk_name, ordered);
>  
>  	set_capacity(disk, sdkp->capacity);
>  	kfree(buffer);

Here it is...

Linux version 2.6.15-mm3 (root@tornado.reub.net) (gcc version 4.1.0 20060106 
(Red Hat 4.1.0-0.14)) #4 SMP Thu Jan 12 16:26:28 NZDT 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fe2f800 (usable)
  BIOS-e820: 000000003fe2f800 - 000000003fe3f8e3 (ACPI NVS)
  BIOS-e820: 000000003ff2f800 - 000000003ff30000 (ACPI NVS)
  BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
  BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
  BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
  BIOS-e820: 00000000fed13000 - 00000000fed1a000 (reserved)
  BIOS-e820: 00000000fed1c000 - 00000000feda0000 (reserved)
126MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 261679
   DMA zone: 4096 pages, LIFO batch:0
   DMA32 zone: 0 pages, LIFO batch:0
   Normal zone: 225280 pages, LIFO batch:31
   HighMem zone: 32303 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f4ee0
ACPI: RSDT (v001 INTEL  D925XCV  0x20051110 MSFT 0x00000097) @ 0x3ff30000
ACPI: FADT (v002 INTEL  D925XCV  0x20051110 MSFT 0x00000097) @ 0x3ff30200
ACPI: MADT (v001 INTEL  D925XCV  0x20051110 MSFT 0x00000097) @ 0x3ff30390
ACPI: MCFG (v001 INTEL  D925XCV  0x20051110 MSFT 0x00000097) @ 0x3ff30400
ACPI: ASF! (v016 LEGEND I865PASF 0x00000001 INTL 0x02002026) @ 0x3ff35fa0
ACPI: TCPA (v001 INTEL  TBLOEMID 0x00000001 MSFT 0x00000097) @ 0x3ff36040
ACPI: WDDT (v001 INTEL  OEMWDDT  0x00000001 INTL 0x02002026) @ 0x3ff36072
ACPI: DSDT (v001 INTEL  D925XCV  0x00000001 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Detected 2800.337 MHz processor.
Built 1 zonelists
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Kernel command line: ro root=/dev/md0 panic=60 console=ttyS0,57600
CPU 0 irqstacks, hard=c040a000 soft=c0408000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033552k/1046716k available (2161k kernel code, 12500k reserved, 713k 
data, 204k init, 129212k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5607.26 BogoMIPS (lpj=11214524)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000441d 
00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000441d 
00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000180 0000441d 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 04
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c040b000 soft=c0409000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5600.57 BogoMIPS (lpj=11201159)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000441d 
00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000441d 
00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000180 0000441d 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 04
Total of 2 processors activated (11207.84 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=128
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
ACPI: Subsystem revision 20051216
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:06:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: Power Resource [URP2] (off)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
   IO window: disabled.
   MEM window: ffa00000-ffafffff
   PREFETCH window: fdf00000-fdffffff
PCI: Bridge: 0000:00:1c.0
   IO window: disabled.
   MEM window: ff600000-ff6fffff
   PREFETCH window: fdb00000-fdbfffff
PCI: Bridge: 0000:00:1c.1
   IO window: a000-afff
   MEM window: ff700000-ff7fffff
   PREFETCH window: fdc00000-fdcfffff
PCI: Bridge: 0000:00:1c.2
   IO window: disabled.
   MEM window: ff800000-ff8fffff
   PREFETCH window: fdd00000-fddfffff
PCI: Bridge: 0000:00:1c.3
   IO window: disabled.
   MEM window: ff900000-ff9fffff
   PREFETCH window: fde00000-fdefffff
PCI: Bridge: 0000:00:1e.0
   IO window: b000-bfff
   MEM window: ff500000-ff5fffff
   PREFETCH window: fe000000-fe7fffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Enabling device 0000:00:1c.1 (0106 -> 0107)
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1c.3 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Time: tsc clocksource has been installed.
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie03]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie03]
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
Allocate Port Service[0000:00:1c.1:pcie03]
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
Allocate Port Service[0000:00:1c.2:pcie03]
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
Allocate Port Service[0000:00:1c.3:pcie03]
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Processor [CPU2] (supports 8 throttling states)
Real Time Clock Driver v1.12ac
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt 0000:06:02.0[A] -> GSI 18 (level, low) -> IRQ 185
0000:06:02.0: ttyS1 at I/O 0xbc00 (irq = 185) is a 16550A
0000:06:02.0: ttyS2 at I/O 0xbc08 (irq = 185) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
libata version 1.20 loaded.
ahci 0000:00:1f.2: version 1.2
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led slum part
ata1: SATA max UDMA/133 cmd 0xF8804D00 ctl 0x0 bmdma 0x0 irq 193
ata2: SATA max UDMA/133 cmd 0xF8804D80 ctl 0x0 bmdma 0x0 irq 193
ata3: SATA max UDMA/133 cmd 0xF8804E00 ctl 0x0 bmdma 0x0 irq 193
ata4: SATA max UDMA/133 cmd 0xF8804E80 ctl 0x0 bmdma 0x0 irq 193
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata1: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ahci
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata2: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : ahci
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata3: dev 0 ATA-6, max UDMA/133, 156299375 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : ahci
ata4: SATA link down (SStatus 0)
scsi3 : ahci
   Vendor: ATA       Model: ST380817AS        Rev: 3.42
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST380817AS        Rev: 3.42
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST380013AS        Rev: 3.18
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
sda: ordered set to 49
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
sda: ordered set to 49
  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
sdb: ordered set to 49
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
sdb: ordered set to 49
  sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 >
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 156299375 512-byte hdwr sectors (80025 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
sdc: ordered set to 49
SCSI device sdc: 156299375 512-byte hdwr sectors (80025 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
sdc: ordered set to 49
  sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 50, io mem 0xff4ff800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 50, io base 0x0000cc00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 193, io base 0x0000d000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 185, io base 0x0000d400
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 169, io base 0x0000d800
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usb 5-1: new full speed USB device using uhci_hcd and address 2
usb 5-1: configuration #1 chosen from 1 choice
usb 5-2: new full speed USB device using uhci_hcd and address 3
usb 5-2: configuration #1 chosen from 1 choice
hub 5-2:1.0: USB hub found
hub 5-2:1.0: 4 ports detected
usb 5-2.1: new low speed USB device using uhci_hcd and address 4
usb 5-2.1: configuration #1 chosen from 1 choice
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
input: Belkin Components Belkin OmniView KVM Switch as /class/input/input0
input: USB HID v1.00 Keyboard [Belkin Components Belkin OmniView KVM Switch] on 
usb-0000:00:1d.3-2.1
input: Belkin Components Belkin OmniView KVM Switch as /class/input/input1
input: USB HID v1.00 Mouse [Belkin Components Belkin OmniView KVM Switch] on 
usb-0000:00:1d.3-2.1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: raid1 personality registered for level 1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
IPv4 over IPv4 tunneling driver
ip_conntrack version 2.4 (8177 buckets, 65416 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Starting balanced_irq
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb10 ...
md:  adding sdb10 ...
md: sdb7 has different UUID to sdb10
md: sdb6 has different UUID to sdb10
md: sdb5 has different UUID to sdb10
md: sdb3 has different UUID to sdb10
md: sdb2 has different UUID to sdb10
md:  adding sda10 ...
md: sda7 has different UUID to sdb10
md: sda6 has different UUID to sdb10
md: sda5 has different UUID to sdb10
md: sda3 has different UUID to sdb10
md: sda2 has different UUID to sdb10
md: created md5
md: bind<sda10>
md: bind<sdb10>
md: running: <sdb10><sda10>
raid1: raid set md5 active with 2 out of 2 mirrors
md5: bitmap initialized from disk: read 11/11 pages, set 3 bits, status: 0
created bitmap (161 pages) for device md5
md: considering sdb7 ...
md:  adding sdb7 ...
md: sdb6 has different UUID to sdb7
md: sdb5 has different UUID to sdb7
md: sdb3 has different UUID to sdb7
md: sdb2 has different UUID to sdb7
md:  adding sda7 ...
md: sda6 has different UUID to sdb7
md: sda5 has different UUID to sdb7
md: sda3 has different UUID to sdb7
md: sda2 has different UUID to sdb7
md: created md4
md: bind<sda7>
md: bind<sdb7>
md: running: <sdb7><sda7>
raid1: raid set md4 active with 2 out of 2 mirrors
md4: bitmap initialized from disk: read 4/4 pages, set 11 bits, status: 0
created bitmap (61 pages) for device md4
md: considering sdb6 ...
md:  adding sdb6 ...
md: sdb5 has different UUID to sdb6
md: sdb3 has different UUID to sdb6
md: sdb2 has different UUID to sdb6
md:  adding sda6 ...
md: sda5 has different UUID to sdb6
md: sda3 has different UUID to sdb6
md: sda2 has different UUID to sdb6
md: created md3
md: bind<sda6>
md: bind<sdb6>
md: running: <sdb6><sda6>
raid1: raid set md3 active with 2 out of 2 mirrors
md3: bitmap initialized from disk: read 1/1 pages, set 11 bits, status: 0
created bitmap (13 pages) for device md3
md: considering sdb5 ...
md:  adding sdb5 ...
md: sdb3 has different UUID to sdb5
md: sdb2 has different UUID to sdb5
md:  adding sda5 ...
md: sda3 has different UUID to sdb5
md: sda2 has different UUID to sdb5
md: created md2
md: bind<sda5>
md: bind<sdb5>
md: running: <sdb5><sda5>
raid1: raid set md2 active with 2 out of 2 mirrors
md2: bitmap initialized from disk: read 10/10 pages, set 84 bits, status: 0
created bitmap (150 pages) for device md2
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb2 has different UUID to sdb3
md:  adding sda3 ...
md: sda2 has different UUID to sdb3
md: created md1
md: bind<sda3>
md: bind<sdb3>
md: running: <sdb3><sda3>
raid1: raid set md1 active with 2 out of 2 mirrors
md1: bitmap initialized from disk: read 10/10 pages, set 5 bits, status: 0
created bitmap (150 pages) for device md1
md: considering sdb2 ...
md:  adding sdb2 ...
md:  adding sda2 ...
md: created md0
md: bind<sda2>
md: bind<sdb2>
md: running: <sdb2><sda2>
raid1: raid set md0 active with 2 out of 2 mirrors
md0: bitmap initialized from disk: read 12/12 pages, set 95 bits, status: 0
created bitmap (187 pages) for device md0
md: ... autorun DONE.
ReiserFS: md0: found reiserfs format "3.6" with standard journal
ReiserFS: md0: using ordered data mode
ReiserFS: md0: journal params: device md0, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md0: checking transaction log (md0)
ReiserFS: md0: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 204k freed
Write protecting the kernel read-only data: 355k
hw_random hardware driver 1.0.0 loaded
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 185
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: _NEC DVD_RW ND-2510A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:04:00.0 to 64
sky2 v0.11 addr 0xff720000 irq 177 Yukon-EC (0xb6) rev 1
sky2 eth0: addr 00:11:11:43:05:2f
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: md1: found reiserfs format "3.6" with standard journal
ReiserFS: md1: using ordered data mode
ReiserFS: md1: journal params: device md1, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md1: checking transaction log (md1)
ReiserFS: md1: Using r5 hash to sort names
ReiserFS: md2: found reiserfs format "3.6" with standard journal
ReiserFS: md2: using ordered data mode
ReiserFS: md2: journal params: device md2, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md2: checking transaction log (md2)
ReiserFS: md2: Using r5 hash to sort names
ReiserFS: md3: found reiserfs format "3.6" with standard journal
ReiserFS: md3: using ordered data mode
ReiserFS: md3: journal params: device md3, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md3: checking transaction log (md3)
ReiserFS: md3: Using r5 hash to sort names
ReiserFS: md4: found reiserfs format "3.6" with standard journal
ReiserFS: md4: using ordered data mode
ReiserFS: md4: journal params: device md4, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md4: checking transaction log (md4)
ReiserFS: md4: Using r5 hash to sort names
ReiserFS: md5: found reiserfs format "3.6" with standard journal
ReiserFS: md5: using ordered data mode
ReiserFS: md5: journal params: device md5, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md5: checking transaction log (md5)
ReiserFS: md5: Using r5 hash to sort names
ReiserFS: sda8: found reiserfs format "3.6" with standard journal
ReiserFS: sda8: using ordered data mode
ReiserFS: sda8: journal params: device sda8, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda8: checking transaction log (sda8)
ReiserFS: sda8: Using r5 hash to sort names
ReiserFS: sdb8: found reiserfs format "3.6" with standard journal
ReiserFS: sdb8: using ordered data mode
ReiserFS: sdb8: journal params: device sdb8, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb8: checking transaction log (sdb8)
ReiserFS: sdb8: Using r5 hash to sort names
ReiserFS: sdc1: found reiserfs format "3.6" with standard journal
ReiserFS: sdc1: using ordered data mode
ReiserFS: sdc1: journal params: device sdc1, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdc1: checking transaction log (sdc1)
ReiserFS: sdc1: Using r5 hash to sort names
Adding 248968k swap on /dev/sda9.  Priority:-1 extents:1 across:248968k
Adding 248968k swap on /dev/sdb9.  Priority:-2 extents:1 across:248968k
sky2 eth0: enabling interface
sky2 eth0: phy interrupt status 0x1c00 0xbc0c
sky2 eth0: Link is up at 1000 Mbps, full duplex, flow control both
GRE over IPv4 tunneling driver
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
i2c_adapter i2c-0: Unrecognized version/stepping 0x69 Defaulting to LM85.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).

I'm seeing some other big problems with SATA which I'll post about soon in the 
original thread.

reuben

