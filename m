Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965280AbWJBS1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965280AbWJBS1r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965261AbWJBS1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:27:47 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:14280 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S965280AbWJBS1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:27:46 -0400
Date: Mon, 2 Oct 2006 12:27:44 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC PATCH] move aic7xxx to pci_request_irq
Message-ID: <20061002182744.GM16272@parisc-linux.org>
References: <20060929235054.GB2020@slug> <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org> <20061001142807.GD16272@parisc-linux.org> <1159729523.2891.408.camel@laptopd505.fenrus.org> <20061001193616.GF16272@parisc-linux.org> <1159755141.2891.434.camel@laptopd505.fenrus.org> <20061002200048.GC3003@slug> <20061002200703.GD3003@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002200703.GD3003@slug>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 08:07:03PM +0000, Frederik Deweerdt wrote:
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

Seems unsafe to me.  Unless you want to trace through the whole driver
changing its internal conventions to use negative errnos like the rest
of the kernel.

> -	
> -	return (-error);
> -}
>  
> +	return error;
> +}

Ditto.
