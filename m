Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272333AbTHEA4B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 20:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272367AbTHEA4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 20:56:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:54496 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272333AbTHEAzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 20:55:47 -0400
Date: Mon, 4 Aug 2003 18:00:40 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] suspend.c cleanups
In-Reply-To: <20030726225809.GA528@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0308041758460.23977-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> These are only cleanups.
> 							Pavel
> 
> Index: linux/kernel/suspend.c
> ===================================================================
> --- linux.orig/kernel/suspend.c	2003-07-22 13:39:43.000000000 +0200
> +++ linux/kernel/suspend.c	2003-07-22 13:46:26.000000000 +0200
> @@ -139,40 +139,45 @@
>  
>  static const char name_suspend[] = "Suspend Machine: ";
>  static const char name_resume[] = "Resume Machine: ";
>  #endif
>  
>  /*
>   * Debug
>   */
> -#define	DEBUG_DEFAULT
> -#undef	DEBUG_PROCESS
> +#undef	DEBUG_DEFAULT
>  #undef	DEBUG_SLOW
> -#define TEST_SWSUSP 0		/* Set to 1 to reboot instead of halt machine after suspension */
> +#define TEST_SWSUSP 1		/* Set to 1 to reboot instead of halt machine after suspension */

This is not a cleanup, it changes behavior, so I didn't apply this first 
part (since I had to make the other changes by hand anyway). 

> @@ -283,17 +329,6 @@

This part was applied.

> @@ -906,7 +898,7 @@
>  		return;
>  
>  	software_suspend_enabled = 0;
> -	BUG_ON(in_interrupt());
> +	BUG_ON(in_atomic());
>  	do_software_suspend();
>  }

I replaced the BUG() with might_sleep(), since it will produce a stack 
trace, and is a bit friendlier. 

Thanks,


	-pat


