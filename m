Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263334AbUDMFI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 01:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbUDMFI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 01:08:56 -0400
Received: from fmr02.intel.com ([192.55.52.25]:30175 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263334AbUDMFIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 01:08:53 -0400
Subject: Re: IO-APIC on nforce2
From: Len Brown <len.brown@intel.com>
To: ross@datscreative.com.au
Cc: christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
In-Reply-To: <200404131117.31306.ross@datscreative.com.au>
References: <200404131117.31306.ross@datscreative.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1081832914.2253.623.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 13 Apr 2004 01:08:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-12 at 21:17, Ross Dickson wrote:

> I am working with 2.4.26-rc2 and have noticed a change with the the recent acpi?
> update. The recent fix to stop unnecessary ioapic irq routing entries puts the 
> following if statement into io_apic.c, io_apic_set_pci_routing()
> 
> 	/*
> 	 * IRQs < 16 are already in the irq_2_pin[] map
> 	 */
> 	if (irq >= 16)
> 		add_pin_to_irq(irq, ioapic, pin);
> 
> which prevents my io-apic patch from using that function to reprogram the
> io-apic pin on irq0 from pin2 to pin0. 
> 
> As a quick fix you could drop the "if (irq >= 16)".
> I don't know what harm if any that would do other than create unwanted
> irq mapping entries as in the past.

I made that change -- sorry I broke your patch.
No, I doubt it would matter if you hacked out "if (irq >=16)"
for the time being.

I haven't been following this thread closely, but
http://bugme.osdl.org/show_bug.cgi?id=1203 says I should;-)

I understand that these boards have the timer attached to pin0
in APIC mode, but that the BIOS says it is connected to pin2:

ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0]
trigger[0x0])

Wouldn't it be a simpler patch to recognize this board and simply
disable this bogus BIOS INT_SRC_OVR?

Also, what is the symptom of the XT-PIC timer?  Is it the source
of the nForce2 hangs, or something else?  The latest message
suggested that it caused a backround load on the system, but
I don't recall hearing that one on this thread before.

thanks,
-Len


