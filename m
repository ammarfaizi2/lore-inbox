Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWGVQe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWGVQe3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 12:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWGVQe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 12:34:29 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:2946 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750879AbWGVQe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 12:34:29 -0400
Message-ID: <44C25392.5000508@garzik.org>
Date: Sat, 22 Jul 2006 12:34:26 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Dave Airlie <airlied@linux.ie>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: remove pci domain local copy (02/07)
References: <11535827134076-git-send-email-airlied@linux.ie> <11535827133352-git-send-email-airlied@linux.ie> <11535827131612-git-send-email-airlied@linux.ie>
In-Reply-To: <11535827131612-git-send-email-airlied@linux.ie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:
> Just call a function to retrieve the pci domain, this isn't exactly
> hotpath code.
> 
> Signed-off-by: Dave Airlie <airlied@linux.ie>
> (cherry picked from 01852d755753bbfcd5434c55d4d7375580f8338f commit)
> ---
>  drivers/char/drm/drmP.h      |   10 +++++++++-
>  drivers/char/drm/drm_ioctl.c |    4 ++--
>  drivers/char/drm/drm_irq.c   |    2 +-
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
> index 5c8f245..4dd28e1 100644
> --- a/drivers/char/drm/drmP.h
> +++ b/drivers/char/drm/drmP.h
> @@ -711,7 +711,6 @@ typedef struct drm_device {
>  	drm_agp_head_t *agp;	/**< AGP data */
>  
>  	struct pci_dev *pdev;		/**< PCI device structure */
> -	int pci_domain;			/**< PCI bus domain number */
>  #ifdef __alpha__
>  	struct pci_controller *hose;
>  #endif
> @@ -733,6 +732,15 @@ static __inline__ int drm_core_check_fea

I would presume that hose goes away too?


> +static inline int drm_get_pci_domain(struct drm_device *dev)
> +{
> +#ifdef __alpha__
> +	return dev->hose->bus->number;
> +#else
> +	return 0;
> +#endif
> +}

Please use the always-present pci_domain_nr() rather than inventing a 
DRM-specific function that does the same thing.

	Jeff


