Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbTKKPa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTKKPa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:30:59 -0500
Received: from misc-out.ouvaton.net ([80.67.180.36]:42215 "EHLO
	mx1.ouvaton.net") by vger.kernel.org with ESMTP id S263618AbTKKPap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:30:45 -0500
Message-ID: <1068564641.3fb100a1312ed@ssl.ouvaton.coop>
Date: Tue, 11 Nov 2003 16:30:41 +0100
From: Berke Durak <obdk65536@ouvaton.org>
To: linux-kernel@vger.kernel.org
Subject: ide-scsi: "Sleeping function called from invalid context", 2.6.0-test9
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-WebMail-Company: WebMail Ouvaton.coop, SA
X-Originating-IP: 213.41.151.68
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a kernel problem while using cdrecord to write audio to a blank
CD-R.

This happens with 2.6.0-test6 and 2.6.0-test9 with kernel
preemptibility enabled.

The distribution is a Debian 3.0r1/testing.

Kernel output, cdrecord output and dmesg follows.

Please Cc any replies to obdk65536@ouvaton.org.

-------------------------------------------------------------------
ide-scsi: abort called for 14143
Debug: sleeping function called from invalid context at
include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():1
Call Trace:
 [<c011e712>] __might_sleep+0xab/0xc9
 [<c02871ea>] scsi_sleep+0x7a/0xa6
 [<c028715c>] scsi_sleep_done+0x0/0x14
 [<c02abdef>] idescsi_abort+0xdf/0xe8
 [<c028694d>] scsi_try_to_abort_cmd+0x5e/0x7f
 [<c0286abb>] scsi_eh_abort_cmds+0x57/0xde
 [<c0287743>] scsi_unjam_host+0x150/0x1ff
 [<c028790a>] scsi_error_handler+0x118/0x1cb
 [<c02877f2>] scsi_error_handler+0x0/0x1cb
 [<c0108275>] kernel_thread_helper+0x5/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011d3a8>] schedule+0x57e/0x583
 [<c01211f9>] printk+0x12b/0x17c
 [<c01090ab>] __down+0x8a/0xfc
 [<c011d3f0>] default_wake_function+0x0/0x2e
 [<c010af91>] dump_stack+0x1e/0x22
 [<c01092bb>] __down_failed+0xb/0x14
 [<c0287ba6>] .text.lock.scsi_error+0x37/0x49
 [<c028715c>] scsi_sleep_done+0x0/0x14
 [<c02abdef>] idescsi_abort+0xdf/0xe8
 [<c028694d>] scsi_try_to_abort_cmd+0x5e/0x7f
 [<c0286abb>] scsi_eh_abort_cmds+0x57/0xde
 [<c0287743>] scsi_unjam_host+0x150/0x1ff
 [<c028790a>] scsi_error_handler+0x118/0x1cb
 [<c02877f2>] scsi_error_handler+0x0/0x1cb
 [<c0108275>] kernel_thread_helper+0x5/0xb
---------------------------------------------------------------------

Here's the output from cdrecord :
---------------------------------------------------------------------
quatre# cdrecord dev=1,0,0 -speed 8 -audio -pad *.wav
Cdrecord-Clone 2.01a19 (i686-pc-linux-gnu) Copyright (C) 1995-2003 Jörg
Schilling
scsidev: '1,0,0'
scsibus: 1 target: 0 lun: 0
Linux sg driver version: 3.5.29
Using libscg version 'schily-0.7'
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   : 
Vendor_info    : 'SAMSUNG '
Identifikation : 'CD-R/RW SW-240B '
Revision       : 'R403'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-2 SWABAUDIO BURNFREE FORCESPEED 
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R96R
Starting to write CD/DVD at speed 8 in real TAO mode for single
session.
Last chance to quit, starting real write    0 seconds. Operation
starts.

WARNING: padding up to secsize.
Track 01: Total bytes read/written: 36062208/36063216 (15333 sectors).

WARNING: padding up to secsize.
Track 02: Total bytes read/written: 45006336/45007872 (19136 sectors).

WARNING: padding up to secsize.
Track 03: Total bytes read/written: 47296512/47298720 (20110 sectors).
cdrecord.mmap: Input/output error. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 F7 E3 00 00 1B 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0C 00 00 00 00 3A 00 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x3A Qual 0x00 (medium not present) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 48.609s timeout 40s
write track data: error after 19813248 bytes
cdrecord.mmap: A write error occured.
cdrecord.mmap: Please properly read the error message above.
cdrecord.mmap: Input/output error. test unit ready: scsi sendcmd: no
error
CDB:  00 00 00 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0C 00 00 00 00 04 01 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x04 Qual 0x01 (logical unit is in process of becoming
ready) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.000s timeout 40s
cdrecord.mmap: Input/output error. flush cache: scsi sendcmd: no error
CDB:  35 00 00 00 00 00 00 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 02 00 00 00 00 0C 00 00 00 00 04 01 00 00
Sense Key: 0x2 Not Ready, Segment 0
Sense Code: 0x04 Qual 0x01 (logical unit is in process of becoming
ready) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.000s timeout 120s
Trouble flushing the cache
cdrecord.mmap: Cannot fixate disk.
---------------------------------------------------------------------

Dmesg:
---------------------------------------------------------------------
ACPI: DSDT (v001   ASUS P4B533   0x00001000 MSFT 0x0100000b) @
0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0]
trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x16] polarity[0x3]
trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 2424.243 MHz processor.
Console: colour VGA+ 80x25
Memory: 254508k/262064k available (2726k kernel code, 6844k reserved,
1144k data, 160k init, 0k highmem)
Calibrating delay loop... 4784.12 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000
00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000
00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-23
not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 001 01  0    0    0   0   0    1    1    71
 0b 001 01  0    0    0   0   0    1    1    79
 0c 001 01  0    0    0   0   0    1    1    81
 0d 001 01  0    0    0   0   0    1    1    89
 0e 001 01  0    0    0   0   0    1    1    91
 0f 001 01  0    0    0   0   0    1    1    99
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 001 01  1    1    0   1   0    1    1    A1
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:22
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2423.0525 MHz.
..... host bus clock speed is 134.0640 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1ea0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xa9 -> IRQ 22 Mode:1
Active:1)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Enabled i801 SMBus device
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xb1 -> IRQ 16 Mode:1
Active:1)
00:00:1d[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19 Mode:1
Active:1)
00:00:1d[B] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc1 -> IRQ 18 Mode:1
Active:1)
00:00:1d[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xc9 -> IRQ 23 Mode:1
Active:1)
00:00:1d[D] -> 2-23 -> IRQ 23
Pin 2-18 already programmed
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xd1 -> IRQ 17 Mode:1
Active:1)
00:00:1f[B] -> 2-17 -> IRQ 17
Pin 2-16 already programmed
Pin 2-17 already programmed
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd9 -> IRQ 21 Mode:1
Active:1)
00:02:09[A] -> 2-21 -> IRQ 21
Pin 2-23 already programmed
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xe1 -> IRQ 20 Mode:1
Active:1)
00:02:09[D] -> 2-20 -> IRQ 20
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-21 already programmed
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-21 already programmed
Pin 2-20 already programmed
Pin 2-21 already programmed
Pin 2-23 already programmed
Pin 2-21 already programmed
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-21 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Machine check exception polling timer started.
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xf8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Using anticipatory io scheduler
floppy0: no floppy controllers found
natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
  originally by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
eth0: NatSemi DP8381[56] at 0xd0806000, 00:02:e3:04:24:49, IRQ 18.
Linux video capture interface: v1.00
bttv: driver version 0.9.12 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 2) at 0000:02:0d.0, irq: 21, latency: 32, mmio:
0xef000000
bttv0: detected: AVermedia TVCapture 98 [card=13], PCI subsystem ID is
1461:0002
bttv0: using: AVerMedia TVCapture 98 [card=13,autodetected]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [11]
bttv0: Avermedia eeprom[0x4111]: tuner=Unknown type radio:no remote
control:yes
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for MSP34xx (alternate address) @ 0x88... not
found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54
(PV951),ta8874z
tuner: chip found @ 0xc2
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
registering 0-0061
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DTLA-307030, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SAMSUNG CD-R/RW SW-240B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 60036480 sectors (30738 MB) w/1916KiB Cache, CHS=59560/16/63,
UDMA(100)
 hda: hda1 hda2 hda3 hda4
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

(scsi0:A:6): 10.000MB/s transfers (10.000MHz, offset 15)
  Vendor: IBM       Model: DORS-32160        Rev: WA0A
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SAMSUNG   Model: CD-R/RW SW-240B   Rev: R403
  Type:   CD-ROM                             ANSI SCSI revision: 02
SCSI device sda: 4226725 512-byte hdwr sectors (2164 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 6, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 5
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem d082f000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: enabled 64bit PCI DMA
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0000d800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0000d400
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0000d000
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver wacom
drivers/usb/input/wacom.c: v1.30:USB Wacom Graphire and Wacom Intuos
tablet driver
mice: PS/2 mouse device common for all mice
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 14
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
i2c /dev entries driver
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25
19:16:36 2003 UTC).
PCI: Enabling device 0000:02:03.0 (0080 -> 0081)
ALSA device list:
  #0: C-Media PCI CMI8738-MC6 (model 55) at 0xff00, irq 21
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 160k freed
hub 2-0:1.0: new USB device on port 1, assigned address 2
hid: probe of 2-1:1.0 failed with error -5
input: Wacom Graphire2 4x5 on usb-0000:00:1d.0-1
hub 3-0:1.0: new USB device on port 2, assigned address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0
alt 1 proto 2 vid 0x03F0 pid 0x1017
Adding 124984k swap on /dev/hda3.  Priority:1000 extents:1
EXT3 FS on hda4, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: link up.
eth0: Setting full-duplex based on negotiated link capability.
---------------------------------------------------------------------
--
Berke Durak



