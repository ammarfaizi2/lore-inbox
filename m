Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbWFVXW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWFVXW1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWFVXW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:22:27 -0400
Received: from xenotime.net ([66.160.160.81]:47514 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751045AbWFVXWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:22:25 -0400
Date: Thu, 22 Jun 2006 16:25:09 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: sergio@sergiomb.no-ip.org
Cc: kernel@agotnes.com, akpm@osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu,
       cw@f00f.org, vsu@altlinux.ru
Subject: Re: how I know if a interrupt is ioapic_edge_type or 
 ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:
 2.6.17-rc6-mm2 - USB issues]]
Message-Id: <20060622162509.c36aa336.rdunlap@xenotime.net>
In-Reply-To: <1151016398.3022.4.camel@localhost.portugal>
References: <44953B4B.9040108@agotnes.com>
	<4497DA3F.80302@agotnes.com>
	<20060620044003.4287426d.akpm@osdl.org>
	<4499245C.8040207@agotnes.com>
	<1150936606.2855.21.camel@localhost.portugal>
	<20060621174754.159bb1d0.rdunlap@xenotime.net>
	<1150938288.3221.2.camel@localhost.portugal>
	<20060621210817.74b6b2bc.rdunlap@xenotime.net>
	<1150977386.2859.34.camel@localhost.localdomain>
	<20060622142902.5c8f8e67.rdunlap@xenotime.net>
	<1151016398.3022.4.camel@localhost.portugal>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 23:46:38 +0100 Sergio Monteiro Basto wrote:

> On Thu, 2006-06-22 at 14:29 -0700, Randy.Dunlap wrote:
> > On Thu, 22 Jun 2006 12:56:25 +0100 Sergio Monteiro Basto wrote:
> > 
> > > On Wed, 2006-06-21 at 21:08 -0700, Randy.Dunlap wrote:
> > > > 
> > > > If you have a specific issue/problem, it would probably be
> > > > better just to focus on that. 
> > > 
> > > on linux-2.6.17/drivers/pci/quirks.c	
> > > 
> > >   * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
> > >   * interrupts delivered properly.
> > >   */
> > > 
> > >  static void quirk_via_irq(struct pci_dev *dev)
> > >  {
> > >  	u8 irq, new_irq;
> > > 
> > > I want here put something like:  if ( dev->irq != XT-PIC) return and don't quirk this dev.
> > >  	else 
> > 
> > I don't think the interrupt device mode is known by this code (AFAICT
> > with a quick look).  The function is only called for certain VIA chipsets.
> > 
> > Do you want the quirk for any particular hardware device?
> > You might be able to look at the function's <dev> parameter
> > to decide on using the quirk or not.
> > 
> > 
> > > 	new_irq = dev->irq & 0xf;
> > >  	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
> 
> yap, in my opinion this function should back to 

No idea about that.
I think that you still didn't answer my question, or maybe I
didn't ask it well enough.  What device are you having problems
with? I don't mean what chipset, I mean what device that you
touch...


> --- orig/drivers/pci/quirks.c	2006-06-21 20:25:41.000000000 +1000
> +++ linux-2.6.17-rc6-mm2/drivers/pci/quirks.c	2006-06-21 20:25:08.000000000 +1000
> @@ -662,13 +662,7 @@
>  		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
>  	}
>  }
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
>  
>  /*
>   * VIA VT82C598 has its device ID settable and many BIOSes
> 
> 
> But do you know or not ? how I know if dev->irq is XT-pic ? 

I don't see a way to know that currently.  It could be added
somehow if it's really required.  So far I haven't seen a full
problem description or requirement for this.

---
~Randy
