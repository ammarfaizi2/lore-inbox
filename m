Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265117AbSJPPoZ>; Wed, 16 Oct 2002 11:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265118AbSJPPoZ>; Wed, 16 Oct 2002 11:44:25 -0400
Received: from thunk.org ([140.239.227.29]:24528 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S265117AbSJPPoX>;
	Wed, 16 Oct 2002 11:44:23 -0400
Date: Wed, 16 Oct 2002 11:50:12 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Add POSIX Access Control Lists to ext2/3
Message-ID: <20021016155012.GA8210@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <E181a3b-0006Nu-00@snap.thunk.org> <20021016141103.A8393@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016141103.A8393@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 02:11:04PM +0100, Christoph Hellwig wrote:
> Ted, please either go _always_ through the {get,set}_posix_acl methods
> or never.  Currently XFS doesn't know and doesn't want to know
> about the so called "egenric ACL representation" used by ext2/ext3.  With
> theses methods we'd have to add it to XFS which is fine for me as long as
> it the representation generally used for working with ACLs.  That would mean
> we'd have to add new syscall or at least VFS-level hooks to the xattr code.

Fine.  I'll just yank the {get,set}_posix_acl methods for now.  The
inode methods were only needed for the NFS code (see Andreas' comments
about the xattr interfaces being problematical for VFS support).  

However, the reality is that at this point, we probably won't have
time to get support in for the NFS server ACL before feature freeze,
and changing the interface to ACL's (never mind the headaches of
trying to agree to a new syscall interface at this late date), given
the deployed userspace tools, just doesn't seem to be realistic.

So if you or Andreas has time to work on NFS server support for ACL's
in the next two days, great, but I'm going to just pass on this for
now.  Later on, we can figure out what changes are necessary to all of
the various filesystems so that nfsd can get what information it
needs.

						- Ted
