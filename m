Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262083AbSJJSsH>; Thu, 10 Oct 2002 14:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262125AbSJJSsH>; Thu, 10 Oct 2002 14:48:07 -0400
Received: from ns.suse.de ([213.95.15.193]:55312 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262083AbSJJSsG> convert rfc822-to-8bit;
	Thu, 10 Oct 2002 14:48:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [Ext2-devel] [RFC] [PATCH 1/5] ACL support for ext2/3
Date: Thu, 10 Oct 2002 20:53:49 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, ext2-devel@sourceforge.net, tytso@mit.edu
References: <E17zVaD-00069Y-00@snap.thunk.org> <20021010193433.A26873@infradead.org>
In-Reply-To: <20021010193433.A26873@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210102053.49806.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 October 2002 20:34, Christoph Hellwig wrote:
> [...]
> > diff -Nru a/include/linux/fs.h b/include/linux/fs.h
> > --- a/include/linux/fs.h	Wed Oct  9 23:53:33 2002
> > +++ b/include/linux/fs.h	Wed Oct  9 23:53:33 2002
> > @@ -770,6 +770,9 @@
> >  	unsigned long (*get_unmapped_area)(struct file *, unsigned long,
> > unsigned long, unsigned long, unsigned long); };
> >
> > +/* posix_acl.h */
> > +struct posix_acl;
> > +
> >  struct inode_operations {
> >  	int (*create) (struct inode *,struct dentry *,int);
> >  	struct dentry * (*lookup) (struct inode *,struct dentry *);
> > @@ -791,6 +794,8 @@
> >  	ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t);
> >  	ssize_t (*listxattr) (struct dentry *, char *, size_t);
> >  	int (*removexattr) (struct dentry *, const char *);
> > +	struct posix_acl *(*get_posix_acl) (struct inode *, int);
> > +	int (*set_posix_acl) (struct inode *, int, struct posix_acl *);
>
> Either you make all setting/retrieving of ACLs go through this interface or
> just rip it.  We don't need more than one way to fiddle with ACLs.

This is an open design problem. Going through the xattr interface is too slow 
for the nfs_permission_mode hack (which if enabled masks off permissions 
before sending them to old clients to be on the safe side). On the other 
hand, always going through the inode operations is also quirky as we would 
need to dispatch xattr names and decode values both in the VFS and in the FS. 
A clean solution to this would be very welcome.

> Also they should take dentries.
They will once permission() also takes dentries. Before that they can't.

--Andreas.

