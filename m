Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934617AbWKXOKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934617AbWKXOKT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 09:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934620AbWKXOKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 09:10:18 -0500
Received: from mpemail.mpe-garching.mpg.de ([130.183.137.110]:14513 "EHLO
	mpemail.mpe.mpg.de") by vger.kernel.org with ESMTP id S934617AbWKXOKQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 09:10:16 -0500
From: "Martin A. Fink" <fink@mpe.mpg.de>
Organization: MPE
To: linux-kernel@vger.kernel.org
Subject: Re: SATA Performance with Intel ICH6
Date: Fri, 24 Nov 2006 15:10:11 +0100
User-Agent: KMail/1.8
References: <200611241407.01210.fink@mpe.mpg.de> <20061124133331.6bf0d7cc@localhost.localdomain>
In-Reply-To: <20061124133331.6bf0d7cc@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611241510.11526.fink@mpe.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 24. November 2006 14:33 schrieben Sie:
> On Fri, 24 Nov 2006 14:07:01 +0100
>
> "Martin A. Fink" <fink@mpe.mpg.de> wrote:
> > If I understand the design of this chipset correctly, then I would have
> > expected, that the CPU needs to do only few work, instead I found out,
> > that writing to disk seems to be really hard work for the CPU.
>
> It has some work to do - the amount in question depends upon the file
> system and device drivers in use. For very high throughput read up on
> the O_DIRECT feature.

Well this seems to be independend from the file system. I tried to write 
directly to the raw device, but nevertheless the cpu time was 20% (sys time).

>
> > My final aim is to get around 140MB/s of data from 3 different Gigabit
> > Ethernet cards and store it on 3 harddisk drives that perform 50MB/s.
> >
> > >From the SATA bus side there should be no problem. Each of the 4 SATAs
> > > on
> >
> > this ICH6 chipset are capable of 150MB/s.
>
> I doubt an ICH6 has the total memory bandwidth to achieve that to be
> honest, but with PCI-E maybe you can.

This is an interessting point. The specification say that I can handle around 
120 to 150 MB/s each of the 4 S-ATA ports. With ICH6 the S-ATA ports seem to 
be directly connected to the Southbridge, and the Southbridge is directly 
connected to Northbridge via PCI Express. So it should be possible to get 150 
MB/s from north to south and from there in packages of 55 MB/s to the 
disks ?!

>
> > So what makes my CPU that slow? Is it a hardware problem or a problem of
> > SATA driver of my operating system?
>
> You don't give anything like enough information to even guess this. What
> controller, what disks, what driver, what kernel version ?

I use a Pentium 4 processor (Xeon), Intel ICH6 chipset, to write on a 250 GB 
S-ATA disk directly connected to one of the 4 onboard S-ATA connections.
kernel version is Linux version 2.6.8-24.25-smp. As disks I used ones from 
Winchester as well as Maxtor. Both behave the same.
Here is some information from /var/log/boot.msg

<6>ACPI: RSDP (v000 DELL                                      ) @ 0x000feb90
<6>ACPI: RSDT (v001 DELL    WS 360  0x00000007 ASL  0x00000061) @ 0x000fd165
<6>ACPI: FADT (v001 DELL    WS 360  0x00000007 ASL  0x00000061) @ 0x000fd19d
<6>ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffc8f10
<6>ACPI: MADT (v001 DELL    WS 360  0x00000007 ASL  0x00000061) @ 0x000fd211
<6>ACPI: BOOT (v001 DELL    WS 360  0x00000007 ASL  0x00000061) @ 0x000fd27d
<6>ACPI: ASF! (v016 DELL    WS 360  0x00000007 ASL  0x00000061) @ 0x000fd2a5
<6>ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
<6>ACPI: PM-Timer IO Port: 0x808
<7>ACPI: Local APIC address 0xfee00000
<6>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
<4>Processor #0 15:2 APIC version 20
<6>ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
<6>ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
<6>ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
<6>ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
<4>IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
<7>ACPI: IRQ0 used by override.
<7>ACPI: IRQ2 used by override.
<7>ACPI: IRQ9 used by override.
<4>Enabling APIC mode:  Flat.  Using 1 I/O APICs
<6>Using ACPI (MADT) for SMP configuration information

<6>CPU: L2 cache: 512K
<6>CPU: Hyper-Threading is disabled

<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 15)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 15)
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, 
disabled.
<4>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 9 10 11 12 15)
<4>ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 15)
<4>ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 15)
<6>Linux Plug and Play Support v0.97 (c) Adam Belay
<6>PCI: Using ACPI for IRQ routing
<6>ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
<6>ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 177
<6>ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
<6>ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 169
<6>ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 193
<6>ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 185
<6>ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 185
<6>ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 201
<6>ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 201
<6>ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
<6>ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 21 (level, low) -> IRQ 209
<6>ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 22 (level, low) -> IRQ 217
<6>ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 17 (level, low) -> IRQ 201
<6>ACPI: PCI interrupt 0000:02:0c.0[A] -> GSI 18 (level, low) -> IRQ 185

<6>scsi1 : ata_piix
<5>  Vendor: ATA       Model: WDC WD740GD-75FL  Rev: 21.0
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>SCSI device sda: 144531250 512-byte hdwr sectors (74000 MB)
<5>SCSI device sda: drive cache: write back
<5>SCSI device sda: 144531250 512-byte hdwr sectors (74000 MB)
<5>SCSI device sda: drive cache: write back
<6> sda: sda1 sda2 < sda5 sda6 sda7 sda8 >
<5>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

>
> > By the way: I'm working with SuSE Linux 9.2 on a Dell Desktop PC, 1GB RAM
>
> For vendor kernels, especially older ones it is probably best to ask the
> vendor first.
>
> Alan

Here some measurement results:

time dd if=/dev/zero of=test.zero bs=1M count=1000
results in

real 0m52.561s
user 0m0.003s
sys  0m7.407s

and strace dd... gives among other information
6.84s 1004calls syscall: write

So I spend 45s of 52s within the kernel. Why so long?

