Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263931AbUDFSB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbUDFSB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:01:58 -0400
Received: from ns.suse.de ([195.135.220.2]:63148 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263931AbUDFSBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:01:39 -0400
Subject: [PATCH] reiserfs v3 fixes and features
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Message-Id: <1081274618.30828.30.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Apr 2004 14:03:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

You can download the set of experimental reiserfs v3 patches from:

ftp://ftp.suse.com/pub/people/mason/patches/reiserfs/2.6.5

Since some of these are in -mm and some are not, there are two series
files.  series.linus gives you the patches needed for mainline 2.6.5,
and series.mm gives you the patches needed for 2.6.5-mm1

Most of these are from Jeff Mahoney and I, they include:

bug fixes
logging optimizations
data=ordered support
xattrs
acls
quotas
error messages with device names (based on Oleg's 2.4 patch)
block allocator improvements

Jeff Mahoney's acls and xattrs for reiserfs v3 have been in use in the
suse 2.4 kernels and now 2.6 kernels for a while.  I've posted for
review to namesys many times, but Hans refuses to consider or read the
code.   I renewed my efforts over the last month to talk with him about
the code, but he has ignored it entirely.

His past objections seem to be that he doesn't want new features in v3. 
The implementation does not change the disk format in any way (xattrs
are stored as regular files in a hidden directory) and is stable.  I
believe reiserfs needs these features in order to stay current in the
kernel, so I'm posting for inclusion in -mm.  I'm sending Andrew the
following patches from series.mm:

reiserfs-end-trans-bkl 
reiserfs-acl-mknod.diff 
reiserfs-xattrs-04 
reiserfs-acl-02 
reiserfs-trusted-02 
reiserfs-selinux-02 
reiserfs-xattr-locking-02 
reiserfs-quota 
permission-reiserfs 
reiserfs-warning 

(which is everything except the new block allocator code)

The block allocator improvements is our attempt to reduce
fragmentation.  The patch defaults to the regular 2.6.5 block allocator,
but has options documented at the top of the patch that allow grouping
of blocks by packing locality or object id.  It also has an option to
inherit lightly used packing localities across multiple subdirs, which
keeps things closer together in the tree if you have a bunch of subdirs
without much in them.

If anyone is interested in experimenting with the block allocator stuff,
please let me know.

-chris


