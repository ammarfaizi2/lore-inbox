Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbTB0QHv>; Thu, 27 Feb 2003 11:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265675AbTB0QHv>; Thu, 27 Feb 2003 11:07:51 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:50310 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S265637AbTB0QHu>;
	Thu, 27 Feb 2003 11:07:50 -0500
Message-Id: <200302271617.h1RGH5CA012080@eeyore.valparaiso.cl>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
cc: Greg KH <greg@kroah.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] dm: __LOW macro fix no. 2 
In-Reply-To: Your message of "Thu, 27 Feb 2003 09:55:22 -0000."
             <20030227095522.GA6312@fib011235813.fsnet.co.uk> 
Date: Thu, 27 Feb 2003 13:17:05 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber <joe@fib011235813.fsnet.co.uk> said:
> Any happier with this ?  The second hunk of the patch may disappear at
> some point.
> 
> - Joe
> 
> 
> Replace __HIGH() and __LOW() with max() and min_not_zero().
> 
> 
> --- diff/drivers/md/dm-table.c	2003-02-26 16:10:24.000000000 +0000
> +++ source/drivers/md/dm-table.c	2003-02-27 09:44:31.000000000 +0000
> @@ -78,22 +78,33 @@
>  	return result;
>  }
>  
> -#define __HIGH(l, r) if (*(l) < (r)) *(l) = (r)
> -#define __LOW(l, r) if (*(l) == 0 || *(l) > (r)) *(l) = (r)
> +/*
> + * Returns the minimum that is _not_ zero, unless both are zero.
> + */
> +#define min_not_zero(l, r) (l == 0) ? r : ((r == 0) ? l : min(l, r))

I'd add () around r and l just for paranoia's sake. Plus make sure they
aren't ever going to be called with sideeffects... why not inline functions?

Besides, I'd call them args a and b (no real reason for l and r, and l is
almost 1 for some fonts...)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
