Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266952AbTGKWZx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 18:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266994AbTGKWZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 18:25:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40710 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266952AbTGKWZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 18:25:52 -0400
Date: Fri, 11 Jul 2003 23:40:33 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: axnet can unload with timers live
Message-ID: <20030711234033.H23713@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <200307111805.h6BI5kxD017236@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307111805.h6BI5kxD017236@hraefn.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Jul 11, 2003 at 07:05:46PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 07:05:46PM +0100, Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/drivers/net/pcmcia/axnet_cs.c linux-2.5.75-ac1/drivers/net/pcmcia/axnet_cs.c
> --- linux-2.5.75/drivers/net/pcmcia/axnet_cs.c	2003-07-10 21:10:53.000000000 +0100
> +++ linux-2.5.75-ac1/drivers/net/pcmcia/axnet_cs.c	2003-07-11 15:21:39.000000000 +0100
> @@ -258,7 +258,7 @@
>      if (*linkp == NULL)
>  	return;
>  
> -    del_timer(&link->release);
> +    del_timer_sync(&link->release);
>      if (link->state & DEV_CONFIG) {
>  	axnet_release((u_long)link);
>  	if (link->state & DEV_STALE_CONFIG) {
> @@ -706,7 +706,7 @@
>      
>      link->open--;
>      netif_stop_queue(dev);
> -    del_timer(&info->watchdog);
> +    del_timer_sync(&info->watchdog);
>      if (link->state & DEV_STALE_CONFIG)
>  	mod_timer(&link->release, jiffies + HZ/20);

The pcmcia release timers actually want killing off.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

