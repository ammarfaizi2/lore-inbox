Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbVFWTPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVFWTPF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 15:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbVFWTPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 15:15:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23765 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262697AbVFWTKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 15:10:30 -0400
Date: Thu, 23 Jun 2005 21:11:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: SMP+irq handling broken in current git?
Message-ID: <20050623191146.GB6814@suse.de>
References: <20050623135318.GC9768@suse.de> <42BAEA67.7090606@pobox.com> <20050623184234.GE9768@suse.de> <200506231258.35258.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506231258.35258.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23 2005, Bjorn Helgaas wrote:
> On Thursday 23 June 2005 12:42 pm, Jens Axboe wrote:
> > On Thu, Jun 23 2005, Jeff Garzik wrote:
> > > Jens Axboe wrote:
> > > >Hi,
> > > >
> > > >Something strange is going on with current git as of this morning (head
> > > >ee98689be1b054897ff17655008c3048fe88be94). On an old test box (dual p3
> > > >800MHz), using the same old config I always do on this box has very
> > > >broken interrupt handling:
> > > 
> > > Does 2.6.12 work for you?
> > > 2.6.11?
> > 
> > 2.6.11 works, 2.6.12 does not.
> 
> Do you have any VIA devices?  If so, you might try the attached.
> (Just for debugging; if the patch helps, I have no idea how to
> do it correctly.)

No VIA devices, it's an intel board with intel chipset. Do you still
want me to test it?


> Index: work/drivers/pci/quirks.c
> ===================================================================
> --- work.orig/drivers/pci/quirks.c	2005-06-21 13:43:29.000000000 -0600
> +++ work/drivers/pci/quirks.c	2005-06-23 10:40:55.000000000 -0600
> @@ -510,7 +510,7 @@
>  		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
>  	}
>  }
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_via_irq);
>  
>  /*
>   * PIIX3 USB: We have to disable USB interrupts that are


-- 
Jens Axboe

