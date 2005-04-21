Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVDUUvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVDUUvC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 16:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVDUUvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 16:51:02 -0400
Received: from [205.233.219.253] ([205.233.219.253]:39871 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S261873AbVDUUtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 16:49:19 -0400
Date: Thu, 21 Apr 2005 16:45:15 -0400
From: Jody McIntyre <scjody@steamballoon.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: bcollins@debian.org, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/ieee1394_transactions.c: possible cleanups
Message-ID: <20050421204515.GX1111@conscoop.ottawa.on.ca>
References: <20050419004523.GK5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419004523.GK5489@stusta.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 02:45:23AM +0200, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - #if 0 the following unused global functions:
>   - hpsb_lock
>   - hpsb_send_gasp
> - ieee1394_transactions.h: remove the stale hpsb_lock64 prototype

I also removed the EXPORT_SYMBOL of hpsb_lock, since we're not (yet?)
accepting your earlier patch.

Applied to our SVN and queued for 2.6.13.  Thanks.

Jody

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/ieee1394/ieee1394_transactions.c |    3 +++
>  drivers/ieee1394/ieee1394_transactions.h |    7 -------
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> --- linux-2.6.12-rc2-mm3-full/drivers/ieee1394/ieee1394_transactions.h.old	2005-04-19 00:24:13.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/drivers/ieee1394/ieee1394_transactions.h	2005-04-19 00:25:00.000000000 +0200
> @@ -53,12 +53,5 @@
>  	      u64 addr, quadlet_t *buffer, size_t length);
>  int hpsb_write(struct hpsb_host *host, nodeid_t node, unsigned int generation,
>  	       u64 addr, quadlet_t *buffer, size_t length);
> -int hpsb_lock(struct hpsb_host *host, nodeid_t node, unsigned int generation,
> -	      u64 addr, int extcode, quadlet_t *data, quadlet_t arg);
> -int hpsb_lock64(struct hpsb_host *host, nodeid_t node, unsigned int generation,
> -		u64 addr, int extcode, octlet_t *data, octlet_t arg);
> -int hpsb_send_gasp(struct hpsb_host *host, int channel, unsigned int generation,
> -                   quadlet_t *buffer, size_t length, u32 specifier_id,
> -                   unsigned int version);
>  
>  #endif /* _IEEE1394_TRANSACTIONS_H */
> --- linux-2.6.12-rc2-mm3-full/drivers/ieee1394/ieee1394_transactions.c.old	2005-04-19 00:24:31.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/drivers/ieee1394/ieee1394_transactions.c	2005-04-19 00:24:51.000000000 +0200
> @@ -535,6 +535,7 @@
>          return retval;
>  }
>  
> +#if 0
>  
>  int hpsb_lock(struct hpsb_host *host, nodeid_t node, unsigned int generation,
>  	      u64 addr, int extcode, quadlet_t *data, quadlet_t arg)
> @@ -599,3 +600,5 @@
>  
>  	return retval;
>  }
> +
> +#endif  /*  0  */
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: New Crystal Reports XI.
> Version 11 adds new functionality designed to reduce time involved in
> creating, integrating, and deploying reporting solutions. Free runtime info,
> new features, or free trial, at: http://www.businessobjects.com/devxi/728
> _______________________________________________
> mailing list linux1394-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux1394-devel

-- 
