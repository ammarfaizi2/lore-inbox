Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269008AbUHMFSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269008AbUHMFSo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 01:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269010AbUHMFSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 01:18:42 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:3848 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268998AbUHMFQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 01:16:37 -0400
Date: Fri, 13 Aug 2004 07:02:40 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Nikolay <Nikolay@Alexandrov.ws>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.27 fs/open.c code small cleanup
Message-ID: <20040813050239.GB1456@alpha.home.local>
References: <S268953AbUHMCzp/20040813025546Z+1005@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S268953AbUHMCzp/20040813025546Z+1005@vger.kernel.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 13, 2004 at 05:49:40AM -0000, Nikolay wrote:
> A little clean up, soon I'll send few bug fixes and cleanups.

I don't know for others, but I find it preferable not to change these
core files for such trivial cleanups. It will not change the output code
nor will make the source much more readable, but may break some external
useful patches. There are patches such as vserver and grsecurity which
touch open.c, and there are certainly others.

BTW, I noticed that credits are by far the most important part of this patch...

Regards,
Willy

> diff -u linux-2.4.27/MAINTAINERS linux-2.4.27/MAINTAINERS
> --- linux-2.4.27/MAINTAINERS	2004-08-09 02:48:53.000000000 +0300
> +++ linux-2.4.27/MAINTAINERS	2004-08-09 02:51:04.000000000 +0300
> @@ -1806,6 +1806,12 @@
>  L:	linux-video@atrey.karlin.mff.cuni.cz
>  S:	Maintained
>  
> +SYS_FSTATFS CODE CLEANUP
> +P:      Nikolay Alexandrov
> +M:      Nikolay@Alexandrov.ws
> +W:      http://kstats.blackwall.org
> +S:      Maintained
> +
>  SYSV FILESYSTEM
>  P:	Christoph Hellwig
>  M:	hch@infradead.org
> diff -u linux-2.4.27/fs/open.c linux-2.4.27/fs/open.c
> --- linux-2.4.27/fs/open.c  2004-08-09 02:22:58.000000000 +0300
> +++ linux-2.4.27/fs/open.c      2004-08-09 02:24:48.000000000 +0300
> @@ -2,6 +2,7 @@
>   *  linux/fs/open.c
>   *
>   *  Copyright (C) 1991, 1992  Linus Torvalds
> + *  08.08.2004 - vfs_fstatfs code cleanup -- Nikolay Alexandrov (Nikolay@Alexandrov.ws)
>   */
> 
>  #include <linux/string.h>
> @@ -62,12 +63,11 @@
>         error = -EBADF;
>         file = fget(fd);
>         if (!file)
> -               goto out;
> +               return error;
>         error = vfs_statfs(file->f_dentry->d_inode->i_sb, &tmp);
>         if (!error && copy_to_user(buf, &tmp, sizeof(struct statfs)))
>                 error = -EFAULT;
>         fput(file);
> -out:
>         return error;
>  }
