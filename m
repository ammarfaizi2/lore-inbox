Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311925AbSCOEBG>; Thu, 14 Mar 2002 23:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311926AbSCOEA5>; Thu, 14 Mar 2002 23:00:57 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:38408 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S311925AbSCOEAj>; Thu, 14 Mar 2002 23:00:39 -0500
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct super_block cleanup - msdos/vfat
In-Reply-To: <3C8FE8E3.2040204@didntduck.org>
	<87k7sfoi8c.fsf@devron.myhome.or.jp>
	<87bsdrohu3.fsf@devron.myhome.or.jp> <3C90A9C4.4030801@didntduck.org>
	<874rjjnp5t.fsf@devron.myhome.or.jp> <3C913DFE.9020306@didntduck.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 15 Mar 2002 13:00:09 +0900
In-Reply-To: <3C913DFE.9020306@didntduck.org>
Message-ID: <87wuwemqeu.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <bgerst@didntduck.org> writes:

> Patch attached.
> 
> -- 
> 
> 						Brian Gerst

Thanks a lot!

> diff -urN linux/fs/msdos/namei.c linux2/fs/msdos/namei.c
> --- linux/fs/msdos/namei.c	Thu Mar 14 10:53:20 2002
> +++ linux2/fs/msdos/namei.c	Thu Mar 14 10:54:53 2002
> @@ -607,7 +607,7 @@
>  
>  	res = fat_fill_super(sb, data, silent, &msdos_dir_inode_operations, 0);
>  	if (res) {
> -		if (!silent)
> +		if (res == -EINVAL && !silent)
>  			printk(KERN_INFO "VFS: Can't find a valid"
>  			       " MSDOS filesystem on dev %s.\n", sb->s_id);
>  		return res;
> diff -urN linux/fs/vfat/namei.c linux2/fs/vfat/namei.c
> --- linux/fs/vfat/namei.c	Thu Mar 14 10:53:20 2002
> +++ linux2/fs/vfat/namei.c	Thu Mar 14 10:55:20 2002
> @@ -1290,7 +1290,7 @@
>    
>  	res = fat_fill_super(sb, data, silent, &vfat_dir_inode_operations, 1);
>  	if (res) {
> -		if (!silent)
> +		if (res == -EINVAL && !silent)
>  			printk(KERN_INFO "VFS: Can't find a valid"
>  			       " VFAT filesystem on dev %s.\n", sb->s_id);
>  		return res;

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
