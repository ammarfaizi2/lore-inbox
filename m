Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVJYUqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVJYUqQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 16:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbVJYUqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 16:46:15 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:12484 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932372AbVJYUqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 16:46:15 -0400
Subject: Re: [PATCH 6 of 6] tpm: move infineon driver off pci_dev
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Matthieu CASTET <castet.matthieu@free.fr>
Cc: linux-kernel@vger.kernel.org, Marcel Selhorst <selhorst@crypto.rub.de>,
       akpm@osdl.org
In-Reply-To: <pan.2005.10.25.20.17.26.57688@free.fr>
References: <1130253738.4839.65.camel@localhost.localdomain>
	 <pan.2005.10.25.20.17.26.57688@free.fr>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Oct 2005 15:46:43 -0500
Message-Id: <1130273203.4839.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthieu,

Thanks for the comments.  I mistakenly generated this patch which
overwrote some of the changes that Marcel had submitted.  I am working
on going back to the pnp names and I'll additionally take these comments
into consideration.  Please hold off on applying this patch.

Thanks,
Kylie

On Tue, 2005-10-25 at 22:17 +0200, Matthieu CASTET wrote:
> Hi,
> 
> nice to see that the tpm framework was cleanned.
> 
> Le Tue, 25 Oct 2005 10:22:18 -0500, Kylene Jo Hall a écrit :
> 
> > ---
> > 
> > --- linux-2.6.14-rc4/drivers/char/tpm/tpm_infineon.c	2005-10-19 17:03:52.000000000 -0500
> > +++ linux-2.6.13-tpm/drivers/char/tpm/tpm_infineon.c	2005-10-21 13:07:24.000000000 -0500
> > @@ -14,6 +14,7 @@
> >   * License.
> >   */
> >  
> > +#include <acpi/acpi_bus.h>
> Why is it needed ?
> 
> 
> 
> > -/* These values will be filled after PnP-call */
> > +/* These values will be filled after ACPI-call */
> Why not keep PnP ?
> 
> 
> > -MODULE_DEVICE_TABLE(pnp, tpm_pnp_tbl);
> >  
> Why removing that ?
> This will allow hotplug and udev to auto load the module.
> 
> 
> > +
> > +	/* read IO-ports from ACPI */
> > +	TPM_INF_ADDR = (pnp_port_start(dev, 0) & 0xff);
> > +	TPM_INF_DATA = ((TPM_INF_ADDR + 1) & 0xff);
> No need to set mask, this is already done by pnp_port_start.
> And I'll keep PNP instead of ACPI.
> 
> 
> > +	tpm_inf.base = pnp_port_start(dev, 1);
> Can't you be coherent ?
> why not using tpm_inf.addr
> or TPM_INF_BASE ?
> 
> 
> 
> > +	dev_info(&dev->dev, "Found %s with ID %s\n",
> > +		 dev->name, dev_id->id);
> > +	if (!((tpm_inf.base >> 8) & 0xff))
> > +		tpm_inf.base = 0;
> >  
> >  	/* Make sure, we have received valid config ports */
> You should also do :
> pnp_port_flags(device, 0) & IORESOURCE_DISABLED) in order to check the
> resources.
> 
> 
> > +	.probe = tpm_inf_acpi_probe,
> > +	.remove = tpm_inf_remove,
> Not coherent : acpi vs nothing.
> Again prefer pnp instead of acpi.
> 
> 
> Matthieu
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

