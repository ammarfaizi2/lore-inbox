Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbVJUG1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbVJUG1o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 02:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbVJUG1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 02:27:44 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:56118 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964893AbVJUG1n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 02:27:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e3wuTHtuVWa8AzbO+JqgJGQW36RFP5DJbn9DupHxohY7nddfU3UT7r6QPwKgPELckxC8Av2rgsLfg8tZRmNxoxWFTFbdBIH61P6cyQZKRw5hxcRBSVVz1V6sZaQ+uKZMmO7K6Wf9eihd4lADJkWQRZfExlOwOjvLdw4eWdSyQg4=
Message-ID: <aec7e5c30510202327l7ce5a89ax7620241ba57a4efa@mail.gmail.com>
Date: Fri, 21 Oct 2005 15:27:43 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH 1/4] Swap migration V3: LRU operations
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Mike Kravetz <kravetz@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <1129874762.26533.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
	 <20051020225940.19761.93396.sendpatchset@schroedinger.engr.sgi.com>
	 <1129874762.26533.5.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05, Dave Hansen <haveblue@us.ibm.com> wrote:
> On Thu, 2005-10-20 at 15:59 -0700, Christoph Lameter wrote:
>
> > +/*
> > + * Isolate one page from the LRU lists.
> > + *
> > + * - zone->lru_lock must be held
> > + *
> > + * Result:
> > + *  0 = page not on LRU list
> > + *  1 = page removed from LRU list
> > + * -1 = page is being freed elsewhere.
> > + */
>
> Can these return values please get some real names?  I just hate when
> things have more than just fail and success as return codes.
>
> It makes much more sense to have something like:
>
>         if (ret == ISOLATION_IMPOSSIBLE) {

Absolutely. But this involves figuring out nice names that everyone
likes and that does not pollute the name space too much. Any
suggestions?

> How about
>
> +static inline int
> > +__isolate_lru_page(struct zone *zone, struct page *page)
> > +{
>         int ret = 0;
>
>         if (!TestClearPageLRU(page))
>                 return ret;
>
> Then, the rest of the thing doesn't need to be indented.

Good idea.

> > +static inline void
> > +__putback_lru_page(struct zone *zone, struct page *page)
> > +{
>
> __put_back_lru_page?
>
> BTW, it would probably be nice to say where these patches came from
> before Magnus. :)

Uh? Yesterday I broke out code from isolate_lru_pages() and
shrink_cache() and emailed Christoph privately. Do you have similar
code in your tree?

/ magnus
