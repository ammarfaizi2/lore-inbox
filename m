Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVFTWzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVFTWzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVFTWsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:48:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64128 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262307AbVFTWKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:10:53 -0400
Date: Tue, 21 Jun 2005 00:10:41 +0200
From: Pavel Machek <pavel@suse.cz>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] kernel/power/disk.c string fix and if-less iterator
Message-ID: <20050620221041.GI2222@elf.ucw.cz>
References: <20050620215712.840835000@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620215712.840835000@nd47.coderock.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The attached patch:
> 
> o  Fixes kernel/power/disk.c string declared as 'char *p = "...";' to be
>    declared as 'char p[] = "...";', as pointed by Jeff Garzik.

? Why was char *p ... wrong? Because you could not do sizeof() later?

> o  Replaces:
> 	i++:
> 	if (i > 3) i = 0;
> 
>    By:
> 	i = (i + 1) % (sizeof(p) - 1);
> 
>    Which is if-less, and the adjust value is evaluated by the compiler in
>    compile-time in case the string related to this loop is modified.

Well, why not...
								Pavel

> Index: quilt/kernel/power/disk.c
> ===================================================================
> --- quilt.orig/kernel/power/disk.c
> +++ quilt/kernel/power/disk.c
> @@ -91,15 +91,13 @@ static void free_some_memory(void)
>  	unsigned int i = 0;
>  	unsigned int tmp;
>  	unsigned long pages = 0;
> -	char *p = "-\\|/";
> +	char p[] = "-\\|/";
>  
>  	printk("Freeing memory...  ");
>  	while ((tmp = shrink_all_memory(10000))) {
>  		pages += tmp;
>  		printk("\b%c", p[i]);
> -		i++;
> -		if (i > 3)
> -			i = 0;
> +		i = (i + 1) % (sizeof(p) - 1);
>  	}
>  	printk("\bdone (%li pages freed)\n", pages);
>  }

-- 
teflon -- maybe it is a trademark, but it should not be.
