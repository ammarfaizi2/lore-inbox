Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVAKTpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVAKTpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbVAKTpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:45:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59327 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262407AbVAKTmw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:42:52 -0500
Message-ID: <41E42C38.1090903@pobox.com>
Date: Tue, 11 Jan 2005 14:42:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: klassert@mathematik.tu-chemnitz.de, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x: support more ethtool_ops
References: <200501111913.j0BJDnIL009341@hera.kernel.org>
In-Reply-To: <200501111913.j0BJDnIL009341@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> +static void vortex_get_ethtool_stats(struct net_device *dev,
> +	struct ethtool_stats *stats, u64 *data)
> +{
> +	struct vortex_private *vp = netdev_priv(dev);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vp->lock, flags);
> +	update_stats(dev->base_addr, dev);
> +	spin_unlock_irqrestore(&vp->lock, flags);
> +
> +	data[0] = vp->stats.rx_packets;
> +	data[1] = vp->stats.tx_packets;
> +	data[2] = vp->stats.rx_bytes;
> +	data[3] = vp->stats.tx_bytes;
> +	data[4] = vp->stats.collisions;
> +	data[5] = vp->stats.tx_carrier_errors;
> +	data[6] = vp->stats.tx_heartbeat_errors;
> +	data[7] = vp->stats.tx_window_errors;
> +}

Everything in the patch is correct except for the above.

This is very wrong -- get_ethtool_stats() is for NIC-specific stats. 
The above stats are already available through the generic net stack.

	Jeff


