Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWBAMIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWBAMIv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWBAMIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:08:51 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:37618 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932383AbWBAMIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:08:51 -0500
Date: Wed, 1 Feb 2006 13:08:40 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Vincent Hanquez <tab@snarc.org>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, viro@zeniv.linux.org.uk
Subject: Re: [BUG] debugfs: hard link count wrong
Message-ID: <20060201120840.GD9361@osiris.boeblingen.de.ibm.com>
References: <20060126141142.GA11599@osiris.boeblingen.de.ibm.com> <20060127032513.GA12559@suse.de> <20060127055607.GA9331@osiris.boeblingen.de.ibm.com> <20060127063804.GA4680@suse.de> <20060127070423.GB9331@osiris.boeblingen.de.ibm.com> <20060127071749.GA13924@suse.de> <20060127174332.GA19649@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127174332.GA19649@snarc.org>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> looks like all fs that use simple_fill_super got a root inode with
> i_nlink=1 at the start of day.
> 
> I've compared with shmem, the nlink is incremented to 2 by a call to
> shmem_get_inode, when filling_super.
> 
> I've test the following patch with debugfs and securityfs, and its
> seems to cure the problem.
> 
> ------
> 
> Fix incorrect nlink of root inode for filesystems that use simple_fill_super
> 
> Signed-off-by: Vincent Hanquez <vincent@snarc.org>
> 
> diff -Naur a/fs/libfs.c a/fs/libfs.c
> --- a/fs/libfs.c	2006-01-03 03:21:10.000000000 +0000
> +++ b/fs/libfs.c	2006-01-27 17:43:31.000000000 +0000
> @@ -388,6 +388,7 @@
>  	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
>  	inode->i_op = &simple_dir_inode_operations;
>  	inode->i_fop = &simple_dir_operations;
> +	inode->i_nlink = 2;
>  	root = d_alloc_root(inode);
>  	if (!root) {
>  		iput(inode);
> 
> -

Sorry to annoy you, but does this patch look ok? Who is actually the
maintainer of libfs?
Thought it would be good to have this fixed...
Thread started here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113828486029233&w=2

Thanks,
Heiko
