Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263435AbUEKTK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUEKTK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbUEKTK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:10:29 -0400
Received: from radius8.csd.net ([204.151.43.208]:44441 "EHLO
	bastille.tuells.org") by vger.kernel.org with ESMTP id S263435AbUEKTKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:10:11 -0400
Date: Tue, 11 May 2004 13:11:24 -0600
From: marcus hall <marcus@tuells.org>
To: linux-kernel@vger.kernel.org
Subject: Block device swamping disk cache
Message-ID: <20040511191124.GA16014@bastille.tuells.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having problems writing a filesystem image to a device file.

I am running an arm version of the 2.5.59 kernel.

Writing the data to the device file eventually caused ps.nr_dirty to exceed
dirty_thresh in balance_dirty_pages(), yet when writeback_inodes() scans
all the superblocks, the inodes that it finds are all marked as memory_backed
(they are on a ramdisk), and the inode for the block device file doesn't
show up.

I did not see any place where mark_inode_dirty() gets called for the block
device..  Is there some other mechanism for flushing the disk cache allocated
to the device?  I end up with balance_dirty_pages() looping forever.

Just for grins, I added a call to mark_inode_dirty() in blkdev_commit_write()
(similar to generic_commit_write()), but this had no effect that I could
notice.  I did note that in blkdev_commit_write(), if I look at
file->f_dentry->d_inode, I see the inode form the /dev filesystem, yet
page->mapping->host is a different inode!  I don't know if this is a
problem or not, but it did surprise me..

Anyhow, is this a known issue with 2.5.59?  How is the disk cache allocated
to a block device supposed to get flushed?

Thanks!

Marcus Hall
marcus@tuells.org
