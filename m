Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVAPWXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVAPWXq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVAPWRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:17:38 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:45701 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262630AbVAPWPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:15:25 -0500
Subject: Re: [PATCH 4/13] ftape: remove cli()/sti() in
	drivers/char/ftape/lowlevel/ftape-io.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Nelson <james4765@cwazy.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitors@lists.osdl.org, akpm@osdl.org
In-Reply-To: <20050116135250.30109.31739.53624@localhost.localdomain>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
	 <20050116135250.30109.31739.53624@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105908349.12201.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 16 Jan 2005 21:11:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-16 at 13:52, James Nelson wrote:
> Signed-off-by: James Nelson <james4765@gmail.com>
> 
> diff -urN --exclude='*~' linux-2.6.11-rc1-mm1-original/drivers/char/ftape/lowlevel/ftape-io.c linux-2.6.11-rc1-mm1/drivers/char/ftape/lowlevel/ftape-io.c
> --- linux-2.6.11-rc1-mm1-original/drivers/char/ftape/lowlevel/ftape-io.c	2005-01-16 07:17:19.000000000 -0500
> +++ linux-2.6.11-rc1-mm1/drivers/char/ftape/lowlevel/ftape-io.c	2005-01-16 07:32:19.293557207 -0500
> @@ -95,15 +95,15 @@
>  
>  		TRACE(ft_t_any, "%d msec, %d ticks", time/1000, ticks);
>  		timeout = ticks;
> -		save_flags(flags);
> -		sti();
> +		local_save_flags(flags);
> +		local_irq_enable();
>  		msleep_interruptible(jiffies_to_msecs(timeout));

This doesn't deal with SMP - please reject

