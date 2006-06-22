Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932765AbWFVEFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbWFVEFd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 00:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbWFVEFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 00:05:32 -0400
Received: from xenotime.net ([66.160.160.81]:8867 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932765AbWFVEFa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 00:05:30 -0400
Date: Wed, 21 Jun 2006 21:08:17 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: sergio@sergiomb.no-ip.org
Cc: kernel@agotnes.com, akpm@osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu,
       cw@f00f.org, vsu@altlinux.ru
Subject: Re: how I know if a interrupt is ioapic_edge_type or 
 ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:
 2.6.17-rc6-mm2 - USB issues]]
Message-Id: <20060621210817.74b6b2bc.rdunlap@xenotime.net>
In-Reply-To: <1150938288.3221.2.camel@localhost.portugal>
References: <44953B4B.9040108@agotnes.com>
	<4497DA3F.80302@agotnes.com>
	<20060620044003.4287426d.akpm@osdl.org>
	<4499245C.8040207@agotnes.com>
	<1150936606.2855.21.camel@localhost.portugal>
	<20060621174754.159bb1d0.rdunlap@xenotime.net>
	<1150938288.3221.2.camel@localhost.portugal>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 02:04:48 +0100 Sergio Monteiro Basto wrote:

> who no, how sorry! I am a little tired 
> 

> On Wed, 2006-06-21 at 17:47 -0700, Randy.Dunlap wrote: 
> > On Thu, 22 Jun 2006 01:36:46 +0100 Sergio Monteiro Basto wrote:
> > 
> > > who I do know if a interrupt is ioapic_edge_type or ioapic_edge_type ? 
> > 
> > Do you mean how they are configured in a running kernel?
> 
> yes, I want to know in 
> linux-2.6.13/drivers/pci/quirks.c
> when I am going quirk the PCI_VIA irq, if this irq is in
> IO-APIC-something or is in XT-PIC , to decide if I quirk the interrupt
> or not

You have to look all over the place. :(
And I've probably missed some of them.

But if the system if using PICs, they will be XT-PIC.
Edge or level triggered is then determined by the bus type:
ISA is mostly edge-triggered (OK, I can't remember that far back)
and PCI is defined as level-triggered.  However, there are
exceptions.  IIRC, legacy IDE is edge-triggered even if it is
on a PCI bus (see listing below for ide0).  And some legacy
devices are edge-triggered (timer, keyboard controller/8042,
parallel port).

You can find info about specifics in places like Intel
chipset specs (ICH5, ICH6, ICH7, etc.), the (large) ACPI
spec from www.acpi.info, the Multiprocessor (MP) spec.
from developer.intel.com, probably some AMD chipset specs,
some PCI bus specs, and in some Linux kernel source code.
Like I said, I probably missed a few places.

If you have a specific issue/problem, it would probably be
better just to focus on that.


> > cat /proc/interrupts ::
> > 
> >            CPU0       CPU1       
> >   0:   12412944   12407808    IO-APIC-edge  timer
> >   1:     122673     124208    IO-APIC-edge  i8042
> >   7:          0          0    IO-APIC-edge  parport0
> >   9:          0          0   IO-APIC-level  acpi
> >  12:    1141950    1138138    IO-APIC-edge  i8042
> >  14:    1107749    1109102    IO-APIC-edge  ide0
> >  58:     451498          0         PCI-MSI  eth0
> >  66:     530689     495356         PCI-MSI  libata
> >  74:          0          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb6
> >  82:         31          3   IO-APIC-level  ohci_hcd:usb2, ohci_hcd:usb3, ohci_hcd:usb4, ohci_hcd:usb5
> >  90:        561        492   IO-APIC-level  HDA Intel
> > 169:          3          0   IO-APIC-level  ohci1394
> > 177:          0          0   IO-APIC-level  uhci_hcd:usb8
> > 185:          0          0   IO-APIC-level  uhci_hcd:usb7
> > 193:          0          0   IO-APIC-level  uhci_hcd:usb9
> > 
> > 
> > or how they should be configured in case you are not sure?
> > See a hardware spec. for that.
> > 
> > 
> > > On Wed, 2006-06-21 at 20:50 +1000, Johny wrote:
> > > > Success :)
> > > > 
> > > > I simply made the change 
> > > > manually, based on your and others' inputs (it seemed the simpler
> > > > option).
> > > > 
> > > > Both kernels now boot, and all USB devices are recognised correctly.
> > > > 
> > > 
> > > > I run in XT_PIC mode for interrupts.
> > > > 
> > > 
> > > Hi, thanks for your positive test on "my" theory.
> > > 
> > > Here it goes the link that I talked about on last email 
> > > http://lkml.org/lkml/2005/8/18/92 (you can read the previous messages on
> > > this thread) 
> > > 
> > > The patch of this link doesn't compile (at least for me), but have a
> > > simple idea, which is just quirk the VIA_PCIs if they are in XT_PIC mode
> > > and I think that is the way of this quirks should go.
> > > 
> > > So someone help me out and do a patch that recognize if the interrupt is
> > > in XT-PIC mode or not ? 
> > > 
> > > Thanks,  
> > > -- 
> > > Sérgio M. B.

---
~Randy
