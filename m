Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVFUISB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVFUISB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVFUIRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:17:08 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:8841 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261990AbVFUHdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 03:33:05 -0400
Date: Tue, 21 Jun 2005 09:33:07 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: domen@coderock.org
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] kernel/power/disk.c string fix and if-less iterator
Message-ID: <20050621073307.GE27887@wohnheim.fh-wedel.de>
References: <20050620215712.840835000@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050620215712.840835000@nd47.coderock.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 June 2005 23:57:13 +0200, domen@coderock.org wrote:
> 
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

Isn't "-\\|/" NUL-terminated and hence 5 characters long?  In that
case, you patch may do funny things.

Jörn

-- 
I've never met a human being who would want to read 17,000 pages of
documentation, and if there was, I'd kill him to get him out of the
gene pool.
-- Joseph Costello
