Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313165AbSEIOZy>; Thu, 9 May 2002 10:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313173AbSEIOZx>; Thu, 9 May 2002 10:25:53 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:33219 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S313165AbSEIOZs>; Thu, 9 May 2002 10:25:48 -0400
Date: Thu, 9 May 2002 14:50:11 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
        akpm@zip.com.au, cr@sap.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] double flush_page_to_ram
In-Reply-To: <20020509152116.A8428@dualathlon.random>
Message-ID: <Pine.LNX.4.21.0205091446070.10938-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2002, Andrea Arcangeli wrote:
> 
> If yes, I prefer to move the flush_page_to_ram on the _pagecache_
> _before_ the memcpy into memory.c, it's cleaner if the pagecache layer
> doesn't need to care about cache aliasing between kernel direct mapping
> and userspace address space (but that it only cares about struct pages
> and filesystem, so only kernel side), and that such user-related part is
> covered only in memory.c.

Agreed.  It's better to keep flush_page_to_ram out of filemap_nopage
(and how many other _nopages that ought at present to have it according
to David, but don't).  As things stand, it's being done unnecessarily
twice on the shared maps: your proposal fixes that.

Hugh

