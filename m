Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTFVWt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 18:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTFVWt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 18:49:58 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:15655 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263271AbTFVWt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 18:49:57 -0400
Date: Sun, 22 Jun 2003 16:04:31 -0700
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page cache readahead implemented?
Message-Id: <20030622160431.3e94369b.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0306222314500.1177-100000@localhost.localdomain>
References: <20030622114159.1ebbc236.akpm@digeo.com>
	<Pine.LNX.4.44.0306222314500.1177-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2003 23:04:03.0182 (UTC) FILETIME=[92D038E0:01C33912]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Sun, 22 Jun 2003, Andrew Morton wrote:
> > Hugh Dickins <hugh@veritas.com> wrote:
> > >
> > > do_mmap_pgoff's PROT_EXEC do_page_cache_readahead assumes that is
> > >  implemented for all mappings, but not all filesystems provide ->readpage.
> > 
> > Which filesystems?
> 
> No prize for guessing it was tmpfs I found the problem with.

Yeah, the usual blot on the kernelscape.

> Am I reading alloc_inode correctly, that the default it gives is
> an empty_aops with NULL readpage, but a backing_dev_info with non-0
> ra_pages?  How does your do_mmap_pgoff fare on a PROT_EXEC mapping
> of one of those mmaping device drivers?

Probably explodes?  I'm not particularly serious about that change - it
can be done in userspace.

Is the do_mmap_pgoff() hack the only offender?  If so it would be better to
localise the test in there too.

