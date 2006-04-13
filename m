Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWDMROs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWDMROs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 13:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWDMROs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 13:14:48 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:57486 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932181AbWDMROr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 13:14:47 -0400
Date: Thu, 13 Apr 2006 11:14:45 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: sho@tnes.nec.co.jp
Cc: Ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC][8/21]ext3 modify variables to exceed 2G
Message-ID: <20060413171445.GT17364@schatzie.adilger.int>
Mail-Followup-To: sho@tnes.nec.co.jp,
	Ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20060413160657sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413160657sho@rifu.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 13, 2006  16:06 +0900, sho@tnes.nec.co.jp wrote:
> Summary of this patch:
>   [8/21]  change the type of variables manipulating a block or an
>           inode(ext3)
>           - Change the type of 4byte variables manipulating a block or
>             an inode from signed to unsigned.

Takashi-san, please, it would make the code much more maintainable if the
changes made here would use new types for filesystem-wide block offsets
and for file-relative block offsets, as was previously discussed, instead
of just changing some variables to be unsigned long.  Like:

typedef unsigned long ext3_fsblk_t;	# block offset in the filesystem
typedef unsigned long ext3_fscnt_t;	# block count in the filesystem
typedef unsigned long ext3_fileblk_t;	# block offset in a file

I believe we should already be using le32 for all on-disk blocks (e.g.
indirect blocks, inodes, etc), but this would be good to verify.

This way, when we get to the stage where we want to increase the blocks
to be 64-bit (as Laurent has wanted to do) we don't need to go through
and re-patch all of the same files to change "unsigned long" to
"unsigned long long".  It also makes the code easier to read, since it
will be clear what kind of variable is being used.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

