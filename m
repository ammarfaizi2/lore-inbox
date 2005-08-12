Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVHLPhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVHLPhN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 11:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVHLPhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 11:37:13 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:20667 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751198AbVHLPhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 11:37:12 -0400
Date: Fri, 12 Aug 2005 19:37:05 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] kernel spams syslog every 10 sec with w1 debug
Message-ID: <20050812153704.GA17148@2ka.mipt.ru>
References: <20050812150748.GA6774@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20050812150748.GA6774@suse.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 12 Aug 2005 19:37:05 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 05:07:48PM +0200, Olaf Hering (olh@suse.de) wrote:
> 
> Bug 104020 - kernel spams syslog every 10 sec with: w1_driver w1_bus_master1: No devices present on the wire.
> 
> After installing 10.0 B1, I found this in my syslog: 
> Aug 10 23:40:06 linux kernel: w1_driver w1_bus_master1: No devices present on the wire. 
> Aug 10 23:40:16 linux kernel: w1_driver w1_bus_master1: No devices present on the wire. 
> 
> Signed-off-by: Olaf Hering <olh@suse.de>
> 
>  drivers/w1/w1.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.13-rc6-aes/drivers/w1/w1.c
> ===================================================================
> --- linux-2.6.13-rc6-aes.orig/drivers/w1/w1.c
> +++ linux-2.6.13-rc6-aes/drivers/w1/w1.c
> @@ -593,7 +593,8 @@ void w1_search(struct w1_master *dev, w1
>  		 * Return 0 - device(s) present, 1 - no devices present.
>  		 */
>  		if (w1_reset_bus(dev)) {
> -			dev_info(&dev->dev, "No devices present on the wire.\n");
> +			if (printk_ratelimit())
> +				dev_debug(&dev->dev, "No devices present on the wire.\n");
>  			break;
>  		}

I would even just replace it with dev_dbg(),
since default 10 seconds timeout is more than printk_ratelimit_jiffies.
I will add such a patch into w1 queue.

Thank you.

-- 
	Evgeniy Polyakov
