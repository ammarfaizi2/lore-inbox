Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135768AbRDYAPX>; Tue, 24 Apr 2001 20:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135765AbRDYAPL>; Tue, 24 Apr 2001 20:15:11 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:36623 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135764AbRDYAPB>; Tue, 24 Apr 2001 20:15:01 -0400
Date: Tue, 24 Apr 2001 19:34:55 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Colonel <klink@clouddancer.com>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove wakeup_bdflush(0) from __alloc_pages()
In-Reply-To: <20010424234901.6FCD578478@mail.clouddancer.com>
Message-ID: <Pine.LNX.4.21.0104241933220.2417-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, 

Can you please apply the following patch ? 

It avoids allocators from waking up bdflush all the time even when it does
not have any job to do (ie no more than 30% (default) of dirty buffers). 

Thanks 

On Tue, 24 Apr 2001, Colonel wrote:

> From: Colonel <klink@clouddancer.com>
> To: marcelo@conectiva.com.br
> CC: linux-kernel@vger.kernel.org
> In-reply-to: <Pine.LNX.4.21.0104232030480.1264-100000@freak.distro.conectiva>
> 	(message from Marcelo Tosatti on Mon, 23 Apr 2001 20:31:12 -0300
> 	(BRT))
> Subject: Re: 2.4.4-pre6 :  THANKS!  very snappy here [nt]
> Reply-to: klink@clouddancer.com
> References:  <Pine.LNX.4.21.0104232030480.1264-100000@freak.distro.conectiva>
> 
>    Date: Mon, 23 Apr 2001 20:31:12 -0300 (BRT)
>    From: Marcelo Tosatti <marcelo@conectiva.com.br>
>    X-Sender: marcelo@freak.distro.conectiva
> 
> 
>    Just as curiosity --- did it got faster in pre5 ? 
> 
>    On Mon, 23 Apr 2001, Colonel wrote:
> 
>    > but since you read it, system seems like it's running twice as fast
> 
> 
> Actually, it made not be pre6.  I patched the kernel per some thread
> on LKML a few days before, but had not had the opportunity to reboot
> and run it until pre6.  The patch was :
> 
> 
> --- linux/mm/page_alloc.c.~1~	Tue Mar 20 15:05:46 2001
> +++ linux/mm/page_alloc.c	Sat Apr 21 19:01:47 2001
> @@ -454,7 +454,6 @@
>  		if (gfp_mask & __GFP_WAIT) {
>  			memory_pressure++;
>  			try_to_free_pages(gfp_mask);
> -			wakeup_bdflush(0);
>  			goto try_again;
>  		}
>  	}
> 
> 
> It would make more sense that the above change was responsible for the
> improvement.
> 

