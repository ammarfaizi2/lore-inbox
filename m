Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318516AbSHLAnA>; Sun, 11 Aug 2002 20:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318519AbSHLAnA>; Sun, 11 Aug 2002 20:43:00 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:43790 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S318516AbSHLAm7>; Sun, 11 Aug 2002 20:42:59 -0400
Date: Mon, 12 Aug 2002 02:46:45 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Studying MTD <studying_mtd@yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at page_alloc.c
Message-ID: <20020812004645.GF24456@louise.pinerecords.com>
References: <20020812002223.GE24456@louise.pinerecords.com> <20020812004151.479.qmail@web40301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020812004151.479.qmail@web40301.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 68 days, 13:41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reckon you'll have to get in touch with the SH port maintainers
and ask them directly. Have a peek in $linuxsrc/MAINTAINERS.

Have you tried any of the kernels available from
http://www.m17n.org/linux-sh/
?

T.


> I have noticed that difference in 2.4.1 and 2.5.25 is
> :-
> 
> (2.4.1)
> if (BAD_RANGE(zone,page))
> 	BUG();
> DEBUG_ADD_PAGE
> 
> (2.2.25)
> if (bad_range(zone, page))
>       BUG();
> prep_new_page(page);
> 
> 
> prep_new_page(page) is replaced with DEBUG_ADD_PAGE
> and prep_newpage is :-
> 
> /*
>  * This page is about to be returned from the page
> allocator
>  */
> static inline void prep_new_page(struct page *page)
> {
>         BUG_ON(page->mapping);
>         BUG_ON(PagePrivate(page));
>         BUG_ON(PageLocked(page));
>         BUG_ON(PageLRU(page));
>         BUG_ON(PageActive(page));
>         BUG_ON(PageDirty(page));
>         BUG_ON(PageWriteback(page));
>         page->flags &= ~(1 << PG_uptodate | 1 <<
> PG_error |
>                         1 << PG_referenced | 1 <<
> PG_arch_1 |
>                         1 << PG_checked);
>         set_page_count(page, 1);
> }
> 
> vs
> 
> #define DEBUG_ADD_PAGE \
> if (PageActive(page) || PageInactiveDirty(page) || \
> 	PageInactiveClean(page)) BUG();
> 
> Can i also replace DEBUG_ADD_PAGE with prep_new_page
> in 2.4.1. Is it OK ?
> 
> Thank you very much for your help.
> 
> 
> --- Tomas Szepe <szepe@pinerecords.com> wrote:
> > > I am using 2.4.1 on SH4 and using only 32 MB RAM
> > > without hard-disk, so only thing i am using is 32
> > MB
> > > RAM .
> > 
> > Could you try a more recent kernel?
> > 2.4.1 is now almost 2 years old.
> > 
> > T.
> 
> 
> __________________________________________________
> Do You Yahoo!?
> HotJobs - Search Thousands of New Jobs
> http://www.hotjobs.com

-- 
T.
       ,
    . ~ ~ .
  .'@ )) .. '..~
  > - ~`  '~\{   ejm'97
