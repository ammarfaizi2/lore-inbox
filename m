Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129404AbQLASBP>; Fri, 1 Dec 2000 13:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbQLASBF>; Fri, 1 Dec 2000 13:01:05 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:50756 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129404AbQLASAr>; Fri, 1 Dec 2000 13:00:47 -0500
Date: Fri, 1 Dec 2000 11:29:49 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Alexander Viro <viro@math.psu.edu>, Jonathan Hudson <jonathan@daria.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <3A26C82D.26267202@uow.edu.au>
Message-ID: <Pine.LNX.3.96.1001201112921.30219K-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Dec 2000, Andrew Morton wrote:

> Alexander Viro wrote:
> > 
> > Confirms. That's definitely an empty list_head at address 0xc3c49058 and -pre2
> > has O_SYNC patches.
> 
> foo.   The overnight run wedged tight in mmap002. No progress.
> 
> I bet this'll catch it:
> 
> --- include/linux/list.h.orig	Fri Dec  1 08:33:36 2000
> +++ include/linux/list.h	Fri Dec  1 08:33:55 2000
> @@ -90,6 +90,7 @@
>  static __inline__ void list_del(struct list_head *entry)
>  {
>  	__list_del(entry->prev, entry->next);
> +	entry->next = entry->prev = 0;
>  }
>  

Or just call list_del_init instead...


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
