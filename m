Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbTEOGYk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 02:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTEOGYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 02:24:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32196 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263869AbTEOGYj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 02:24:39 -0400
Message-ID: <3EC3359D.5050207@pobox.com>
Date: Thu, 15 May 2003 02:37:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: davej@codemonkey.org.uk
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: [PATCH] iphase fix.
References: <200305150417.h4F4HTRA025809@hera.kernel.org>
In-Reply-To: <200305150417.h4F4HTRA025809@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1127, 2003/05/14 20:44:02-07:00, davej@codemonkey.org.uk
> 
> 	[PATCH] iphase fix.
> 	
> 	This went into 2.4 nearly a year back with the wonderfully
> 	descriptive  "Fix from maintainer" comment.

> diff -Nru a/drivers/net/fc/iph5526.c b/drivers/net/fc/iph5526.c
> --- a/drivers/net/fc/iph5526.c	Wed May 14 21:17:37 2003
> +++ b/drivers/net/fc/iph5526.c	Wed May 14 21:17:37 2003
> @@ -2984,8 +2984,7 @@
>  	 */
>  	if ((type == ETH_P_ARP) || (status == 0))
>  		dev_kfree_skb(skb);
> -	else
> -		netif_wake_queue(dev);
> +	netif_wake_queue(dev);
>  	LEAVE("iph5526_send_packet");


This appears to revert a fix.

You only want to wake the queue if you have room to queue another skb.

	Jeff


