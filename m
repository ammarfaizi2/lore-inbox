Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbSJAEEs>; Tue, 1 Oct 2002 00:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261475AbSJAEEr>; Tue, 1 Oct 2002 00:04:47 -0400
Received: from thunk.org ([140.239.227.29]:63398 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261474AbSJAEEr>;
	Tue, 1 Oct 2002 00:04:47 -0400
To: linux-kernel@vger.kernel.org
Subject: New set of code snapshots for ext3-dxdir (kernel and userspace)
From: tytso@mit.edu
Phone: (781) 391-3464
Message-Id: <E17wELv-00028q-00@think.thunk.org>
Date: Tue, 01 Oct 2002 00:09:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Sep 29, 2002 at 07:46:57PM -0700, Ryan Cumming wrote:
> On September 29, 2002 01:16, Ryan Cumming wrote:  
> > Case 1:
> > "Problem in HTREE directory inode 2 (/): bad block 3223649"

This turned out to actually be an e2fsprogs bug, not a kernel bug.
E2fsck was getting confused in some cases and interpreting a completely
empty directory block as a HTREE interior node, and thus incorrectly
flagging a valid HTREE directory as being corrupt.  Your test case tends
to generate the empty directory blocks because it does a large amounts
of creates and deletes.

Anyway, let's try to synchronize on a common set of kernel patches and
userspace utilities, and see whether or not we've managed to get all of
the problems fixed.

For the kernel patches, I've created a patches against 2.4.19 and 2.5.39
that include the Andreas' kernel stack usage patch and Chrisl' empty
directory entry split patch, which can be found here: 

        http://thunk.org/tytso/linux/ext3-dxdir/patch-ext3-dxdir-2.4.19-3
        http://thunk.org/tytso/linux/ext3-dxdir/patch-ext3-dxdir-2.5.39   

In addition, I've released new e2fsprogs test release, which you can
obtain from sourceforge:

http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.30-WIP-0930.tar.gz

With these code base, and using a freshly created filesystem, I haven't
been able to reproduce any problems using Ryan's fs-ream.c stress
tester.  So I'm pretty confident about its stability, although there
might possibly be some race conditions lurking about under extreme load.

Ryan, you care to give it a go, and see what you can find?   

                                                - Ted
