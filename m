Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267660AbUHEL4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267660AbUHEL4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 07:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267658AbUHEL4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:56:52 -0400
Received: from web14924.mail.yahoo.com ([216.136.225.8]:56491 "HELO
	web14924.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267662AbUHELxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:53:11 -0400
Message-ID: <20040805115306.71087.qmail@web14924.mail.yahoo.com>
Date: Thu, 5 Aug 2004 04:53:06 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Martin Mares <mj@ucw.cz>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>
In-Reply-To: <1091684486.9271.202.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> Looks ok for me. It would be nice though if the code returning the
> shadow copy could be "hooked" by the driver, that way, the radeon
> kernel driver can force-enable the ROM decoding... or do you want
> to use pci quirks for that too ?

My current plan is for the radeon driver to keep the code for enabling
the ROM. Otherwise we have to build all of the radeon PCI IDs somewhere
else into the kernel. In my system if you dump if without the driver
loaded it is FFFF, load the driver and you see it. First thing the
driver does is fix the ROM so that it is visible to the hotplug event.

> > I did the x86 quirk, what do the quirks on ia64, ppc, x86_64 need?
> Can
> > they just copy the x86 one?
> 
> Probably... can't we have arch-independant quirks ? Especially with
> the new quirk section stuff David just posted, we can have quirks
> pretty much anywhere...

But isn't this architecture specific? The Mac doesn't shadow ROMs at
0xC0000 does it? How does it shadow ROMs?

I may change the API a little today and expose a map/unmap ROM function
to make things easier for the driver to get the right copy. Adding
those calls will let me add a pci_map_rom_copy, which the driver can
use to trigger the copy for ROMs that aren't fully decoded.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - Helps protect you from nasty viruses.
http://promotions.yahoo.com/new_mail
