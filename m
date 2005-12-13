Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbVLMWjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbVLMWjf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbVLMWjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:39:35 -0500
Received: from verein.lst.de ([213.95.11.210]:2783 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1030323AbVLMWje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:39:34 -0500
Date: Tue, 13 Dec 2005 23:39:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] per-mount noatime and nodiratime
Message-ID: <20051213223928.GA22373@lst.de>
References: <20051213175659.GF17130@lst.de> <20051213143638.120ee601.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213143638.120ee601.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 02:36:38PM -0800, Andrew Morton wrote:
> Where'd this hunk come from?
> 
> > Index: linux-2.6.15-rc5/fs/super.c
> > ===================================================================
> > --- linux-2.6.15-rc5.orig/fs/super.c	2005-12-13 11:27:14.000000000 +0100
> > +++ linux-2.6.15-rc5/fs/super.c	2005-12-13 12:06:00.000000000 +0100
> > @@ -830,9 +830,9 @@
> >  	mnt->mnt_parent = mnt;
> >  
> >  	if (type->fs_flags & FS_NOATIME)
> > -		sb->s_flags |= MS_NOATIME;
> > +		mnt->mnt_flags |= MNT_NOATIME;
> >  	if (type->fs_flags & FS_NODIRATIME)
> > -		sb->s_flags |= MS_NODIRATIME;
> > +		mnt->mnt_flags |= MNT_NODIRATIME;
> >  
> >  	up_write(&sb->s_umount);
> >  	free_secdata(secdata);
> 
> I just dropped it, but it's a worry...

This is totally intentional.  The FS_* flags were introduced in the
previous patch to mark filesystems that always are NOATIME/NODIRATIME,
and with this patch we need to set them in the vfsmount instead of the
superblock.
