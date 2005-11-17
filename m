Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbVKQGEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVKQGEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 01:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVKQGEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 01:04:46 -0500
Received: from fmr18.intel.com ([134.134.136.17]:54223 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932481AbVKQGEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 01:04:45 -0500
Subject: Re: [PATCH] ipw2200: disallow direct scanning when device is down
	(was: Linuv 2.6.15-rc1)
From: Zhu Yi <yi.zhu@intel.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Zilvinas Valinskas <zilvinas@gemtek.lt>, Andrew Morton <akpm@osdl.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jketreno@linux.intel.com
In-Reply-To: <1132170906.7963.11.camel@localhost>
References: <20051115100519.GA5567@gemtek.lt>
	 <20051115115657.GA30489@gemtek.lt>
	 <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com>
	 <20051115140023.GB9910@gemtek.lt>
	 <1132120145.18679.12.camel@debian.sh.intel.com>
	 <20051116094551.GA23140@gemtek.lt> <20051116114052.GA14042@gemtek.lt>
	 <Pine.LNX.4.58.0511161415010.4402@sbz-30.cs.Helsinki.FI>
	 <20051116131505.GD31362@gemtek.lt> <1132158813.8902.6.camel@localhost>
	 <20051116181537.GA21709@gemtek.lt>  <1132170906.7963.11.camel@localhost>
Content-Type: text/plain
Organization: Intel Corp.
Date: Thu, 17 Nov 2005 13:59:04 +0800
Message-Id: <1132207144.30299.6.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 21:55 +0200, Pekka Enberg wrote:
> Yi, please consider applying the included patch.

The patch looks good to me. Thanks Pekka!

-yi

> [PATCH] ipw2200: disallow direct scanning when device is down
> 
> The function ipw_request_direct_scan() should bail out when the device
> is down. This patch fixes an lockup caused by wpa_supplicant
> triggering ipw_request_direct_scan() while the driver was in a middle
> of a reset due to firmware errors.
> 
> Thanks to Zilvinas Valinskas for reporting the bug and helping me
> debug it.
> 
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
> ---
> 
>  ipw2200.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> Index: 2.6/drivers/net/wireless/ipw2200.c
> ===================================================================
> --- 2.6.orig/drivers/net/wireless/ipw2200.c
> +++ 2.6/drivers/net/wireless/ipw2200.c
> @@ -8926,6 +8926,10 @@ static int ipw_request_direct_scan(struc
>  	struct ipw_scan_request_ext scan;
>  	int err = 0, scan_type;
>  
> +	if (!(priv->status & STATUS_INIT) ||
> +	    (priv->status & STATUS_EXIT_PENDING))
> +		return 0;
> +
>  	down(&priv->sem);
>  
>  	if (priv->status & STATUS_RF_KILL_MASK) {
> 

