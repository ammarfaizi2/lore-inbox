Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbSJPNFn>; Wed, 16 Oct 2002 09:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262481AbSJPNFn>; Wed, 16 Oct 2002 09:05:43 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:39180 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262450AbSJPNFm>; Wed, 16 Oct 2002 09:05:42 -0400
Date: Wed, 16 Oct 2002 14:11:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: tytso@mit.edu
Cc: torvalds@transmeta.com, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Add POSIX Access Control Lists to ext2/3
Message-ID: <20021016141103.A8393@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, tytso@mit.edu,
	torvalds@transmeta.com, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <E181a3b-0006Nu-00@snap.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E181a3b-0006Nu-00@snap.thunk.org>; from tytso@mit.edu on Tue, Oct 15, 2002 at 06:20:55PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 06:20:55PM -0400, tytso@mit.edu wrote:
> 
> The following five patches add Posix ACL support to the 2.5 kernel.  The
> first three patches are generic, and will be useful to other filesystems
> who also have ACL support on deck (in particular, the JFS and XFS
> folks).  The last two patches add ACL support to the ext2 and ext3
> filesystems.  These patches are safe, in that the code paths remain
> largely untouched if they the compile-time option is not enabled, and
> even if ACL support is compiled in, the filesystem must be explicitly
> mounted a mount-option to enable ACL support.
> 
> These pataches require that the extended attribute patches be applied
> first.

Linux, please domn't apply these ACL patches until the inode method mess is
sorted out.

Ted, please either go _always_ through the {get,set}_posix_acl methods
or never.  Currently XFS doesn't know and doesn't want to know
about the so called "egenric ACL representation" used by ext2/ext3.  With
theses methods we'd have to add it to XFS which is fine for me as long as
it the representation generally used for working with ACLs.  That would mean
we'd have to add new syscall or at least VFS-level hooks to the xattr code.

Or just declare the xattr representation the default one, remove
the get_posix_acl/set_posix_acl code from this code and fix up the nfsd
patch (that doesn't seem to be submitted yet) up to us the xattr
representation.
