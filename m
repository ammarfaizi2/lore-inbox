Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316864AbSF1QbQ>; Fri, 28 Jun 2002 12:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316903AbSF1QbQ>; Fri, 28 Jun 2002 12:31:16 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:21822 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S316864AbSF1QbP>; Fri, 28 Jun 2002 12:31:15 -0400
Date: Fri, 28 Jun 2002 17:33:21 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel lock order
In-Reply-To: <3D1C64BD.4F57F3EE@bull.net>
Message-ID: <Pine.LNX.4.21.0206281705470.1260-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2002, Zoltan Menyhart wrote:
> Is there a list describing the lock hierarchy ?

There is indeed Documentation/vm/locking - but I wouldn't trust it
for an instant!  These details change from time to time, Documentation
is likely to lag far behind, the source must be your reference.

There is also a very useful "NOTE:" in the 2.4 mm/filemap.c, which did
get updated in 2.4.14; but that doesn't mention the page_table_lock.

> Does do_swap_page() (in mm/memory.c) release mm->page_table_lock because
> one cannot hold this lock when lookup_swap_cache() ... __find_get_page()
> takes pagecache_lock ? Or does it do only for shorten the locked path ?
> (Can I keep mm->page_table_lock when I call __find_get_page() ?)

I deduce from "pagecache_lock" that you're asking about current 2.4,
though I think an equivalent answer would apply to current 2.5. It does
it to shorten the locked path, you could hold mm->page_table_lock when
you call __find_get_page(): a precedent is where do_swap_page() holds
page_table_lock while calling remove_exclusive_swap_page(), which may
take the pagecache_lock.

But tomorrow... who knows?

Hugh

