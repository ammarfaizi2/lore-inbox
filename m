Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWCNDMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWCNDMy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 22:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWCNDMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 22:12:53 -0500
Received: from fmr18.intel.com ([134.134.136.17]:55780 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932398AbWCNDMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 22:12:53 -0500
Subject: Re: [2.6 patch] drivers/net/wireless/ipw2200.c: fix an array overun
From: Zhu Yi <yi.zhu@intel.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: jketreno@linux.intel.com, netdev@vger.kernel.org, linville@tuxdriver.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060311034258.GJ21864@stusta.de>
References: <20060311034258.GJ21864@stusta.de>
Content-Type: text/plain
Organization: Intel Corp.
Date: Tue, 14 Mar 2006 11:05:36 +0800
Message-Id: <1142305536.2622.35.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-11 at 04:42 +0100, Adrian Bunk wrote:
> This patch fixes a big array overun found by the Coverity checker.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.16-rc5-mm3-full/drivers/net/wireless/ipw2200.c.old	2006-03-11 02:41:23.000000000 +0100
> +++ linux-2.6.16-rc5-mm3-full/drivers/net/wireless/ipw2200.c	2006-03-11 02:42:04.000000000 +0100
> @@ -9956,9 +9956,8 @@ static int ipw_ethtool_set_eeprom(struct
>  		return -EINVAL;
>  	mutex_lock(&p->mutex);
>  	memcpy(&p->eeprom[eeprom->offset], bytes, eeprom->len);
> -	for (i = IPW_EEPROM_DATA;
> -	     i < IPW_EEPROM_DATA + IPW_EEPROM_IMAGE_SIZE; i++)
> -		ipw_write8(p, i, p->eeprom[i]);
> +	for (i = 0; i < IPW_EEPROM_IMAGE_SIZE; i++)
> +		ipw_write8(p, i + IPW_EEPROM_DATA, p->eeprom[i]);
>  	mutex_unlock(&p->mutex);
>  	return 0;
>  }

Acked-by: Zhu Yi <yi.zhu@intel.com>

Thanks,
-yi

