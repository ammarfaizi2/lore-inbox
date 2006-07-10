Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422687AbWGJUCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWGJUCV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 16:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbWGJUCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 16:02:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4616 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422687AbWGJUCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 16:02:20 -0400
Date: Mon, 10 Jul 2006 21:02:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Brian Walsh <brian@walsh.ws>
Cc: Deepak Sanexa <dsanexa@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc1 1/1] mtd/maps: ixp4xx partition parsing
Message-ID: <20060710200212.GA31761@flint.arm.linux.org.uk>
Mail-Followup-To: Brian Walsh <brian@walsh.ws>,
	Deepak Sanexa <dsanexa@mvista.com>, linux-kernel@vger.kernel.org
References: <44B2AFFB.2070507@walsh.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B2AFFB.2070507@walsh.ws>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 03:52:27PM -0400, Brian Walsh wrote:
> If the amount of flash is not divisible by 2 then the mask in
> parse_mtd_partitions would fail to work as designed.  Passing in the
> base address corrects this problem.

This patch is obviously buggy and untested.  "resouce" is a typo.

> diff -ur a/drivers/mtd/maps/ixp4xx.c b/drivers/mtd/maps/ixp4xx.c
> --- a/drivers/mtd/maps/ixp4xx.c 2006-06-17 21:49:35.000000000 -0400
> +++ b/drivers/mtd/maps/ixp4xx.c 2006-07-10 13:34:09.000000000 -0400
> @@ -253,7 +253,7 @@
>         /* Use the fast version */
>         info->map.write = ixp4xx_write16,
> 
> -       err = parse_mtd_partitions(info->mtd, probes, &info->partitions, 0);
> +       err = parse_mtd_partitions(info->mtd, probes, &info->partitions,
> dev->resouce->start);
>         if (err > 0) {
>                 err = add_mtd_partitions(info->mtd, info->partitions, err);
>                 if(err)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
