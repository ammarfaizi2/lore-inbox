Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbUEFT6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbUEFT6q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 15:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUEFT6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 15:58:46 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:5647 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262579AbUEFT6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 15:58:42 -0400
Date: Fri, 7 May 2004 05:58:29 +1000
From: Nathan Scott <nathans@sgi.com>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] XFS warning on sparc64
Message-ID: <20040507055829.A229613@wobbly.melbourne.sgi.com>
References: <Pine.GSO.4.44.0405061920450.21792-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.44.0405061920450.21792-100000@math.ut.ee>; from mroos@linux.ee on Thu, May 06, 2004 at 08:33:06PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 08:33:06PM +0300, Meelis Roos wrote:
> This is 2.6.6-rc3+BK as of today on a sparc64 (gcc 3.3.3 on Debian):
> 
>   CC [M]  fs/xfs/xfs_buf_item.o
> fs/xfs/xfs_buf_item.c: In function `xfs_buf_iodone_callbacks':
> fs/xfs/xfs_buf_item.c:1055: warning: long long unsigned int format, xfs_daddr_t arg (arg 3)
> 
> The following patch seems to fix it - is it correct?
> 
> ===== fs/xfs/xfs_buf_item.c 1.16 vs edited =====
> --- 1.16/fs/xfs/xfs_buf_item.c	Mon Feb  9 06:12:20 2004
> +++ edited/fs/xfs/xfs_buf_item.c	Thu May  6 20:09:01 2004
> @@ -1053,7 +1053,7 @@
>  		    (time_after(jiffies, (lasttime + 5*HZ)))) {
>  			lasttime = jiffies;
>  			prdev("XFS write error in file system meta-data "
> -			      "block 0x%Lx in %s",
> +			      "block 0x%Zx in %s",
>  			      XFS_BUF_TARGET(bp),
>  			      XFS_BUF_ADDR(bp), mp->m_fsname);
>  		}

In most other places we've used %llu and an explicit cast to 
(unsigned long long) when dumping block numbers - I'll fix
that one up.

thanks.

-- 
Nathan
