Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbUKQX5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbUKQX5l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbUKQXz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:55:57 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:49089 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262619AbUKQWEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:04:35 -0500
Date: Wed, 17 Nov 2004 14:04:23 -0800
From: Greg KH <greg@kroah.com>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PPC] Missing pci_dev_put in arch/ppc/platforms/chrp_pci.c ?
Message-ID: <20041117220423.GC1291@kroah.com>
References: <200411171329.51687@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411171329.51687@bilbo.math.uni-mannheim.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 01:29:51PM +0100, Rolf Eike Beer wrote:
> This is how it is:
> 
> chrp_pcibios_fixup(void)
> {
>         struct pci_dev *dev = NULL;
>         struct device_node *np;
> 
>         /* PCI interrupts are controlled by the OpenPIC */
>         for_each_pci_dev(dev) {
>                 np = pci_device_to_OF_node(dev);
>                 if ((np != 0) && (np->n_intrs > 0) && (np->intrs[0].line != 0))
>                         dev->irq = np->intrs[0].line;
>                 pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
>         }
> }
> 
> for_each_pci_dev is defined to use pci_get_device in include/linux/pci.h,
> which uses pci_dev_get. So every PCI devices use count will be incremented
> if chrp_pcibios_fixup is called. Do I miss something or should we add a
> pci_dev_put(dev) at the end of the loop?

You missed something :)

Read the docs for pci_get_device(), it will explain how the above code
is just fine.

BTW, this isn't the first time this very question has come up on lkml,
how come people never think to do a archive search...

thanks,

greg k-h
