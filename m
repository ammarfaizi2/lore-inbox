Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314748AbSFQQTK>; Mon, 17 Jun 2002 12:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314783AbSFQQTJ>; Mon, 17 Jun 2002 12:19:09 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:20725 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S314748AbSFQQTI>; Mon, 17 Jun 2002 12:19:08 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 17 Jun 2002 10:17:18 -0600
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch 10/19] direct-to-BIO I/O for swapcache pages
Message-ID: <20020617161718.GD22427@clusterfs.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Hugh Dickins <hugh@veritas.com>
References: <3D0D873A.405ED0BB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D0D873A.405ED0BB@zip.com.au>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 16, 2002  23:52 -0700, Andrew Morton wrote:
> This patch changes the swap I/O handling.  The objectives are:
>
> At swapon time (for an S_ISBLK swapfile), we install a single swap extent
> which describes the entire device.
>
> +	inode = sis->swap_file->f_dentry->d_inode;
> +	if (S_ISBLK(inode->i_mode)) {
> +		ret = add_swap_extent(sis, 0, sis->max, 0);
> +		goto done;
> +	}

I believe it is possible to have blocks marked bad in the swap header,
even for a block device, so this will try to use those bad blocks.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

