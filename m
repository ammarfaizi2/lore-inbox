Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261442AbSJHQae>; Tue, 8 Oct 2002 12:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261443AbSJHQae>; Tue, 8 Oct 2002 12:30:34 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:52910 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261441AbSJHQac>;
	Tue, 8 Oct 2002 12:30:32 -0400
Subject: Re: [patch] 512-byte alignment for O_DIRECT I/O
From: Steve Lord <lord@sgi.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
       Badari Pulavarty <pbadari@us.ibm.com>
In-Reply-To: <3DA211B8.325C32BA@digeo.com>
References: <3DA211B8.325C32BA@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 08 Oct 2002 11:34:29 -0500
Message-Id: <1034094869.16054.7.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 17:59, Andrew Morton wrote:
> 
> This patch from Badari is passing all testing now.
> 
.....
> +++ 2.5.41-akpm/fs/xfs/linux/xfs_aops.c	Mon Oct  7 15:50:21 2002
> @@ -688,8 +688,8 @@ linvfs_direct_IO(
>  {
>  	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
>  
> -        return generic_direct_IO(rw, inode, iov, offset, nr_segs,
> -					linvfs_get_blocks_direct);
> +        return generic_direct_IO(rw, inode, inode->i_sb->s_bdev,
> +			iov, offset, nr_segs, linvfs_get_blocks_direct);
>  }
>  
>  STATIC int
> 

Actually this part is broken for XFS - it will work for most cases,
but not for realtime files, in this case there is another bdev involved.
I just have to work out how to get to it from here...... the getblock
code knows enough to set it in the bh, but at this level we do not.

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
