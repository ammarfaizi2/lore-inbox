Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318514AbSHLAiK>; Sun, 11 Aug 2002 20:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318516AbSHLAiK>; Sun, 11 Aug 2002 20:38:10 -0400
Received: from web40301.mail.yahoo.com ([66.218.78.80]:7704 "HELO
	web40301.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318514AbSHLAiI>; Sun, 11 Aug 2002 20:38:08 -0400
Message-ID: <20020812004151.479.qmail@web40301.mail.yahoo.com>
Date: Sun, 11 Aug 2002 17:41:51 -0700 (PDT)
From: Studying MTD <studying_mtd@yahoo.com>
Subject: Re: kernel BUG at page_alloc.c
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020812002223.GE24456@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed that difference in 2.4.1 and 2.5.25 is
:-

(2.4.1)
if (BAD_RANGE(zone,page))
	BUG();
DEBUG_ADD_PAGE

(2.2.25)
if (bad_range(zone, page))
      BUG();
prep_new_page(page);


prep_new_page(page) is replaced with DEBUG_ADD_PAGE
and prep_newpage is :-

/*
 * This page is about to be returned from the page
allocator
 */
static inline void prep_new_page(struct page *page)
{
        BUG_ON(page->mapping);
        BUG_ON(PagePrivate(page));
        BUG_ON(PageLocked(page));
        BUG_ON(PageLRU(page));
        BUG_ON(PageActive(page));
        BUG_ON(PageDirty(page));
        BUG_ON(PageWriteback(page));
        page->flags &= ~(1 << PG_uptodate | 1 <<
PG_error |
                        1 << PG_referenced | 1 <<
PG_arch_1 |
                        1 << PG_checked);
        set_page_count(page, 1);
}

vs

#define DEBUG_ADD_PAGE \
if (PageActive(page) || PageInactiveDirty(page) || \
	PageInactiveClean(page)) BUG();

Can i also replace DEBUG_ADD_PAGE with prep_new_page
in 2.4.1. Is it OK ?

Thank you very much for your help.


--- Tomas Szepe <szepe@pinerecords.com> wrote:
> > I am using 2.4.1 on SH4 and using only 32 MB RAM
> > without hard-disk, so only thing i am using is 32
> MB
> > RAM .
> 
> Could you try a more recent kernel?
> 2.4.1 is now almost 2 years old.
> 
> T.


__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com
