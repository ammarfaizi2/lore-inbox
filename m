Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbVAJWmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVAJWmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVAJWjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:39:42 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:26548 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262573AbVAJWa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:30:26 -0500
To: Michael.Waychison@Sun.COM
CC: akpm@osdl.org, torvalds@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <41E2F654.5090707@sun.com> (message from Mike Waychison on Mon,
	10 Jan 2005 16:40:36 -0500)
Subject: Re: [PATCH 2/11] FUSE - core
References: <E1Co4kB-00044r-00@dorka.pomaz.szeredi.hu> <41E2F654.5090707@sun.com>
Message-Id: <E1Co81z-0004ef-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Jan 2005 23:28:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > + *
> > + *  - the private_data field of the device file
> > + *  - the s_fs_info field of the super block
> > + *  - unused_list, pending, processing lists in fuse_conn
> > + *  - the unique request ID counter reqctr in fuse_conn
> > + *  - the sb (super_block) field in fuse_conn
> > + *  - the file (device file) field in fuse_conn
> > + */
> 
> These comments seem out of date.  There is no unused_lsit, pending or
> processing lists in fuse_conn.  Nor is there a reqctr or file.
> 

[...]

> > +		return NULL;
> > +	spin_lock(&fuse_lock);
> > +	fc->sb = sb;
> > +	spin_unlock(&fuse_lock);
> 
> The lock here looks unnessary, fc is private to this function at this point.

Yes, well these are caused by the split.  Later patches will explain
these.  I could split up the comment too...

> > +static int fuse_read_super(struct super_block *sb, void *data, int silent)
> 
> Can you rename this to fuse_fill_super so its consistent with what the
> VFS calls it?

Yes.

> > +		fuse_inode_cachep = kmem_cache_create("fuse_inode",
> > +						      sizeof(struct inode) + sizeof(struct fuse_inode) ,
> 
> I'm not convinced this will get the right alignments in the case where
> struct inode ever changes size.  You're better off using a new struct
> that contains both and using the size of it here, as well as using it
> for calculating the offset in get_fuse_inode instead of &inode[1].

Good point. I haven't thought of this.

> > +int __init fuse_init(void)
> 
> static?

OK.

> > +{
> > +	printk(KERN_DEBUG "fuse exit\n");
> > +
> > +	fuse_fs_cleanup();
> > +}
> 
> Why not just do the cleanup here?  If you still want to keep fuse_exit
> seperate from fuse_fs_cleanup, may I suggest marking the former __exit?

Again, later patches explain this.

> > +/** Version number of this interface */
> > +#define FUSE_KERNEL_VERSION 5
> > +
> > +/** Minor version number of this interface */
> > +#define FUSE_KERNEL_MINOR_VERSION 1
> 
> I haven't yet looked at the other patches, but is this VERSION info
> negotiated with userspace?

Yes.

Thanks for the comments!

Miklos
