Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWIABCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWIABCK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWIABCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:02:10 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:3801
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932323AbWIABCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:02:08 -0400
Message-ID: <44F78687.7080805@microgate.com>
Date: Thu, 31 Aug 2006 20:01:59 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Sesterhenn <snakebyte@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Uninitialized variable in drivers/net/wan/syncppp.c
References: <1157066002.13592.3.camel@alice>	 <1157067913.2634.3.camel@localhost.localdomain> <1157070362.14246.2.camel@alice>
In-Reply-To: <1157070362.14246.2.camel@alice>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sesterhenn wrote:
> Thanks for clarification. Here is an updated patch, which has the advantage
> of also silencing the gcc warning.
> 
> For len equal to 4, we never call sppp_lcp_conf_parse_options(),
> therefore rmagic does not get initialized.
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 
> --- linux-2.6.18-rc5/drivers/net/wan/syncppp.c.orig	2006-09-01 02:16:18.000000000 +0200
> +++ linux-2.6.18-rc5/drivers/net/wan/syncppp.c	2006-09-01 02:16:40.000000000 +0200
> @@ -469,7 +469,7 @@ static void sppp_lcp_input (struct sppp 
>  	struct net_device *dev = sp->pp_if;
>  	int len = skb->len;
>  	u8 *p, opt[6];
> -	u32 rmagic;
> +	u32 rmagic = 0;
>  
>  	if (!pskb_may_pull(skb, sizeof(struct lcp_header))) {
>  		if (sp->pp_flags & PP_DEBUG)

Acked-by: Paul Fulghum <paulkf@microgate.com>

