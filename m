Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbUDMI0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbUDMI0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:26:21 -0400
Received: from mail3.codesense.com ([213.132.104.154]:20120 "EHLO
	mail3.codesense.com") by vger.kernel.org with ESMTP id S263033AbUDMIZi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:25:38 -0400
Subject: Re: Failing back to INSANE timesource :) Time stopped today.
From: Niclas Gustafsson <niclas.gustafsson@codesense.com>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1081465114.4705.4.camel@cog.beaverton.ibm.com>
References: <1081416100.6425.45.camel@gmg.codesense.com>
	 <1081465114.4705.4.camel@cog.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-pdvO8DgP+ME/qWWG/5Wd"
Message-Id: <1081844735.26440.41.camel@gmg.codesense.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Apr 2004 10:25:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pdvO8DgP+ME/qWWG/5Wd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Sorry for the late reply I was away on Easter holidays.

I'm attaching both the dmesg output (dmesg.265-IBM305_2) and the
unpacked /proc/config.gz (config.gz.IBM_265_2)

However the last lines from dmesg:
---
> set_rtc_mmss: can't update from 52 to 0
> > set_rtc_mmss: can't update from 53 to 1
> > set_rtc_mmss: can't update from 54 to 2
> > set_rtc_mmss: can't update from 55 to 3
> > set_rtc_mmss: can't update from 56 to 4
> > set_rtc_mmss: can't update from 57 to 5
> > set_rtc_mmss: can't update from 58 to 6
> > Losing too many ticks!
> > TSC cannot be used as a timesource.  <4>Possible reasons for this are:
> >   You're running with Speedstep,
> >   You don't have DMA enabled for your hard disk (see hdparm),
> >   Incorrect TSC synchronization on an SMP system (see dmesg).
---

Were not synched to disk before I rebooted the system.


I've compiled a new kernel that seems to be working better although I
need to run some more tests to be sure.


Regards,

Niclas Gustafsson

 
fre 2004-04-09 klockan 00.58 skrev john stultz:
> On Thu, 2004-04-08 at 02:21, Niclas Gustafsson wrote:
> > Hi,
> > 
> > I'm running Linux 2.6.5  on a IBM xSeries 305 with a Intel P4 2.8Ghz.
> > 
> > And something is very very wrong, I'm getting the following last
> > messages in dmesg:
> > 
> > ------
> > set_rtc_mmss: can't update from 52 to 0
> > set_rtc_mmss: can't update from 53 to 1
> > set_rtc_mmss: can't update from 54 to 2
> > set_rtc_mmss: can't update from 55 to 3
> > set_rtc_mmss: can't update from 56 to 4
> > set_rtc_mmss: can't update from 57 to 5
> > set_rtc_mmss: can't update from 58 to 6
> > Losing too many ticks!
> > TSC cannot be used as a timesource.  <4>Possible reasons for this are:
> >   You're running with Speedstep,
> >   You don't have DMA enabled for your hard disk (see hdparm),
> >   Incorrect TSC synchronization on an SMP system (see dmesg).
> > ------
> > 
> > The problem seesm to be related to heavy loads.
> > I experienced a similar problem yesterday. The machine completly hung
> > after that and i had to cut the power to reboot it. Now however it is
> > responsive and I can log on to it through ssh.
> > 
> > Problem is that the clock stopped completly! - I've never seen anything
> > like this before. 
> > 
> > Local time is about 11 am here and a time gives me:
> > 
> > [root@s151 root]# date
> > Thu Apr  8 03:51:21 CEST 2004
> > 
> > ...10 s later, using my wristwatch, not sleep 10 ;)
> > 
> > [root@s151 root]# date
> > Thu Apr  8 03:51:21 CEST 2004
> > 
> > 
> > Any ideas anyone, I'd really like to know why it is behaving this way.
> 
> Huh. Very very odd.  
> 
> Does /proc/interrupts show timer ticks increasing? 
> Does setting the date change anything? 
> 
> Would you mind sending me your complete dmesg? 
> 
> I'll look into reproducing the error here if you can give me a better
> description of what triggers it and how frequently you see the problem.
> 
> thanks
> -john
> 
> 
> 

--=-pdvO8DgP+ME/qWWG/5Wd
Content-Disposition: attachment; filename=dmesg.265-IBM305_2
Content-Type: text/plain; name=dmesg.265-IBM305_2; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

 IBM                                       ) @ 0x000fe030
ACPI: RSDT (v001 IBM    M51SL    0x00000001 IBM  0x00000000) @ 0x3ffe0000
ACPI: FADT (v001 IBM    M51SL    0x00000001 IBM  0x00000000) @ 0x3ffe014b
ACPI: ASF! (v016    IBM          0x01000000  0x00000000) @ 0x3ffe0030
ACPI: MADT (v001 IBM    M51SL    0x00000001 IBM  0x00000000) @ 0x3ffe00e3
ACPI: DSDT (v001   IBM    M51SL  0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 1
IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-15
ACPI: IOAPIC (id[0x02] address[0xfec01000] global_irq_base[0x10])
IOAPIC[1]: Assigned apic_id 2
IOAPIC[1]: apic_id 2, version 17, address 0xfec01000, GSI 16-31
ACPI: IOAPIC (id[0x03] address[0xfec02000] global_irq_base[0x20])
IOAPIC[2]: Assigned apic_id 3
IOAPIC[2]: apic_id 3, version 17, address 0xfec02000, GSI 32-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/sda2
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2800.545 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 1033864k/1048448k available (1981k kernel code, 13688k reserved, 749k data, 344k init, 130944k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5505.02 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 2-0, 2-1, 2-2, 2-3, 2-4, 2-5, 2-6, 2-7, 2-8, 2-9, 2-10, 2-11, 2-12, 2-13, 2-14, 2-15, 3-0, 3-1, 3-2, 3-3, 3-4, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2798.0746 MHz.
..... host bus clock speed is 133.0273 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0220, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:............................................................................................................................................................................................
Table [DSDT](id F004) - 618 Objects with 53 Devices 188 Methods 27 Regions
ACPI Namespace successfully loaded at root c041873c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0867 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 0000000000000428 on int 9
evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 1 Runtime GPEs in this block
evgpeblk-0867 [06] ev_create_gpe_block   : GPE 32 to 63 [_GPE] 4 regs at 0000000000000528 on int 9
evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 7 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:.....................................................
Initialized 27/27 Regions 0/0 Fields 14/14 Buffers 12/12 Packages (627 nodes)
Executing all Device _STA and_INI methods:.......................................................
55 Devices found containing: 55 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [PII0] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PII1] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PII2] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PII3] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PII4] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [PII5] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PII6] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PII7] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PII8] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PII9] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PIIA] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PIIB] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PIIC] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PIID] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PIIE] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PIIF] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PI10] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PI11] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PI12] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PI13] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PI14] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PI15] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [PIIU] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Root Bridge [PCI1] (00:01)
PCI: Probing PCI hardware (bus 01)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
ACPI: PCI Root Bridge [PCI2] (00:02)
PCI: Probing PCI hardware (bus 02)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2._PRT]
SCSI subsystem initialized
/usr/src/linux-2.6.5/drivers/usb/core/usb.c: registered new driver usbfs
/usr/src/linux-2.6.5/drivers/usb/core/usb.c: registered new driver hub
IOAPIC[1]: Set PCI routing entry (2-1 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
00:00:03[A] -> 2-1 -> IRQ 17
ACPI: PCI Interrupt Link [PIIU] enabled at IRQ 10
IOAPIC[0]: Set PCI routing entry (1-10 -> 0x79 -> IRQ 10 Mode:1 Active:1)
00:00:0f[A] -> 1-10 -> IRQ 10
IOAPIC[1]: Set PCI routing entry (2-0 -> 0xb1 -> IRQ 16 Mode:1 Active:1)
00:00:02[A] -> 2-0 -> IRQ 16
IOAPIC[1]: Set PCI routing entry (2-2 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
00:01:02[A] -> 2-2 -> IRQ 18
IOAPIC[1]: Set PCI routing entry (2-3 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
00:01:02[B] -> 2-3 -> IRQ 19
IOAPIC[1]: Set PCI routing entry (2-4 -> 0xc9 -> IRQ 20 Mode:1 Active:1)
00:01:03[A] -> 2-4 -> IRQ 20
IOAPIC[1]: Set PCI routing entry (2-5 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
00:01:03[B] -> 2-5 -> IRQ 21
IOAPIC[1]: Set PCI routing entry (2-6 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
00:02:04[A] -> 2-6 -> IRQ 22
IOAPIC[1]: Set PCI routing entry (2-7 -> 0xe1 -> IRQ 23 Mode:1 Active:1)
00:02:05[A] -> 2-7 -> IRQ 23
number of MP IRQ sources: 15.
number of IO-APIC #1 registers: 16.
number of IO-APIC #2 registers: 16.
number of IO-APIC #3 registers: 16.
testing the IO APIC.......................
IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   1   0    1    1    71
 0a 001 01  1    1    0   1   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  1    1    0   1   0    1    1    B1
 01 001 01  1    1    0   1   0    1    1    A9
 02 001 01  1    1    0   1   0    1    1    B9
 03 001 01  1    1    0   1   0    1    1    C1
 04 001 01  1    1    0   1   0    1    1    C9
 05 001 01  1    1    0   1   0    1    1    D1
 06 001 01  1    1    0   1   0    1    1    D9
 07 001 01  1    1    0   1   0    1    1    E1
 08 023 03  1    0    0   0   0    0    2    00
 09 00C 0C  1    0    0   0   0    0    2    08
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 03000000
.......     : arbitration: 03
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 060 00  1    0    0   0   0    0    2    44
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ18 -> 1:2
IRQ19 -> 1:3
IRQ20 -> 1:4
IRQ21 -> 1:5
IRQ22 -> 1:6
IRQ23 -> 1:7
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
lp: driver loaded but no devices found
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdb: CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdb: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
  Vendor: IBM-ESXS  Model: DTN018W3UWDY10FN  Rev: S23J
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
SCSI device sda: 35548320 512-byte hdwr sectors (18201 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Fusion MPT base driver 3.01.01
Copyright (c) 1999-2004 LSI Logic Corporation
Fusion MPT SCSI Host driver 3.01.01
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:0f.2: ServerWorks OSB4/CSB5 OHCI USB Controller
ohci_hcd 0000:00:0f.2: irq 10, pci mem f880b000
ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
/usr/src/linux-2.6.5/drivers/usb/core/usb.c: registered new driver hid
/usr/src/linux-2.6.5/drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sda2: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 213361
ext3_orphan_cleanup: deleting unreferenced inode 213364
EXT3-fs: sda2: 2 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 344k freed
EXT3 FS on sda2, internal journal
Adding 522104k swap on /dev/sda3.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
tg3.c:v2.9 (March 8, 2004)
eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:0f:5f:7a
eth1: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:0f:5f:7b
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.

--=-pdvO8DgP+ME/qWWG/5Wd
Content-Disposition: attachment; filename=config.gz.IBM-265_2
Content-Type: application/x-gzip; name=config.gz.IBM-265_2
Content-Transfer-Encoding: base64

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

--=-pdvO8DgP+ME/qWWG/5Wd--

