Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311503AbSCNFCY>; Thu, 14 Mar 2002 00:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311504AbSCNFCP>; Thu, 14 Mar 2002 00:02:15 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:1039 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S311503AbSCNFCF>; Thu, 14 Mar 2002 00:02:05 -0500
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct super_block cleanup - msdos/vfat
In-Reply-To: <3C8FE8E3.2040204@didntduck.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 14 Mar 2002 14:01:39 +0900
In-Reply-To: <3C8FE8E3.2040204@didntduck.org>
Message-ID: <87k7sfoi8c.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Brian Gerst <bgerst@didntduck.org> writes:

> diff -urN linux-2.5.7-pre1/fs/msdos/namei.c linux/fs/msdos/namei.c
> --- linux-2.5.7-pre1/fs/msdos/namei.c	Thu Mar  7 21:18:32 2002
> +++ linux/fs/msdos/namei.c	Wed Mar 13 08:20:12 2002
> @@ -603,17 +603,14 @@
>  
>  int msdos_fill_super(struct super_block *sb,void *data, int silent)
>  {
> -	struct super_block *res;
> +	int res;
>  
> -	MSDOS_SB(sb)->options.isvfat = 0;
> -	res = fat_read_super(sb, data, silent, &msdos_dir_inode_operations);
> -	if (IS_ERR(res))
> -		return PTR_ERR(res);
> -	if (res == NULL) {
> +	res = fat_fill_super(sb, data, silent, &msdos_dir_inode_operations, 0);
> +	if (res) {
>  		if (!silent)
>  			printk(KERN_INFO "VFS: Can't find a valid"
>  			       " MSDOS filesystem on dev %s.\n", sb->s_id);

If the error is I/O error, I think we shouldn't output this message.
What do you think about this?

> -		return -EINVAL;
> +		return res;
>  	}
>  
>  	sb->s_root->d_op = &msdos_dentry_operations;
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
