Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbVIVTMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVIVTMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVIVTMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:12:23 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:54971 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1750942AbVIVTMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:12:23 -0400
Date: Thu, 22 Sep 2005 15:14:19 -0400
From: Bob Picco <bob.picco@hp.com>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Bob Picco <robert.picco@hp.com>
Subject: Re: [PATCH 1/2] HPET: disallow zero interrupt frequency
Message-ID: <20050922191419.GF16066@localhost.localdomain>
References: <20050922150832.21412.18884.balrog@ifiu24.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922150832.21412.18884.balrog@ifiu24.informatik.uni-halle.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Ladisch wrote:	[Thu Sep 22 2005, 11:08:32AM EDT]
> Trying to set an interrupt frequency of zero would result in a
> division by zero, so disallow this.
> 
> Enabling the interrupt when the frequency hasn't yet been set would
> use an interrupt period of minimum length, so disallow this, too.
> 
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
> 
> --- linux-2.6.13.orig/drivers/char/hpet.c	2005-09-22 10:56:23.000000000 +0200
> +++ linux-2.6.13/drivers/char/hpet.c	2005-09-22 10:56:26.000000000 +0200
> @@ -365,6 +365,9 @@ static int hpet_ioctl_ieon(struct hpet_d
>  	hpet = devp->hd_hpet;
>  	hpetp = devp->hd_hpets;
>  
> +	if (!devp->hd_ireqfreq)
> +		return -EIO;
> +
>  	v = readq(&timer->hpet_config);
>  	spin_lock_irq(&hpet_lock);
>  
> @@ -517,7 +520,7 @@ hpet_ioctl_common(struct hpet_dev *devp,
>  			break;
>  		}
>  
> -		if (arg & (arg - 1)) {
> +		if (arg < 1 || (arg & (arg - 1))) {
Well it seems like what you want is:
		if (!arg || (arg & (arg - 1))) {
>  			err = -EINVAL;
>  			break;
>  		}
> -

BTW, it will be a day or two before I can review your other patch.

thanks,

bob
