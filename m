Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132917AbQL2Ahx>; Thu, 28 Dec 2000 19:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133000AbQL2Ahm>; Thu, 28 Dec 2000 19:37:42 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:37649 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132917AbQL2Ahf>; Thu, 28 Dec 2000 19:37:35 -0500
Date: Thu, 28 Dec 2000 20:14:55 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
In-Reply-To: <Pine.LNX.4.10.10012281243010.788-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012282012480.12680-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2000, Linus Torvalds wrote:

>  - make "SetPageDirty()" do something like
> 
> 	if (!test_and_set(PG_dirty, &page->flags)) {
> 		spin_lock(&page_cache_lock);
> 		list_del(page->list);
> 		list_add(page->list, page->mapping->dirty_pages);
> 		spin_unlock(&page_cache_lock);
> 	}
> 
>    This will require making sure that every place that does a
>    SetPageDirty() will be ok with this (ie double-check that they all have
>    a mapping: right now the free_pte() code in mm/memory.c doesn't care,
>    because it knew that it coul dmark even anonymous pages dirty and
>    they'd just get ignored.
>  - make a filemap_fdatasync() that walks the dirty pages and does a
>    writepage() on them all and moves them to the clean list.

We also want to move the page to the per-address-space clean list in
ClearPageDirty I suppose.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
