Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317628AbSHOWyn>; Thu, 15 Aug 2002 18:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317637AbSHOWyn>; Thu, 15 Aug 2002 18:54:43 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:39077 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S317628AbSHOWyn>; Thu, 15 Aug 2002 18:54:43 -0400
Date: Thu, 15 Aug 2002 23:59:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@zip.com.au>
cc: j-nomura@ce.jp.nec.com, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18(19) swapcache oops
In-Reply-To: <3D5C0995.CEE36FC8@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208152357210.1161-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2002, Andrew Morton wrote:
> Hugh Dickins wrote:
> > On Thu, 15 Aug 2002 j-nomura@ce.jp.nec.com wrote:
> > >
> > > I'm using 2.4.18 kernel and suspect there are swapcache race.
> > > I looked into 2.4.19 patch but could not find the fix to it.
> > 
> > I see a benign race but no oops.
> 
> But look at lru_cache_add():
> 
> void lru_cache_add(struct page * page)
> {
>         if (!TestSetPageLRU(page)) {
> /* window here */
>                 spin_lock(&pagemap_lru_lock);
>                 add_page_to_inactive_list(page);
>                 spin_unlock(&pagemap_lru_lock);
>         }
> }
> 
> It sets PG_lru before adding the page to the LRU.

Right you are!  Thanks for correcting my dysanalysis.

Hugh

