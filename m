Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265937AbTFVWN5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 18:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265940AbTFVWN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 18:13:57 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:5817 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S265937AbTFVWN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 18:13:56 -0400
Date: Sun, 22 Jun 2003 23:29:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page cache readahead implemented?
In-Reply-To: <20030622114159.1ebbc236.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0306222314500.1177-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jun 2003, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > do_mmap_pgoff's PROT_EXEC do_page_cache_readahead assumes that is
> >  implemented for all mappings, but not all filesystems provide ->readpage.
> 
> Which filesystems?

No prize for guessing it was tmpfs I found the problem with.
Which others?  I don't know, and wouldn't trust any answer I came up with.
Plus we can't tell beyond what's in the kernel tree itself.

> For tmpfs and other memory-backed filesystems we could perhaps just
> rely on backing_dev_info.ra_pages being zero.  For others, maybe
> we should just say "thou shalt implement readpage".

I've no great attachment to my "page_cache_readahead_implemented()",
and it would be just fine to say that anyone who implements readpages
must also implement readpage, drop that part of the test.

But what you suggest above sounds much too shaky (or draconian) to me -
particularly since disobedience shows up as a hang rather than an oops.

Am I reading alloc_inode correctly, that the default it gives is
an empty_aops with NULL readpage, but a backing_dev_info with non-0
ra_pages?  How does your do_mmap_pgoff fare on a PROT_EXEC mapping
of one of those mmaping device drivers?

Hugh

