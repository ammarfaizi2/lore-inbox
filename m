Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267914AbUHPTv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267914AbUHPTv5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 15:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267921AbUHPTv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 15:51:57 -0400
Received: from fmr11.intel.com ([192.55.52.31]:33184 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S267914AbUHPTve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 15:51:34 -0400
Subject: Re: eth*: transmit timed out since .27
From: Len Brown <len.brown@intel.com>
To: Oliver Feiler <kiza@gmx.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <41210649.4090008@gmx.net>
References: <566B962EB122634D86E6EE29E83DD808182C3236@hdsmsx403.hd.intel.com>
	 <1092678734.23057.18.camel@dhcppc4> <41210098.4080904@gmx.net>
	 <41210649.4090008@gmx.net>
Content-Type: text/plain
Organization: 
Message-Id: <1092685821.23066.39.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 16 Aug 2004 15:50:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 15:08, Oliver Feiler wrote:
> Oliver Feiler wrote:
> > 
> > 
> > Ok, I've turned on the IOAPIC and it seems to work perfectly fine. 
> > Except for that IRQ 255 thing I've noticed no oddities. Thanks for
> the 
> > hint. :)
> 
> No, not quite. After about 30 minutes of uptime and a moderate load of
> eth0 (100-200KB/s constant data flow) it happened again. :(
> 
> Aug 16 21:03:13 spot kernel: eth0: Tx timed out, lost interrupt? 
> TSR=0x3, ISR=0x97, t=36.
> Aug 16 21:03:15 spot kernel: eth0: Tx timed out, lost interrupt? 
> TSR=0x3, ISR=0x3, t=141.
> Aug 16 21:03:23 spot kernel: eth0: Tx timed out, lost interrupt? 
> TSR=0x3, ISR=0x3, t=545.
> [repeating endlessly]
> 
> I've booted a kernel without APIC and IOAPIC compiled and it works
> again.
> 
> I'm attaching a dmesg from a boot with IOAPIC enabled. I don't really 
> know where to look for the problem here. The interrupt counter for the
> IRQ eth0 is using (a Realtek 8029 chipset) is growing significantly 
> after a while. And after a while is seems to get stuck (Tx timed out).
> "ifconfig eth0 down" and "up" again did nothing. Sometimes it seems to
> fix such network problems.

You've got 3 ethernet controllers.

eth0: RealTek RTL-8029 found at 0xe800, IRQ 18, 00:00:E8:5C:2D:AA.
eth1: SiS 900 PCI Fast Ethernet at 0xec00, IRQ 17, 00:c0:ca:16:4c:b6.
eth2: VIA VT6102 Rhine-II at 0xd400, 00:0b:6a:2b:48:84, IRQ 23.

And eth0 is failing.
See if you can give its network cable and its IRQ to on of the other
devices and see if the error follows the load and the wires,
or stays with the device.

The quirks for this hardware look totally broken in IOAPIC mode:
PCI: Via IRQ fixup for 00:10.2, from 10 to 5
PCI: Via IRQ fixup for 00:10.1, from 10 to 5
PCI: Via IRQ fixup for 00:10.0, from 11 to 5
I have no idea if they're a nop or not, but you might exeriment with
disabling them.  Sure isn't obvious that something called
quirk_via_irqpic() should be running in IOAPIC mode.
I'd try disabling quirk_via_acpi() too.

cheers,
-Len

ps. to exchange IRQs, you'll need to physically exchange the slots
of the cards, easy enough unless eth0 is soldered onto the
motherboard;-)


