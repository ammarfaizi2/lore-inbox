Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316723AbSGLRiC>; Fri, 12 Jul 2002 13:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316746AbSGLRiB>; Fri, 12 Jul 2002 13:38:01 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:40711 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316723AbSGLRh7>; Fri, 12 Jul 2002 13:37:59 -0400
Date: Fri, 12 Jul 2002 19:40:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Thunder from the hill <thunder@ngforever.de>
cc: Dawson Engler <engler@csl.stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <mc@cs.stanford.edu>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
In-Reply-To: <Pine.LNX.4.44.0207111711530.26269-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0207121934420.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Jul 2002, Thunder from the hill wrote:

> --- fs/affs/namei.c	19 Jun 2002 02:11:51 -0000	1.1.1.1
> +++ fs/affs/namei.c	11 Jul 2002 22:36:41 -0000
> @@ -345,10 +345,14 @@ affs_rmdir(struct inode *dir, struct den
>  	lock_kernel();
>
>  	/* WTF??? */
> +	res = -ENOENT;
> +
>  	if (!dentry->d_inode)
> -		return -ENOENT;
> +		goto out_unlock;
>
>  	res = affs_remove_header(dentry);
> +
> + out_unlock:
>  	unlock_kernel();
>  	return res;
>  }

Please drop this patch, it's impossible to hit this problem and I have a
better patch for this.

bye, Roman

