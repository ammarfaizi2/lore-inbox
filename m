Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261361AbSIWUgc>; Mon, 23 Sep 2002 16:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSIWUgc>; Mon, 23 Sep 2002 16:36:32 -0400
Received: from mons.uio.no ([129.240.130.14]:18895 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S261361AbSIWUgb>;
	Mon, 23 Sep 2002 16:36:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15759.31838.68147.725840@charged.uio.no>
Date: Mon, 23 Sep 2002 22:41:02 +0200
To: Andrew Morton <akpm@digeo.com>
Cc: trond.myklebust@fys.uio.no, Rik van Riel <riel@conectiva.com.br>,
       Urban Widmark <urban@teststation.com>, Chuck Lever <cel@citi.umich.edu>,
       Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <3D8F6409.D45AA848@digeo.com>
References: <3D811A6C.C73FEC37@digeo.com>
	<15759.17258.990642.379366@charged.uio.no>
	<3D8F6409.D45AA848@digeo.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@digeo.com> writes:

     > Well it has to be a new thread, or user processes.

     > Would it be possible to mark the inode as "needs invalidation",
     > and make user processes check that flag once they have i_sem?

Not good enough unless you add those checks at the VFS/MM level. Think
for instance about mmap() where the filesystem is usually not involved
once a pagein has occurred.

     > Do we really need to invalidate individual pages, or is it
     > real-life acceptable to invalidate the whole mapping?

Invalidating the mapping is certainly a good alternative if it can be
done cleanly.
Note that in doing so, we do not want to invalidate any reads or
writes that may have been already scheduled. The existing mapping
still would need to hang around long enough to permit them to
complete.

     > Doing an NFS-special invalidate function is not a problem, btw
     > - my current invalidate_inode_pages() is just 25 lines.  It's
     > merely a matter of working out what it should do ;)

invalidate_inode_pages() *was* NFS-specific until you guys hijacked it
for other purposes in 2.5.x ;-)

Cheers,
   Trond
