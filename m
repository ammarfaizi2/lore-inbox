Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293380AbSCJXeO>; Sun, 10 Mar 2002 18:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293381AbSCJXeE>; Sun, 10 Mar 2002 18:34:04 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:49311 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S293380AbSCJXdt>; Sun, 10 Mar 2002 18:33:49 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Date: Mon, 11 Mar 2002 10:34:23 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15499.60799.774246.580102@notabene.cse.unsw.edu.au>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RAID superblock....
In-Reply-To: message from Rogier Wolff on Sunday March 10
In-Reply-To: <200203101328.OAA15987@cave.bitwizard.nl>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday March 10, R.E.Wolff@BitWizard.nl wrote:
> 
> Hi,
> 
> The MD code I see doing: 
> 
> 
> 488         sb_offset = calc_dev_sboffset(rdev->dev, rdev->mddev, 1);
> 489         rdev->sb_offset = sb_offset;
> 490         fsync_dev(dev);
> 491         set_blocksize (dev, MD_SB_BYTES);
> 492         bh = bread (dev, sb_offset / MD_SB_BLOCKS, MD_SB_BYTES);
> 
> 
> where sb_offset is calculated as: 
> 
> 290         if (blk_size[MAJOR(dev)])
> 291                 size = blk_size[MAJOR(dev)][MINOR(dev)];

You missed:
	if (persistent)
		size = MD_NEW_SIZE_BLOCKS(size);

where MD_NEW_SIZE_BLOCKS is
#define MD_NEW_SIZE_BLOCKS(x)		((x & ~(MD_RESERVED_BLOCKS - 1)) - MD_RESERVED_BLOCKS)

and there you have your "-1".

> Anyway on the old machine, I still cannot find the raid superblock by
> hand, but the drives now mount, so the kernel must have been able to
> locate them somehow......

The superblock should be located between 64K and 128K from the end of
the device, on a 64K boundary.
> 


NeilBrown
