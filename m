Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318238AbSHDVwF>; Sun, 4 Aug 2002 17:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318243AbSHDVwF>; Sun, 4 Aug 2002 17:52:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44898 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S318238AbSHDVwE>; Sun, 4 Aug 2002 17:52:04 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, Hans Reiser <reiser@namesys.com>,
       Andreas Gruenbacher <agruen@suse.de>, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Caches that shrink automatically
References: <Pine.LNX.4.44L.0208041555500.23404-100000@imladris.surriel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Aug 2002 15:42:43 -0600
In-Reply-To: <Pine.LNX.4.44L.0208041555500.23404-100000@imladris.surriel.com>
Message-ID: <m1bs8is3l8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On Sun, 4 Aug 2002, Linus Torvalds wrote:
> > On Sun, 4 Aug 2002, Rik van Riel wrote:
> > >
> > > Linus has indicated that he would like to have it page based,
> > > but implementation issues point towards letting the subcache
> > > manage its objects by itself ;)
> >
> > The two are not mutually incompatible.
> 
> > In particular, it is useless for the sub-caches to try to maintain their
> > own LRU lists and their own accessed bits. But that doesn't mean that
> > they can _act_ as if they updated their own accessed bits, while really
> > just telling the page-based thing that that page is active.
> 
> I'm not sure I agree with this.  For eg. the dcache you will want
> to reclaim the less used entries on a page even if there are a few
> very intensely used entries on that page.
> 
> This is because then new dcache allocations can come from the
> empty space on this page and the dcache doesn't have to grow in
> order to allocate new entries.
> 
> If we were to go fully page-based, it'd become impossible to evict
> dcache entries from any page with at least one heavily used entry
> and the dcache will use much more space than otherwise required.
> In reality it'd be even worse because we cannot evict any dcache
> entry which is pinned by eg. inodes or directory entries.
> 
> Please tell me if I've overlooked something, it would be nice if
> the page based scheme could work out after all ;)

Another angle worth taking into account is that for any data that
is purely cached, (that is not currently pinned by a user), it is
possible to compact the data.  With rmap is property even applies to
pinned page cache pages.

For cases where internal fragmentation is likely it may be worth
taking advantage of this property.

Eric
