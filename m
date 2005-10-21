Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVJUG6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVJUG6f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 02:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbVJUG6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 02:58:35 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:45260 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964887AbVJUG6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 02:58:34 -0400
Subject: Re: [PATCH 1/4] Swap migration V3: LRU operations
From: Dave Hansen <haveblue@us.ibm.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Mike Kravetz <kravetz@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <aec7e5c30510202327l7ce5a89ax7620241ba57a4efa@mail.gmail.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
	 <20051020225940.19761.93396.sendpatchset@schroedinger.engr.sgi.com>
	 <1129874762.26533.5.camel@localhost>
	 <aec7e5c30510202327l7ce5a89ax7620241ba57a4efa@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 08:56:34 +0200
Message-Id: <1129877795.26533.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-21 at 15:27 +0900, Magnus Damm wrote:
> On 10/21/05, Dave Hansen <haveblue@us.ibm.com> wrote:
> > On Thu, 2005-10-20 at 15:59 -0700, Christoph Lameter wrote:
> > > + *  0 = page not on LRU list
> > > + *  1 = page removed from LRU list
> > > + * -1 = page is being freed elsewhere.
> > > + */
> >
> > Can these return values please get some real names?  I just hate when
> > things have more than just fail and success as return codes.
> >
> > It makes much more sense to have something like:
> >
> >         if (ret == ISOLATION_IMPOSSIBLE) {
> 
> Absolutely. But this involves figuring out nice names that everyone
> likes and that does not pollute the name space too much.

So, your excuse for bad code is that you want to avoid a discussion?
Are you new here? ;)

> Any suggestions?

I'd start with the comment, and work from there.  

ISOLATE_PAGE_NOT_LRU
ISOLATE_PAGE_REMOVED_FROM_LRU
ISOLATE_PAGE_FREEING_ELSEWHERE

Not my best names in history, but probably a place to start.  It keeps
the author from having to add bad comments explaining what the code
does.

> > BTW, it would probably be nice to say where these patches came from
> > before Magnus. :)
> 
> Uh? Yesterday I broke out code from isolate_lru_pages() and
> shrink_cache() and emailed Christoph privately. Do you have similar
> code in your tree?

Hirokazu's page migration patches have some functions called the exact
same things: __putback_page_to_lru, etc... although they are simpler.
Not my code, but it would be nice to acknowledge if ideas were coming
from there.

-- Dave

