Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263330AbSJOPTi>; Tue, 15 Oct 2002 11:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbSJOPTi>; Tue, 15 Oct 2002 11:19:38 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:40709 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263330AbSJOPTf>; Tue, 15 Oct 2002 11:19:35 -0400
Date: Tue, 15 Oct 2002 16:25:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021015162524.A27906@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <E181IS8-0001DQ-00@snap.thunk.org> <20021015125816.A22877@infradead.org> <20021015131507.GC31235@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021015131507.GC31235@think.thunk.org>; from tytso@mit.edu on Tue, Oct 15, 2002 at 09:15:07AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 09:15:07AM -0400, Theodore Ts'o wrote:
> Actually, I did, for those comments that made sense.  The fs/Config.in
> logic has been cleaned up, as well as removing excess header files,
> stray LINUX_VERSION_CODE #ifdef's that I had missed the first time
> around, etc.
> 
> fs/mbcache.c is still there because it applies to both ext2 and ext3
> filesystems, and so your suggestion of moving it into the ext2 and
> ext3 directories would cause code duplication and maintenance
> headaches.  It also *can* be used by other filesystems, as it is
> written in a generic way.  The fs/Config.in only compiles it in if
> necessary (i.e., if ext2/3 extended attribute is enabled) so it won't
> cause code bloat for other filesystems if it is not needed.
> 
> The superblock fields are more of an issue with the posix acl changes
> than for the extended attribute patches.  I had wanted to get the
> extended attribute changes in first, since they stand alone, and so I
> have fewer patches to juggle.

Patch 1: Config.in (all against 2.5.42-mm3):

The xattr options must be dep_mbool to actually work, ext2 xattrs
should depends on ext2, not ext3


--- linux-2.5.42-mm3-plain/fs/Config.in	Tue Oct 15 17:05:08 2002
+++ linux-2.5.42-mm3/fs/Config.in	Tue Oct 15 16:03:45 2002
@@ -27,7 +27,7 @@
 dep_tristate 'BFS file system support (EXPERIMENTAL)' CONFIG_BFS_FS $CONFIG_EXPERIMENTAL
 
 tristate 'Ext3 journalling file system support' CONFIG_EXT3_FS
-dep_bool '  Ext3 extended attributes' CONFIG_EXT3_FS_XATTR $CONFIG_EXT3_FS
+dep_mbool '  Ext3 extended attributes' CONFIG_EXT3_FS_XATTR $CONFIG_EXT3_FS
 # CONFIG_JBD could be its own option (even modular), but until there are
 # other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS
 # dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD $CONFIG_EXT3_FS
@@ -97,7 +97,7 @@
 tristate 'ROM file system support' CONFIG_ROMFS_FS
 
 tristate 'Second extended fs support' CONFIG_EXT2_FS
-dep_bool '  Ext2 extended attributes' CONFIG_EXT2_FS_XATTR $CONFIG_EXT3_FS
+dep_mbool '  Ext2 extended attributes' CONFIG_EXT2_FS_XATTR $CONFIG_EXT2_FS
 
 tristate 'System V/Xenix/V7/Coherent file system support' CONFIG_SYSV_FS
 
