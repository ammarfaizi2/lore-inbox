Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVCYC6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVCYC6r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 21:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVCYC6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 21:58:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48281 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261321AbVCYC6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 21:58:42 -0500
Message-ID: <42437E53.5060708@pobox.com>
Date: Thu, 24 Mar 2005 21:58:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: tulip-users@lists.sourceforge.net, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/tulip/dmfe.c: fix check after use
References: <20050325010315.GL3966@stusta.de>
In-Reply-To: <20050325010315.GL3966@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch fixes a check after use found by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc1-mm1-full/drivers/net/tulip/dmfe.c.old	2005-03-23 05:05:36.000000000 +0100
> +++ linux-2.6.12-rc1-mm1-full/drivers/net/tulip/dmfe.c	2005-03-23 05:06:00.000000000 +0100
> @@ -736,20 +736,22 @@
>  
>  static irqreturn_t dmfe_interrupt(int irq, void *dev_id, struct pt_regs *regs)
>  {
>  	struct DEVICE *dev = dev_id;
>  	struct dmfe_board_info *db = netdev_priv(dev);
> -	unsigned long ioaddr = dev->base_addr;
> +	unsigned long ioaddr;
>  	unsigned long flags;
>  
>  	DMFE_DBUG(0, "dmfe_interrupt()", 0);
>  
>  	if (!dev) {
>  		DMFE_DBUG(1, "dmfe_interrupt() without DEVICE arg", 0);
>  		return IRQ_NONE;
>  	}

I would prefer to remove the "if (!dev)" test, since it shouldn't ever 
succeed.

	Jeff



