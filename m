Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUGEPOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUGEPOR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 11:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266142AbUGEPOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 11:14:17 -0400
Received: from gprs214-220.eurotel.cz ([160.218.214.220]:37775 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266139AbUGEPN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 11:13:57 -0400
Date: Mon, 5 Jul 2004 17:13:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Erik Rigtorp <erik@rigtorp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/power/swsusp.c
Message-ID: <20040705151339.GA31824@elf.ucw.cz>
References: <20040703172843.GA7274@linux.nu> <20040703204647.GE31892@elf.ucw.cz> <20040704133715.GA4717@linux.nu> <20040704151848.GC8488@elf.ucw.cz> <20040705105421.GA8680@linux.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040705105421.GA8680@linux.nu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Sun, Jul 04, 2004 at 05:18:49PM +0200, Pavel Machek wrote:
> > Actually, this has several advantages -- you can actually see the
> > messages of the kernel during resume. And reading does logically
> > belong to the kernel doing boot, so it belongs on its screen, too...
> 
> Here's a clean patch that does just that.

Thanks. I applied equivalent patch to my tree, and it will eventually
propagate. This probably does not apply to latest -bk kernel. If it
does, you can send it to akpm and say that I approved it.

								Pavel

> diff -Nru linux-2.6.7/kernel/power/swsusp.c linux-2.6.7-pavel/kernel/power/swsusp.c
> --- linux-2.6.7/kernel/power/swsusp.c	2004-06-16 07:19:02.000000000 +0200
> +++ linux-2.6.7-pavel/kernel/power/swsusp.c	2004-07-04 15:15:25.000000000 +0200
> @@ -1190,9 +1190,6 @@
>  	}
>  	MDELAY(1000);
>  
> -	if (pm_prepare_console())
> -		printk("swsusp: Can't allocate a console... proceeding\n");
> -
>  	if (!resume_file[0] && resume_status == RESUME_SPECIFIED) {
>  		printk( "suspension device unspecified\n" );
>  		return -EINVAL;
> @@ -1201,12 +1198,15 @@
>  	printk( "resuming from %s\n", resume_file);
>  	if (read_suspend_image(resume_file, 0))
>  		goto read_failure;
> +
> +	if (pm_prepare_console())
> +		printk("swsusp: Can't allocate a console... proceeding\n");
> +
>  	device_suspend(4);
>  	do_magic(1);
>  	panic("This never returns");
>  
>  read_failure:
> -	pm_restore_console();
>  	return 0;
>  }
>  


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
