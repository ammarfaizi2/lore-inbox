Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbVBXV3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVBXV3g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbVBXV3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:29:36 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:5598 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262486AbVBXV3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:29:33 -0500
Date: Thu, 24 Feb 2005 22:29:32 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 6/6] Bind Mount Extensions 0.06
Message-ID: <20050224212932.GF4981@mail.13thfloor.at>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20050222121333.GG3682@mail.13thfloor.at> <20050223230659.GE21383@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223230659.GE21383@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 11:06:59PM +0000, Christoph Hellwig wrote:
> > +++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/ext2/ioctl.c	2005-02-19 06:32:05 +0100
> > @@ -29,7 +29,8 @@ int ext2_ioctl (struct inode * inode, st
> >  	case EXT2_IOC_SETFLAGS: {
> >  		unsigned int oldflags;
> >  
> > -		if (IS_RDONLY(inode))
> > +		if (IS_RDONLY(inode) ||
> > +			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))
> 
> doing this in every filesystem ->ioctl is a really bad idea.  We need to
> add common handling for ext2-style file attributes first.

hmm, well, but the ioctls are somewhat mixed, i.e.
some of them do just read (only) like operations,
others do change stuff, and the test is just valid
for write/change ioctls ...

of course I could add a second switch/case block
which checks for 'write' type ioctls and blocks
them in the beginning ... 

but maybe I did misunderstood your comment, so let
me know what you consider appropriate ...

> Also please add a file_readonly() helper - when introduced it only checks
> IS_RDONLY(file->f_dentry->d_inode) and once you add per-mount flags it
> only needs to be added in a single place. Actually probably a lowelevel
> one taking inode,vfsmount and wrappers for a struct file * or
> struct nameidata * which would cover most of the cases.

actually I started the BME patches by extending the
IS_RDONLY() macro to take two arguments, the inode 
and the vfsmount (which sounded natural to me) but
that was shot down ... (don't remember why exactly)

no problem with a file_readonly() or nd_readonly()
if that makes folks happy ...

thanks,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
