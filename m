Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUHHQXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUHHQXf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 12:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbUHHQXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 12:23:34 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:11958 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265887AbUHHQXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 12:23:08 -0400
Date: Sun, 8 Aug 2004 17:22:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andi Kleen <ak@muc.de>
cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow to disable shmem.o
In-Reply-To: <20040808142829.GC94449@muc.de>
Message-ID: <Pine.LNX.4.44.0408081711530.1983-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Aug 2004, Andi Kleen wrote:
> On Sun, Aug 08, 2004 at 09:07:05AM -0500, Matt Mackall wrote:
> > +extern struct inode *ramfs_get_inode(struct super_block *sb, int mode, dev_t dev);
> > +extern struct super_block *ramfs_get_sb(struct file_system_type *fs_type,
> > +	 int flags, const char *dev_name, void *data);
> > +extern struct file_operations ramfs_file_operations;
> > +extern struct vm_operations_struct generic_file_vm_ops;
> 
> This should be all in header files.

Yes.

> > +	if (IS_ERR(shm_mnt))
> > +		return (void *)shm_mnt;
> 
> Why this strange cast? 

Matt copied from shmem.c, so blame me.  Strange cast because it's one
of those IS_ERR things, an -errno hiding inside a pointer, and it's
being propagated from an initialization error on shm_mnt to a runtime
error on any struct file for that mount.  I wrote (void *) because it
seemed to express the ambiguity better than pretending struct file *.

> > +	inode = ramfs_get_inode(root->d_sb, S_IFREG | S_IRWXUGO, 0);
> 
> Hmm, won't this allow everybody else to open it in /proc/pid/fd/ ? 
> (existing shmem.c seems to use it too, but it looks a bit bogus) 

But there's no fd associated with it?

Hugh

