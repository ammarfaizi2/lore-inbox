Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbTHYGbh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 02:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbTHYGbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 02:31:37 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:1755 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S261530AbTHYGbZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 02:31:25 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: via rhine network failure on 2.6.0-test4
Date: Sun, 24 Aug 2003 23:30:59 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AECC@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: via rhine network failure on 2.6.0-test4
Thread-Index: AcNqw6N8CY6t/nW3T7KTjRENxD1oOwABfqug
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Steve French" <smfrench@austin.rr.com>, "Jeff Garzik" <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Aug 2003 06:30:59.0918 (UTC) FILETIME=[72DBA6E0:01C36AD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following info would be crucial when figuring out the problem. 
In this particular case, it looks like test4 attempted to enable wrong
PCI interrupt links (i.e. LNKA and LNKD, the ones already enabled).

Thanks,
Jun
----

Please file a bug at http://bugzilla.kernel.org/
Category: Power Management
Componenet: ACPI

Attach the output from dmidecide, available in /usr/sbin/, or here: 
http://www.nongnu.org/dmidecode/

Attach the output from acpidmp, available in /usr/sbin/, or in here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar
.gz

Attach the dmesg output showing the failure, if possible.


> -----Original Message-----
> From: Steve French [mailto:smfrench@austin.rr.com]
> Sent: Sunday, August 24, 2003 9:33 PM
> To: Jeff Garzik; linux-kernel@vger.kernel.org
> Subject: Re: via rhine network failure on 2.6.0-test4
> 
> Looks like IRQ misassignment. Disabling ACPI on test4 got networking
to
> work again and the IRQ assignment is back to IRQ11 for via rhine. The
> assigned interrupt in the failing case (linux-2.6.0-test4) was IRQ5
> instead of 11 which presumably it should be - see contents of
> /proc/interrupts in the failing case (test4):
> 
> CPU0
> 0: 1013475 XT-PIC timer
> 1: 1309 XT-PIC i8042
> 2: 0 XT-PIC cascade
> 5: 0 XT-PIC eth0
> 9: 0 XT-PIC acpi
> 10: 0 XT-PIC uhci-hcd, uhci-hcd
> 12: 30047 XT-PIC i8042
> 14: 15193 XT-PIC ide0
> 15: 24 XT-PIC ide1
> NMI: 0
> ERR: 13
> 
> The excerpt from the good boot.msg (linux-2.6.0-test3) follows:
> 
> <6>ACPI: Subsystem revision 20030714
> <4> tbxface-0117 [03] acpi_load_tables : ACPI Tables successfully
acquired
> <4>Parsing all Control
>
Methods:................................................................
..
> ................
> <4>Table [DSDT](id F004) - 326 Objects with 29 Devices 82 Methods 21
> Regions
> <4>ACPI Namespace successfully loaded at root c054f95c
> <4>evxfevnt-0093 [04] acpi_enable : Transition to ACPI mode successful
> <4>evgpeblk-0748 [06] ev_create_gpe_block : GPE 00 to 15 [_GPE] 2 regs
> at 0000000000004020 on int 9
> <4>Completing Region/Field/Buffer/Package
> initialization:..............................................
> <4>Initialized 21/21 Regions 0/0 Fields 15/15 Buffers 10/10 Packages
> (334 nodes)
> <4>Executing all Device _STA and_INI
methods:..............................
> <4>30 Devices found containing: 30 _STA, 1 _INI methods
> <6>ACPI: Interpreter enabled
> <6>ACPI: Using PIC for interrupt routing
> <6>ACPI: PCI Root Bridge [PCI0] (00:00)
> <4>PCI: Probing PCI hardware (bus 00)
> <7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> <4>ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
> <4>ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15,
> disabled)
> <4>ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15,
> disabled)
> <4>ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
> <6>Linux Plug and Play Support v0.97 (c) Adam Belay
> <5>SCSI subsystem initialized
> <6>Linux Kernel Card Services 3.1.22
> <6> options: [pci] [pm]
> <6>drivers/usb/core/usb.c: registered new driver usbfs
> <6>drivers/usb/core/usb.c: registered new driver hub
> <4>ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
> <4>ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
> <6>PCI: Using ACPI for IRQ routing
> 
> 
> The corresponding excerpt from the failing (linux-2.6.0-test4)
boot.msg
> 
> <6>ACPI: Subsystem revision 20030813
> <6>ACPI: Interpreter enabled
> <6>ACPI: Using PIC for interrupt routing
> <6>ACPI: PCI Root Bridge [PCI0] (00:00)
> <4>PCI: Probing PCI hardware (bus 00)
> <7>PM: Adding info for No Bus:pci0000:00
> <7>PM: Adding info for pci:0000:00:00.0
> <7>PM: Adding info for pci:0000:00:01.0
> <7>PM: Adding info for pci:0000:00:0e.0
> <7>PM: Adding info for pci:0000:00:11.0
> <7>PM: Adding info for pci:0000:00:11.1
> <7>PM: Adding info for pci:0000:00:11.2
> <7>PM: Adding info for pci:0000:00:11.3
> <7>PM: Adding info for pci:0000:00:12.0
> <7>PM: Adding info for pci:0000:01:00.0
> <7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> <4>ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
> <4>ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15,
> disabled)
> <4>ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15,
> disabled)
> <4>ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
> <6>Linux Plug and Play Support v0.97 (c) Adam Belay
> <5>SCSI subsystem initialized
> <6>drivers/usb/core/usb.c: registered new driver usbfs
> <6>drivers/usb/core/usb.c: registered new driver hub
> <4>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
> <4>ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
> <6>PCI: Using ACPI for IRQ routing
> 
> 
> 
> 
> Jeff Garzik wrote:
> 
> > Steve French wrote:
> >
> >> The via rhine driver fails to get a dhcp address on my test system
on
> >> 2.6.0-test4. ethereal shows no dhcp request leaving the box but
> >> ifconfig does show the device and it is detected in /proc/pci.
> >> Switching from the test3 vs. test4 snapshots built with equivalent
> >> configure options on the same system (SuSE 8.2) - test3 works but
> >> test4 does not. This is using essentially the default config for
both
> >> the test3 and test4 cases - the only changes are SMP disabled, scsi
> >> devices disabled, Athlon, via-rhine enabled in network devices and
a
> >> handful of additional filesystems enabled, debug memory allocations
> >> enabled. This is the first time in many months that I have seen
> >> problems with the via-rhine driver on 2.6
> >>
> >> Analyzing the code differences between 2.6.0-test3 and test4 (in
> >> via-rhine.c) is not very promising since the only line that has
> >> changed (kfree to free_netdev) is in the routine
via_rhine_remove_one
> >> that seems unlikely to cause problems sending data on the network.
> >>
> >> Ideas as to what could have caused the regression?
> >
> >
> >
> > Does /proc/interrupts show any interrupts being received on your eth
> > device? Does dmesg report any irq assignment problems, or similar?
> >
> > This sounds like ACPI or irq routing related.
> >
> > Jeff
> >
> >
> >
> >
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
