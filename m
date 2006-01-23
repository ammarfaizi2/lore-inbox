Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWAWIE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWAWIE0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 03:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWAWIE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 03:04:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751408AbWAWIEZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 03:04:25 -0500
Date: Mon, 23 Jan 2006 00:04:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, jesper.juhl@gmail.com
Subject: Re: [PATCH] ide-tape: attempt to handle copy_*_user() failures  
 [take two]
Message-Id: <20060123000401.144e2ca2.akpm@osdl.org>
In-Reply-To: <200601222251.56185.jesper.juhl@gmail.com>
References: <200601222251.56185.jesper.juhl@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> Second attempt at this patch.
> 
> (
>  noticed a small flaw in my first patch, this should be better.
>  also noticed that Gadi Oxman seems unable to recieve mail at the address
>  listed in MAINTAINERS, so put a few other (hopefully relevant) people on
>  Cc instead
> )
> 
> 
> Attempt to handle copy_*_user() failures in
> drivers/ide/ide-tape.c::idetape_copy_stage_*_user
> 
> drivers/ide/ide-tape.c:2663: warning: ignoring return value of opy_from_user', declared with attribute warn_unused_result
> drivers/ide/ide-tape.c:2690: warning: ignoring return value of opy_to_user', declared with attribute warn_unused_result
> 
> Due to lack of hardware I'm unfortunately not able to test this patch
> beyond making sure it compiles.
> 

Too scary for me.

> @@ -2669,26 +2671,30 @@ static void idetape_copy_stage_from_user
>  			if (bh)
>  				atomic_set(&bh->b_count, 0);
>  		}
> +		if (not_copied)
> +			return not_copied;
>  	}
>  	tape->bh = bh;
> +	return 0;
>  }

What are the effects of not updating tape->bh?

