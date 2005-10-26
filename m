Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbVJZCgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbVJZCgW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 22:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVJZCgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 22:36:22 -0400
Received: from relay02.pair.com ([209.68.5.16]:64010 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S932521AbVJZCgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 22:36:20 -0400
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Lee Revell <rlrevell@joe-job.com>
Subject: (was: Oops in do_page_fault) ReiserFS problems... (Now with full trace)
Date: Tue, 25 Oct 2005 21:35:51 -0500
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <60411.67.163.102.102.1130266824.squirrel@webmail2.pair.com> <1130270350.28314.72.camel@mindpipe>
In-Reply-To: <1130270350.28314.72.camel@mindpipe>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0uuXDd3LNofHlge"
Message-Id: <200510252136.14096.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_0uuXDd3LNofHlge
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 25 October 2005 02:58 pm, Lee Revell wrote:
> You need to reproduce this with an untainted kernel AKA without nvidia
> loaded.

My apologies. To retest, I ensured that no modules at all were dynamically 
linked. I also took the liberty of rebuilding the kernel on another system, 
then transferring it over (thankfully I was successful). In the rebuilt 
kernel, I enabled ReiserFS debugging, Magic SysRq, and a serial console (I 
also bought a NULL modem cable).

> You left out the most important part of the Oops, the stack trace.  It
> should have been printed immediately after the registers.

Actually, the Oops didn't contain a stack trace either time I produced the bug 
on my existing 2.6.13! Subsequent attempts to reproduce the problem on that 
production kernel resulted in a freeze.

I've attached the following files:

* boot-dmesg.txt
dmesg right after booting my newly built 2.6.13 debug kernel.
* config-debug.txt
.config from the debug kernel
* cpuinfo.txt
contents of /proc/cpuinfo
* lspci.txt
Output of lspci -vvv, in case anyone finds it relevant.
* emerge.txt
Serial console capture of me running "emerge traceroute" to cause the bug, 
along with some logs of ReiserFS sweating.
* crash.txt
ReiserFS's panic, followed by the full traces produced by the kernel.

Just a few more points about my problem... 

#1 - I've never seen any of the disks in this raid10 (md1 mounted on /) 
produce any CRC errors (though correct me if I'm wrong, I don't see any 
reason the kernel should BUG()/oops/panic because of corrupted filesystems)
#2 - This ReiserFS partition is literally days old.
#3 - When I had strange stability issues before, I had been using 2.6.13 for 
some time successfully. Stability went from perfect to nonexistent.
#4 - I successfully ran a CPU burn in program I don't have source for. I've 
also run memtest86 extensively, replaced the motherboard, power supply and 
GPU. I no longer believe this to be a hardware issue.
#5 - I disabled all swap partitions to eliminate that as a variable.

Thanks a bunch for any ideas. If anyone needs more information from me, I'm 
willing and able to produce whatever is asked for to help debug this.

Thanks,
Chase Venters

--Boundary-00=_0uuXDd3LNofHlge
Content-Type: text/plain;
  charset="iso-8859-1";
  name="boot-dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="boot-dmesg.txt"

Linux version 2.6.13 (root@tazjr) (gcc version 3.3.6 (Gentoo 3.3.6, ssp-3.3.6-1.0, pie-8.7.8)) #2 SMP Tue Oct 25 18:58:10 CDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffbe000 (ACPI data)
 BIOS-e820: 000000003ffbe000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 262064
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32688 pages, LIFO batch:15
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: DELUXE       APIC at: 0xFEE00000
Processor #0 15:4 APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 40000000 (gap: 40000000:bfb80000)
Built 1 zonelists
Kernel command line: root=/dev/md1 noapic acpi=off console=tty0 console=ttyS0,9600n8
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3212.643 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1031368k/1048256k available (4273k kernel code, 16132k reserved, 1717k data, 272k init, 130752k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6429.42 BogoMIPS (lpj=3214713)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000441d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000441d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 01
Total of 1 processors activated (6429.42 BogoMIPS).
Brought up 1 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=4
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:04:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/2640] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:01.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 0000:00:01.0
PCI: Sharing IRQ 10 with 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:00:1c.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:04:00.0
PCI: IRQ 0 for device 0000:00:1c.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 5 for device 0000:00:1c.1
PCI: Sharing IRQ 5 with 0000:02:00.0
PCI: Sharing IRQ 5 with 0000:01:09.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 5 for device 0000:00:1f.1
PCI: Sharing IRQ 5 with 0000:00:1d.2
PCI: IRQ 0 for device 0000:00:1f.3 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 3 for device 0000:00:1f.3
PCI: Sharing IRQ 3 with 0000:00:1d.1
PCI: Sharing IRQ 3 with 0000:00:1f.2
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: cdf00000-cfffffff
  PREFETCH window: d0000000-dfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: d000-dfff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: c000-cfff
  MEM window: cde00000-cdefffff
  PREFETCH window: 40000000-400fffff
PCI: Bridge: 0000:00:1e.0
  IO window: a000-bfff
  MEM window: cdd00000-cddfffff
  PREFETCH window: 40100000-401fffff
PCI: Found IRQ 10 for device 0000:00:01.0
PCI: Sharing IRQ 10 with 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:00:1c.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:04:00.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Found IRQ 10 for device 0000:00:1c.0
PCI: Sharing IRQ 10 with 0000:00:01.0
PCI: Sharing IRQ 10 with 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:04:00.0
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Found IRQ 5 for device 0000:00:1c.1
PCI: Sharing IRQ 5 with 0000:02:00.0
PCI: Sharing IRQ 5 with 0000:01:09.0
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
audit: initializing netlink socket (disabled)
audit(1130291642.077:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
PCI: Found IRQ 10 for device 0000:00:01.0
PCI: Sharing IRQ 10 with 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:00:1c.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:04:00.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Found IRQ 10 for device 0000:00:1c.0
PCI: Sharing IRQ 10 with 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:04:00.0
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
PCI: Found IRQ 5 for device 0000:00:1c.1
PCI: Sharing IRQ 5 with 0000:02:00.0
PCI: Sharing IRQ 5 with 0000:01:09.0
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
hw_random: RNG not detected
[drm] Initialized drm 1.0.0 20040925
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
ub: sizeof ub_scsi_cmd 68 ub_dev 2412 ub_lun 140
usbcore: registered new driver ub
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
PCI: Found IRQ 5 for device 0000:00:1f.1
PCI: Sharing IRQ 5 with 0000:00:1d.2
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
IT8212: IDE controller at PCI slot 0000:01:04.0
PCI: Found IRQ 11 for device 0000:01:04.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:00:1d.7
IT8212: chipset revision 19
it821x: controller in pass through mode.
IT8212: 100% native mode on irq 11
    ide2: BM-DMA at 0xa880-0xa887, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa888-0xa88f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
PCI: Found IRQ 5 for device 0000:01:0a.0
PCI: Sharing IRQ 5 with 0000:01:03.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2902/04/10/15/20C/30C SCSI adapter>
        aic7850: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

  Vendor: PLEXTOR   Model: CD-R   PX-W124TS  Rev: 1.07
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:4: asynchronous.
 target0:0:4: Beginning Domain Validation
 target0:0:4: Domain Validation skipping write tests
 target0:0:4: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 8)
 target0:0:4: Ending Domain Validation
libata version 1.12 loaded.
ahci version 1.01
PCI: Found IRQ 3 for device 0000:00:1f.2
PCI: Sharing IRQ 3 with 0000:00:1d.1
PCI: Sharing IRQ 3 with 0000:00:1f.3
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl IDE mode
ahci(0000:00:1f.2) flags: 64bit ncq pm led slum part 
ata1: SATA max UDMA/133 cmd 0xF8810D00 ctl 0x0 bmdma 0x0 irq 3
ata2: SATA max UDMA/133 cmd 0xF8810D80 ctl 0x0 bmdma 0x0 irq 3
ata3: SATA max UDMA/133 cmd 0xF8810E00 ctl 0x0 bmdma 0x0 irq 3
ata4: SATA max UDMA/133 cmd 0xF8810E80 ctl 0x0 bmdma 0x0 irq 3
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 88:203f
ata1: dev 0 ATA, max UDMA/100, 625142448 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi1 : ahci
ata2: dev 0 cfg 49:2f00 82:306b 83:7e01 84:4003 85:3069 86:3c01 87:4003 88:203f
ata2: dev 0 ATA, max UDMA/100, 625142448 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi2 : ahci
ata3: dev 0 cfg 49:2f00 82:306b 83:7e01 84:4003 85:3069 86:3c01 87:4003 88:203f
ata3: dev 0 ATA, max UDMA/100, 625142448 sectors: lba48
ata3: dev 0 configured for UDMA/100
scsi3 : ahci
ata4: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 88:203f
ata4: dev 0 ATA, max UDMA/100, 625142448 sectors: lba48
ata4: dev 0 configured for UDMA/100
scsi4 : ahci
  Vendor: ATA       Model: WDC WD3200JD-00K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD3200JD-60K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD3200JD-60K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD3200JD-00K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3
Attached scsi disk sdc at scsi3, channel 0, id 0, lun 0
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2 sdd3
Attached scsi disk sdd at scsi4, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 4, lun 0,  type 5
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg3 at scsi3, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg4 at scsi4, channel 0, id 0, lun 0,  type 0
usbmon: debugfs is not available
PCI: Found IRQ 11 for device 0000:00:1d.7
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:04.0
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 01010001)
ehci_hcd 0000:00:1d.7: continuing after BIOS bug...
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xcdcff800
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v2.3
PCI: Found IRQ 11 for device 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:00:1d.7
PCI: Sharing IRQ 11 with 0000:01:04.0
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
usb 1-3: new high speed USB device using ehci_hcd and address 2
uhci_hcd 0000:00:1d.0: irq 11, io base 0x00008880
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Found IRQ 3 for device 0000:00:1d.1
PCI: Sharing IRQ 3 with 0000:00:1f.2
PCI: Sharing IRQ 3 with 0000:00:1f.3
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 3, io base 0x00008c00
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 1-3:1.0: USB hub found
hub 1-3:1.0: 4 ports detected
PCI: Found IRQ 5 for device 0000:00:1d.2
PCI: Sharing IRQ 5 with 0000:00:1f.1
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 5, io base 0x00009000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Found IRQ 10 for device 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:00:1b.0
usb 1-5: new high speed USB device using ehci_hcd and address 3
PCI: Sharing IRQ 10 with 0000:04:00.0
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 10, io base 0x00009080
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usb 1-3.1: new low speed USB device using ehci_hcd and address 4
usb 1-3.2: new low speed USB device using ehci_hcd and address 5
usbcore: registered new driver hiddev
input: USB HID v1.00 Mouse [USB Mouse] on usb-0000:00:1d.7-3.1
input: USB HID v1.10 Keyboard [Key Tronic Keytronic USB Keyboard] on usb-0000:00:1d.7-3.2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
I2O subsystem v1.288
i2o: max drivers = 8
I2O Configuration OSM v1.248
I2O Bus Adapter OSM v$Rev$
I2O Block Device OSM v1.287
I2O SCSI Peripheral OSM v1.282
I2O ProcFS OSM v1.145
i2c /dev entries driver
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid10 personality registered as nr 9
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  4744.000 MB/sec
raid5: using function: pIII_sse (4744.000 MB/sec)
raid6: int32x1    835 MB/s
raid6: int32x2    871 MB/s
raid6: int32x4    679 MB/s
raid6: int32x8    582 MB/s
raid6: mmxx1     1937 MB/s
raid6: mmxx2     2234 MB/s
raid6: sse1x1    1121 MB/s
raid6: sse1x2    1265 MB/s
raid6: sse2x1    2226 MB/s
raid6: sse2x2    2386 MB/s
raid6: using algorithm sse2x2 (2386 MB/s)
md: raid6 personality registered as nr 8
md: multipath personality registered as nr 7
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
device-mapper: dm-multipath version 1.0.4 loaded
device-mapper: dm-round-robin version 1.0.0 loaded
device-mapper: dm-emc version 0.0.3 loaded
padlock: VIA PadLock not detected.
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (8189 buckets, 65512 max) - 248 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
ClusterIP Version 0.7 loaded successfully
arp_tables: (C) 2002 David S. Miller
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0667240(lo)
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
registering ipv6 mark target
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdd1 ...
md:  adding sdd1 ...
md: sdc3 has different UUID to sdd1
md:  adding sdc1 ...
md: sdb3 has different UUID to sdd1
md:  adding sdb1 ...
md: sda3 has different UUID to sdd1
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1><sdb1><sda1>
raid1: raid set md0 active with 4 out of 4 mirrors
md: considering sdc3 ...
md:  adding sdc3 ...
md:  adding sdb3 ...
md:  adding sda3 ...
md: created md1
md: bind<sda3>
md: bind<sdb3>
md: bind<sdc3>
md: running: <sdc3><sdb3><sda3>
raid10: raid set md1 active with 3 out of 4 devices
md: ... autorun DONE.
ReiserFS: md1: found reiserfs format "3.6" with standard journal
ReiserFS: md1: using ordered data mode
ReiserFS: md1: journal params: device md1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md1: checking transaction log (md1)
ReiserFS: md1: journal-1153: found in header: first_unflushed_offset 6018, last_flushed_trans_id 35054
ReiserFS: md1: journal-1006: found valid transaction start offset 6018, len 21 id 34585
ReiserFS: md1: journal-1206: Starting replay from offset 150560078567298, trans_id 1
ReiserFS: md1: journal-1037: journal_read_transaction, offset 6018, len 21 mount_id 12
ReiserFS: md1: journal-1039: journal_read_trans skipping because 6018 is too old
ReiserFS: md1: journal-1299: Setting newest_mount_id to 30
ReiserFS: md1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 272k freed
spurious 8259A interrupt: IRQ7.
--Boundary-00=_0uuXDd3LNofHlge
Content-Type: text/plain;
  charset="iso-8859-1";
  name="config-debug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="config-debug.txt"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.13
# Sun Aug 28 23:36:20 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_SYSCTL=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
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
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_PHYSICAL_START=0x100000
CONFIG_KEXEC=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION=""

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set

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
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

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
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
# CONFIG_IP_FIB_TRIE is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_MULTIPATH_CACHED=y
CONFIG_IP_ROUTE_MULTIPATH_RR=y
CONFIG_IP_ROUTE_MULTIPATH_RANDOM=y
CONFIG_IP_ROUTE_MULTIPATH_WRANDOM=y
CONFIG_IP_ROUTE_MULTIPATH_DRR=y
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_ARPD=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_TUNNEL=y
CONFIG_IP_TCPDIAG=y
CONFIG_IP_TCPDIAG_IPV6=y
CONFIG_TCP_CONG_ADVANCED=y

#
# TCP congestion control
#
CONFIG_TCP_CONG_BIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_SCALABLE=m

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=y
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
CONFIG_INET6_IPCOMP=y
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_TUNNEL=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CONNTRACK_MARK=y
CONFIG_IP_NF_CT_PROTO_SCTP=m
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_IPRANGE=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_OWNER=y
# CONFIG_IP_NF_MATCH_PHYSDEV is not set
CONFIG_IP_NF_MATCH_ADDRTYPE=y
CONFIG_IP_NF_MATCH_REALM=y
CONFIG_IP_NF_MATCH_SCTP=y
CONFIG_IP_NF_MATCH_COMMENT=y
CONFIG_IP_NF_MATCH_CONNMARK=y
CONFIG_IP_NF_MATCH_HASHLIMIT=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=y
CONFIG_IP_NF_TARGET_SAME=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_CLASSIFY=y
CONFIG_IP_NF_TARGET_CONNMARK=y
CONFIG_IP_NF_TARGET_CLUSTERIP=y
CONFIG_IP_NF_RAW=y
CONFIG_IP_NF_TARGET_NOTRACK=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y

#
# IPv6: Netfilter Configuration (EXPERIMENTAL)
#
CONFIG_IP6_NF_QUEUE=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_LIMIT=y
CONFIG_IP6_NF_MATCH_MAC=y
CONFIG_IP6_NF_MATCH_RT=y
CONFIG_IP6_NF_MATCH_OPTS=y
CONFIG_IP6_NF_MATCH_FRAG=y
CONFIG_IP6_NF_MATCH_HL=y
CONFIG_IP6_NF_MATCH_MULTIPORT=y
CONFIG_IP6_NF_MATCH_OWNER=y
CONFIG_IP6_NF_MATCH_MARK=y
CONFIG_IP6_NF_MATCH_IPV6HEADER=y
CONFIG_IP6_NF_MATCH_AHESP=y
CONFIG_IP6_NF_MATCH_LENGTH=y
CONFIG_IP6_NF_MATCH_EUI64=y
# CONFIG_IP6_NF_MATCH_PHYSDEV is not set
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_LOG=y
# CONFIG_IP6_NF_MANGLE is not set
CONFIG_IP6_NF_RAW=y

#
# Bridge: Netfilter Configuration
#
# CONFIG_BRIDGE_NF_EBTABLES is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
CONFIG_BRIDGE=y
CONFIG_VLAN_8021Q=y
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_BCSP_TXCRC=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_UB=y
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=y
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA24XX is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

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
CONFIG_MD_RAID10=y
CONFIG_MD_RAID5=y
CONFIG_MD_RAID6=y
CONFIG_MD_MULTIPATH=y
# CONFIG_MD_FAULTY is not set
CONFIG_BLK_DEV_DM=y
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_MIRROR=y
CONFIG_DM_ZERO=y
CONFIG_DM_MULTIPATH=y
CONFIG_DM_MULTIPATH_EMC=y

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=y
CONFIG_I2O_EXT_ADAPTEC=y
CONFIG_I2O_CONFIG=y
# CONFIG_I2O_CONFIG_OLD_IOCTL is not set
CONFIG_I2O_BUS=y
CONFIG_I2O_BLOCK=y
CONFIG_I2O_SCSI=y
CONFIG_I2O_PROC=y

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
CONFIG_TULIP=m
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_TULIP_NAPI=y
CONFIG_TULIP_NAPI_HW_MITIGATION=y
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
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
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
CONFIG_8139CP=m
CONFIG_8139TOO=m
CONFIG_8139TOO_PIO=y
CONFIG_8139TOO_TUNE_TWISTER=y
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
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
# CONFIG_SKGE is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_AIRO is not set
# CONFIG_HERMES is not set
# CONFIG_ATMEL is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
# CONFIG_PRISM54 is not set
CONFIG_NET_WIRELESS=y

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_NET_FC=y
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

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
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

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
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_I915 is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_ISA=y
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set
CONFIG_I2C_SENSOR=y

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=y

#
# Video For Linux
#

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_OVCAMCHIP is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
# CONFIG_SND is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set

#
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
#
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Input Devices
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_ITMTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_SN9C102 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_PWC is not set

#
# USB Network Adapters
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m

#
# USB Host-to-Host Cables
#
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_GENESYS=y
CONFIG_USB_NET1080=y
CONFIG_USB_PL2301=y
CONFIG_USB_KC2190=y

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_ZAURUS=y
CONFIG_USB_CDCETHER=y

#
# USB Network Adapters
#
CONFIG_USB_AX8817X=y
CONFIG_USB_ZD1201=m
CONFIG_USB_MON=y

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
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
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y

#
# XFS support
#
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=y
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_DEVPTS_FS_SECURITY=y
CONFIG_TMPFS=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_SECURITY=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=y
CONFIG_CIFS_STATS=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_CIFS_EXPERIMENTAL is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
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
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=y

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=y

#
# Library routines
#
CONFIG_CRC_CCITT=y
CONFIG_CRC32=y
CONFIG_LIBCRC32C=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--Boundary-00=_0uuXDd3LNofHlge
Content-Type: text/plain;
  charset="iso-8859-1";
  name="emerge.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="emerge.txt"

emerge traceroute
ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

Calculating dependencies     -   ...done!
>>> emerge (1 of 1) net-analyzer/traceroute-1.4_p12-r2 to /
ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

>>> md5 files   ;-) traceroute-1.4_p12-r2.ebuild
>>> md5 files   ;-) traceroute-1.4_p12-r3.ebuild
>>> md5 files   ;-) files/traceroute-1.4a5-llanfairpwllgwyngyllgogerychwyrndrobwllllantysiliogogogoch.patch
>>> md5 files   ;-) files/traceroute-1.4a5-bigpacklen.patch
>>> md5 files   ;-) files/traceroute-1.4a5-lsrr.patch
>>> md5 files   ;-) files/tReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

raceroute-1.4a5-ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

unaligned.patch
ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

>>> md5 files   ;-) files/traceroute-1.4a12.patch
>>> md5 files   ;-) files/traceroute-1.4-target-resolv.patch
>>> md5 files   ;-) files/digest-traceroute-1.4_p12-r2
>>> md5 files   ;-) files/digest-traceroute-1.4_p12-r3ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1
 
>>> md5 files ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

  ;-) files/tracReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

eroute-1.4-emptylabel.patch
>>> md5 files   ;-) files/traceroute-1.4a5-droproot.patch
>>> md5 files   ;-) files/traceroute-1.4a5-secfix.patch
>>> md5 files   ;-) files/traceroute-1.4a12-LDFLAGS.patch
>>> md5 src_uri ;-) traceroute-1.4a12.tar.gz
ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

>>> Unpacking source...
>>> Unpacking traceroute-1.4a12.tar.gz to /var/tmp/portage/traceroute-1.4_p12-r2/work
  [32;01m* [0m Applying traceroute-1.4-target-resolv.patch ...
 [A [73G   [34;01m[  [32;01mok [34;01m ] [0m
>>> Source unpacked.
ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

  [32;01m* [0m Using GNU config files from /usr/share/libtool
  [32;01m* [0m   Updating config.sub
 [A [73G   [34;01m[  [32;01mok [34;01m ] [0m
  [32;01m* [0m   Updating config.guess
 [A [73G   [34;01m[  [32;01mok [34;01m ] [0m
 * econf: updating traceroute-1.4a12/config.guess with /usr/share/gnuconfig/config.guess
 * econf: updating traceroute-1.4a12/config.sub with /usr/share/gnuconfig/config.sub
./configure --prefix=/usr --host=i686-pc-linux-gnu --mandir=/usr/share/man --infodir=/usr/share/info --datadir=/usr/share --sysconfdir=/etc --localstatedir=/var/lib --build=i686-pc-linux-gnu
creating cache ./config.cache
checking host system type... i686-pc-linux-gnu
checking target system type... i686-pc-linux-gnu
checking build system type... i686-pc-linux-gnu
checking for gcc... gcc
checking whether the C compiler (gcc -O3 -mcpu=i686 -fomit-frame-pointer  -Wl,-z,now) works... yes
checking whether the C compiler (gcc -O3 -mcpu=i686 -fomit-frame-pointer  -Wl,-z,now) is a cross-compiler... no
checking whether we are using GNU C... yes
checking whether gcc accepts -g... yes
checking how to run the C preprocessor... gcc -E
checking for malloc.h... yes
checking for sys/select.h... yes
checking for sys/sockio.h... no
checking for net/route.h... yes
checking for net/if_dl.h... no
checking for inet/mib2.h... no
checking for strerror... yes
checking for usleep... yes
checking for setlinebuf... yes
checking for gethostbyname... yes
checking for socket... yes
checking for putmsg in -lstr... no
checking routing table type... linux
checking for int32_t using gcc... yes
checking for u_int32_t using gcc... yes
checking if sockaddr struct has sa_len member... no
checking if struct icmp has icmp_nextmtu... yes
checking for a BSD compatible install... /bin/install -c
updating cache ./config.cache
creating ./config.status
creating Makefile
gcc -O -O3 -mcpu=i686 -fomit-frame-pointer -DHAVE_MALLOC_H=1 -DHAVE_SYS_SELECT_H=1 -DHAVE_NET_ROUTE_H=1 -DHAVE_STRERROR=1 -DHAVE_USLEEP=1 -DHAVE_SETLINEBUF=1 -DBYTESWAP_IP_HDR=1 -DHAVE_ICMP_NEXTMTU=1  -I.  -Ilinux-include -c ./traceroute.c
gcc -O -O3 -mcpu=i686 -fomit-frame-pointer -DHAVE_MALLOC_H=1 -DHAVE_SYS_SELECT_H=1 -DHAVE_NET_ROUTE_H=1 -DHAVE_STRERROR=1 -DHAVE_USLEEP=1 -DHAVE_SETLINEBUF=1 -DBYTESWAP_IP_HDR=1 -DHAVE_ICMP_NEXTMTU=1  -I.  -Ilinux-include -c ./ifaddrlist.c
gcc -O -O3 -mcpu=i686 -fomit-frame-pointer -DHAVE_MALLOC_H=1 -DHAVE_SYS_SELECT_H=1 -DHAVE_NET_ROUTE_H=1 -DHAVE_STRERROR=1 -DHAVE_USLEEP=1 -DHAVE_SETLINEBUF=1 -DBYTESWAP_IP_HDR=1 -DHAVE_ICMP_NEXTMTU=1  -I.  -Ilinux-include -c ./findsaddr-linux.c
sed -e 's/.*/char version[] = "&";/' ./VERSION > version.c
gcc -O -O3 -mcpu=i686 -fomit-frame-pointer -DHAVE_MALLOC_H=1 -DHAVE_SYS_SELECT_H=1 -DHAVE_NET_ROUTE_H=1 -DHAVE_STRERROR=1 -DHAVE_USLEEP=1 -DHAVE_SETLINEBUF=1 -DBYTESWAP_IP_HDR=1 -DHAVE_ICMP_NEXTMTU=1  -I.  -Ilinux-include -c ./version.c
gcc -O -O3 -mcpu=i686 -fomit-frame-pointer -DHAVE_MALLOC_H=1 -DHAVE_SYS_SELECT_H=1 -DHAVE_NET_ROUTE_H=1 -DHAVE_STRERROR=1 -DHAVE_USLEEP=1 -DHAVE_SETLINEBUF=1 -DBYTESWAP_IP_HDR=1 -DHAVE_ICMP_NReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

EXTMTU=1  -I.  -ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

Ilinux-include -ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

o traceroute traReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ceroute.o ifaddrReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

list.o findsaddrReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

-linux.o version.o  -Wl,-z,now
ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

>>> Test phase [not enabled]: net-analyzer/traceroute-1.4_p12-r2
ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]
 
>>> Install traceroute-1.4_p12-r2 into /var/tmp/portage/traceroute-1.4_p12-r2/image/ category net-analyzer
/bin/install -c -m 4555 -o root -g bin traceroute /var/tmp/portage/traceroute-1.4_p12-r2/image//usr/sbin
man:
prepallstrip:
strip: i686-pc-linux-gnu-strip --strip-unneeded
strip: i686-pc-linux-gnu-strip --strip-unneeded
   usr/sbin/traceroute
>>> Completed installing traceroute-1.4_p12-r2 into /var/tmp/portage/traceroute-1.4_p12-r2/image/

>>> Merging net-analyzer/traceroute-1.4_p12-r2 to /
ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

ReiserFS: warning: is_tree_node: node level 2619 does not match to the expected one 1

ReiserFS: md1: warning: vs-5150: search_by_key: invalid format found in block 50208179. Fsck?

ReiserFS: md1: warning: vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [907070 909203 0x0 SD]

  [32;01m* [0m >>> SetUID: [chmod go-r] /var/tmp/portage/traceroute-1.4_p12-r2/image//usr/sbin/traceroute  ...
 [A [73G   [34;012223

1m[  [32;01mok [
--Boundary-00=_0uuXDd3LNofHlge
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci.txt"

lspci -vvv
0000:00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Processor to I/O Controller (rev 04)
	Subsystem: Intel Corporation 915G/P/GV/GL/PL/910GL Processor to I/O Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] #09 [2109]

0000:00:01.0 PCI bridge: Intel Corporation 915G/P/GV/GL/PL/910GL PCI Express Root Port (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: cdf00000-cfffffff
	Prefetchable memory behind bridge: d0000000-dfffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee01004  Data: 4041
	Capabilities: [a0] #10 [0141]

0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 03)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 813d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at cdcf4000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] #10 [0091]

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee01004  Data: 4049
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: cde00000-cdefffff
	Prefetchable memory behind bridge: 0000000040000000-0000000040000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee01004  Data: 4051
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at 8880 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 3
	Region 4: I/O ports at 8c00 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 5
	Region 4: I/O ports at 9000 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at 9080 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at cdcff800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000a000-0000bfff
	Memory behind bridge: cdd00000-cddfffff
	Prefetchable memory behind bridge: 0000000040100000-0000000040100000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]

0000:00:1f.2 IDE interface: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW) SATA Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 2601
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 3
	Region 0: I/O ports at 9c00 [size=8]
	Region 1: I/O ports at 9880 [size=4]
	Region 2: I/O ports at 9800 [size=8]
	Region 3: I/O ports at 9480 [size=4]
	Region 4: I/O ports at 9400 [size=16]
	Region 5: Memory at cdcffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 3
	Region 4: I/O ports at 0400 [size=32]

0000:01:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at cddfe800 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at cddf8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:04.0 Mass storage controller: Integrated Technology Express, Inc. IT/ITE8212 Dual channel ATA RAID controller (PCI version seems to be IT8212, embedded seems (rev 13)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 813a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at b400 [size=8]
	Region 1: I/O ports at b080 [size=4]
	Region 2: I/O ports at b000 [size=8]
	Region 3: I/O ports at ac00 [size=4]
	Region 4: I/O ports at a880 [size=16]
	Expansion ROM at 40100000 [disabled] [size=128K]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at b480 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at bc00 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:0a.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
	Subsystem: Adaptec AHA-2904/Integrated AIC-7850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 1000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at b800 [disabled] [size=256]
	Region 1: Memory at cddff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 40120000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 Gigabit Ethernet Controller (rev 15)
	Subsystem: ASUSTeK Computer Inc. Marvell 88E8053 Gigabit Ethernet Controller (Asus)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
	Latency: 0, cache line size 04
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at cdefc000 (64-bit, non-prefetchable) [size=16K]
	Region 2: I/O ports at c800 [size=256]
	Expansion ROM at 40000000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=7 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] #10 [0011]

0000:04:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0092 (rev a1) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at cf000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at ce000000 (64-bit, non-prefetchable) [size=16M]
	Region 5: I/O ports at ec00 [size=128]
	Expansion ROM at cdf00000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] #10 [0001]
--Boundary-00=_0uuXDd3LNofHlge
Content-Type: text/plain;
  charset="iso-8859-1";
  name="cpuinfo.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpuinfo.txt"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	: Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping	: 1
cpu MHz		: 3212.643
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor ds_cpl cid xtpr
bogomips	: 6429.42
--Boundary-00=_0uuXDd3LNofHlge
Content-Type: text/plain;
  charset="iso-8859-1";
  name="crash.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="crash.txt"

ReiserFS: md1: warning: B_FREE_SPACE (PATH_H_PBUFFER(tb->tb_path,0)) = 3680; MAX_CHILD_SIZE (4072) - dc_size( [dc_number=16425, dc_size=28376], 24 ) [65376] = -61304
--REISERFS: panic (device md1): PAP-12365: check_after_balance_leaf: S is incorrect
---------------[ cut here ]------------

kernel BUG at fs/reiserfs/prints.c:362!

invalid operand: 0000 [#1]

PREEMPT SMP 

Modules linked in:

CPU:    0

EIP:    0060:[<c01cd94f>]    Not tainted VLI

EFLAGS: 00010282   (2.6.13) 

EIP is at reiserfs_panic+0x4f/0x80

eax: 00000058   ebx: c0571156   ecx: 00000000   edx: ffff8b02

esi: f7d96650   edi: f7d967c0   ebp: f5ed7b18   esp: f5ed7b00

ds: 007b   es: 007b   ss: 0068

Process emerge (pid: 5646, threadinfo=f5ed6000 task=f6380020)

Stack: c0581580 f7d967c0 c0750cc0 00000005 f5b15000 00000005 f5ed7b58 c01b6e30 

       f7d96650 c057c040 00000e60 00000fe8 f5ad6ed8 00000018 0000ff60 ffff1088 

       00000e60 00000100 00000019 00000001 00000018 f5ed7bec f5ed7bc0 c01b70b7 

Call Trace:

 [<c01040df>] show_stack+0x7f/0xa0

 [<c0104294>] show_registers+0x164/0x1d0

 [<c01044c1>] die+0x101/0x1a0

 [<c0104615>] do_trap+0xb5/0xc0

 [<c010495c>] do_invalid_op+0xbc/0xd0

 [<c0103d07>] error_code+0x4f/0x54

 [<c01b6e30>] check_after_balance_leaf+0x100/0x1d0

 [<c01b70b7>] do_balance+0xc7/0x1a0

 [<c01db0b5>] reiserfs_insert_item+0x285/0x390

 [<c01bdf88>] reiserfs_new_inode+0x588/0x880

 [<c01b8a02>] reiserfs_mkdir+0x1b2/0x3b0

 [<c017d6d7>] vfs_mkdir+0x97/0x140

 [<c017d829>] sys_mkdir+0xa9/0xe0

 [<c010311f>] sysenter_past_esp+0x54/0x75

Code: 01 00 00 89 04 24 e8 e1 fc ff ff c7 04 24 80 15 58 c0 85 f6 89 d8 0f 45 c7 ba c0 0c 75 c0 89 54 24 08 89 44 24 04 e8 41 65 f5 ff <0f> 0b 6a 01 06 17 57 c0 c7 04 24 c0 15 58 c0 85 f6 b9 c0 0c 75 

Badness in do_exit at kernel/exit.c:787

dump_stack+0x1e/0x30e
 [<c0126c48>] do_exit+0x438/0x440

 [<c010455c>] die+0x19c/0x1a0

 [<c0104615>] do_trap+0xb5/0xc0

 [<c010495c>] do_invalid_op+0xbc/0xd0

 [<c0103d07>] error_code+0x4f/0x54

 [<c01b6e30>] check_after_balance_leaf+0x100/0x1d0

 [<c01b70b7>] do_balance+0xc7/0x1a0

 [<c01db0b5>] reiserfs_insert_item+0x285/0x390

 [<c01bdf88>] reiserfs_new_inode+0x588/0x880

 [<c01b8a02>] reiserfs_mkdir+0x1b2/0x3b0

 [<c017d6d7>] vfs_mkdir+0x97/0x140

 [<c017d829>] sys_mkdir+0xa9/0xe0

 [<c010311f>] sysenter_past_esp+0x54/0x75

5140

REISERFS: panic (device md1): PAP-5140: search_by_key: schedule occurred in do_balance!

------------[ cut here ]------------

kernel BUG at fs/reiserfs/prints.c:362!

invalid operand: 0000 [#2]

PREEMPT SMP 

Modules linked in:

CPU:    0

EIP:    0060:[<c01cd94f>]    Not tainted VLI

EFLAGS: 00010286   (2.6.13) 

EIP is at reiserfs_panic+0x4f/0x80

eax: 0000005e   ebx: c0571156   ecx: 00000000   edx: ffff8217

esi: f7d96650   edi: f7d967c0   ebp: f5ed7514   esp: f5ed74fc

ds: 007b   es: 007b   ss: 0068

Process emerge (pid: 5646, threadinfo=f5ed6000 task=f6380020)

Stack: c0581580 f7d967c0 c0750cc0 00000000 c0586e40 f5ed7bec f5ed76d0 c01d773b 

       f7d96650 c0586e40 f5ed7640 00001000 c05718ea f8840000 f5ed7574 c01e13e3 

       f7d96650 f5ed7550 00000286 c1927d30 c1927d34 f5ed7558 c052bb51 f5ed7570 

Call Trace:

 [<c01040df>] show_stack+0x7f/0xa0

 [<c0104294>] show_registers+0x164/0x1d0

 [<c01044c1>] die+0x101/0x1a0

 [<c0104615>] do_trap+0xb5/0xc0

 [<c010495c>] do_invalid_op+0xbc/0xd0

 [<c0103d07>] error_code+0x4f/0x54

 [<c01d773b>] search_by_key+0x1dfb/0x1e00

 [<c01d77a9>] search_for_position_by_key+0x69/0x430

 [<c01da0c6>] reiserfs_do_truncate+0xe6/0x6f0

 [<c01d925f>] reiserfs_delete_object+0x3f/0x80

 [<c01ba5f6>] reiserfs_delete_inode+0xa6/0x120

 [<c01881b5>] generic_delete_inode+0xa5/0x150

 [<c01883d8>] generic_drop_inode+0x18/0x30

 [<c0188454>] iput+0x64/0x90

 [<c0185096>] dput+0x126/0x1f0

 [<c016d60f>] __fput+0x13f/0x1b0

 [<c016d4c9>] fput+0x19/0x20

 [<c016bb4b>] filp_close+0x4b/0x80

 [<c0125b94>] put_files_struct+0x74/0xe0

 [<c0126923>] do_exit+0x113/0x440

 [<c010455c>] die+0x19c/0x1a0

 [<c0104615>] do_trap+0xb5/0xc0

 [<c010495c>] do_invalid_op+0xbc/0xd0

 [<c0103d07>] error_code+0x4f/0x54

 [<c01b6e30>] check_after_balance_leaf+0x100/0x1d0

 [<c01b70b7>] do_balance+0xc7/0x1a0

 [<c01db0b5>] reiserfs_insert_item+0x285/0x390

 [<c01bdf88>] reiserfs_new_inode+0x588/0x880

 [<c01b8a02>] reiserfs_mkdir+0x1b2/0x3b0

 [<c017d6d7>] vfs_mkdir+0x97/0x140

 [<c017d829>] sys_mkdir+0xa9/0xe0

 [<c010311f>] sysenter_past_esp+0x54/0x75

Code: 01 00 00 89 04 24 e8 e1 fc ff ff c7 04 24 80 15 58 c0 85 f6 89 d8 0f 45 c7 ba c0 0c 75 c0 89 54 24 08 89 44 24 04 e8 41 65 f5 ff <0f> 0b 6a 01 06 17 57 c0 c7 04 24 c0 15 58 c0 85 f6 b9 c0 0c 75 

 Badness in do_exit at kernel/exit.c:787

 [<c010411e>] dump_stack+0x1e/0x30

 [<c0126c48>] do_exit+0x438/0x440

 [<c010455c>] die+0x19c/0x1a0

 [<c0104615>] do_trap+0xb5/0xc0

 [<c010495c>] do_invalid_op+0xbc/0xd0

 [<c0103d07>] error_code+0x4f/0x54

 [<c01d773b>] search_by_key+0x1dfb/0x1e00

 [<c01d77a9>] search_for_position_by_key+0x69/0x430

 [<c01da0c6>] reiserfs_do_truncate+0xe6/0x6f0

 [<c01d925f>] reiserfs_delete_object+0x3f/0x80

 [<c01ba5f6>] reiserfs_delete_inode+0xa6/0x120

 [<c01881b5>] generic_delete_inode+0xa5/0x150

 [<c01883d8>] generic_drop_inode+0x18/0x30

 [<c0188454>] iput+0x64/0x90

 [<c0185096>] dput+0x126/0x1f0

 [<c016d60f>] __fput+0x13f/0x1b0

 [<c016d4c9>] fput+0x19/0x20

 [<c016bb4b>] filp_close+0x4b/0x80

 [<c0125b94>] put_files_struct+0x74/0xe0

 [<c0126923>] do_exit+0x113/0x440

 [<c010455c>] die+0x19c/0x1a0

 [<c0104615>] do_trap+0xb5/0xc0

 [<c010495c>] do_invalid_op+0xbc/0xd0

 [<c0103d07>] error_code+0x4f/0x54

 [<c01b6e30>] check_after_balance_leaf+0x100/0x1d0

 [<c01b70b7>] do_balance+0xc7/0x1a0

 [<c01db0b5>] reiserfs_insert_item+0x285/0x390

 [<c01bdf88>] reiserfs_new_inode+0x588/0x880

 [<c01b8a02>] reiserfs_mkdir+0x1b2/0x3b0

 [<c017d6d7>] vfs_mkdir+0x97/0x140

 [<c017d829>] sys_mkdir+0xa9/0xe0

 [<c010311f>] sysenter_past_esp+0x54/0x75

Fixing recursive fault but reboot is needed!

--Boundary-00=_0uuXDd3LNofHlge--
