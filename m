Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWIAQfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWIAQfM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWIAQfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:35:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49895 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030197AbWIAQfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:35:09 -0400
Date: Fri, 1 Sep 2006 09:34:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, steved@redhat.com, trond.myklebust@fys.uio.no,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
 sharing [try #13]
Message-Id: <20060901093451.87aa486d.akpm@osdl.org>
In-Reply-To: <9534.1157116114@warthog.cambridge.redhat.com>
References: <20060831102127.8fb9a24b.akpm@osdl.org>
	<20060830135503.98f57ff3.akpm@osdl.org>
	<20060830125239.6504d71a.akpm@osdl.org>
	<20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	<27414.1156970238@warthog.cambridge.redhat.com>
	<9849.1157018310@warthog.cambridge.redhat.com>
	<9534.1157116114@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Sep 2006 14:08:34 +0100
David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Your CONFIG_BLOCK patches did a decent job of trashing your
> > fs-cache-make-kafs-* patches, btw.  What's up with that?  OK, it's sensible
> > for people to work against mainline but the net effect of doing that is to
> > create a mess for other people to clean up.
> 
> It seems the only problem in my patches is that the file address space
> operations have had the sync_pages op removed in a patch in the
> disable-block-layer patchset as it's no longer necessary.
> 
> However, as I suspect you're applying the block patches *before* the FS-Cache
> patches,

Yes, I stage the subsystem trees ahead of everything else.  So a) things
which get merged into a subsystem tree effectively do a queue-jump and b) I
spend much of the merge window twiddling thumbs until the git trees have
merged.

> I can't give you an incremental patch that you can apply after the
> other fs-cache-make-kafs-* patches, since you need to modify the first patch
> (fs-cache-make-kafs-use-fs-cache.patch) to get it to apply at all now.
> 
> So, I could issue a revised AFS+FS-Cache patch, would that do?  Or would you
> rather have a patch that you can apply to the one you already have directly
> and modify it in place?

I fixed it all up, I think.  Please review-and-test rc5-mm1 (including
hot-fixes/ contents, which grows apace).

nfs automounter submounts are still broken in Trond's tree, btw.  Are we stuck?
