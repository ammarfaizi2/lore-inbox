Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUJBCNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUJBCNF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 22:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267212AbUJBCNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 22:13:05 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:24516 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S267180AbUJBCM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 22:12:57 -0400
Date: Fri, 1 Oct 2004 19:13:40 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ACurrid@nvidia.com
Subject: Re: nforce2 bugs?
Message-ID: <20041002021340.GA3482@tesore.ph.cox.net>
Mail-Followup-To: Jesse Allen <the3dfxdude@gmail.com>,
	linux-kernel@vger.kernel.org, ACurrid@nvidia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2004-09-29 at 23:42, white phoenix wrote:
> > [x86] fix lockups with APIC support on nForce2
>
> Looks reasonable (anyone from Nvidia care to ack any of these)
>
> > Add PCI quirk to disable Halt Disconnect and Stop Grant Disconnect
> > (based on athcool program by Osamu Kayasono).
>
> Is this always safe - if not why does the BIOS not do it.

An older Nvidia reference BIOS has a bug.  Nvidia provided this information on 
it:

http://marc.theaimsgroup.com/?l=linux-kernel&m=108362246902784&w=2

A more appropriate patch was merged. It was similar to this:

http://marc.theaimsgroup.com/?l=linux-kernel&m=108362608309197&w=2

So disconnect lockups should not happen anymore. He may be hitting a rarer
nforce2 bug.

For me, an issue with noise on the timer remains.

Ross Dickson wrote:
> A couple of Skewing Mobos Involved:
> Abit NF7-S V2.0 motherboard. 
> A7N8X Deluxe mobo/Athlon

Shuttle AN35N Ultra V1.1

I have not tried the newest BIOS release.  I have the one that fixes
disconnect timings.

> Maybe they are using the same revision of non GPU nforce2 silicon?
> I personally never had any clock skew but I have only used Mobos with 
> graphics onboard, several Albatron KM18G and an Epox 8RGA+

Well, my motherboard has no integrated GPU as well.

Andy Currid wrote:
> In systems running in IOAPIC mode where this problem has been observed, is
> ACPI enabled?

I have ACPI enabled.  I don't explicitly set acpi_skip_timer_override.

Jesse

bash-3.00$ cat /proc/interrupts 
           CPU0       
  0:   16741454    IO-APIC-edge  timer
  1:       9300    IO-APIC-edge  i8042
  7:          0    IO-APIC-edge  parport0
  8:     324750    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:      12284    IO-APIC-edge  ide0
 15:         11    IO-APIC-edge  ide1
 16:         92   IO-APIC-level  aic7xxx
 17:       6156   IO-APIC-level  CMI8738
 19:     290981   IO-APIC-level  radeon@pci:0000:03:00.0
 20:          2   IO-APIC-level  ehci_hcd
 21:          0   IO-APIC-level  NVidia nForce2, ohci_hcd
 22:    1925390   IO-APIC-level  eth0, ohci_hcd
NMI:          0 
LOC:   16698953 
ERR:          0
MIS:          0

shortened dmesg follows:

DMI 2.2 present.
Shuttle AN35N detected: BIOS IRQ0 pin2 override will be ignored
ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f6f70
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff7880
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Linux ro root=301

(cut)

ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=0 pin2=-1


