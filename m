Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTHUKXO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 06:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbTHUKXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 06:23:13 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:16 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S262591AbTHUKXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 06:23:11 -0400
Date: Thu, 21 Aug 2003 11:17:51 +0100
From: Joe Thornber <thornber@sistina.com>
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: online resizing of devices/filesystems (2.6)
Message-ID: <20030821101750.GK430@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Should genhd.h:set_capacity() find and update the i_size field of the
inode for the device ?

The BLKGETSIZE and BLKGETSIZE64 ioctls report the size in the devices
inode:

	case BLKGETSIZE:
		if ((bdev->bd_inode->i_size >> 9) > ~0UL)
			return -EFBIG;
		return put_ulong(arg, bdev->bd_inode->i_size >> 9);
	case BLKGETSIZE64:
		return put_u64(arg, bdev->bd_inode->i_size);

Currently people have to close and reopen the device in order for a
size change to take effect.  This is a problem if people want to do
online resizing of a filesystem (supported by xfs and resier).

- Joe

