Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbVHVWna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbVHVWna (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbVHVWnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:43:23 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:21388 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751485AbVHVWnT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:43:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rXIqrg0VKqtDzEB/D7FPcLG9skGGD7VzFdy4Sm8TpyWsWPX+L7e79zkLW2bzcQ2O7TD658dHofekZ5ulNjRTkKg6teqFb9SktuzOfYj16rLTkzfyQNeWcNCJiRlUFTzj1vq1Yt4a7r8ZDbY4p0ViNAq6Xo24NRCIyNRsNp06lic=
Message-ID: <2cd57c900508212217c0465a3@mail.gmail.com>
Date: Mon, 22 Aug 2005 13:17:59 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH] make loglevels in init/main.c a little more sane.
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0501222229210.3073@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0501222229210.3073@dragon.hygekrogen.localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/05, Jesper Juhl <juhl-lkml@dif.dk> wrote:
> 
> This patch modifies a few of the printk() loglevels used in init/main.c in
> an attempt to make them a bit more appropriate.
> 
> The default loglevel is KERN_WARNING, but a few printk's without explicit
> loglevel are not (in my oppinion) warnings, so add proper warning levels -
> for instance; telling the user how many CPU's were brought up is hardly a
> warning, make it KERN_INFO instead. The initial printing of linux_banner
> is not a warning condition, I'd say it's more of a NOTICE or even INFO
> condition - I've made it KERN_NOTICE just as the printing of the kernel
> command line. A few printk's without explicit loglevel do match the
> default one, but I've made them explicit (the default could change in the
> future, and if it does then explicitly setting the proper loglevel is a
> nice thing).
> Please consider applying.
> 
> Patch compiles and boots fine on my box.
> 
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> diff -up linux-2.6.11-rc2-orig/init/main.c linux-2.6.11-rc2/init/main.c
> --- linux-2.6.11-rc2-orig/init/main.c   2005-01-22 22:00:02.000000000 +0100
> +++ linux-2.6.11-rc2/init/main.c        2005-01-22 22:45:23.000000000 +0100
> @@ -347,7 +347,7 @@ static void __init smp_init(void)
>         }
> 
>         /* Any cleanup work */
> -       printk("Brought up %ld CPUs\n", (long)num_online_cpus());
> +       printk(KERN_INFO "Brought up %ld CPUs\n", (long)num_online_cpus());
>         smp_cpus_done(max_cpus);
>  #if 0
>         /* Get other processors into their bootup holding patterns. */
> @@ -428,6 +428,7 @@ asmlinkage void __init start_kernel(void
>   */
>         lock_kernel();
>         page_address_init();
> +       printk(KERN_NOTICE);
>         printk(linux_banner);

Why not merge it to the same line?

>         setup_arch(&command_line);
>         setup_per_cpu_areas();

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
