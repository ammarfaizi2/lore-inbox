Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVCBGXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVCBGXG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 01:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVCBGXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 01:23:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5061 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262197AbVCBGWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 01:22:54 -0500
Message-ID: <42255BB1.5000301@pobox.com>
Date: Wed, 02 Mar 2005 01:22:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: panagiotis.issaris@mech.kuleuven.ac.be
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Possible VIA-Rhine free irq issue
References: <20050228145032.B32550@lumumba.luc.ac.be>
In-Reply-To: <20050228145032.B32550@lumumba.luc.ac.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Issaris wrote:
> Hi,
> 
> It seems to me that in the VIA Rhine device driver the requested irq might
> not be freed in case the alloc_ring() function fails. alloc_ring()
> can fail with a ENOMEM return value because of possible
> pci_alloc_consistent() failures.
> 
> This patch applies to 2.6.11-rc5-bk2.
> 
> diff -uprN linux-2.6.11-rc5-bk2/drivers/net/via-rhine.c linux-2.6.11-rc5-bk2-pi/drivers/net/via-rhine.c
> --- linux-2.6.11-rc5-bk2/drivers/net/via-rhine.c	2005-02-28 13:44:37.000000000 +0100
> +++ linux-2.6.11-rc5-bk2-pi/drivers/net/via-rhine.c	2005-02-28 13:44:31.000000000 +0100
> @@ -1198,7 +1198,10 @@ static int rhine_open(struct net_device 
>  
>  	rc = alloc_ring(dev);
>  	if (rc)
> +	{
> +		free_irq(rp->pdev->irq, dev);
>  		return rc;
> +	}

Yes, this is a needed fix.  Thanks,

	Jeff



