Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWCKECE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWCKECE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 23:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWCKECE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 23:02:04 -0500
Received: from xenotime.net ([66.160.160.81]:22428 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932401AbWCKECC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 23:02:02 -0500
Date: Fri, 10 Mar 2006 20:03:50 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: tim@cyberelk.net, linux-parport@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/block/paride/pd.c: fix an off-by-one
Message-Id: <20060310200350.11127467.rdunlap@xenotime.net>
In-Reply-To: <20060311034253.GI21864@stusta.de>
References: <20060311034253.GI21864@stusta.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2006 04:42:53 +0100 Adrian Bunk wrote:

> The Coverity checker found this off-by-one error.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.16-rc5-mm3-full/drivers/block/paride/pd.c.old	2006-03-11 02:07:21.000000000 +0100
> +++ linux-2.6.16-rc5-mm3-full/drivers/block/paride/pd.c	2006-03-11 02:07:50.000000000 +0100
> @@ -275,7 +275,7 @@
>  	int i;
>  
>  	printk("%s: %s: status = 0x%x =", disk->name, msg, status);
> -	for (i = 0; i < 18; i++)
> +	for (i = 0; i < 17; i++)
>  		if (status & (1 << i))
>  			printk(" %s", pd_errs[i]);
>  	printk("\n");

Please use ARRAY_SIZE(pd_errs)
and #include <linux/kernel.h>

---
~Randy
Please use an email client that implements proper (compliant) threading.
(You know who you are.)
