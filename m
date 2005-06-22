Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVFVREU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVFVREU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVFVRCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:02:44 -0400
Received: from [80.71.243.242] ([80.71.243.242]:27112 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261690AbVFVQ72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:59:28 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17081.39151.25553.436292@gargle.gargle.HOWL>
Date: Wed, 22 Jun 2005 20:59:27 +0400
To: Vladimir Saveliev <vs@namesys.com>
Cc: David Masover <ninja@slaphack.com>, Hans Reiser <reiser@namesys.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
In-Reply-To: <1119456807.4191.82.camel@tribesman.namesys.com>
References: <20050620235458.5b437274.akpm@osdl.org>
	<42B831B4.9020603@pobox.com>
	<42B87318.80607@namesys.com>
	<20050621202448.GB30182@infradead.org>
	<42B8B9EE.7020002@namesys.com>
	<42B8BB5E.8090008@pobox.com>
	<42B8E834.5030809@slaphack.com>
	<42B8F4BC.5060100@pobox.com>
	<42B92AA1.3010107@slaphack.com>
	<17081.30107.751071.983835@gargle.gargle.HOWL>
	<1119456807.4191.82.camel@tribesman.namesys.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Saveliev writes:
 > Hello
 > 
 > On Wed, 2005-06-22 at 18:28, Nikita Danilov wrote:
 > > David Masover writes:
 > > 
 > > [...]
 > > 
 > >  > 
 > >  > Maintainability is like optimization.  The maintainability of a
 > >  > non-working program is irrelevant.  You'd be right if we already had
 > >  > plugins-in-the-VFS.  We don't.  The most maintainable solution for
 > >  > plugins-in-the-FS that actually exists is Reiser4, exactly as it is now
 > >  > - -- because it is the _only_ one that actually exists right now.
 > > 
 > > But it is not so. There _are_ plugins-in-the-VFS. VFS operates on opaque
 > > objects (inodes, dentries, file system types) through interfaces:
 > > {inode,address_space,dentry,sb,etc.}_operations. Every file system
 > > back-end if free to implement whatever number of these interfaces. And
 > > the do this already: check the sources; even ext2 does this: e.g.,
 > > ext2_fast_symlink_inode_operations and ext2_symlink_inode_operations.
 > > 
 > 
 > imho, this is something different. Ext2 decides itself how to manage a
 > symlink depending on length of string the symlink is to store.
 > Reiser4 plugins are to allow a user to define himself which operations
 > file is to be managed with.

I fail to see this as an important distinction:

 - ext2    decides what "plugin" to use based on parameters supplied to
 the file creation system call;

 - reiser4 decides what "plugin" to use based on parameters supplied to
 the file creation system call.

 > 
 > > This is exactly what upper level reiser4 plugins are for.
 > 
 > > I guess that one of Christoph Hellwig's complaints is that reiser4
 > > introduces another layer of abstraction to implement something that
 > > already exists.
 > > 
 > 
 > I do not think that it exists already.
 > You can have standart type of files and that is all.
 > 
 > Linux filesystem is not supposed to provide anything but plain
 > regular/directory/symlinks/sockets/block device/char device/fifo files.

If you are talking about S_IFMT bits they are just a relic to keep user
level happy (yes, VFS does few S_ISFOO checks here and there, but they
all can be replaced with checks for appropriate operations being
non-NULL). Nothing prevents file system from rolling forward whatever
exotic objects it wants.

 > 
 > Existing file API does not allow create anything but that.
 > Merging reiser4 with object plugins would make it necessary to modify
 > VFS layer so that files of arbitrary types could be created.
 > 

This is important, but it doesn't depend on whether file system has
additional layer if indirection below VFS operations. If file system
wants to support extended object types, additional parameters have to be
somehow communicated from the user level during object creation. But:

 - this is necessary even if file system has no "plugins" below VFS
 operations;

 - this doesn't necessary means changing VFS. For example, these
 parameters can be set on parent directory (this is how ACLs were
 integrated into POSIX).

 >

Nikita.
