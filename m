Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUCDO7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 09:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbUCDO5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 09:57:52 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30953 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261918AbUCDO5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 09:57:44 -0500
Date: Tue, 2 Mar 2004 22:38:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Keith Duthie <psycho@albatross.co.nz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: APM suspend causes uninterruptible sleep
Message-ID: <20040302213822.GB531@openzaurus.ucw.cz>
References: <Pine.LNX.4.53.0402272054010.164@loki.albatross.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0402272054010.164@loki.albatross.co.nz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Between alsa-driver 0.9.4 and alsa-driver 0.9.5 the change below was made.
> Since then, suspending with a program outputting to the pcm device
> causes that program to enter the uninterruptible sleep state. Reverting
> this patch fixes the problem. The problem exists in 0.9.5 through 1.0.2c.
> 
> This problem affects kernel 2.6.3; applying the reversion of this patch
> fixes it.

This should really use driver model...

> 
> diff -urN alsa-driver-0.9.4/alsa-kernel/isa/cs423x/cs4231_lib.c alsa-driver-0.9.5/alsa-kernel/isa/cs423x/cs4231_lib.c
> --- alsa-driver-0.9.4/alsa-kernel/isa/cs423x/cs4231_lib.c	Wed Apr 30 23:53:17 2003
> +++ alsa-driver-0.9.5/alsa-kernel/isa/cs423x/cs4231_lib.c	Tue Jul  8 22:42:09 2003
> @@ -1401,8 +1401,10 @@
> 
>  	switch (rqst) {
>  	case PM_SUSPEND:
> -		if (chip->suspend)
> +		if (chip->suspend) {
> +			snd_pcm_suspend_all(chip->pcm);
>  			(*chip->suspend)(chip);
> +		}
>  		break;
>  	case PM_RESUME:
>  		if (chip->resume)
> 
> -- 
> Just because it isn't nice doesn't make it any less a miracle.
>      http://users.albatross.co.nz/~psycho/     O-   -><-
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

