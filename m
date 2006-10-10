Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWJJQQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWJJQQF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWJJQQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:16:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:45106 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1030186AbWJJQQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:16:02 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,291,1157353200"; 
   d="scan'208"; a="2593067:sNHT22660659"
Message-ID: <452BC6C9.3050902@intel.com>
Date: Tue, 10 Oct 2006 09:14:01 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] ixgb: Delete IXGB_DBG() macro and call pr_debug() directly.
References: <Pine.LNX.4.64.0610100816440.7711@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0610100816440.7711@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2006 16:16:01.0753 (UTC) FILETIME=[60ED1C90:01C6EC87]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
> Delete the minimally-useful IXGB_DBG() macro and call pr_debug()
> directly from the main routine.
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> ---
> diff --git a/drivers/net/ixgb/ixgb.h b/drivers/net/ixgb/ixgb.h
> index 50ffe90..fb9fde5 100644
> --- a/drivers/net/ixgb/ixgb.h
> +++ b/drivers/net/ixgb/ixgb.h
> @@ -77,12 +77,6 @@ #include "ixgb_hw.h"
>  #include "ixgb_ee.h"
>  #include "ixgb_ids.h"
> 
> -#ifdef _DEBUG_DRIVER_
> -#define IXGB_DBG(args...) printk(KERN_DEBUG "ixgb: " args)
> -#else
> -#define IXGB_DBG(args...)
> -#endif
> -
>  #define PFX "ixgb: "
>  #define DPRINTK(nlevel, klevel, fmt, args...) \
>  	(void)((NETIF_MSG_##nlevel & adapter->msg_enable) && \
> diff --git a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
> index e09f575..eada685 100644
> --- a/drivers/net/ixgb/ixgb_main.c
> +++ b/drivers/net/ixgb/ixgb_main.c
> @@ -1948,7 +1948,7 @@ #endif
> 
>  			/* All receives must fit into a single buffer */
> 
> -			IXGB_DBG("Receive packet consumed multiple buffers "
> +			pr_debug("ixgb: Receive packet consumed multiple buffers "
>  					 "length<%x>\n", length);
> 
>  			dev_kfree_skb_irq(skb);
> 
> --
> 
>   all right ... what did i mess up *this* time?  :-)  it's good
> practice.  that's my story and i'm sticking to it.

We should really use dev_dbg() instead, as it retains the 'ethX:' annotation afaics.

I'll have to see what looks best and also handle e100 and e1000.

Thanks,

Auke
