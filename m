Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261705AbSJNOeU>; Mon, 14 Oct 2002 10:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261717AbSJNOeT>; Mon, 14 Oct 2002 10:34:19 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:32424 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261705AbSJNOeR>; Mon, 14 Oct 2002 10:34:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@digeo.com>, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] remove BKL from inode_setattr
Date: Mon, 14 Oct 2002 09:41:26 -0500
X-Mailer: KMail [version 1.4]
Cc: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
References: <3DAA4FD6.A18DAFE6@digeo.com> <Pine.LNX.4.44.0210140657240.9845-100000@localhost.localdomain> <3DAA6587.2A4C24B0@digeo.com>
In-Reply-To: <3DAA6587.2A4C24B0@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210140941.26157.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 October 2002 01:34, Andrew Morton wrote:

> --- 2.5.42/fs/jfs/file.c~truncate-bkl	Sun Oct 13 21:11:06 2002
> +++ 2.5.42-akpm/fs/jfs/file.c	Sun Oct 13 21:11:11 2002
> @@ -18,6 +18,7 @@
>   */
>
>  #include <linux/fs.h>
> +#include <linux/smp_lock.h>
>  #include "jfs_incore.h"
>  #include "jfs_dmap.h"
>  #include "jfs_txnmgr.h"
> @@ -90,9 +91,11 @@ static void jfs_truncate(struct inode *i
>  {
>  	jFYI(1, ("jfs_truncate: size = 0x%lx\n", (ulong) ip->i_size));
>
> +	lock_kernel();
>  	IWRITE_LOCK(ip);
>  	jfs_truncate_nolock(ip, ip->i_size);
>  	IWRITE_UNLOCK(ip);
> +	unlock_kernel();
>  }
>
>  static int jfs_open(struct inode *inode, struct file *file)

JFS does not need the BKL.  It does it's own locking.

-- 
David Kleikamp
IBM Linux Technology Center

