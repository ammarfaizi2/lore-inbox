Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbTIULgc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 07:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTIULgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 07:36:32 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:21156 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S262364AbTIULfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 07:35:23 -0400
Date: Sun, 21 Sep 2003 13:34:47 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
To: linux-kernel@vger.kernel.org
Subject: Network broke between test4-bk4 and test4-bk5
Message-ID: <20030921113447.GC4735@ppp0.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
I-love-doing-this: really
X-Modeline: vim:set ts=8 sw=4 smarttab tw=72 si noic notitle:
X-Operating-System: Linux/2.4.22aa1 (i686)
X-Uptime: 10:07:58 up 19 days, 7 min,  6 users,  load average: 0.00, 0.05, 0.07
Accept-Languages: de, en, fr
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Today I wanted to upgrade the kernel on my laptop from test2-mm2 to
test5-mm3, but networking was broken afterwards and rebooting doesn't
work anymore correctly (ie hangs on post afterwards).
After some recompiling fun, I tracked the first occurance of this
problem down to the change from test4-bk4 to test4-bk5.
Symptom is, that networking isn't working anymore, but looking at my
/proc/interrupts it seems, that interrupt 9 just doesn't work anymore.
Strangely the count is exactly 100000, everytime I boot.
Booting with acpi=off gets me to a working network, but then some other
devices aren't working properly (Wireless network).
I also tried adding noapic, nolapic, pci=noacpi to the command line, but
that didn't change anything.
Looking at the dmesg output, I see a 'interrupt 9 nobody cared - disabling 
interrupt' uhci related backtrace starting from bk5. 
I suppose because my nic is on the same interrupt, it won't get any further
interrupts.
Is there a way to get the single patches from the bk web interface?
Of interest would be the broken out diffs between 2-9-2003 4:27 (bk4)
and 3-9-2003 4:27 (bk5). Is it possible to get the changes between
these two dates?
Attached is my .config, dmesg output for bk4 and bk5, /proc/interrupts
for bk4 and bk5.
Hardware is a Sony SRX51P laptop.
Anything else of interest to debug this problem?

Thanks,

   Jan

Extract from bk5 dmesg:

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs *9)
ACPI: PCI Interrupt Link [LNKC] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs *9)
...
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
...
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:1f.2: UHCI Host Controller
irq 9: nobody cared!
Call Trace:
 [<c010b65a>] __report_bad_irq+0x2a/0x90
 [<c010b750>] note_interrupt+0x70/0xb0
 [<c010ba21>] do_IRQ+0x121/0x130
 [<c0109d38>] common_interrupt+0x18/0x20
 [<c01e007b>] crypto_init_compress_ops+0x3b/0x40
 [<c01226de>] do_softirq+0x3e/0xa0
 [<c010b9fd>] do_IRQ+0xfd/0x130
 [<c0109d38>] common_interrupt+0x18/0x20
 [<c01e44bf>] pci_bus_write_config_word+0x5f/0x90
 [<c029f450>] uhci_reset+0x0/0x60
 [<c029f48f>] uhci_reset+0x3f/0x60
 [<c0295ad6>] usb_hcd_pci_probe+0x196/0x4a0
 [<c01e8092>] pci_device_probe_static+0x52/0x70
 [<c01e821c>] __pci_device_probe+0x3c/0x50
 [<c01e825c>] pci_device_probe+0x2c/0x50
 [<c023c6ff>] bus_match+0x3f/0x70
 [<c023c84f>] driver_attach+0x6f/0xb0
 [<c023cb13>] bus_add_driver+0x93/0xb0
 [<c023cf4f>] driver_register+0x2f/0x40
 [<c01e84ec>] pci_register_driver+0x5c/0x90
 [<c044bbb4>] uhci_hcd_init+0xc4/0x160
 [<c04347cb>] do_initcalls+0x2b/0xa0
 [<c012e10f>] init_workqueues+0xf/0x30
 [<c01050a4>] init+0x34/0x1d0
 [<c0105070>] init+0x0/0x1d0
 [<c0107255>] kernel_thread_helper+0x5/0x10

handlers:
[<c01eb9af>] (acpi_irq+0x0/0x16)
Disabling IRQ #9
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci-hcd 0000:00:1f.2: irq 9, io base 00001820
uhci-hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg-test4-bk4

00:00:1f.1
PM: Adding info for pci:0000:00:1f.2
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:00:1f.4
PM: Adding info for pci:0000:00:1f.5
PM: Adding info for pci:0000:00:1f.6
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:01:02.0
PM: Adding info for pci:0000:01:05.0
PM: Adding info for pci:0000:01:08.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs *9)
ACPI: PCI Interrupt Link [LNKC] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs *9)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6cf0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x8ae6, dseg 0x400
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0a
PM: Adding info for pnp:00:0b
PM: Adding info for pnp:00:0d
PM: Adding info for pnp:00:0f
PM: Adding info for pnp:00:10
PM: Adding info for pnp:00:16
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
agpgart: Detected an Intel i815 Chipset.
agpgart: Maximum main memory to use for agp memory: 202M
agpgart: AGP aperture is 64M @ 0xf8000000
I810FB: fb0         : Intel(R) 815 (Internal Graphics with AGP) Framebuffer Device v0.9.0
I810FB: Video RAM   : 4096K
I810FB: Monitor     : H: 29-60 KHz V: 60-60 Hz
I810FB: Mode        : 1024x768-8bpp@60Hz
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [ATF0] (55 C)
sonypi: Sony Programmable I/O Controller Driver v1.20.
sonypi: detected type2 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
sonypi: device allocated minor is 63
Sony VAIO Jog Dial installed.
Real Time Clock Driver v1.12
hw_random: RNG not detected
i810 TCO timer init: failed to reset NO_REBOOT flag, reboot disabled by hardware
Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized i810 1.4.0 20030605 on minor 0
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2M: IDE controller at PCI slot 0000:00:1f.1
ICH2M: chipset revision 3
ICH2M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
hda: IC25N030ATCS04-0, ATA DISK drive
PM: Adding info for No Bus:ide0
Using anticipatory scheduling io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=58140/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Console: switching to colour frame buffer device 128x48
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:1f.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci-hcd 0000:00:1f.2: irq 9, io base 00001820
uhci-hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
PM: Adding info for usb:usb1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PM: Adding info for usb:1-0:0
uhci-hcd 0000:00:1f.4: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci-hcd 0000:00:1f.4: irq 9, io base 00002400
uhci-hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
PM: Adding info for usb:usb2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
PM: Adding info for usb:2-0:0
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13 2003 UTC).
PCI: Setting latency timer of device 0000:00:1f.5 to 64
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 2-0:0: new USB device on port 1, assigned address 2
PM: Adding info for usb:2-1
usb-storage: USB Mass Storage device detected
usb-storage: act_altsetting is 0, id_index is 34
usb-storage: -- associate_dev
usb-storage: Vendor: Sony
usb-storage: Product: Memorystick MSC-U03
usb-storage: Transport: Control/Bulk
usb-storage: Protocol: Uniform Floppy Interface (UFI)
usb-storage: Endpoints: In: 0xcf8972c0 Out: 0xcf8972d4 Int: 0xcf8972e8 (Period 1)
usb-storage: *** thread sleeping.
scsi0 : SCSI emulation for USB Mass Storage devices
PM: Adding info for No Bus:host0
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 00 00 00 24 00
usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=21 value=0000 index=00 len=12
usb-storage: Status code 0; transferred 12/12
usb-storage: -- transfer complete
usb-storage: Call to usb_stor_ctrl_transfer() returned 0
usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
usb-storage: Status code 0; transferred 36/36
usb-storage: -- transfer complete
usb-storage: CB data stage result is 0x0
usb-storage: -- CB transport device requiring auto-sense
usb-storage: ** no auto-sense for a special command
usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 00 00 00 38 00
usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=21 value=0000 index=00 len=12
usb-storage: Status code 0; transferred 12/12
usb-storage: -- transfer complete
usb-storage: Call to usb_stor_ctrl_transfer() returned 0
usb-storage: usb_stor_bulk_transfer_buf: xfer 56 bytes
usb-storage: Status code 0; transferred 36/56
usb-storage: -- short transfer
usb-storage: CB data stage result is 0x1
usb-storage: -- CB transport device requiring auto-sense
usb-storage: ** no auto-sense for a special command
usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
  Vendor: Sony      Model: MSC-U03           Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=21 value=0000 index=00 len=12
usb-storage: Status code -32; transferred 12/12
usb-storage: -- stall on control pipe
usb-storage: Call to usb_stor_ctrl_transfer() returned 2
usb-storage: -- CB transport device requiring auto-sense
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=21 value=0000 index=00 len=12
usb-storage: Status code 0; transferred 12/12
usb-storage: -- transfer complete
usb-storage: Call to usb_stor_ctrl_transfer() returned 0
usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: CB data stage result is 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
usb-storage: (Unknown Key): (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=21 value=0000 index=00 len=12
usb-storage: Status code -32; transferred 12/12
usb-storage: -- stall on control pipe
usb-storage: Call to usb_stor_ctrl_transfer() returned 2
usb-storage: -- CB transport device requiring auto-sense
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=21 value=0000 index=00 len=12
usb-storage: Status code 0; transferred 12/12
usb-storage: -- transfer complete
usb-storage: Call to usb_stor_ctrl_transfer() returned 0
usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: CB data stage result is 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
usb-storage: (Unknown Key): (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=21 value=0000 index=00 len=12
usb-storage: Status code -32; transferred 12/12
usb-storage: -- stall on control pipe
usb-storage: Call to usb_stor_ctrl_transfer() returned 2
usb-storage: -- CB transport device requiring auto-sense
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=21 value=0000 index=00 len=12
usb-storage: Status code 0; transferred 12/12
usb-storage: -- transfer complete
usb-storage: Call to usb_stor_ctrl_transfer() returned 0
usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: CB data stage result is 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
usb-storage: (Unknown Key): (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
PM: Adding info for scsi:0:0:0:0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (1:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (2:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (3:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (4:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (5:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (6:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (7:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
PM: Adding info for usb:2-1:0
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801BA-ICH2 at 0x1c00, irq 9
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ACPI: (supports S0 S3 S4 S5)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda1) for (hda1)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 168k freed
Adding 996020k swap on /dev/hda2.  Priority:-1 extents:1
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0000:01:00.0 (0110 -> 0112)
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[9]  MMIO=[f4101000-f41017ff]  Max Packet=[2048]
PM: Adding info for ieee1394:fw-host0
sbp2: $Rev: 1034 $ Ben Collins <bcollins@debian.org>
PM: Adding info for ieee1394:0800460301101508
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0800460301101508]
Bluetooth: Core ver 2.2
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.0
Bluetooth: BNEP filters: protocol multicast
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
drivers/usb/core/usb.c: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.10
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda3) for (hda3)
Using r5 hash to sort names

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg-test4-bk5

Linux version 2.6.0-test4-bk5 (jdittmer@sfhq.hn.org) (gcc version 3.3.1 20030626 (Debian prerelease)) #6 Sun Sep 21 13:09:08 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fcf0000 (usable)
 BIOS-e820: 000000000fcf0000 - 000000000fcff000 (ACPI data)
 BIOS-e820: 000000000fcff000 - 000000000fd00000 (ACPI NVS)
 BIOS-e820: 000000000fd00000 - 000000000fe80000 (usable)
 BIOS-e820: 000000000fe80000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
254MB LOWMEM available.
On node 0 totalpages: 65152
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61056 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
Sony Vaio laptop detected.
ACPI: RSDP (v000 SONY                                      ) @ 0x000f6c60
ACPI: RSDT (v001 SONY   U2       0x20020812 PTL  0x00000000) @ 0x0fcfaea3
ACPI: FADT (v002   SONY       U2 0x20020812 PTL  0x01000000) @ 0x0fcfef54
ACPI: BOOT (v001   SONY       U2 0x20020812 PTL  0x00000001) @ 0x0fcfefd8
ACPI: DSDT (v001   SONY       U2 0x20020812 PTL  0x0100000e) @ 0x00000000
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: root=/dev/hda1 ro video=i810fb:xres:1024,yres:768,vsync1:60,vsync2:60,hsync1:29,hsync2:60 
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 795.208 MHz processor.
Console: colour VGA+ 80x25
Memory: 253612k/260608k available (2367k kernel code, 6212k reserved, 899k data, 168k init, 0k highmem)
Calibrating delay loop... 1568.76 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
CPU: Intel(R) Pentium(R) III Mobile CPU       800MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 794.0828 MHz.
..... host bus clock speed is 99.0353 MHz.
PM: Adding info for No Bus:legacy
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd9b0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
Transparent bridge - 0000:00:1e.0
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:00:1f.2
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:00:1f.4
PM: Adding info for pci:0000:00:1f.5
PM: Adding info for pci:0000:00:1f.6
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:01:02.0
PM: Adding info for pci:0000:01:05.0
PM: Adding info for pci:0000:01:08.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs *9)
ACPI: PCI Interrupt Link [LNKC] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs *9)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6cf0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x8ae6, dseg 0x400
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0a
PM: Adding info for pnp:00:0b
PM: Adding info for pnp:00:0d
PM: Adding info for pnp:00:0f
PM: Adding info for pnp:00:10
PM: Adding info for pnp:00:16
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
agpgart: Detected an Intel i815 Chipset.
agpgart: Maximum main memory to use for agp memory: 202M
agpgart: AGP aperture is 64M @ 0xf8000000
I810FB: fb0         : Intel(R) 815 (Internal Graphics with AGP) Framebuffer Device v0.9.0
I810FB: Video RAM   : 4096K
I810FB: Monitor     : H: 29-60 KHz V: 60-60 Hz
I810FB: Mode        : 1024x768-8bpp@60Hz
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [ATF0] (57 C)
sonypi: Sony Programmable I/O Controller Driver v1.20.
sonypi: detected type2 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
sonypi: device allocated minor is 63
Sony VAIO Jog Dial installed.
Real Time Clock Driver v1.12
hw_random: RNG not detected
i810 TCO timer init: failed to reset NO_REBOOT flag, reboot disabled by hardware
Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized i810 1.4.0 20030605 on minor 0
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2M: IDE controller at PCI slot 0000:00:1f.1
ICH2M: chipset revision 3
ICH2M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
hda: IC25N030ATCS04-0, ATA DISK drive
PM: Adding info for No Bus:ide0
Using anticipatory scheduling io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=58140/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Console: switching to colour frame buffer device 128x48
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:1f.2: UHCI Host Controller
irq 9: nobody cared!
Call Trace:
 [<c010b65a>] __report_bad_irq+0x2a/0x90
 [<c010b750>] note_interrupt+0x70/0xb0
 [<c010ba21>] do_IRQ+0x121/0x130
 [<c0109d38>] common_interrupt+0x18/0x20
 [<c01e007b>] crypto_init_compress_ops+0x3b/0x40
 [<c01226de>] do_softirq+0x3e/0xa0
 [<c010b9fd>] do_IRQ+0xfd/0x130
 [<c0109d38>] common_interrupt+0x18/0x20
 [<c01e44bf>] pci_bus_write_config_word+0x5f/0x90
 [<c029f450>] uhci_reset+0x0/0x60
 [<c029f48f>] uhci_reset+0x3f/0x60
 [<c0295ad6>] usb_hcd_pci_probe+0x196/0x4a0
 [<c01e8092>] pci_device_probe_static+0x52/0x70
 [<c01e821c>] __pci_device_probe+0x3c/0x50
 [<c01e825c>] pci_device_probe+0x2c/0x50
 [<c023c6ff>] bus_match+0x3f/0x70
 [<c023c84f>] driver_attach+0x6f/0xb0
 [<c023cb13>] bus_add_driver+0x93/0xb0
 [<c023cf4f>] driver_register+0x2f/0x40
 [<c01e84ec>] pci_register_driver+0x5c/0x90
 [<c044bbb4>] uhci_hcd_init+0xc4/0x160
 [<c04347cb>] do_initcalls+0x2b/0xa0
 [<c012e10f>] init_workqueues+0xf/0x30
 [<c01050a4>] init+0x34/0x1d0
 [<c0105070>] init+0x0/0x1d0
 [<c0107255>] kernel_thread_helper+0x5/0x10

handlers:
[<c01eb9af>] (acpi_irq+0x0/0x16)
Disabling IRQ #9
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci-hcd 0000:00:1f.2: irq 9, io base 00001820
uhci-hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
PM: Adding info for usb:usb1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PM: Adding info for usb:1-0:0
uhci-hcd 0000:00:1f.4: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci-hcd 0000:00:1f.4: irq 9, io base 00002400
uhci-hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
PM: Adding info for usb:usb2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
PM: Adding info for usb:2-0:0
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13 2003 UTC).
PCI: Setting latency timer of device 0000:00:1f.5 to 64
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 2-0:0: new USB device on port 1, assigned address 2
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801BA-ICH2 at 0x1c00, irq 9
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ACPI: (supports S0 S3 S4 S5)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda1) for (hda1)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 168k freed
Adding 996020k swap on /dev/hda2.  Priority:-1 extents:1
usb 2-1: control timeout on ep0out
uhci-hcd 0000:00:1f.4: Unlink after no-IRQ?  Different ACPI or APIC settings may help.
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0000:01:00.0 (0110 -> 0112)
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[9]  MMIO=[f4101000-f41017ff]  Max Packet=[2048]
PM: Adding info for ieee1394:fw-host0
sbp2: $Rev: 1034 $ Ben Collins <bcollins@debian.org>
Bluetooth: Core ver 2.2
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.0
Bluetooth: BNEP filters: protocol multicast
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
drivers/usb/core/usb.c: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.10
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda3) for (hda3)
Using r5 hash to sort names

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=interrupts-test4-bk4

           CPU0       
  0:     130077          XT-PIC  timer
  1:        367          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          4          XT-PIC  rtc
  9:         54          XT-PIC  acpi, uhci-hcd, uhci-hcd, Intel 82801BA-ICH2, ohci1394, eth0, 0000:01:02.0, 0000:01:05.0, orinoco_cs
 11:          2          XT-PIC  sonypi
 12:         52          XT-PIC  i8042
 14:       5407          XT-PIC  ide0
NMI:          0 
LOC:     130028 
ERR:          0
MIS:          0

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=interrupts-test4-bk5

           CPU0       
  0:     177940          XT-PIC  timer
  1:        194          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          4          XT-PIC  rtc
  9:     100000          XT-PIC  acpi, uhci-hcd, uhci-hcd, ohci1394, Intel 82801BA-ICH2, eth0, 0000:01:02.0, 0000:01:05.0, orinoco_cs
 11:          2          XT-PIC  sonypi
 12:         52          XT-PIC  i8042
 14:       5478          XT-PIC  ide0
NMI:          0 
LOC:     177893 
ERR:          0
MIS:          0

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
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
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_HPET_TIMER is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI_HT is not set
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_PROC_INTF=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_24_API=y
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_YENTA=m
CONFIG_CARDBUS=y
# CONFIG_I82092 is not set
# CONFIG_TCIC is not set

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_FAKE=m
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Generic Driver Options
#
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
CONFIG_PNPBIOS=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_IDEDMA_PCI_WIP=y
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=m

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
CONFIG_IEEE1394_OUI_DB=y

#
# Device Drivers
#

#
# Texas Instruments PCILynx requires I2C bit-banging
#
CONFIG_IEEE1394_OHCI1394=m

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_SBP2_PHYS_DMA=y
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_NETFILTER is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

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
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_AIRO is not set
CONFIG_HERMES=m
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
CONFIG_PCI_HERMES=m

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
CONFIG_PCMCIA_HERMES=m
# CONFIG_AIRO_CS is not set
# CONFIG_PCMCIA_ATMEL is not set
# CONFIG_PCMCIA_WL3501 is not set
CONFIG_NET_WIRELESS=y

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_PCMCIA_PCNET=m
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_PCMCIA_AXNET is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

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
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

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
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Hardware Sensors Mainboard support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_I810_TCO=y
# CONFIG_MIXCOMWD is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_AMD7XX_TCO is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_HW_RANDOM=y
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
CONFIG_SONYPI=y

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
CONFIG_DRM_I810=y
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_HANGCHECK_TIMER=y

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_DEVPTS_FS_SECURITY=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
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
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
# CONFIG_NFSD is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
# CONFIG_EXPORTFS is not set
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
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
# CONFIG_NLS_ISO8859_1 is not set
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
# CONFIG_NLS_UTF8 is not set

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_I810=y
CONFIG_FB_I810_GTF=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_RTCTIMER=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_VXP440 is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set

#
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
#
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_AX8817X_STANDALONE is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
CONFIG_USB_SERIAL_PL2303=m
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_USB_SCO=y
CONFIG_BT_USB_ZERO_PACKET=y
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIDTL1 is not set
# CONFIG_BT_HCIBT3C is not set
# CONFIG_BT_HCIBLUECARD is not set
# CONFIG_BT_HCIBTUART is not set
# CONFIG_BT_HCIVHCI is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci-test4-bk5

00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 11)
	Subsystem: Sony Corporation: Unknown device 80f2
	Flags: bus master, fast devsel, latency 0
	Capabilities: [88] #09 [f205]

00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics Controller] (rev 11) (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 80f2
	Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 9
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Memory at f4000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [dc] Power Management version 2

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (-M) (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f4100000-f41fffff

00:1f.0 ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA Bridge (ICH2-M) (rev 03)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 (-M) (rev 03) (prog-if 80 [Master])
	Subsystem: Sony Corporation: Unknown device 80f2
	Flags: bus master, medium devsel, latency 0
	I/O ports at 1800 [size=16]

00:1f.2 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 80f2
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 1820 [size=32]

00:1f.3 SMBus: Intel Corp. 82820 820 (Camino 2) Chipset SMBus (rev 03)
	Subsystem: Sony Corporation: Unknown device 80f2
	Flags: medium devsel, IRQ 9
	I/O ports at 1810 [size=16]

00:1f.4 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub B) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 80f2
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 2400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82820 820 (Camino 2) Chipset AC'97 Audio Controller (rev 03)
	Subsystem: Sony Corporation: Unknown device 80f2
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at 1c00 [size=256]
	I/O ports at 1840 [size=64]

00:1f.6 Modem: Intel Corp. 82820 820 (Camino 2) Chipset AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Sony Corporation: Unknown device 80f2
	Flags: medium devsel, IRQ 9
	I/O ports at 2000 [size=256]
	I/O ports at 1880 [size=128]

01:00.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8023 (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80f2
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at f4101000 (32-bit, non-prefetchable) [size=2K]
	Memory at f4104000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

01:02.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
	Subsystem: Sony Corporation: Unknown device 80f2
	Flags: bus master, medium devsel, latency 168, IRQ 9
	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00001400-000014ff
	I/O window 1: 00002800-000028ff
	16-bit legacy interface ports at 0001

01:05.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Lucent Technologies: Unknown device ab01
	Flags: bus master, medium devsel, latency 168, IRQ 9
	Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=01, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00002c00-00002cff
	I/O window 1: 00003400-000034ff
	16-bit legacy interface ports at 0001

01:08.0 Ethernet controller: Intel Corp. 82820 (ICH2) Chipset Ethernet Controller (rev 03)
	Subsystem: Sony Corporation: Unknown device 8111
	Flags: bus master, medium devsel, latency 66, IRQ 9
	Memory at f4100000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 3000 [size=64]
	Capabilities: [dc] Power Management version 2


--6TrnltStXW4iwmi0--
