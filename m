Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWJCDqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWJCDqA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 23:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWJCDqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 23:46:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20898 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932449AbWJCDp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 23:45:59 -0400
Subject: Re: [RFC PATCH] move aic7xxx to pci_request_irq
From: Arjan van de Ven <arjan@infradead.org>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
In-Reply-To: <20061002200703.GD3003@slug>
References: <1159550143.13029.36.camel@localhost.localdomain>
	 <20060929235054.GB2020@slug>
	 <1159573404.13029.96.camel@localhost.localdomain>
	 <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org>
	 <20061001142807.GD16272@parisc-linux.org>
	 <1159729523.2891.408.camel@laptopd505.fenrus.org>
	 <20061001193616.GF16272@parisc-linux.org>
	 <1159755141.2891.434.camel@laptopd505.fenrus.org>
	 <20061002200048.GC3003@slug>  <20061002200703.GD3003@slug>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 03 Oct 2006 05:45:05 +0200
Message-Id: <1159847105.2891.505.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 20:07 +0000, Frederik Deweerdt wrote:
> Hi,
> 
> This proof-of-concept patch converts the aic7xxx drivers to use the
> pci_request_irq() function.
> 
> Regards,
> Frederik
> 
> 
> diff --git a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
> index 2001fe8..c934f30 100644
> --- a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
> +++ b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
> @@ -341,12 +341,12 @@ ahd_pci_map_int(struct ahd_softc *ahd)
>  {
>  	int error;
>  
> -	error = request_irq(ahd->dev_softc->irq, ahd_linux_isr,
> -			    IRQF_SHARED, "aic79xx", ahd);
> +	error = pci_request_irq(ahd->dev_softc, ahd_linux_isr,
> +			    IRQF_SHARED, "aic79xx");
>  	if (!error)
>  		ahd->platform_data->irq = ahd->dev_softc->irq;
>  	
> -	return (-error);
> +	return error;
>  }

might as well kill this entire wrapper...


