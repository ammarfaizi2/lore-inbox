Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267353AbSKPU2P>; Sat, 16 Nov 2002 15:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbSKPU2P>; Sat, 16 Nov 2002 15:28:15 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:10739 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267350AbSKPU2N>; Sat, 16 Nov 2002 15:28:13 -0500
Date: Sat, 16 Nov 2002 12:33:51 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       grundler@dsl2.external.hp.com, willy@debian.org
Subject: Re: [RFC][PATCH] move dma_mask into struct device
Message-ID: <20021116123351.A7537@eng2.beaverton.ibm.com>
References: <200211152034.gAFKYC404219@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200211152034.gAFKYC404219@localhost.localdomain>; from James.Bottomley@steeleye.com on Fri, Nov 15, 2002 at 03:34:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Nov 15, 2002 at 03:34:12PM -0500, J.E.J. Bottomley wrote:
> --- 1.36/drivers/scsi/hosts.h	Thu Nov 14 13:07:27 2002
> +++ edited/drivers/scsi/hosts.h	Fri Nov 15 14:43:59 2002
> @@ -468,10 +468,10 @@
>      unsigned int max_host_blocked;
>  
>      /*
> -     * For SCSI hosts which are PCI devices, set pci_dev so that
> -     * we can do BIOS EDD 3.0 mappings
> +     * This is a pointer to the generic device for this host (i.e. the
> +     * device on the bus);
>       */
> -    struct pci_dev *pci_dev;
> +    struct device *dev;
>  
>      /* 
>       * Support for driverfs filesystem
> @@ -521,11 +521,17 @@
>  	shost->host_lock = lock;
>  }
>  
> +static inline void scsi_set_device(struct Scsi_Host *shost,
> +                                   struct device *dev)
> +{
> +        shost->dev = dev;
> +        shost->host_driverfs_dev.parent = dev;
> +}
> +
>  static inline void scsi_set_pci_device(struct Scsi_Host *shost,
>                                         struct pci_dev *pdev)
>  {
> -	shost->pci_dev = pdev;
> -	shost->host_driverfs_dev.parent=&pdev->dev;
> +        scsi_set_device(shost, &pdev->dev);
>  }

Can shost->host_driverfs_dev.parent be used instead of adding and
using a duplicate shost->dev?

-- Patrick Mansfield
