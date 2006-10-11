Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWJKFl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWJKFl6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 01:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWJKFl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 01:41:58 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:20484 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1030274AbWJKFl5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 01:41:57 -0400
Date: Wed, 11 Oct 2006 07:41:57 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: wingel@nano-system.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c/buses/scx200_acb: handle PCI errors
Message-Id: <20061011074157.9a7a3a5c.khali@linux-fr.org>
In-Reply-To: <20061010132206.GA9191@havoc.gtf.org>
References: <20061010132206.GA9191@havoc.gtf.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

>  drivers/i2c/busses/scx200_acb.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
> index 32aab0d..714bae7 100644
> --- a/drivers/i2c/busses/scx200_acb.c
> +++ b/drivers/i2c/busses/scx200_acb.c
> @@ -494,11 +494,12 @@ static __init int scx200_create_pci(cons
>  	iface->pdev = pdev;
>  	iface->bar = bar;
>  
> -	pci_enable_device_bars(iface->pdev, 1 << iface->bar);
> +	rc = pci_enable_device_bars(iface->pdev, 1 << iface->bar);
> +	if (rc)
> +		goto errout_free;
>  
>  	rc = pci_request_region(iface->pdev, iface->bar, iface->adapter.name);
> -
> -	if (rc != 0) {
> +	if (rc) {
>  		printk(KERN_ERR NAME ": can't allocate PCI BAR %d\n",
>  				iface->bar);
>  		goto errout_free;

Looks good, applied, thanks.

-- 
Jean Delvare
