Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVALUPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVALUPO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVALULl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:11:41 -0500
Received: from coderock.org ([193.77.147.115]:13005 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261368AbVALUGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:06:23 -0500
Date: Wed, 12 Jan 2005 21:06:11 +0100
From: Domen Puncer <domen@coderock.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: more small fixes
Message-ID: <20050112200611.GM4978@nd47.coderock.org>
References: <20050112131010.GA1378@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112131010.GA1378@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/05 14:10 +0100, Pavel Machek wrote:
> Hi!
> 
> This adds few missing statics to swsusp.c, prints errors even when
> non-debugging and fixes last "pmdisk: " message. Fixed few comments. 
> Please apply,

Some nitpicking...
> 
> --- clean/kernel/power/swsusp.c	2005-01-12 11:07:40.000000000 +0100
> +++ linux/kernel/power/swsusp.c	2005-01-12 11:35:42.000000000 +0100
> @@ -420,7 +419,7 @@
>  	struct highmem_page *next;
>  };
>  
> -struct highmem_page *highmem_copy = NULL;
> +static struct highmem_page *highmem_copy = NULL;

You could remove explicit initialization (so pointer would go into bss
instead of data, IIRC).


> @@ -753,21 +753,21 @@
>  		return -ENOSPC;
>  
>  	if ((error = alloc_pagedir())) {
> -		pr_debug("suspend: Allocating pagedir failed.\n");
> +		printk("suspend: Allocating pagedir failed.\n");

Missing KERN_ constant.

>  		return error;
>  	}
>  	if ((error = alloc_image_pages())) {
> -		pr_debug("suspend: Allocating image pages failed.\n");
> +		printk("suspend: Allocating image pages failed.\n");

Same here.


	Domen
