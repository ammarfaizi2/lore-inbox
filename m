Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262815AbULRCPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbULRCPK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 21:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbULRCPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 21:15:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61447 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262815AbULRCO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 21:14:59 -0500
Date: Sat, 18 Dec 2004 03:14:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: james4765@verizon.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] ip2: fix compile warnings
Message-ID: <20041218021457.GK21288@stusta.de>
References: <20041217214735.7127.91238.40236@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217214735.7127.91238.40236@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 03:47:13PM -0600, james4765@verizon.net wrote:

> This fixes the following compile errors in the ip2 and ip2main drivers:
> 
>   CC      drivers/char/ip2main.o
> drivers/char/ip2main.c:470: warning: initialization from incompatible pointer type
> drivers/char/ip2main.c: In function `ip2_tiocmget':
> drivers/char/ip2main.c:2004: warning: unused variable `wait'
> drivers/char/ip2/i2lib.c: At top level:
> drivers/char/ip2/i2cmd.c:142: warning: `ct89' defined but not used
> drivers/char/ip2main.c:205: warning: `set_modem_info' declared `static' but never defined
> drivers/char/ip2/i2ellis.c:108: warning: `iiEllisCleanup' defined but not used
>...

This are not errors - they are only warnings.
 
> --- linux-2.6.10-rc3-mm1-original/drivers/char/ip2main.c	2004-12-03 16:55:03.000000000 -0500
> +++ linux-2.6.10-rc3-mm1/drivers/char/ip2main.c	2004-12-17 16:24:24.094730049 -0500
>...
> @@ -2001,7 +2000,6 @@
>  static int ip2_tiocmget(struct tty_struct *tty, struct file *file)
>  {
>  	i2ChanStrPtr pCh = DevTable[tty->index];
> -	wait_queue_t wait;
>  
>  	if (pCh == NULL)
>  		return -ENODEV;
> @@ -2018,6 +2016,8 @@
>  		/\/\|=mhw=|\/\/			*/
>  
>  #ifdef	ENABLE_DSSNOW
> +	wait_queue_t wait;
> +
>  	i2QueueCommands(PTYPE_BYPASS, pCh, 100, 1, CMD_DSS_NOW);
>  
>  	init_waitqueue_entry(&wait, current);

If someone will ever define ENABLE_DSSNOW your change broke compilation 
with gcc 2.95 (variable declaration mixed with code).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

