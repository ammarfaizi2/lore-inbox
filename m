Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265719AbTFXGWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 02:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265721AbTFXGWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 02:22:10 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:5904 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP id S265719AbTFXGWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 02:22:07 -0400
Date: Tue, 24 Jun 2003 08:36:12 +0200
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] MS-6368L ACPI IRQ problem still in 2.4.21
Message-ID: <20030624063612.GB20235@alf.amelek.gda.pl>
References: <F760B14C9561B941B89469F59BA3A847E96FBE@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96FBE@orsmsx401.jf.intel.com>
User-Agent: Mutt/1.4i
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 03:23:48PM -0700, Grover, Andrew wrote:
> Is this an SMP machine?

No, it's a low cost Socket-370 Micro-ATX board with built-in VGA and
RTL8139 LAN, VT8601/VT82C686A chipset, Celeron 1200A processor.

Some of the kernel build options:

CONFIG_MPENTIUMIII=y
CONFIG_SMP=n
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y

But, there are some SMP-related boot messages:

found SMP MP-table at 000f6430

Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.

I can provide the complete boot messages if necessary.

> What do the INT_SRC_OVR lines in the dmesg say?

There are none.

The following part of the boot messages is always the same, it doesn't
matter if ACPI uses IRQ9 (not working) or IRQ11 (working).

PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 11	<- usb-uhci
PCI->APIC IRQ transform: (B0,I7,P3) -> 11	<- usb-uhci
PCI->APIC IRQ transform: (B0,I7,P2) -> 12	<- via82cxxx (sound)
PCI->APIC IRQ transform: (B0,I8,P0) -> 10	<- serial (NM9835 #1)
PCI->APIC IRQ transform: (B0,I9,P0) -> 5	<- serial (NM9835 #2)
PCI->APIC IRQ transform: (B0,I14,P0) -> 11	<- eth0 (RTL8139)
PCI->APIC IRQ transform: (B1,I0,P0) -> 10	<- VGA
PCI: Enabling Via external APIC routing

As you can see, ACPI (even if sharing the IRQ with usb-uhci and eth0)
does not appear in any of the above "PCI->APIC IRQ transform" lines.

It looks like an IRQ is only routed if at least one device uses it,
but ACPI is somehow excluded from these devices.

Thanks,
Marek

