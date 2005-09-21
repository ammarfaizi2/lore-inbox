Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVIUJaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVIUJaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 05:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVIUJaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 05:30:12 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:64519
	"EHLO x30.random") by vger.kernel.org with ESMTP id S1750782AbVIUJaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 05:30:11 -0400
Date: Wed, 21 Sep 2005 11:30:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Fawad Lateef <fawadlateef@gmail.com>
Cc: Ustyugov Roman <dr_unique@ymg.ru>, liyu <liyu@ccoss.com.cn>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: A pettiness question.
Message-ID: <20050921093007.GA11144@x30.random>
References: <43311071.8070706@ccoss.com.cn> <200509211200.06274.dr_unique@ymg.ru> <1e62d13705092102012f0a5c9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e62d13705092102012f0a5c9c@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 02:01:11PM +0500, Fawad Lateef wrote:
> On 9/21/05, Ustyugov Roman <dr_unique@ymg.ru> wrote:
> > > Hi, All.
> > >
> > >     I found there are use double operator ! continuously sometimes in
> > > kernel.
> > > e.g:
> > >
> > >     static inline int is_page_cache_freeable(struct page *page)
> > >     {
> > >         return page_count(page) - !!PagePrivate(page) == 2;
> > >     }
> > >
> > >     Who would like tell me why write like above?
> > 
> > For example,
> > 
> >         int test = 5;
> >         !test will be  0,  !!test will be 1.
> > 
> > This give a enum of {0,1}. If test is not 0, !!test will give 1, otherwise 0.
> > 
> > Am I right?
> 
> Yes, but what abt the above case/example ??? PagePrivate is defined as
> test_bit and test_bit will return 0 or 1 only ...... So y there is (
> !! )  ??

Note that gcc should optimize it away as long as the asm*/bitops is
doing "return something != 0" like most archs do.

Most of the time test_bit retval is checked against zero only, here it's
one of the few cases where it's required to be 1 or 0. If you audit all
archs then you can as well remove the !! from above.

Thanks!
