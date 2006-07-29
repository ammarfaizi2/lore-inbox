Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWG2N7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWG2N7i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 09:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWG2N7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 09:59:38 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:42630 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932180AbWG2N7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 09:59:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=oVoxFMXEGteKK/qSmyJ69rUe1KnYS7nSv2BsMbYosMExEfy6FqEZYA6hR/7KxuGMEWlUyTcfj8f7+nHdhnQDvjfOd9S6qCaz/Jmo850GPrQ6lK43cSCplo+chDqZ4rNp9l0UYaXdO6NYb4cDPo8ECxMdSScoWS1BRl57eRsZZC0=
Date: Sat, 29 Jul 2006 15:58:37 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] #define rwxr_xr_x 0755
Message-ID: <20060729135837.GB28712@leiferikson.dystopia.lan>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060727205911.GB5356@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727205911.GB5356@martell.zuzino.mipt.ru>
User-Agent: mutt-ng/devel-r804 (GNU/Linux)
From: Johannes Weiner <hnazfoo@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 28, 2006 at 12:59:11AM +0400, Alexey Dobriyan wrote:
> Every time I try to decipher S_I* combos I cry in pain. Often I just
> refer to include/linux/stat.h defines to find out what mode it is
> because numbers are actually quickier to understand.
> 
> Compare and contrast:
> 
> 	0644 vs S_IRUGO|S_IWUSR vs rw_r__r__
> 
> I'd say #2 really sucks.

I understood the octal notation at once. #2 took a second, I'd prefer
writing it  S_IRUGO | S_IWUSR  which makes it slightly more obvious.
#3 is even better than #2 but still sucks. What against octals?

> What people think? Should folks at Moscow call 03 ASAP?
> 
> --- a/fs/smbfs/inode.c
> +++ b/fs/smbfs/inode.c
> @@ -575,10 +575,8 @@ static int smb_fill_super(struct super_b
>  		mnt->flags = (oldmnt->file_mode >> 9) | SMB_MOUNT_UID |
>  			SMB_MOUNT_GID | SMB_MOUNT_FMODE | SMB_MOUNT_DMODE;
>  	} else {
> -		mnt->file_mode = S_IRWXU | S_IRGRP | S_IXGRP |
> -				S_IROTH | S_IXOTH | S_IFREG;
> -		mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
> -				S_IROTH | S_IXOTH | S_IFDIR;
> +		mnt->file_mode = rwxr_xr_x | S_IFREG;

0755 | S_IFREG is more readable I think.

> +		mnt->dir_mode = rwxr_xr_x | S_IFDIR;

0755 | S_IFDIR ; same here

Hannes
