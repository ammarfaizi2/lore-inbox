Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272052AbTHFTuz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272139AbTHFTuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:50:55 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:3489 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272052AbTHFTuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:50:52 -0400
Date: Wed, 6 Aug 2003 21:51:01 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jason Baron <jbaron@redhat.com>
Subject: Re: pivot_root solved by patch to 2.4.22-pre7
Message-ID: <20030806195101.GB16054@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	Rene Mayrhofer <rene.mayrhofer@gibraltar.at>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jason Baron <jbaron@redhat.com>
References: <3F309FD8.8090105@gibraltar.at> <Pine.LNX.4.44.0308061633240.2722-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0308061633240.2722-100000@logos.cnet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 04:33:52PM -0300, Marcelo Tosatti wrote:
> 
> What is your problem with pivot_root? 
> 
> Sorry but I've searched the list archives and found nothing but this email 
> and this patch, which seems a bit hackish.

 Jul 21  Rene Mayrhofer     82 pivot_root seems to be broken in 2.4.21-a1716
 Jul 22  Denis Vlasenko    103   >
 Jul 22  Rene Mayrhofer     54     >
 Jul 22  Jason Baron        18       >
 Jul 22  Alan Cox           22         >
 Jul 22  Rene Mayrhofer     25           >
 Jul 22  Alan Cox           17             >
 Jul 22  Rene Mayrhofer    154               >
 Jul 23  Mika Penttilä      40               >
 Jul 22  Mika Penttilä      41           >

HTH,
Herbert

> On Wed, 6 Aug 2003, Rene Mayrhofer wrote:
> 
> > Hi all,
> > 
> > The problem with pivot_root that appeared in 2.4.21-ac4 and the 
> > 2.4.22-pre kernels is now solved (at least for my case) by applying the 
> > trvial patch sent by Jason Baron.
> > 
> > Jason Baron wrote:
> > > right. so the semantics of how file tables are shared has changed a bit. I
> > > would think that for at least 'init', it'd be nice to preserve the
> > > original behavior, for situations such as you described. Something like
> > > the following would probably work, although i havent' tried the test
> > > script.
> > > 
> > > --- linux/kernel/fork.c.orig  2003-07-23 21:34:59.000000000 -0400
> > > +++ linux/kernel/fork.c       2003-07-23 21:35:45.000000000 -0400
> > > @@ -558,7 +558,7 @@ int unshare_files(void)
> > >  
> > >         /* This can race but the race causes us to copy when we don't
> > >            need to and drop the copy */
> > > -       if(atomic_read(&files->count) == 1)
> > > +       if(atomic_read(&files->count) == 1 || (current->pid == 1))
> > >         {
> > >                 atomic_inc(&files->count);
> > >                 return 0;
> > >    
> > 
> > 
> > 
> > I tried that on my system and it works as expected. The kernel processes
> > close their fds and the old root fs can thus be unmounted after
> > pivot_root. Thanks for the hint !
> > So the problem is solved for me and it would be wonderful to get it into
> > 2.4.22.
> > 
> > best regards,
> > Rene
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
