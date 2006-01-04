Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWADR6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWADR6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWADR6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:58:12 -0500
Received: from hera.kernel.org ([140.211.167.34]:6318 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030242AbWADR6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:58:11 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] ipw2200: Fix NETDEV_TX_BUSY erroneous returned
Date: Wed, 4 Jan 2006 09:58:00 -0800
Organization: OSDL
Message-ID: <20060104095800.7c71ef98@dxpl.pdx.osdl.net>
References: <20060104040954.GA19618@mail.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1136397481 25804 10.8.0.74 (4 Jan 2006 17:58:01 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 4 Jan 2006 17:58:01 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006 12:09:54 +0800
Zhu Yi <yi.zhu@intel.com> wrote:

> 
> This patch fixes the warning below warning for the ipw2200 driver.
> 
>   NETDEV_TX_BUSY returned; driver should report queue full via
>   ieee_device->is_queue_full.
> 
> Signed-off-by: Hong Liu <hong.liu@intel.com>
> Signed-off-by: Zhu Yi <yi.zhu@intel.com>
> --
> 
> diff -urp linux.orig/drivers/net/wireless/ipw2200.c linux/drivers/net/wireless/ipw2200.c
> --- linux.orig/drivers/net/wireless/ipw2200.c	2005-10-21 05:35:24.000000000 +0800
> +++ linux/drivers/net/wireless/ipw2200.c	2005-10-25 13:22:38.000000000
> +0800
> @@ -9649,11 +9649,6 @@ static inline int ipw_tx_skb(struct ipw_
>  	u16 remaining_bytes;
>  	int fc;
>  
> -	/* If there isn't room in the queue, we return busy and let the
> -	 * network stack requeue the packet for us */
> -	if (ipw_queue_space(q) < q->high_mark)
> -		return NETDEV_TX_BUSY;
> -
>  	switch (priv->ieee->iw_mode) {
>  	case IW_MODE_ADHOC:
>  		hdr_len = IEEE80211_3ADDR_LEN;
> @@ -9871,7 +9866,7 @@ static int ipw_net_hard_start_xmit(struc
>  
>        fail_unlock:
>  	spin_unlock_irqrestore(&priv->lock, flags);
> -	return 1;
> +	return -1;

That's not right... -1 is NETDEV_TX_LOCKED, which is not what you want.
Also, please use NETDEV_TX_ values for return values from transmit routine.

You should post this to netdev@vger.kernel.org and ipw2100-devel@lists.sourceforge.net
for discussion there.
-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
