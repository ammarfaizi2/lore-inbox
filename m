Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281031AbRKCUYF>; Sat, 3 Nov 2001 15:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281032AbRKCUX4>; Sat, 3 Nov 2001 15:23:56 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:27776 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S281031AbRKCUXq>;
	Sat, 3 Nov 2001 15:23:46 -0500
Date: Sat, 3 Nov 2001 12:23:44 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Something broken in sys_swapon
Message-ID: <20011103122344.A12059@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking through sys_swapon() for the culprit of my corruption after a
nonexistent swap device is added (/dev/hdb2 when /dev/hda is my only hard
drive and hdc and hdd are cdroms), I notice a things that look a bit odd.

First, set_blocksize(dev, PAGE_SIZE) is done twice in the S_ISBLK block
(it should only be needed once?), but furthermore:

                kdev_t dev = swap_inode->i_rdev;
                struct block_device_operations *bdops;

                p->swap_device = dev;
                set_blocksize(dev, PAGE_SIZE);

I don't know much at all about the inode structure, but doesn't this set
the block size of the originating filesystem containing the inode rather
than the block device that inode happens to be pointing to?  That would
definitely explain the corruption I see if my file system block size is
changed (/ is a 2KB block-sized EXT2 filesystem).

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
