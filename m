Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271025AbTHFTdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270967AbTHFTcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:32:13 -0400
Received: from pwmail.portoweb.com.br ([200.248.222.108]:37780 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S270991AbTHFTbM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:31:12 -0400
Date: Wed, 6 Aug 2003 16:33:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jason Baron <jbaron@redhat.com>
Subject: Re: pivot_root solved by patch to 2.4.22-pre7
In-Reply-To: <3F309FD8.8090105@gibraltar.at>
Message-ID: <Pine.LNX.4.44.0308061633240.2722-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What is your problem with pivot_root? 

Sorry but I've searched the list archives and found nothing but this email 
and this patch, which seems a bit hackish.

On Wed, 6 Aug 2003, Rene Mayrhofer wrote:

> Hi all,
> 
> The problem with pivot_root that appeared in 2.4.21-ac4 and the 
> 2.4.22-pre kernels is now solved (at least for my case) by applying the 
> trvial patch sent by Jason Baron.
> 
> Jason Baron wrote:
> > right. so the semantics of how file tables are shared has changed a bit. I
> > would think that for at least 'init', it'd be nice to preserve the
> > original behavior, for situations such as you described. Something like
> > the following would probably work, although i havent' tried the test
> > script.
> > 
> > --- linux/kernel/fork.c.orig  2003-07-23 21:34:59.000000000 -0400
> > +++ linux/kernel/fork.c       2003-07-23 21:35:45.000000000 -0400
> > @@ -558,7 +558,7 @@ int unshare_files(void)
> >  
> >         /* This can race but the race causes us to copy when we don't
> >            need to and drop the copy */
> > -       if(atomic_read(&files->count) == 1)
> > +       if(atomic_read(&files->count) == 1 || (current->pid == 1))
> >         {
> >                 atomic_inc(&files->count);
> >                 return 0;
> >    
> 
> 
> 
> I tried that on my system and it works as expected. The kernel processes
> close their fds and the old root fs can thus be unmounted after
> pivot_root. Thanks for the hint !
> So the problem is solved for me and it would be wonderful to get it into
> 2.4.22.
> 
> best regards,
> Rene
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

