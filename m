Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267554AbUHEFoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267554AbUHEFoW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 01:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUHEFoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 01:44:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:58796 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267554AbUHEFoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 01:44:18 -0400
Subject: Re: [PATCH] add PCI ROMs to sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Martin Mares <mj@ucw.cz>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>
In-Reply-To: <20040805050556.9899.qmail@web14924.mail.yahoo.com>
References: <20040805050556.9899.qmail@web14924.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1091684486.9271.202.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 05 Aug 2004 15:41:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-05 at 15:05, Jon Smirl wrote:
> Version 10
> 
> implements an x86 quirk to record the boot video device. Is the
> PCI_ROM_SHADOW flag a safe define? Quirk records boot video device by
> looking at how the bridges route to the VGA device. It there some other
> way to tell which video card is the boot one? What if there is more
> than one VGA card on the PCI bus? I think the BIOS spec is to enable
> the one in the lowest slot number. Can someone who own multiple PCI
> video cards test this? I tested with one PCI, one AGP.
> 
> BenH, this should solve the problem of which video card owns the ROM
> copy at C000:0. For the boot device this code returns the shadow copy,
> else the real ROM on the card.

Looks ok for me. It would be nice though if the code returning the
shadow copy could be "hooked" by the driver, that way, the radeon
kernel driver can force-enable the ROM decoding... or do you want
to use pci quirks for that too ?

> I did the x86 quirk, what do the quirks on ia64, ppc, x86_64 need? Can
> they just copy the x86 one?

Probably... can't we have arch-independant quirks ? Especially with the
new quirk section stuff David just posted, we can have quirks pretty much
anywhere...

Ben.


