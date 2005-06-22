Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVFVQRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVFVQRR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVFVQRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:17:10 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:19387 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261551AbVFVQNx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:13:53 -0400
Subject: Re: reiser4 plugins
From: Vladimir Saveliev <vs@namesys.com>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: David Masover <ninja@slaphack.com>, Hans Reiser <reiser@namesys.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <17081.30107.751071.983835@gargle.gargle.HOWL>
References: <20050620235458.5b437274.akpm@osdl.org>
	 <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com>
	 <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com>
	 <42B8BB5E.8090008@pobox.com> <42B8E834.5030809@slaphack.com>
	 <42B8F4BC.5060100@pobox.com> <42B92AA1.3010107@slaphack.com>
	 <17081.30107.751071.983835@gargle.gargle.HOWL>
Content-Type: text/plain
Message-Id: <1119456807.4191.82.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 22 Jun 2005 20:13:28 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Wed, 2005-06-22 at 18:28, Nikita Danilov wrote:
> David Masover writes:
> 
> [...]
> 
>  > 
>  > Maintainability is like optimization.  The maintainability of a
>  > non-working program is irrelevant.  You'd be right if we already had
>  > plugins-in-the-VFS.  We don't.  The most maintainable solution for
>  > plugins-in-the-FS that actually exists is Reiser4, exactly as it is now
>  > - -- because it is the _only_ one that actually exists right now.
> 
> But it is not so. There _are_ plugins-in-the-VFS. VFS operates on opaque
> objects (inodes, dentries, file system types) through interfaces:
> {inode,address_space,dentry,sb,etc.}_operations. Every file system
> back-end if free to implement whatever number of these interfaces. And
> the do this already: check the sources; even ext2 does this: e.g.,
> ext2_fast_symlink_inode_operations and ext2_symlink_inode_operations.
> 

imho, this is something different. Ext2 decides itself how to manage a
symlink depending on length of string the symlink is to store.
Reiser4 plugins are to allow a user to define himself which operations
file is to be managed with.

> This is exactly what upper level reiser4 plugins are for.

> I guess that one of Christoph Hellwig's complaints is that reiser4
> introduces another layer of abstraction to implement something that
> already exists.
> 

I do not think that it exists already.
You can have standart type of files and that is all.

Linux filesystem is not supposed to provide anything but plain
regular/directory/symlinks/sockets/block device/char device/fifo files.

Existing file API does not allow create anything but that.
Merging reiser4 with object plugins would make it necessary to modify
VFS layer so that files of arbitrary types could be created.



