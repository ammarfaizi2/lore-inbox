Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318295AbSIOXOV>; Sun, 15 Sep 2002 19:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318299AbSIOXOV>; Sun, 15 Sep 2002 19:14:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46603 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318295AbSIOXOV>;
	Sun, 15 Sep 2002 19:14:21 -0400
Message-ID: <3D851556.7070203@mandrakesoft.com>
Date: Sun, 15 Sep 2002 19:18:46 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cranford <ac9410@attbi.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 9/9]Four new i2c drivers and __init/__exit cleanup to
 i2c
References: <Pine.LNX.4.44.0209151845330.7637-200000@home1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cranford wrote:
> --- linux/drivers/i2c/i2c-elektor.c.orig	2002-09-14 22:10:45.000000000 -0400
> +++ linux-2.5.34/drivers/i2c/i2c-elektor.c	2002-09-15 01:18:55.000000000 -0400
> @@ -125,12 +125,12 @@
>  	int timeout = 2;
>  
>  	if (irq > 0) {
> -		cli();
> +		local_irq_disable();
>  		if (pcf_pending == 0) {
>  			interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );
>  		} else
>  			pcf_pending = 0;
> -		sti();
> +		local_irq_enable();
>  	} else {
>  		udelay(100);
>  	}



this is _not_ the way to fix...   use a proper spinlock

