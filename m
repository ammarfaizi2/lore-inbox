Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSEEWHO>; Sun, 5 May 2002 18:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313760AbSEEWHN>; Sun, 5 May 2002 18:07:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35595 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313743AbSEEWHL>;
	Sun, 5 May 2002 18:07:11 -0400
Message-ID: <3CD5ACD1.CBB2ACC8@zip.com.au>
Date: Sun, 05 May 2002 15:06:10 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/10] suppress allocation warnings for radix-tree allocations
In-Reply-To: <3CD59BAD.37BD6A51@zip.com.au> <E174TuG-0004As-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Sunday 05 May 2002 22:53, Andrew Morton wrote:
> > The recently-added page allocation failure warning generates a lot of
> > noise due to radix-tree node allocation failures.  Those messages are
> > not interesting.
> >
> > But I think the warning is otherwise useful - "I got an allocation
> > failure and then it crashed" is better than "it crashed".
> >
> > The patch suppresses the message for ratnode allocation failures.
> >
> > =====================================
> >
> > --- 2.5.13/mm/vmscan.c~radix-tree-warning     Sun May  5 13:31:59 2002
> > +++ 2.5.13-akpm/mm/vmscan.c   Sun May  5 13:31:59 2002
> > @@ -58,6 +58,7 @@ swap_out_add_to_swap_cache(struct page *
> >       int ret;
> >
> >       current->flags &= ~PF_MEMALLOC;
> > +     current->flags |= PF_RADIX_TREE;
> 
> Isn't that really 'PF_NO_WARN_ALLOC'?
> 

Yup, that would make more sense.

Or __GFP_I_DONT_REALLY_CARE ;)

-
