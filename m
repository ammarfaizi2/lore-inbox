Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbWEYV41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbWEYV41 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbWEYV41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:56:27 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:57476
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1030449AbWEYV40
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:56:26 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 2/3] pci: bcm43xx kill pci_find_device
Date: Thu, 25 May 2006 23:55:35 +0200
User-Agent: KMail/1.9.1
References: <20060525003040.A91E0C7BDC@atrey.karlin.mff.cuni.cz> <4474FE3E.9040303@garzik.org>
In-Reply-To: <4474FE3E.9040303@garzik.org>
Cc: Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Netdev List <netdev@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605252355.36453.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 May 2006 02:45, you wrote:
> Jiri Slaby wrote:
> > bcm43xx kill pci_find_device
> > 
> > Change pci_find_device to safer pci_get_device.
> > 
> > Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> > 
> > ---
> > commit 75664d3c6fe1d8d00b87e42cc001cb5d90613dae
> > tree ebcec31955a991f1661197c7e8bcdd682e030681
> > parent 431ef31d431939bc9370f952d9510ab9e5b0ad47
> > author Jiri Slaby <ku@bellona.localdomain> Thu, 25 May 2006 02:04:38 +0159
> > committer Jiri Slaby <ku@bellona.localdomain> Thu, 25 May 2006 02:04:38 +0159
> > 
> >  drivers/net/wireless/bcm43xx/bcm43xx_main.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_main.c b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> > index b488f77..f770f59 100644
> > --- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> > +++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> > @@ -2142,9 +2142,10 @@ #ifdef CONFIG_BCM947XX
> >  	if (bcm->pci_dev->bus->number == 0) {
> >  		struct pci_dev *d = NULL;
> >  		/* FIXME: we will probably need more device IDs here... */
> > -		d = pci_find_device(PCI_VENDOR_ID_BROADCOM, 0x4324, NULL);
> > +		d = pci_get_device(PCI_VENDOR_ID_BROADCOM, 0x4324, NULL);
> >  		if (d != NULL) {
> >  			bcm->irq = d->irq;
> > +			pci_dev_put(d);
> 
> Given the FIXME, if you are going to touch this area, it seems logical 
> to add a PCI device match table.

Yes, you may want to discuss that with the openwrt people, as this
code is only openwrt related.
