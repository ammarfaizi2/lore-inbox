Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267689AbTASVXC>; Sun, 19 Jan 2003 16:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267692AbTASVXC>; Sun, 19 Jan 2003 16:23:02 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:7186 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267689AbTASVXA>; Sun, 19 Jan 2003 16:23:00 -0500
Date: Sun, 19 Jan 2003 13:28:08 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Bryan Andersen <bryan@bogonomicon.net>
cc: Hugh Dickins <hugh@veritas.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-pre3-ac oops
In-Reply-To: <3E2B1833.5060203@bogonomicon.net>
Message-ID: <Pine.LNX.4.10.10301191327050.12087-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Exactly when you want to flush the devices to platter.
The problem will be what to do if we get an error on flush-cache.

Andre Hedrick
LAD Storage Consulting Group

On Sun, 19 Jan 2003, Bryan Andersen wrote:

> Patch looks like it solved the problem.  6 kernel compiles
> and 6 mke2fs with bad block scans and the system is still
> up.
> 
> The only thing I'm still seeing that is unusual is this kernel
> message:
> 
>    ide: no cache flush required.
> 
> which only shows up in the file:
> 
>    ./drivers/ide/ide-disk.c:
> 
> Nothing seams to come of them, but in the average boot I see
> 25 or so of them.  They did not show up under linux-2.4.21-pre3.
> As near as I can tell they are generated when an ide device is
> closed.
> 
> - Bryan
> 
> Hugh Dickins wrote:
> > If you got 2.4.21-pre3-ac __free_pages_ok oops, please try this patch.
> > 
> > Hugh
> > 
> > --- 2.4.21-pre3-ac4/kernel/fork.c	Mon Jan 13 18:56:12 2003
> > +++ linux/kernel/fork.c	Sun Jan 19 13:39:37 2003
> > @@ -688,6 +688,8 @@
> >  	p->lock_depth = -1;		/* -1 = no lock */
> >  	p->start_time = jiffies;
> >  
> > +	INIT_LIST_HEAD(&p->local_pages);
> > +
> >  	retval = -ENOMEM;
> >  	/* copy all the process information */
> >  	if (copy_files(clone_flags, p))
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

