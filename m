Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265918AbUBCCuo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 21:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265921AbUBCCuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 21:50:44 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:9736 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S265918AbUBCCun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 21:50:43 -0500
Date: Mon, 2 Feb 2004 21:50:41 -0500
To: linda.dunaphant@ccur.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.1 nfs4 mount version message
Message-ID: <20040203025040.GA11303@fieldses.org>
References: <200402030146.BAA22183@jedi.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402030146.BAA22183@jedi.ccur.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 08:46:29PM -0500, Linda Dunaphant wrote:
> In the file fs/nfs/inode.c in nfs4_get_sb() there is a test that compares
> the version of the incoming nfs4_mount_data versus NFS4_MOUNT_VERSION. If
> these do not match, a warning message is printed. Inside the printk() for
> this warning message, there is another test of the versions to determine
> whether the string "older" or "newer" should be printed.
> 
> Shouldn't this second test be comparing NFS4_MOUNT_VERSION instead of
> NFS_MOUNT_VERSION? 

Whoops, yes.

> I have included a patch for linux-2.6.1.

Thanks.--Bruce Fields

> diff -ur base.linux-2.6.1/fs/nfs/inode.c new.linux-2.6.1/fs/nfs/inode.c
> --- base.linux-2.6.1/fs/nfs/inode.c     2004-01-09 01:59:55.000000000 -0500
> +++ new.linux-2.6.1/fs/nfs/inode.c      2004-01-30 15:47:55.000000000 -0500
> @@ -1499,7 +1499,7 @@
>   
>         if (data->version != NFS4_MOUNT_VERSION) {
>                 printk("nfs warning: mount version %s than kernel\n",
> -                       data->version < NFS_MOUNT_VERSION ? "older" : "newer");
> +                       data->version < NFS4_MOUNT_VERSION ? "older" : "newer");        }
>   
>         p = nfs_copy_user_string(NULL, &data->hostname, 256);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
