Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVGEVcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVGEVcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVGEVcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:32:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16556 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261949AbVGEVWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:22:08 -0400
Date: Tue, 5 Jul 2005 14:20:59 -0700
From: Chris Wright <chrisw@osdl.org>
To: Alexander Nyberg <alexn@telia.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: [stable] Re: If ACPI doesn't find an irq listed, don't accept 0 as a valid PCI irq.
Message-ID: <20050705212059.GR9046@shell0.pdx.osdl.net>
References: <200507021908.j62J8m4D009707@hera.kernel.org> <1120462115.1172.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120462115.1172.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexander Nyberg (alexn@telia.com) wrote:
> > tree e6a38b3d6bf434f08054562113bb660c4227769f
> > parent 4a89a04f1ee21a7c1f4413f1ad7dcfac50ff9b63
> > author Linus Torvalds <torvalds@g5.osdl.org> Sun, 03 Jul 2005 00:35:33 -0700
> > committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 03 Jul 2005 00:35:33 -0700
> > 
> > If ACPI doesn't find an irq listed, don't accept 0 as a valid PCI irq.
> > 
> > That zero just means that nothing else found any irq information either.
> > 
> >  drivers/acpi/pci_irq.c |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> > --- a/drivers/acpi/pci_irq.c
> > +++ b/drivers/acpi/pci_irq.c
> > @@ -433,7 +433,7 @@ acpi_pci_irq_enable (
> >  		printk(KERN_WARNING PREFIX "PCI Interrupt %s[%c]: no GSI",
> >  			pci_name(dev), ('A' + pin));
> >  		/* Interrupt Line values above 0xF are forbidden */
> > -		if (dev->irq >= 0 && (dev->irq <= 0xF)) {
> > +		if (dev->irq > 0 && (dev->irq <= 0xF)) {
> >  			printk(" - using IRQ %d\n", dev->irq);
> >  			acpi_register_gsi(dev->irq, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
> >  			return_VALUE(0);
> 
> Could this go into stable please? I've got it confirmed it fixes:
> http://bugme.osdl.org/show_bug.cgi?id=4824
> 
> Which was introduced in -stable 2.6.12.2.

Thanks Alex, I've had bug reports from this one too (which that patch
does fix).  PCI irq routing is so damn touchy and easy to break, I rather
hate mucking with it in -stable.  But, unless Linus sees a reason not
to include this one, it does appear to fix real problems.

thanks,
-chris
