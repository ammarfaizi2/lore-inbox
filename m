Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264541AbUGRWN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264541AbUGRWN1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 18:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUGRWN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 18:13:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46509 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264542AbUGRWNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 18:13:04 -0400
Date: Mon, 19 Jul 2004 00:13:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [6/25] Merge pmdisk and swsusp
Message-ID: <20040718221302.GC31958@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.50.0407171528280.22290-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0407171528280.22290-100000@monsoon.he.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - Move helpers calc_order(), alloc_pagedir(), alloc_image_pages(),
>   enough_free_mem(), and enough_swap() into swsusp.


> +/**
> + *	enough_free_mem - Make sure we enough free memory to snapshot.
> + *
> + *	Returns TRUE or FALSE after checking the number of available
> + *	free pages.
> + */
> +
> +static int enough_free_mem(void)
> +{
> +	if(nr_free_pages() < (nr_copy_pages + PAGES_FOR_IO)) {
> +		pr_debug("pmdisk: Not enough free pages: Have %d\n",
> +			 nr_free_pages());
> +		return 0;
> +	}
> +	return 1;
> +}

> +	if (!enough_free_mem())
> +		return -ENOMEM;
> +
> +	if (!enough_swap())
> +		return -ENOSPC;
> +
> +	if ((error = alloc_pagedir())) {
> +		pr_debug("suspend: Allocating pagedir failed.\n");
> +		return error;
> +	}

Perhaps enough_free_* should return 0 / -ERROR to keep it consistent
with rest of code, no need to explain TRUE/FALSE etc?

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
