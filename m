Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWADX45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWADX45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWADX45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:56:57 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:6083 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750783AbWADX44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:56:56 -0500
Date: Thu, 5 Jan 2006 00:52:47 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Zhu Yi <yi.zhu@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, jketreno@linux.intel.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] ipw2200: Fix NETDEV_TX_BUSY erroneous returned
Message-ID: <20060104235247.GA8137@electric-eye.fr.zoreil.com>
References: <20060104040954.GA19618@mail.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104040954.GA19618@mail.intel.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhu Yi <yi.zhu@intel.com> :
> 
> This patch fixes the warning below warning for the ipw2200 driver.
> 
>   NETDEV_TX_BUSY returned; driver should report queue full via
>   ieee_device->is_queue_full.

Beyond what was said by Stephen Hemminger, the driver reports a
NETDEV_TX_BUSY when !STATUS_ASSOCIATED: neither this patch nor mine
fix it. 

Btw the patch that I posted earlier forgets to protect against 
every undue wake-up through:

ipw_rx
-> ipw_rx_notification
   -> priv->link_up (work_queue)
      -> ipw_bg_link_up
         -> ipw_link_up

It will need some extra care to correctly play the
netif_{stop/wake}_queue dance.

--
Ueimor
