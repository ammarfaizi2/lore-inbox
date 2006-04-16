Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWDPRs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWDPRs0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 13:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWDPRs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 13:48:26 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:54164 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750771AbWDPRsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 13:48:25 -0400
Message-ID: <44428368.2000703@foo-projects.org>
Date: Sun, 16 Apr 2006 10:48:24 -0700
From: Auke Kok <sofar@foo-projects.org>
User-Agent: Mail/News 1.5 (X11/20060331)
MIME-Version: 1.0
To: Willy TARREAU <willy@w.ods.org>
CC: jesse.brandeburg@intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, rol@as2917.net
Subject: Re: [PATCH-2.6] e1000: fix media_type <-> phy_type thinko
References: <20060415110025.GA6266@w.ods.org>
In-Reply-To: <20060415110025.GA6266@w.ods.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy TARREAU wrote:
> Recent patch cb764326dff0ee51aca0d450e1a292de65661055 introduced
> a thinko in e1000_main.c : e1000_media_type_copper is compared
> to hw.phy_type instead of hw.media_type. Original patch proposed
> by Jesse Brandeburg was correct, but what has been merged is not.

Indeed this seems like a mistake to me. I'll make sure this is checked 
tomorrow with Jeff Kirsher who submitted the original patch.

Auke Kok


> ---
> 
>  drivers/net/e1000/e1000_main.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 3df8a180d50c89a72c28abf37151e38ffda75f39
> diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
> index add8dc4..590a456 100644
> --- a/drivers/net/e1000/e1000_main.c
> +++ b/drivers/net/e1000/e1000_main.c
> @@ -4156,7 +4156,7 @@ e1000_mii_ioctl(struct net_device *netde
>  			spin_unlock_irqrestore(&adapter->stats_lock, flags);
>  			return -EIO;
>  		}
> -		if (adapter->hw.phy_type == e1000_media_type_copper) {
> +		if (adapter->hw.media_type == e1000_media_type_copper) {
>  			switch (data->reg_num) {
>  			case PHY_CTRL:
>  				if (mii_reg & MII_CR_POWER_DOWN)

