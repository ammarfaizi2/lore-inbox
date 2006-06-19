Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWFSPt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWFSPt0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWFSPt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:49:26 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:59654 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932178AbWFSPtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:49:25 -0400
Message-ID: <4496C782.8090605@argo.co.il>
Date: Mon, 19 Jun 2006 18:49:22 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Theodore Tso <tytso@thunk.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 5/8] inode-diet: Eliminate i_blksize and use a per-superblock
 default
References: <20060619153109.817554000@candygram.thunk.org>
In-Reply-To: <20060619153109.817554000@candygram.thunk.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jun 2006 15:49:23.0800 (UTC) FILETIME=[EFCB1580:01C693B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
>
> This eliminates the i_blksize field from struct inode and uses default
> value in super->s_blksize.  Filesystems that want to provide a
> per-inode st_blksize can do so by providing their own getattr routine
> instead of using the generic_fillattr() function.
>

> Index: linux-2.6.17/include/linux/nfsd/nfsfh.h
> ===================================================================
> --- linux-2.6.17.orig/include/linux/nfsd/nfsfh.h        2006-06-18 
> 19:37:14.000000000 -0400
> +++ linux-2.6.17/include/linux/nfsd/nfsfh.h     2006-06-18 
> 19:53:54.000000000 -0400
> @@ -270,8 +270,8 @@
>         fhp->fh_post_uid        = inode->i_uid;
>         fhp->fh_post_gid        = inode->i_gid;
>         fhp->fh_post_size       = inode->i_size;
> -       if (inode->i_blksize) {
> -               fhp->fh_post_blksize    = inode->i_blksize;
> +       if (inode->i_sb->s_blksize) {
> +               fhp->fh_post_blksize    = inode->i_sb->s_blksize;
>                 fhp->fh_post_blocks     = inode->i_blocks;
>         } else {
>                 fhp->fh_post_blksize    = BLOCK_SIZE;
>

Isn't this a behavioral change?  If a filesystem chooses to provide 
i_blksize via a getattr method, it will not show on nfs mounts.

-- 
error compiling committee.c: too many arguments to function

