Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752044AbWCIXf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbWCIXf4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbWCIXf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:35:56 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:16434 "EHLO
	stargate.chelsio.com") by vger.kernel.org with ESMTP
	id S1752044AbWCIXfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:35:55 -0500
Message-ID: <4410BB81.4050803@chelsio.com>
Date: Thu, 09 Mar 2006 15:34:25 -0800
From: Scott Bardone <sbardone@chelsio.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: maintainers@chelsio.com, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] chelsio/espi.c:tricn_init(): remove dead code
References: <20060309230653.GK21864@stusta.de>
In-Reply-To: <20060309230653.GK21864@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Mar 2006 23:34:44.0074 (UTC) FILETIME=[0B704CA0:01C643D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is correct, these two variables are unused in this driver. Thanks for 
catching this!

Signed-off-by: Scott Bardone <sbardone@chelsio.com>

Adrian Bunk wrote:
> The Coverity checker spotted these two unused variables.
> 
> Please check whether this patch is correct or whether they should be 
> used.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/net/chelsio/espi.c |   14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> --- linux-2.6.16-rc5-mm3-full/drivers/net/chelsio/espi.c.old	2006-03-09 23:19:54.000000000 +0100
> +++ linux-2.6.16-rc5-mm3-full/drivers/net/chelsio/espi.c	2006-03-09 23:20:35.000000000 +0100
> @@ -87,15 +87,9 @@
>  static int tricn_init(adapter_t *adapter)
>  {
>  	int     i               = 0;
> -	int     sme             = 1;
>  	int     stat            = 0;
>  	int     timeout         = 0;
>  	int     is_ready        = 0;
> -	int     dynamic_deskew  = 0;
> -
> -	if (dynamic_deskew)
> -		sme = 0;
> -
>  
>  	/* 1 */
>  	timeout=1000;
> @@ -113,11 +107,9 @@
>  	}
>  
>  	/* 2 */
> -	if (sme) {
> -		tricn_write(adapter, 0, 0, 0, TRICN_CNFG, 0x81);
> -		tricn_write(adapter, 0, 1, 0, TRICN_CNFG, 0x81);
> -		tricn_write(adapter, 0, 2, 0, TRICN_CNFG, 0x81);
> -	}
> +	tricn_write(adapter, 0, 0, 0, TRICN_CNFG, 0x81);
> +	tricn_write(adapter, 0, 1, 0, TRICN_CNFG, 0x81);
> +	tricn_write(adapter, 0, 2, 0, TRICN_CNFG, 0x81);
>  	for (i=1; i<= 8; i++) tricn_write(adapter, 0, 0, i, TRICN_CNFG, 0xf1);
>  	for (i=1; i<= 2; i++) tricn_write(adapter, 0, 1, i, TRICN_CNFG, 0xf1);
>  	for (i=1; i<= 3; i++) tricn_write(adapter, 0, 2, i, TRICN_CNFG, 0xe1);
> 
