Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTFKQXB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 12:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTFKQXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 12:23:01 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:54708 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262709AbTFKQWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 12:22:44 -0400
Date: Wed, 11 Jun 2003 09:38:38 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] And yet more PCI fixes for 2.5.70
Message-ID: <20030611163837.GA24951@kroah.com>
References: <1055290315109@kroah.com> <1055335057.2083.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055335057.2083.14.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 01:37:37PM +0100, Alan Cox wrote:
> On Mer, 2003-06-11 at 01:11, Greg KH wrote:
> >  			/* user supplied value */
> >  			system_bus_speed = idebus_parameter;
> > -		} else if (pci_present()) {
> > +		} else if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) != NULL) {
> 
> That is just gross. pci_present() is far more readable even if you make
> it an inline in pci.h that is pci_find_device(PCI_ANY_ID, PCI_ANY_ID,
> NULL)

Bartlomiej was actually the one who suggested this patch, I didn't do it
on my own :)

Anyway, there are only 2 places in the whole kernel that want a
pci_present() check, this place, and drivers/sbus/sbus.c.  sbus.c can
probably be changed to not need it at all, but I did it this way to be
safe.

So that leaves only this file.  Jeff Garzik and I talked about removing
pci_present() as it's not needed, and I think for this one case we can
live without it.  Do you want me to make the pci_present() macro earlier
in this file, so it's readable again?  I don't want to put it back into
pci.h.

thanks,

greg k-h
