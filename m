Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbSLBFZF>; Mon, 2 Dec 2002 00:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbSLBFYv>; Mon, 2 Dec 2002 00:24:51 -0500
Received: from dp.samba.org ([66.70.73.150]:4509 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264934AbSLBFYi>;
	Mon, 2 Dec 2002 00:24:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Chris Wilson <chris@qwirx.com>
Cc: mikejc@us.ibm.com,
       Linux Kernel Janitors 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] create_proc_read_entry in arch/ppc/iSeries/rtc.c 
In-reply-to: Your message of "Mon, 18 Nov 2002 19:19:00 -0000."
             <Pine.LNX.4.44.0211181909260.15091-200000@top.qwarx.com> 
Date: Mon, 02 Dec 2002 15:47:35 +1100
Message-Id: <20021202053207.348322C340@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0211181909260.15091-200000@top.qwarx.com> you write:
>   This message is in MIME format.  The first part should be readable text,
>   while the remaining parts are likely unreadable without MIME-aware tools.
>   Send mail to mime@docserver.cac.washington.edu for more info.
> 
> ---1044231485-1031583466-1037559336=:16702
> Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
> Content-ID: <Pine.LNX.4.44.0211171855531.16702@top.qwarx.com>
> 
> Dear Sir,
> 
> As part of the Linux Kernel Janitors audit of misc_register usage, 
> I would like to submit my related patch to arch/ppc/iSeries/rtc.c.

> --- linux-2.5.47/arch/ppc/iSeries/rtc.c	Mon Nov 11 03:28:15 2002
> +++ linux-2.5.47-chris/arch/ppc/iSeries/rtc.c	Sun Nov 17 21:29:25 2002
>  static int __init rtc_init(void)
>  {
> -	if (misc_register(&rtc_dev))
> +	if (misc_register(&rtc_dev)) {
> +		printk(KERN_ERR "iSeries-rtc: cannot register misc device.\n");
>  		return -ENODEV;
> -	create_proc_read_entry ("driver/rtc", 0, 0, rtc_read_proc, NULL);
> +	}

But this cannot sanely fail (it cannot be a module).  It's probably
better to do something like inserting a check inside misc_register and
create_proc_read_entry:

	BUG_ON(booting && failed);

Maybe even create a "NOFAIL_ON_BOOT(condition)" which does this for
you.

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
