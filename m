Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268680AbUI2QB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268680AbUI2QB3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 12:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268679AbUI2QB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 12:01:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10376 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268680AbUI2QBJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 12:01:09 -0400
Message-ID: <415ADC31.7080902@pobox.com>
Date: Wed, 29 Sep 2004 12:00:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Colin Leroy <colin@colino.net>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add polling support to Sungem
References: <20040929145721.6a489ed8@pirandello>
In-Reply-To: <20040929145721.6a489ed8@pirandello>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Leroy wrote:
> [sending again, forgot Cc:, sorry]
> 
> Hi Benjamin!
> 
> This patch adds polling support to Sungem ethernet card. It makes
> netconsole usable on iBook G4, for example.
> I hope it's fine.
> 
> Signed-off-by: Colin Leroy <colin@colino.net>
> 
> --- a/drivers/net/sungem.c	2004-09-29 12:22:41.802346664 +0200
> +++ b/drivers/net/sungem.c	2004-09-29 12:15:56.000000000 +0200
> @@ -2687,6 +2687,23 @@
>  }
>  #endif /* not Sparc and not PPC */
>  
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +/*
> + * Polling 'interrupt' - used by things like netconsole to send skbs
> + * without having to re-enable interrupts. It's not called while
> + * the interrupt routine is executing.
> + */
> +static void gem_netpoll(struct net_device *netdev)
> +{
> +	struct gem *gp = netdev->priv;
> +	if (!gp->pdev)
> +		return;
> +	disable_irq(gp->pdev->irq);
> +	gem_interrupt(gp->pdev->irq, netdev, NULL);
> +	enable_irq(gp->pdev->irq);
> +}
> +#endif

Check BK snapshots, this support is already in sungem.

	Jeff



