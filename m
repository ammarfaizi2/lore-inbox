Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753883AbWKGA1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbWKGA1E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 19:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753937AbWKGA1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 19:27:03 -0500
Received: from mail.fieldses.org ([66.93.2.214]:40832 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1753884AbWKGA1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 19:27:01 -0500
Date: Mon, 6 Nov 2006 19:26:57 -0500
To: Srinivasa Ds <srinivasa@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, neilb@suse.de,
       nfs@lists.sourceforge.net, andros@citi.umich.edu
Subject: Re: [PATCH] NFS4  fix for recursive locking problem.
Message-ID: <20061107002657.GN12372@fieldses.org>
References: <454755B0.5020103@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454755B0.5020103@in.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 07:24:56PM +0530, Srinivasa Ds wrote:
> When I was performing some operations on NFS, I got below error on server 
> side.
> 
> ===========================================================
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> 2.6.19-prep #1
...
> So I have developed the patch to overcome this problem. Please let me know 
> your comments on this.

Looks right, thanks!

--b.

> Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>
> 
> 
> 

>  nfs4recover.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.19-rc3/fs/nfsd/nfs4recover.c
> ===================================================================
> --- linux-2.6.19-rc3.orig/fs/nfsd/nfs4recover.c	2006-10-24 04:32:02.000000000 +0530
> +++ linux-2.6.19-rc3/fs/nfsd/nfs4recover.c	2006-10-31 18:27:30.000000000 +0530
> @@ -274,7 +274,7 @@
>  	 * any regular files anyway, just in case the directory was created by
>  	 * a kernel from the future.... */
>  	nfsd4_list_rec_dir(dentry, nfsd4_remove_clid_file);
> -	mutex_lock(&dir->d_inode->i_mutex);
> +	mutex_lock_nested(&dir->d_inode->i_mutex, I_MUTEX_PARENT);
>  	status = vfs_rmdir(dir->d_inode, dentry);
>  	mutex_unlock(&dir->d_inode->i_mutex);
>  	return status;

