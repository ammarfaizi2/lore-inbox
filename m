Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVCWPTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVCWPTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 10:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVCWPTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 10:19:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26288 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261624AbVCWPTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 10:19:22 -0500
Date: Wed, 23 Mar 2005 05:49:31 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Horms <horms@verge.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix sign checks in copy_from_read_buf() in 2.4
Message-ID: <20050323084931.GA4017@logos.cnet>
References: <20050323074931.GA3092@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323074931.GA3092@verge.net.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Horms,

On Wed, Mar 23, 2005 at 04:49:35PM +0900, Horms wrote:
> Applologies if this is already pending, but the signdness fix for
> copy_from_read_buf() in  2.6 seems to be needed for 2.4 as well.
> 
> This relates to the bugs reported in this document
> http://www.guninski.com/where_do_you_want_billg_to_go_today_3.html

v2.4 does not suffer from the issue mentioned by Guninski because 
the first argument of the arithmetic comparison is not casted
to a "signed" value:

  n = min((ssize_t)*nr, n);

That was the problem in v2.6, where an unsigned value bigger than 2^31 
would be treated as a negative signed.

Thanks anyway for pinging me, highly appreciated.

> -- 
> Horms
> 
> Backport of copy_from_read_buf() signedness fix from 2.6
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> ===== drivers/char/n_tty.c 1.7 vs edited =====
> --- 1.7/drivers/char/n_tty.c	2004-12-16 22:57:23 +09:00
> +++ edited/drivers/char/n_tty.c	2005-03-23 13:08:37 +09:00
> @@ -1095,7 +1095,7 @@
>  
>  {
>  	int retval;
> -	ssize_t n;
> +	size_t n;
>  	unsigned long flags;
>  
>  	retval = 0;
