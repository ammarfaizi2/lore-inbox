Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313025AbSDGKQT>; Sun, 7 Apr 2002 06:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313027AbSDGKQT>; Sun, 7 Apr 2002 06:16:19 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:33799 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S313025AbSDGKQS>;
	Sun, 7 Apr 2002 06:16:18 -0400
Date: Sun, 7 Apr 2002 06:16:16 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: WatchDog Driver Updates
In-Reply-To: <Pine.LNX.4.44.0204071114020.8253-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0204070614500.3791-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 7 Apr 2002, Zwane Mwaikambo wrote:

> static int sc1200wdt_release(struct inode *inode, struct file *file)
>  {
> -#ifndef CONFIG_WATCHDOG_NOWAYOUT
>  	if (expect_close) {
>  		sc1200wdt_write_data(WDTO, 0);
>  		printk(KERN_INFO PFX "Watchdog disabled\n");
> @@ -202,7 +197,6 @@
>  		sc1200wdt_write_data(WDTO, timeout);
>  		printk(KERN_CRIT PFX "Unexpected close!, timeout = %d
> min(s)\n", timeout);
>  	}
> -#endif
>
> hmm, that would allow closing of the watchdog even if
> CONFIG_WATCHDOG_NOWAYOUT is specified. Was this your intention?

No it doesn't because expect_close will never be set to anything but 0 if
CONFIG_WATCHDOG_NOWAYOUT is set.  So the if(expect_close) will never be
true.

Regards,
Rob Radez

