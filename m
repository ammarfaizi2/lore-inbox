Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263936AbUDQL2E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 07:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUDQL2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 07:28:03 -0400
Received: from ozlabs.org ([203.10.76.45]:33729 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263936AbUDQL17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 07:27:59 -0400
Date: Sat, 17 Apr 2004 21:25:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dave Jones <davej@redhat.com>, jgarzik@pobox.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: orinoco potentially dereferencing before check
Message-ID: <20040417112549.GA32444@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Dave Jones <davej@redhat.com>, jgarzik@pobox.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040416211826.GN20937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416211826.GN20937@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 10:18:26PM +0100, Dave Jones wrote:
> 
> +++ linux-2.6.5/drivers/net/wireless/orinoco_pci.c	2004-04-16 22:17:30.000000000 +0100
> @@ -275,14 +275,16 @@
>  static void __devexit orinoco_pci_remove_one(struct pci_dev *pdev)
>  {
>  	struct net_device *dev = pci_get_drvdata(pdev);
> -	struct orinoco_private *priv = dev->priv;
> +	struct orinoco_private *priv;
>  
>  	if (! dev)
>  		BUG();
>  
> +	priv = dev->priv;
> +
>  	unregister_netdev(dev);
>  
> -        if (dev->irq)
> +	if (dev->irq)
>  		free_irq(dev->irq, dev);
>  
>  	if (priv->hw.iobase)
> -

Better to just remove the if (! dev) BUG().  I don't believe we've
ever hit that particular BUG() in debugging, so there's probably not
much point having it.

It's already gone in the driver's development tree.  Which hasn't been
merged to Linus for months and months and should have been, yes, I
know.  Unfortunately I have barely any time or energy for maintaining
the orinoco driver these days.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
