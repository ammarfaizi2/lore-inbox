Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbVJUH0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVJUH0B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 03:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVJUH0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 03:26:01 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:28171 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964894AbVJUH0A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 03:26:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZevqhEN+Bzl5LtKl2vgIwiRnw4nmm+UYngt8Ntj9O9P07wVhUroJlYK2wQU7LGkbfWwN1n92x0hXyYJQvx8Ymd15Z3BjFbZwX3z0rWJC2qA55bkzrnhlsNHsG3iFkRTbfgi3v/XIIb6b1vKGSJgLxqIqc+9QlRRCScxtTVr2Hoo=
Message-ID: <aec7e5c30510210025y4c8fc747ue3d567c0c60eeeaf@mail.gmail.com>
Date: Fri, 21 Oct 2005 16:25:59 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH 1/4] Swap migration V3: LRU operations
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Mike Kravetz <kravetz@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <1129877795.26533.12.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
	 <20051020225940.19761.93396.sendpatchset@schroedinger.engr.sgi.com>
	 <1129874762.26533.5.camel@localhost>
	 <aec7e5c30510202327l7ce5a89ax7620241ba57a4efa@mail.gmail.com>
	 <1129877795.26533.12.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05, Dave Hansen <haveblue@us.ibm.com> wrote:
> On Fri, 2005-10-21 at 15:27 +0900, Magnus Damm wrote:
> > On 10/21/05, Dave Hansen <haveblue@us.ibm.com> wrote:
> > > On Thu, 2005-10-20 at 15:59 -0700, Christoph Lameter wrote:
> > > > + *  0 = page not on LRU list
> > > > + *  1 = page removed from LRU list
> > > > + * -1 = page is being freed elsewhere.
> > > > + */
> > >
> > > Can these return values please get some real names?  I just hate when
> > > things have more than just fail and success as return codes.
> > >
> > > It makes much more sense to have something like:
> > >
> > >         if (ret == ISOLATION_IMPOSSIBLE) {
> >
> > Absolutely. But this involves figuring out nice names that everyone
> > likes and that does not pollute the name space too much.
>
> So, your excuse for bad code is that you want to avoid a discussion?
> Are you new here? ;)

No and yes. =) To me, broken code is bad code. If code looks good or
not is another issue.

Anyway, I fully agree that using constants are better than hard coded
values. I just prefer to stay out of naming discussions. They tend to
go on forever and I find them pointless.

> > Any suggestions?
>
> I'd start with the comment, and work from there.
>
> ISOLATE_PAGE_NOT_LRU
> ISOLATE_PAGE_REMOVED_FROM_LRU
> ISOLATE_PAGE_FREEING_ELSEWHERE
>
> Not my best names in history, but probably a place to start.  It keeps
> the author from having to add bad comments explaining what the code
> does.

Thank you for that suggestion.

> > > BTW, it would probably be nice to say where these patches came from
> > > before Magnus. :)
> >
> > Uh? Yesterday I broke out code from isolate_lru_pages() and
> > shrink_cache() and emailed Christoph privately. Do you have similar
> > code in your tree?
>
> Hirokazu's page migration patches have some functions called the exact
> same things: __putback_page_to_lru, etc... although they are simpler.

I saw that akpm commented regarding duplicated code and I figured it
would be better to break out these functions. And if someone has
written similar code before then it is probably a good sign saying
that something similar is needed.

> Not my code, but it would be nice to acknowledge if ideas were coming
> from there.

Yeah, thanks for stating the obvious.

/ magnus
