Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbUDNKhm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 06:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264033AbUDNKhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 06:37:42 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:40115 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264027AbUDNKhi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 06:37:38 -0400
Date: Wed, 14 Apr 2004 12:37:37 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ross Dickson <ross@datscreative.com.au>
Cc: Len Brown <len.brown@intel.com>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2 [PATCH]
In-Reply-To: <200404141502.14023.ross@datscreative.com.au>
Message-ID: <Pine.LNX.4.55.0404141220500.17639@jurand.ds.pg.gda.pl>
References: <200404131117.31306.ross@datscreative.com.au>
 <200404131703.09572.ross@datscreative.com.au> <1081893978.2251.653.camel@dhcppc4>
 <200404141502.14023.ross@datscreative.com.au>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004, Ross Dickson wrote:

> e.g. for 2.4.26-rc2 io_apic.c line 1613 or 2.6.5 line 2180 
> 	if (pin1 != -1) {
> 		/*
> 		 * Ok, does IRQ0 through the IOAPIC work?
> 		 */
> +		if(acpi_skip_timer_override)
> +			timer_ack=0;
> 		unmask_IO_APIC_irq(0);
> 
> I might also grab the pci quirk source from the old nforce2 disconnect bit
> patch and try it as a means of detection for automatic trigger. i.e. instead
> of writing the pci config bit, set acpi_skip_timer_override instead - but then
> if someone gets clock skew we would need the kern arg to turn it off - 
> unless the potential for clock skew is fixed.

 Well, the question is whether the timer->INTIN0 routing is hardwired
inside the nforce2 chipset or is it external and thus board-dependent.  
Any way to get this clarified by the chipset's manufacturer?

> The clock skew is an interesting one, I think the clock uses tsc if available
> to interpolate between timer ints and if so should it not also be used to 
> validate the timer ints in case of noise? Apparently the clock speeds up not
> slows down in those cases?

 With real hardware perhaps it can be debugged.  The interaction between
the 8254, the 8259As and the APICs seems interesting in the chipset.  
Perhaps the override to INTIN2 is to tell the timer is really unavailable
directly?  I can't see a way to have an ACPI override that specifies an
ISA interrupt is not connected to the I/O APIC (unlike with the MPS).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
