Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268581AbRHBBy2>; Wed, 1 Aug 2001 21:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268582AbRHBByR>; Wed, 1 Aug 2001 21:54:17 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:37892 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268581AbRHBByM>; Wed, 1 Aug 2001 21:54:12 -0400
Date: Wed, 1 Aug 2001 21:54:20 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200108020154.f721sKR04927@devserv.devel.redhat.com>
To: hch@ns.caldera.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill unneeded code from mm/memory.c
In-Reply-To: <mailman.996710160.18802.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.996710160.18802.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -uNr ../master/linux-2.4.7-ac3/mm/memory.c linux/mm/memory.c
> --- ../master/linux-2.4.7-ac3/mm/memory.c	Thu Aug  2 01:48:23 2001
> +++ linux/mm/memory.c	Thu Aug  2 01:50:12 2001
> @@ -1041,17 +1041,10 @@
>  		}
>  	}
>  	inode->i_size = offset;
> -	if (inode->i_op && inode->i_op->truncate)
> -	{
> -		/* This doesnt scale but it is meant to be a 2.4 invariant */
> -		lock_kernel();
> -		inode->i_op->truncate(inode);
> -		unlock_kernel();
> -	}
> -	return 0;
> -	
> +
>  out_truncate:
>  	if (inode->i_op && inode->i_op->truncate) {
> +		/* This doesnt scale but it is meant to be a 2.4 invariant */
>  		lock_kernel();
>   		inode->i_op->truncate(inode);
>  		unlock_kernel();

I disagree. It is the style to have a function trip exceptions
by doing goto out_something. Those exceptions are stacked
in the fall through fashion, but the success case IS NOT.
By implemention this factorization you save several bytes
and make just everyone to wonder if there is a bug or mispatch
with missing "return 0" case here.

-- Pete
