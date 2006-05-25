Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWEYApy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWEYApy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 20:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWEYApy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 20:45:54 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:2707 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964801AbWEYApx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 20:45:53 -0400
Message-ID: <4474FE3E.9040303@garzik.org>
Date: Wed, 24 May 2006 20:45:50 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: [PATCH 2/3] pci: bcm43xx kill pci_find_device
References: <20060525003040.A91E0C7BDC@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060525003040.A91E0C7BDC@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> bcm43xx kill pci_find_device
> 
> Change pci_find_device to safer pci_get_device.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> ---
> commit 75664d3c6fe1d8d00b87e42cc001cb5d90613dae
> tree ebcec31955a991f1661197c7e8bcdd682e030681
> parent 431ef31d431939bc9370f952d9510ab9e5b0ad47
> author Jiri Slaby <ku@bellona.localdomain> Thu, 25 May 2006 02:04:38 +0159
> committer Jiri Slaby <ku@bellona.localdomain> Thu, 25 May 2006 02:04:38 +0159
> 
>  drivers/net/wireless/bcm43xx/bcm43xx_main.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_main.c b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> index b488f77..f770f59 100644
> --- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> +++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> @@ -2142,9 +2142,10 @@ #ifdef CONFIG_BCM947XX
>  	if (bcm->pci_dev->bus->number == 0) {
>  		struct pci_dev *d = NULL;
>  		/* FIXME: we will probably need more device IDs here... */
> -		d = pci_find_device(PCI_VENDOR_ID_BROADCOM, 0x4324, NULL);
> +		d = pci_get_device(PCI_VENDOR_ID_BROADCOM, 0x4324, NULL);
>  		if (d != NULL) {
>  			bcm->irq = d->irq;
> +			pci_dev_put(d);

Given the FIXME, if you are going to touch this area, it seems logical 
to add a PCI device match table.

	Jeff


