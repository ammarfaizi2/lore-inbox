Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTGFQRx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 12:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTGFQRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 12:17:53 -0400
Received: from dp.samba.org ([66.70.73.150]:46487 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262489AbTGFQRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 12:17:52 -0400
Date: Mon, 7 Jul 2003 02:31:37 +1000
From: Anton Blanchard <anton@samba.org>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix return of compat_sys_sched_getaffinity
Message-ID: <20030706163137.GK13308@krispykreme>
References: <20030706162400.GA15526@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030706162400.GA15526@rushmore>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -EFAULT return got buggered when compat_sys_sched_getaffinity
> was added in 2.5.68.

but getaffinity returns sizeof(compat_ulong_t) on success...

Anton

> --- linux-2.5.74/kernel/compat.c.orig	2003-06-22 15:54:17.000000000 -0400
> +++ linux-2.5.74/kernel/compat.c	2003-07-06 11:29:33.000000000 -0400
> @@ -425,11 +425,9 @@
>  				    &kernel_mask);
>  	set_fs(old_fs);
>  
> -	if (ret > 0) {
> +	if (ret > 0)
>  		if (put_user(kernel_mask, user_mask_ptr))
> -			ret = -EFAULT;
> -		ret = sizeof(compat_ulong_t);
> -	}
> +			return -EFAULT;
>  
>  	return ret;
>  }
