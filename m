Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267026AbUBRRny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 12:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267060AbUBRRny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 12:43:54 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:39905 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S267026AbUBRRnw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 12:43:52 -0500
Date: Wed, 18 Feb 2004 18:43:36 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Len Brown <len.brown@intel.com>
Cc: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org,
       AMartin@nvidia.com, kernel@kolivas.org, Ian Kumlien <pomac@vapor.com>
Subject: Re: ACPI SCI IOAPIC bug (Re: Fixes for nforce2 hard lockup, apic,
 io-apic, udma133 covered)
In-Reply-To: <1076725909.25344.61.camel@dhcppc4>
Message-ID: <Pine.LNX.4.55.0402181835450.23650@jurand.ds.pg.gda.pl>
References: <BF1FE1855350A0479097B3A0D2A80EE0023ED17F@hdsmsx402.hd.intel.com>
 <1076725909.25344.61.camel@dhcppc4>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Feb 2004, Len Brown wrote:

> > > ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1]
> > trigger[0x3])
> > > Int: type 0, pol 1, trig 3, bus 0, irq 9, 2-9
> > 
> >  ...
> > 
> > > IRQ to pin mappings:
> ...
> > > IRQ9 -> 0:9-> 0:9
> > 
> >  ... wrong -- the interrupts are set up as if they were
> > connected to multiple I/O APIC inputs.
> 
> Maciej,
> You're right.  This bug is in mp_config_ioapic_for_sci(), which calls
> io_apic_set_pci_routing(), which uncondnitionally calls
> add_pin_to_irq().  Problem is that this IRQ has already been initialized
> back in setup_IO_APIC_irqs().

 Note that if changing an I/O APIC input was indeed needed, the
replace_pin_at_irq() function could be used.

> Clearly in this case we shouldn't be calling io_apic_set_pci_routing()
> at all.  But I've got to look more closely at the case where the SCI is
> not identity mapped before simply ripping it out.

 I still wonder why these arrangements are made so late in a boot -- after 
all, ACPI IRQ configuration is table-driven and does not require any 
specific hardware initialization to work.  So it could be done at the 
stage MP-table parsing happens, couldn't it?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
