Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUHUXnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUHUXnL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 19:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUHUXnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 19:43:11 -0400
Received: from main.gmane.org ([80.91.224.249]:58282 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261239AbUHUXnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 19:43:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH] make swsusp produce nicer screen output
Date: Sun, 22 Aug 2004 01:42:46 +0200
Message-ID: <4127DDF6.2030500@suse.de>
References: <20040820152317.GA7118@linux.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: erik@rigtorp.com
X-Gmane-NNTP-Posting-Host: c3b3c4c9.dial.de.easynet.net
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
In-Reply-To: <20040820152317.GA7118@linux.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Erik Rigtorp wrote:
> Hi!
> 
> I made a small patch that makes swsusp produce a bit nicer screen output,
> it's still a little rough though.

generally not a bad idea, but....

> diff -Nru linux-2.6.8.1-mm2/kernel/power/swsusp.c linux-2.6.8.1-mm2-erkki/kernel/power/swsusp.c
> --- linux-2.6.8.1-mm2/kernel/power/swsusp.c	2004-08-20 17:10:58.000000000 +0200
> +++ linux-2.6.8.1-mm2-erkki/kernel/power/swsusp.c	2004-08-20 16:13:29.000000000 +0200
> @@ -296,15 +296,16 @@
>  {
>  	int error = 0;
>  	int i;
> -
> -	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
> +	int mod = nr_copy_pages / 100;
> +	
> +	printk( "Writing data to swap (%d pages):     ", nr_copy_pages );
>  	for (i = 0; i < nr_copy_pages && !error; i++) {
> -		if (!(i%100))
> -			printk( "." );
> +		if (!(i%mod))
> +			printk( "\b\b\b\b%3d%%", i / mod );

what will happen here if nr_copy_pages < 100?

>  		error = write_page((pagedir_nosave+i)->address,
>  					  &((pagedir_nosave+i)->swap_address));
>  	}
> -	printk(" %d Pages done.\n",i);
> +	printk("\b\b\b\bdone\n");
>  	return error;
>  }
>  
> @@ -1150,14 +1151,15 @@
>  	struct pbe * p;
>  	int error;
>  	int i;
> -
> +	int mod = nr_copy_pages / 100;
> +	
>  	if ((error = swsusp_pagedir_relocate()))
>  		return error;
>  
> -	printk( "Reading image data (%d pages): ", nr_copy_pages );
> +	printk( "Reading image data (%d pages):     ", nr_copy_pages );
>  	for(i = 0, p = pagedir_nosave; i < nr_copy_pages && !error; i++, p++) {
> -		if (!(i%100))
> -			printk( "." );
> +		if (!(i%mod))
> +			printk( "\b\b\b\b%3d%%", i / mod );

...and here...

>  		error = bio_read_page(swp_offset(p->swap_address),
>  				  (void *)p->address);
>  	}

  Stefan

