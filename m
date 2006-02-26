Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWBZNIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWBZNIS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 08:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWBZNIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 08:08:18 -0500
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:64960 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751106AbWBZNIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 08:08:17 -0500
Date: Sun, 26 Feb 2006 08:05:06 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: ramfs and directory modification time
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Al Viro <viro@ftp.linux.org.uk>
Message-ID: <200602260807_MC3-1-B952-1BBE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060224040400.2f093523.akpm@osdl.org>

On Fri, 24 Feb 2006 at 04:04:00 -0800, Andrew Morton wrote:

> --- devel/fs/ramfs/inode.c~ramfs-update-dir-mtime-and-ctime   2006-02-24 03:53:46.000000000 -0800
> +++ devel-akpm/fs/ramfs/inode.c       2006-02-24 03:54:29.000000000 -0800
> @@ -27,6 +27,7 @@
>  #include <linux/fs.h>
>  #include <linux/pagemap.h>
>  #include <linux/highmem.h>
> +#include <linux/time.h>
>  #include <linux/init.h>
>  #include <linux/string.h>
>  #include <linux/smp_lock.h>
> @@ -104,6 +105,7 @@ ramfs_mknod(struct inode *dir, struct de
>               d_instantiate(dentry, inode);
>               dget(dentry);   /* Extra count - pin the dentry in core */
>               error = 0;
> +             dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
>       }
>       return error;
>  }


 Shouldn't that be CURRENT_TIME?

[me@tu ramfs]$ grep -i current_time *
inode.c:                inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;


-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

