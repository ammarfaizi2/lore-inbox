Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267949AbTAHWuM>; Wed, 8 Jan 2003 17:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267950AbTAHWuM>; Wed, 8 Jan 2003 17:50:12 -0500
Received: from web10009.mail.yahoo.com ([216.136.128.120]:48300 "HELO
	web10009.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267949AbTAHWuL>; Wed, 8 Jan 2003 17:50:11 -0500
Message-ID: <20030108225852.65766.qmail@web10009.mail.yahoo.com>
Date: Wed, 8 Jan 2003 14:58:52 -0800 (PST)
From: Shangc <shangcs@yahoo.com>
Subject: Re: [PATCH] mm/slab.c, kernel <2.4.20>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Cc: markhe@nextd.demon.co.uk, Shangc <shangcs@yahoo.com>
In-Reply-To: <200301082312.32961.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thank you for reply. However, I am not very sure to be
vary agree with you.

after assigned the calculated initial value for "i",
it is very close to the break value for the next while
loop, actually, it is only one loop at most, so "i"
never goes to be 
i*size + L1_CACHE_ALIGN(base+i*extra) >  wastage +
L1_CACHE_BYTES

so, we do not need change the line 399 of slab.c.

thanks,

chen

--- Marc-Christian Petersen <m.c.p@wolk-project.de>
wrote:
> On Wednesday 08 January 2003 23:03, Shangc wrote:
> 
> Hi Shangc,
> 
> > --- slab.c	2003-02-08 04:26:50.000000000 -0500
> > +++ slab.c	2003-02-08 04:26:14.000000000 -0500
> > @@ -397,7 +397,7 @@
> >  		base = sizeof(slab_t);
> >  		extra = sizeof(kmem_bufctl_t);
> >  	}
> > -	i = 0;
> > +	i = (wastage - base) / (size + extra);
> >  	while (i*size + L1_CACHE_ALIGN(base+i*extra) <=>
> wastage)
> >  		i++;
> >  	if (i > 0)
> if you use this you may also want this.
> 
> ciao, Marc> diff -Naurp a/mm/slab.c b/mm/slab.c
> --- a/mm/slab.c	Wed Jul 17 12:25:04 2002
> +++ b/mm/slab.c	Wed Jul 17 12:25:04 2002
> @@ -399,10 +399,10 @@
>  		base = sizeof(slab_t);
>  		extra = sizeof(kmem_bufctl_t);
>  	}
> -	i = 0;
> +       i = (wastage - base)/(size + extra);
>  	while (i*size + L1_CACHE_ALIGN(base+i*extra) <=
> wastage)
>  		i++;
> -	if (i > 0)
> +       while (i*size + L1_CACHE_ALIGN(base+i*extra)
> > wastage)
>  		i--;
>  
>  	if (i > SLAB_LIMIT)
> 


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
