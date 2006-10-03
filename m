Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030555AbWJCVXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030555AbWJCVXm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 17:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030557AbWJCVXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 17:23:42 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:2674 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030555AbWJCVXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 17:23:41 -0400
Date: Tue, 3 Oct 2006 14:23:35 -0700
From: Chris Wedgwood <cw@f00f.org>
To: David Chinner <dgc@sgi.com>
Cc: xfs-dev@sgi.com, xfs@oss.sgi.com, dhowells@redhat.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/3] Convert XFS inode hashes to radix trees
Message-ID: <20061003212335.GA13120@tuatara.stupidest.org>
References: <20061003060610.GV3024@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003060610.GV3024@melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 04:06:10PM +1000, David Chinner wrote:

> Overall, the patchset removes more than 200 lines of code from the
> xfs inode caching and lookup code and provides more consistent
> scalability for large numbers of cached inodes. The only down side
> is that it limits us to 32 bit inode numbers of 32 bit platforms due
> to the way the radix tree uses unsigned longs for it's indexes

    commit afefdbb28a0a2af689926c30b94a14aea6036719
    tree 6ee500575cac928cd90045bcf5b691cf2b8daa09
    parent 1d32849b14bc8792e6f35ab27dd990d74b16126c
    author David Howells <dhowells@redhat.com> 1159863226 -0700
    committer Linus Torvalds <torvalds@g5.osdl.org> 1159887820 -0700

    [PATCH] VFS: Make filldir_t and struct kstat deal in 64-bit inode numbers

    These patches make the kernel pass 64-bit inode numbers internally when
    communicating to userspace, even on a 32-bit system.  They are required
    because some filesystems have intrinsic 64-bit inode numbers: NFS3+ and XFS
    for example.  The 64-bit inode numbers are then propagated to userspace
    automatically where the arch supports it.
    [...]

Doing this will mean XFS won't be able to support 32-bit inodes on
32-bit platforms the above (merged) patch --- though given that cheap
64-bit systems are now abundant does anyone really care?
