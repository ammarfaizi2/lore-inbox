Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbTDDVtm (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbTDDVtm (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:49:42 -0500
Received: from mons.uio.no ([129.240.130.14]:28548 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id S261359AbTDDVtj (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 16:49:39 -0500
To: Steve Dickson <SteveD@redhat.com>
Cc: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] [PATCH] mmap corruption
References: <3E8DDB13.9020009@RedHat.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 05 Apr 2003 00:01:02 +0200
In-Reply-To: <3E8DDB13.9020009@RedHat.com>
Message-ID: <shsistt7wip.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Steve Dickson <SteveD@redhat.com> writes:

     > The Cause: Memory mapped pages were not being flushed out in a
     > timely manner. When a file is about to truncated (up or down),
     > nfs_writepage() is called (by filemap_fdatasync()) to flush out
     > dirty pages. When this done asynchronously, nfs_writepage()
     > will (indirectly) call nfs_strategy().  nfs_strategy() wants to
     > send groups of pages (in this case 4 pages). Now in the error
     > case, only one page was dirty so it was *not* flushed out.
     > Eventually that page would be flushed (by kupdate) but it was
     > too late because the file size had already change due to a
     > second truncation.

That simply doesn't ring true. The nfs_wb_all() immediately after the
call to filemap_fdatasync() should ensure that *all* scheduled writes
will flushed out.

Cheers,
  Trond
