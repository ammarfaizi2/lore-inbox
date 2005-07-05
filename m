Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVGEXTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVGEXTv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 19:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVGEXTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 19:19:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:34203 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262003AbVGEXJg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 19:09:36 -0400
Date: Wed, 6 Jul 2005 09:02:36 +1000
From: Nathan Scott <nathans@sgi.com>
To: Andy <genanr@emsphone.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Online resizing devices
Message-ID: <20050705230236.GA812@frodo>
References: <20050705160815.GA14324@thumper2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20050705160815.GA14324@thumper2>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 11:08:15AM -0500, Andy wrote:
> I'd like to do an online resize of and XFS filesystem on a non-partitioned
> device.  But, I always have to reboot to do so.
> 
> Say I have a sdc with 16777216 blocks and expand it on the SAN
> to have 17825792 blocks, and rescan the device.
> 
> The xfs_growfs does not see the size, nor does blockdev --getsz /dev/sdc,
> however, the I know the rescan worked because /sys/block/sdc/size now is
> 17825792 instead of 16777216.
> 

I've wondered why this is so too occasionally.  AFAICT, we are
doing everything correctly from the filesystem point of view,
we are just not being told of the larger device size when we
query it.  So, it was interesting to hear that sysfs reports
the correct size..

>From a quick look through the code - it seems sysfs reports the
value from the struct genhd ->capacity field (get_capacity and
set_capacity from <linux/genhd.h>).  Whereas the other block
device interfaces are looking at the struct block_device bd_inode
->i_size field.  So, it kinda looks like a coherency issue
between those two beasts - someone more familiar with the block
layer may be able to suggest a fix (Christoph/Jens/Al/...).

> Is there some reason for this?  Is there a fix for it?  I'm not using any
> volume management stuff yet but would like to be able to grow our
> filesystems without having to reboot to do so.

I'm not aware of a fix, and the last time I looked using a volume
manager doesn't resolve this issue either.

cheers.

-- 
Nathan
