Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVA0Q3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVA0Q3H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVA0Q3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:29:06 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:20954 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262491AbVA0Q3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:29:02 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Date: Thu, 27 Jan 2005 08:28:43 -0800
User-Agent: KMail/1.7.2
Cc: Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
References: <9e47339105011719436a9e5038@mail.gmail.com> <20050125042459.GA32697@kroah.com> <9e473391050127015970e1fedc@mail.gmail.com>
In-Reply-To: <9e473391050127015970e1fedc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501270828.43879.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 27, 2005 1:59 am, Jon Smirl wrote:
> Another item I need to add is generating an initial hotplug event for
> each secondary card. This event has to happen even if there is a card
> specific driver loaded. The event will be used to run the reset
> program needed by secondary cards.

Makes sense, having hotplug events would be nice.  I've got a standalone bios 
emulator (based on the X int10 library) that I hope to open source soon, we 
could use that as a starting piont for the reset app.

+static void vga_enable(struct pci_dev *pdev, unsigned int enable)
...
+ outb(~0x01 & inb(0x3C3),  0x3C3);
+ outb(~0x08 & inb(0x46e8), 0x46e8);
+ outb(~0x01 & inb(0x102),  0x102);
+ pdev->resource[PCI_ROM_RESOURCE].flags &= ~IORESOURCE_VGA_ACTIVE;
+ if (pdev == vga_active)
+  vga_active = NULL;
+ bridge_no(pdev);

Those ins and outs won't work on all platforms unless they have a base address 
(assigned by arch code) associated with them.  But then again, I suppose if a 
platform supports more than one legacy I/O space, it also supports multiple 
active VGAs, so maybe this enable/disable code isn't needed for them...

Jesse

