Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUBNCcq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 21:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbUBNCcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 21:32:45 -0500
Received: from fmr04.intel.com ([143.183.121.6]:390 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S264546AbUBNCco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 21:32:44 -0500
Subject: ACPI SCI IOAPIC bug (Re: Fixes for nforce2 hard lockup, apic,
	io-apic, udma133 covered)
From: Len Brown <len.brown@intel.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org,
       AMartin@nvidia.com, kernel@kolivas.org, Ian Kumlien <pomac@vapor.com>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0023ED17F@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0023ED17F@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1076725909.25344.61.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 13 Feb 2004 21:31:49 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-11 at 10:15, Maciej W. Rozycki wrote:
> On Thu, 11 Dec 2003, Ross Dickson wrote:

> > ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1]
> trigger[0x3])
> > Int: type 0, pol 1, trig 3, bus 0, irq 9, 2-9
> 
>  ...
> 
> > IRQ to pin mappings:
...
> > IRQ9 -> 0:9-> 0:9
> 
>  ... wrong -- the interrupts are set up as if they were
> connected to multiple I/O APIC inputs.

Maciej,
You're right.  This bug is in mp_config_ioapic_for_sci(), which calls
io_apic_set_pci_routing(), which uncondnitionally calls
add_pin_to_irq().  Problem is that this IRQ has already been initialized
back in setup_IO_APIC_irqs().

Clearly in this case we shouldn't be calling io_apic_set_pci_routing()
at all.  But I've got to look more closely at the case where the SCI is
not identity mapped before simply ripping it out.

thanks,
-Len

 

