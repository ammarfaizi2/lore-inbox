Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313810AbSEEWvf>; Sun, 5 May 2002 18:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313817AbSEEWve>; Sun, 5 May 2002 18:51:34 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:42342 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313810AbSEEWvd>; Sun, 5 May 2002 18:51:33 -0400
Message-Id: <5.1.0.14.2.20020505235015.040e8640@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 05 May 2002 23:51:53 +0100
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [patch 1/10] suppress allocation warnings for radix-tree
  allocations
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD5ACD1.CBB2ACC8@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:06 05/05/02, Andrew Morton wrote:
>Daniel Phillips wrote:
> >
> > On Sunday 05 May 2002 22:53, Andrew Morton wrote:
> > > The recently-added page allocation failure warning generates a lot of
> > > noise due to radix-tree node allocation failures.  Those messages are
> > > not interesting.
> > >
> > > But I think the warning is otherwise useful - "I got an allocation
> > > failure and then it crashed" is better than "it crashed".
> > >
> > > The patch suppresses the message for ratnode allocation failures.
> > >
> > > =====================================
> > >
> > > --- 2.5.13/mm/vmscan.c~radix-tree-warning     Sun May  5 13:31:59 2002
> > > +++ 2.5.13-akpm/mm/vmscan.c   Sun May  5 13:31:59 2002
> > > @@ -58,6 +58,7 @@ swap_out_add_to_swap_cache(struct page *
> > >       int ret;
> > >
> > >       current->flags &= ~PF_MEMALLOC;
> > > +     current->flags |= PF_RADIX_TREE;
> >
> > Isn't that really 'PF_NO_WARN_ALLOC'?
> >
>
>Yup, that would make more sense.
>
>Or __GFP_I_DONT_REALLY_CARE ;)

Surely this is only a temporary flag which together with the warning 
message will disappear later on so debating about its name is, err, silly? 
(((-;

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

