Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVAGB7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVAGB7i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVAGB7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:59:08 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:42765 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261211AbVAGB6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:58:36 -0500
Date: Fri, 7 Jan 2005 02:58:28 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][3/4] let's kill verify_area - convert kernel/compat.c to access_ok()
Message-ID: <20050107015828.GA4396@pclin040.win.tue.nl>
References: <Pine.LNX.4.61.0501070155050.3430@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501070155050.3430@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 02:18:44AM +0100, Jesper Juhl wrote:

> Here's a patch to convert verify_area to access_ok in kernel/compat.c
> 
> diff -up linux-2.6.10-bk9-orig/kernel/compat.c linux-2.6.10-bk9/kernel/compat.c
> --- linux-2.6.10-bk9-orig/kernel/compat.c	2005-01-06 22:19:13.000000000 +0100
> +++ linux-2.6.10-bk9/kernel/compat.c	2005-01-07 02:06:00.000000000 +0100
> @@ -26,16 +26,16 @@
>  
>  int get_compat_timespec(struct timespec *ts, const struct compat_timespec __user *cts)
>  {
> -	return (verify_area(VERIFY_READ, cts, sizeof(*cts)) ||
> +	return (access_ok(VERIFY_READ, cts, sizeof(*cts)) ||
>  			__get_user(ts->tv_sec, &cts->tv_sec) ||
> -			__get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
> +			__get_user(ts->tv_nsec, &cts->tv_nsec)) ? 0 : -EFAULT;
>  }

This is not an equivalent transformation.
