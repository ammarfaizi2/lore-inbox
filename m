Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWIVBDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWIVBDa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 21:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWIVBDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 21:03:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41414 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932159AbWIVBD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 21:03:29 -0400
Date: Fri, 22 Sep 2006 11:03:16 +1000
From: David Chinner <dgc@sgi.com>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs mailing list <xfs@oss.sgi.com>
Subject: Re: [PATCH -mm] rescue large xfs preferred iosize from the inode diet patch
Message-ID: <20060922010316.GY3034@melbourne.sgi.com>
References: <45131334.6050803@sandeen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45131334.6050803@sandeen.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 05:33:24PM -0500, Eric Sandeen wrote:
> The inode diet patch in -mm unhooked xfs_preferred_iosize from the stat call:
....
> Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
> 
> XFS guys, does this look ok?
>
> Index: linux-2.6.18/fs/xfs/linux-2.6/xfs_iops.c
> ===================================================================
> --- linux-2.6.18.orig/fs/xfs/linux-2.6/xfs_iops.c
> +++ linux-2.6.18/fs/xfs/linux-2.6/xfs_iops.c
> @@ -623,12 +623,16 @@ xfs_vn_getattr(
>  {
>  	struct inode	*inode = dentry->d_inode;
>  	bhv_vnode_t	*vp = vn_from_inode(inode);
> +	xfs_inode_t	*ip;
>  	int		error = 0;
>  
>  	if (unlikely(vp->v_flag & VMODIFIED))
>  		error = vn_revalidate(vp);
> -	if (!error)
> +	if (!error) {
>  		generic_fillattr(inode, stat);
> +		ip = xfs_vtoi(vp);
> +		stat->blksize = xfs_preferred_iosize(ip->i_mount);
> +	}
>  	return -error;
>  }

ACK. Looks good, Eric. Good catch.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
