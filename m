Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSF1ItO>; Fri, 28 Jun 2002 04:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSF1ItN>; Fri, 28 Jun 2002 04:49:13 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:5070 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S317068AbSF1ItN>; Fri, 28 Jun 2002 04:49:13 -0400
Date: Fri, 28 Jun 2002 09:51:23 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Austin Gonyou <austin@digitalroadkill.net>
cc: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: vm fixes for 2.4.19rc1
In-Reply-To: <1025234354.2087.10.camel@UberGeek>
Message-ID: <Pine.LNX.4.21.0206280939300.1553-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Jun 2002, Austin Gonyou wrote:
> For something like DB work, would this patch be *too* aggressive on
> freeing memory/cache as to introduced increased latency there?
> Just curious, I'm all for using *any* good VM changes. 

No, you're taking the "_cache_" too seriously.  This has nothing to
do with taking pages out of the lookup cache: it's a matter of when
anonymous pages not in any lookup cache, which were put on an LRU list
for fair aging, can safely be removed from that LRU list when they are
freed.  An issue of the best place to catch them all, an issue of when
the locking is safe, but no macroscopic issue of caching versus latency.

> On Thu, 2002-06-27 at 15:14, Andrea Arcangeli wrote:
> > some fix for 2.4.19rc1 (btw, the lru_cache_del() in the LRU path is
> > needed in 2.5 too and it's also more efficient than the
> > page_cache_release, see ptrace freeing the anon pages with put_page(),
> > it will not pass through page_cache_release and it will trigger the
> > PageLRU check that __free_pages_ok isn't capable to handle in 2.5, I
> > will make a full vm update for 2.5 [in small pieces based on post-Andrew
> > split of the monolithic patch] in the next days anyways):

