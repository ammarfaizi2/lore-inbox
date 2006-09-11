Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWIKEWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWIKEWz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 00:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWIKEWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 00:22:55 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:16521 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751084AbWIKEWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 00:22:55 -0400
Date: Mon, 11 Sep 2006 06:22:01 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2/2] convert s390 page handling macros to functions v3
Message-ID: <20060911042201.GA8379@osiris.ibm.com>
References: <20060908111716.GA6913@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.64.0609092248400.6762@scrub.home> <20060910130832.GB12084@osiris.ibm.com> <1157905518.26324.83.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157905518.26324.83.camel@localhost.localdomain>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2006 at 09:25:18AM -0700, Dave Hansen wrote:
> On Sun, 2006-09-10 at 15:08 +0200, Heiko Carstens wrote:
> > 
> > +static inline int page_test_and_clear_dirty(struct page *page)
> > +{
> > +       unsigned long physpage = __pa((page - mem_map) << PAGE_SHIFT);
> > +       int skey = page_get_storage_key(physpage); 
> 
> This has nothing to do with your patch at all, but why is 'page -
> mem_map' being open-coded here?

I just changed the defines to functions without thinking about this.. :)
 
> I see at least a couple of page_to_phys() definitions on some
> architectures.  This operation is done enough times that s390 could
> probably use the same treatment.

Yes, even s390 has page_to_phys() as well. But why is it in io.h? Seems
like this is inconsistent across architectures. Also in quite a few
architectures the define looks like this:

#define page_to_phys(page)	((page - mem_map) << PAGE_SHIFT)

A pair of braces is missing around page. Yet another possible subtle bug...

> It could at least use a page_to_pfn() instead of the 'page - mem_map'
> operation, right?

Yes, I will address that in a later patch. Shouldn't stop this one from
being merged, if there aren't any other objections.
Thanks for pointing this out!
