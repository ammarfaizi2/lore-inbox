Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbTHSV64 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTHSV6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:58:10 -0400
Received: from web14908.mail.yahoo.com ([216.136.225.60]:5809 "HELO
	web14908.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261322AbTHSVyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:54:54 -0400
Message-ID: <20030819215452.69093.qmail@web14908.mail.yahoo.com>
Date: Tue, 19 Aug 2003 14:54:52 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Standard driver call to enable/disable PCI ROM
To: Russell King <rmk@arm.linux.org.uk>, "David S. Miller" <davem@redhat.com>
Cc: jonsmirl@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030819223203.I23670@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Russell King <rmk@arm.linux.org.uk> wrote:
> On Tue, Aug 19, 2003 at 02:17:35PM -0700, David S. Miller wrote:
> > On Tue, 19 Aug 2003 21:52:46 +0100
> > Russell King <rmk@arm.linux.org.uk> wrote:
> > >                 new |= res->flags & PCI_ROM_ADDRESS_ENABLE;
> > >                 reg = dev->rom_base_reg;
> > 
> > A word of caution, please do not enable PCI ROMs lightly.
> > 
> > There are many devices which stop responding to MEM and IO
> > space once their ROM is enabled, Qlogic-ISP chips are one
> > such device and there are several others.

I'm doing this in the device driver for the device, so I know it is ok to do.

> However, there are device drivers which want to access the ROM for
> whatever reason, and we should provide a standard way to allow
> drivers to enable / disable ROM access for architecture portability
> reasons (so that VGA drivers can find tables in their ROMs for
> instance.)

In my case I need access to tables in the ROM.

> Since this is critical to some devices, maybe their drivers should
> consider ensuring that the ROM resources are disabled upon driver
> initialisation of the device?

My driver can be load/unloaded so I need to turn the ROM on each
time to get to the tables. I also don't like calling release_resource()
directly from my driver since that looks like an internal PCI driver call.

As to pcibios_resource_to_bus()....

I called pci_assign_resource() which calls pci_update_resource() 
which calls pcibios_resource_to_bus().

I see now that pci_assign_resource() will return with the ROM 
enabled. I believe I have also hit cases where ROM was assigned
an address but not enabled. Do I still need to call 
pcibios_resource_to_bus() if I am just enabling the ROM?

Do I need to call pcibios_resource_to_bus() when disabling the ROM?


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
