Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318086AbSIFGpO>; Fri, 6 Sep 2002 02:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318099AbSIFGpO>; Fri, 6 Sep 2002 02:45:14 -0400
Received: from pat.uio.no ([129.240.130.16]:4061 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S318086AbSIFGpN>;
	Fri, 6 Sep 2002 02:45:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15736.20490.154659.93421@charged.uio.no>
Date: Fri, 6 Sep 2002 08:49:46 +0200
To: Andrew Morton <akpm@zip.com.au>
Cc: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <3D780027.13A5B3B@zip.com.au>
References: <3D77D879.7F7A3385@zip.com.au>
	<15735.64356.246705.392224@charged.uio.no>
	<3D780027.13A5B3B@zip.com.au>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@zip.com.au> writes:

     > Oh.  I thought this was a "purely theoretical" discussion
     > because it only pertains to directory data.  You seem to be
     > saying that NFS is doing this for S_ISREG pagecache also?

Yes. Chuck's particular example pertains to directory data, but if
we're to expand the discussion to what *should* we be doing, then we
need to consider the S_ISREG case too.

     > Again: what do you _want_ to do?  Having potentially incorrect
     > pagecache mapped into process memory space is probably not the
     > answer to that ;)

     > Should we be forcibly unmapping the pages from pagetables?
     > That would result in them being faulted in again, and re-read.

If we could do that for unlocked pages, and at the same time flush out
any pending writes, then that would be ideal. As long as the
page_count() thing is there, we *do* unfortunately have a potential
for cache corruption.
 
    >> (btw: there's currently a bug w.r.t. that'. If I understand you
    >> correctly, the releasepage() thing is unrelated to
    >> page->buffers, but the call in shrink_cache() is masked by an
    >> 'if (page->buffers))

     > That would be in a 2.4 kernel?  In 2.4, page->buffers can only
     > contain buffers.  If it contains anything else the kernel will
     > die.

2.5.33
 
     > If your mapping has old, dirty pages then the VM will call your
    -> vm_writeback to write some of them back.  Or it will repeatedly
     > call ->writepage if you don't define ->vm_writeback.  That's
     > the place to clean the pages.

OK. I'll think about that. I'm off to France on a fortnight's vacation
now. Should leave me with a bit of free time, so once I finish the VFS
credential code, I'll try to find some time to catch up on your recent
changes...

Cheers,
  Trond
