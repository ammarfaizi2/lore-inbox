Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWEEFh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWEEFh3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 01:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWEEFh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 01:37:29 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:17423 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932468AbWEEFh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 01:37:28 -0400
Date: Fri, 5 May 2006 07:37:18 +0200
From: Willy Tarreau <willy@w.ods.org>
To: marcelo@kvack.org
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Steven French <sfrench@us.ibm.com>,
       Mark Moseley <moseleymark@gmail.com>
Subject: Re: [PATCH] smbfs chroot issue (CVE-2006-1864)
Message-ID: <20060505053718.GE11191@w.ods.org>
References: <20060505014041.GZ24291@moss.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505014041.GZ24291@moss.sous-sol.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

This patch also applies to 2.4, did you receive it on your side or do you
want me to queue it in -upstream ?

Regards,
Willy

On Thu, May 04, 2006 at 06:40:41PM -0700, Chris Wright wrote:
> From: Olaf Kirch <okir@suse.de>
> 
> Mark Moseley reported that a chroot environment on a SMB share can be
> left via "cd ..\\".  Similar to CVE-2006-1863 issue with cifs, this fix
> is for smbfs.
> 
> Steven French <sfrench@us.ibm.com> wrote:
> 
> Looks fine to me.  This should catch the slash on lookup or equivalent,
> which will be all obvious paths of interest.
> 
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>  This fix is in -stable, but doesn't appear to be in your tree yet.
> 
>  fs/smbfs/dir.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- linus-2.6.orig/fs/smbfs/dir.c
> +++ linus-2.6/fs/smbfs/dir.c
> @@ -434,6 +434,11 @@ smb_lookup(struct inode *dir, struct den
>  	if (dentry->d_name.len > SMB_MAXNAMELEN)
>  		goto out;
>  
> +	/* Do not allow lookup of names with backslashes in */
> +	error = -EINVAL;
> +	if (memchr(dentry->d_name.name, '\\', dentry->d_name.len))
> +		goto out;
> +
>  	lock_kernel();
>  	error = smb_proc_getattr(dentry, &finfo);
>  #ifdef SMBFS_PARANOIA
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
