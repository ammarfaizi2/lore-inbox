Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWF1S0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWF1S0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWF1S0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:26:19 -0400
Received: from smtp4.poczta.interia.pl ([80.48.65.7]:15722 "EHLO
	smtp4.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1750836AbWF1S0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:26:18 -0400
Message-ID: <44A2C9A7.6060703@interia.pl>
Date: Wed, 28 Jun 2006 20:25:43 +0200
From: =?ISO-8859-2?Q?Rafa=B3_Bilski?= <rafalbilski@interia.pl>
User-Agent: Thunderbird 1.5.0.4 (X11/20060628)
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA from Longhaul
 by rw semaphores
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
X-EMID: c4262acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You mean the longhaul driver can change the frequency of the PCI
> bus?  Oh, that's a recipe for disaster... 

No. Sorry. My English is bad. I mean changing CPU frequency.

> No, it's a hack :)

Again :-)

> No, this is not acceptable.  What exactly do you want to do here?  Make
> sure the PCI drivers are not doing DMA when the longhaul driver wants to
> change the pci bus speed? 

I'm trying not to break DMA. Current version of longhaul (marked broken 
in 2.6.16.2) simply clears bus master bit on every device.

> Does it really save battery?

Yes. And CPU temperature is lower.

> And what about PCI devices that always do DMA?  (think USB controllers,
> they can easily saturate the PCI bus all the time). 

This is worst for SATA. USB (this is strange) seems to work correcly.
I know that this is 10% coverage, but it is better then nothing.
It is always possible to add support for longhaul to driver.

> Why not just suspend all PCI devices make the bus change, and then
> resume them?  That would require no PCI core, or driver changes.

This was my first idea. But trust me in current kernel this is simply
worst idea.

> greg k-h

> Though currently in the driver, voltage scaling is missing,
> so we never save any power, and just run at the maximum voltage 
> the whole time.

I added this to longhaul, but it only works on non EBGA CPU's.
EBGA CPU's (at least Nehemiah) seem to have voltage scaling
disabled.

> It needs there to be no bus mastering occuring at the time
> of a CPU speed transition. Though I'm unable to find the part that mentions
> this in the specs I have right now.

> Dave

"Once this is set, the processor will switch to the
value in [26:23] on the next AUTOHALT transition. The duration of the AUTOHALT
should be >=1ms to ensure the CPU's internal PLL is resynchronized. For 
AUTOHALT, this means interrupts must be disabled except for the time tick, 
which should be reset to >=1ms. Care must be taken to avoid other system events 
that could interfere with this operation. A few examples are snooping, NMI, 
INIT, SMI and FLUSH."

For CPU's with Longhaul MSR this time is equal to 200us.

Rafa³


----------------------------------------------------------------------
PS. Fajny portal... >>> http://link.interia.pl/f196a

