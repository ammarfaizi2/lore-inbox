Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbTAVVE2>; Wed, 22 Jan 2003 16:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbTAVVE2>; Wed, 22 Jan 2003 16:04:28 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:36595 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S263256AbTAVVEZ>; Wed, 22 Jan 2003 16:04:25 -0500
Date: Wed, 22 Jan 2003 14:12:42 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: remove EXT2_MAX_BLOCK_SIZE
Message-ID: <20030122141242.K1594@schatzie.adilger.int>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030122202851.GR780@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030122202851.GR780@holomorphy.com>; from wli@holomorphy.com on Wed, Jan 22, 2003 at 12:28:51PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 22, 2003  12:28 -0800, William Lee Irwin III wrote:
> Remove 100% unused EXT2_MAX_BLOCK_SIZE.
> 
> diff -urpN cleanup-2.5.59-3/include/linux/ext2_fs.h cleanup-2.5.59-4/include/linux/ext2_fs.h
> --- cleanup-2.5.59-3/include/linux/ext2_fs.h	2003-01-16 18:21:39.000000000 -0800
> +++ cleanup-2.5.59-4/include/linux/ext2_fs.h	2003-01-22 12:26:00.000000000 -0800
> @@ -90,7 +90,6 @@ static inline struct ext2_sb_info *EXT2_
>   * Macro-instructions used to manage several block sizes
>   */
>  #define EXT2_MIN_BLOCK_SIZE		1024
> -#define	EXT2_MAX_BLOCK_SIZE		4096
>  #define EXT2_MIN_BLOCK_LOG_SIZE		  10
>  #ifdef __KERNEL__
>  # define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)

Actually, the correct fix is to check in ext2_read_super() whether the
blocksize is larger than EXT2_MAX_BLOCK_SIZE like ext3 does, and maybe
even fix up the code drift between that part of ext2_read_super() and
ext3_read_super()...

Both ext2 and ext3 will in theory support a blocksize up to PAGE_SIZE,
but nobody with access to a > 4kB PAGE_SIZE system has bothered to test
whether it works, so EXT[23]_MAX_BLOCK_SIZE has not been increased.
Any e2fsprogs from the last year or so will support larger blocksizes,
but it has never been tested AFAIK.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

