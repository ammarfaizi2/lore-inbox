Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUCANPZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 08:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUCANPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 08:15:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37804 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261252AbUCANPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 08:15:23 -0500
Date: Mon, 1 Mar 2004 08:15:43 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Urban Widmark <urban@teststation.com>
cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [SELINUX] Handle fuse binary mount data.
In-Reply-To: <Pine.LNX.4.44.0403011007300.6156-100000@cola.local>
Message-ID: <Xine.LNX.4.44.0403010809470.24584-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2004, Urban Widmark wrote:

> On Sun, 29 Feb 2004, James Morris wrote:
> 
> > It seems more like a property of the filesystem type: perhaps add 
> > FS_BINARY_MOUNTDATA to fs_flags for such filesystems, per the patch below.
> ...
> > diff -urN -X dontdiff linux-2.6.3-mm4.o/fs/smbfs/inode.c linux-2.6.3-mm4.w/fs/smbfs/inode.c
> > --- linux-2.6.3-mm4.o/fs/smbfs/inode.c	2003-10-15 08:53:19.000000000 -0400
> > +++ linux-2.6.3-mm4.w/fs/smbfs/inode.c	2004-02-29 19:50:58.172037088 -0500
> > @@ -778,6 +778,7 @@
> >  	.name		= "smbfs",
> >  	.get_sb		= smb_get_sb,
> >  	.kill_sb	= kill_anon_super,
> > +	.fs_flags	= FS_BINARY_MOUNTDATA,
> >  };
> >  
> >  static int __init init_smb_fs(void)
> 
> smbfs does not have a binary mountdata, unless the smbmount used is really
> old (samba 2.0). If that means that it should get a FS_BINARY_MOUNTDATA
> flag or not, I don't know.

Well, smb_fill_super() looks like it is dealing with binary mount data 
initially, and we need to treat it as such.  This should be fixed properly 
so that different versions of smbfs have different filesystem types, like 
NFS.


- James
-- 
James Morris
<jmorris@redhat.com>


