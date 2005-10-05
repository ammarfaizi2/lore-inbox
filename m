Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbVJEGek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVJEGek (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 02:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbVJEGek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 02:34:40 -0400
Received: from pop.gmx.net ([213.165.64.20]:36539 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932552AbVJEGek convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 02:34:40 -0400
X-Authenticated: #9962044
From: Marc <marvin24@gmx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: clock skew on B/W G3
Date: Wed, 5 Oct 2005 08:34:35 +0200
User-Agent: KMail/1.8.2
Cc: Rune Torgersen <runet@innovsys.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
References: <DCEAAC0833DD314AB0B58112AD99B93B859476@ismail.innsys.innovsys.com> <200510040814.07188.marvin24@gmx.de> <1128464094.6417.31.camel@gaston>
In-Reply-To: <1128464094.6417.31.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510050834.35493.marvin24@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ben, 

Le Mittwoch 05 Oktober 2005 00:14, Benjamin Herrenschmidt a écrit :
> The problem is indeed in via_calibrate_decr(). This routine works on
> HZ/100 so it will not do any good with HZ not beeing a multiple of 100.
>
> Can you test this patch ?

I can confirm that this patch solves the timer skew on my mac.

Thanks!

>
> Index: linux-work/arch/ppc/platforms/pmac_time.c
> ===================================================================
> --- linux-work.orig/arch/ppc/platforms/pmac_time.c	2005-09-22
> 14:06:18.000000000 +1000 +++
> linux-work/arch/ppc/platforms/pmac_time.c	2005-10-05 08:14:17.000000000
> +1000 @@ -195,7 +195,7 @@
>  		;
>  	dend = get_dec();
>
> -	tb_ticks_per_jiffy = (dstart - dend) / (6 * (HZ/100));
> +	tb_ticks_per_jiffy = (dstart - dend) / ((6 * HZ)/100);
>  	tb_to_us = mulhwu_scale_factor(dstart - dend, 60000);
>
>  	printk(KERN_INFO "via_calibrate_decr: ticks per jiffy = %u (%u ticks)\n",
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
