Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbTHaVPB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 17:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbTHaVPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 17:15:01 -0400
Received: from [212.18.235.100] ([212.18.235.100]:25737 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S262680AbTHaVO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 17:14:59 -0400
Subject: Re: [PATCH] 2.6.0-test4 - Watchdog patches
From: Justin Cormack <justin@street-vision.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: torvalds@osdl.org, Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030831225236.A6938@infomag.infomag.iguana.be>
References: <20030831225236.A6938@infomag.infomag.iguana.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 31 Aug 2003 22:15:09 +0100
Message-Id: <1062364509.30543.155.camel@lotte.street-vision.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-31 at 21:52, Wim Van Sebroeck wrote: 
 = 0;
>  
>  /*
>   *	You must set these - there is no sane way to probe for this board.
> @@ -56,10 +56,17 @@
>   *      to restart it again.
>   */
>  
> -#define WDT_START 0x443
> -#define WDT_STOP 0x843
> -
> -static int wd_margin = WD_TIMO;
> +static int wdt_stop = 0x843;
> +module_param(wdt_stop, int, 0);
> +MODULE_PARM_DESC(wdt_stop, "Wafer 5823 WDT 'stop' io port (default 0x843)");
> +
> +static int wdt_start = 0x443;
> +module_param(wdt_start, int, 0);
> +MODULE_PARM_DESC(wdt_start, "Wafer 5823 WDT 'start' io port (default 0x443)");

There is *no point* making these module parameters. There is no other
watchdog that works in exactly the same way but using different io
ports. If there was this still wouldnt be the sensible way to do it. 

> +	if (timeout < 1 || timeout > 63) {
> +		timeout = WD_TIMO;
> +		printk (KERN_INFO PFX "timeout value must be 1<=x<=255, using %d\n",
> +			timeout);

where did that 63 come from? should be 255.

Also, generally, please cc authors when you send patches. And making the comments the
same in the watchdog drivers is a complete  waste of time. If you want to reduce
the amount of duplicated code in the drivers you could make a watchdog_ops interface
for almost all of them.

Justin


