Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965214AbVIVCid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbVIVCid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 22:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbVIVCid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 22:38:33 -0400
Received: from mail.dvmed.net ([216.237.124.58]:43431 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965214AbVIVCic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 22:38:32 -0400
Message-ID: <43321922.70707@pobox.com>
Date: Wed, 21 Sep 2005 22:38:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Florin Malita <fmalita@gmail.com>
CC: linux-kernel@vger.kernel.org, ctindel@users.sourceforge.net,
       fubar@us.ibm.com, "David S. Miller" <davem@davemloft.net>,
       netdev@vger.kernel.org
Subject: Re: [PATCH] bond_main.c: fix device deregistration in init exception
 path
References: <432D0612.7070408@gmail.com> <20050917233224.2d4b3652.akpm@osdl.org>
In-Reply-To: <20050917233224.2d4b3652.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> diff -puN drivers/net/bonding/bond_main.c~bond_mainc-fix-device-deregistration-in-init-exception drivers/net/bonding/bond_main.c
> --- devel/drivers/net/bonding/bond_main.c~bond_mainc-fix-device-deregistration-in-init-exception	2005-09-17 23:18:38.000000000 -0700
> +++ devel-akpm/drivers/net/bonding/bond_main.c	2005-09-17 23:31:02.000000000 -0700
> @@ -5039,6 +5039,14 @@ static int __init bonding_init(void)
>  	return 0;
>  
>  out_err:
> +	/*
> +	 * rtnl_unlock() will run netdev_run_todo(), putting the
> +	 * thus-far-registered bonding devices into a state which
> +	 * unregigister_netdevice() will accept
> +	 */
> +	rtnl_unlock();
> +	rtnl_lock();
> +


Don't we want a schedule() or schedule_timeout(1) in between?

	Jeff


