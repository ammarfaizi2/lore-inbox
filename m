Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbTJXQ7F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 12:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbTJXQ7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 12:59:05 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:52096 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262412AbTJXQ7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 12:59:02 -0400
Date: Fri, 24 Oct 2003 18:57:18 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jon Smirl <jonsmirl@yahoo.com>,
       Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
Message-ID: <20031024165718.GA4972@vana.vc.cvut.cz>
References: <3F987E18.9080606@pobox.com> <Pine.LNX.4.44.0310240931090.6051-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310240931090.6051-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 at 09:44:38AM -0700, Linus Torvalds wrote:
> 
> On Thu, 23 Oct 2003, Jeff Garzik wrote:
> 
> >       /* Assign space for ROM resource if not already assigned. Ugly. */
> >       if (!pci_resource_start(dev, PCI_ROM_RESOURCE))
> >               if (pci_assign_resource(dev, PCI_ROM_RESOURCE) < 0)
> >                       return -ENOMEM;
> > 
> >       /* Enable it. This is too ugly */
> >       if (!(pci_resource_flags(dev, PCI_ROM_RESOURCE) & PCI_ROM_ADDRESS_ENABLE)) {
> >               u32 val;
> >               pci_read_config_dword(dev, PCI_ROM_ADDRESS, &val);
> >               val |= PCI_ROM_ADDRESS_ENABLE;
> >               pci_write_config_dword(dev, PCI_ROM_ADDRESS, val);
> >               pci_resource_flags(dev, PCI_ROM_RESOURCE) |= PCI_ROM_ADDRESS_ENABLE;
> >       }
> 
> over and over again _is_ going to cause us problems later. Either we'll
> change some interface slightly (and have to fix up the drivers), or a

We need something more sophisticated. Matrox's hardware has bits
31-16 readable/writable only if bit 0 is set to 1 (ROM enabled; you can
(obviously) set bits 31-16 & 0 in one write). When ROM is disabled, 
bits 31-1 are always read as 0.

> So wouldn't it be nice if we just had those ten lines as a generic
> function like
> 
> 	int pci_enable_rom(struct pci_device *dev)
> 	{
> 		...
> 
> 	int pci_disable_rom(..);

It would be nice if it works... For matrox hardware I have to map ROM
over framebuffer (it is solution recommended by datasheet), as there is
no way to get memory range allocated for ROM unless ROM was left enabled
all the time.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz
