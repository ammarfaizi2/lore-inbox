Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288855AbSAIGJa>; Wed, 9 Jan 2002 01:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288857AbSAIGJU>; Wed, 9 Jan 2002 01:09:20 -0500
Received: from ike-ext.ab.videon.ca ([206.75.216.35]:58600 "HELO
	ike-ext.ab.videon.ca") by vger.kernel.org with SMTP
	id <S288855AbSAIGJI>; Wed, 9 Jan 2002 01:09:08 -0500
Date: Tue, 8 Jan 2002 23:09:06 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
To: linux-kernel@vger.kernel.org
cc: quinlan@transmeta.com
Subject: cramfs + initrd bug in 2.4.15
Message-ID: <Pine.LNX.3.96.1020108225839.9606E-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC all replies]

Hi,

I just found a small bug in the way ramdisks work - it was introduced
sometime between 2.4.10 and 2.4.15. I haven't yet been able to try 2.4.17,
but I didn't see anything too evident in the patch/changelog.

Basically, if you use a filesystem with a blocksize that is not BLOCK_SIZE
then when the filesystem super block is loaded set_blocksize will be
called which will call kill_bdev which calls truncate_inode_pages on the
rd mapping - that ends up destroying the ramdisk.

I found this while using cramfs as an initrd, a hackish work around in my
case is to change the default block size of the ramdisk - I'm not sure
what the real fix should be.

Hope this helps,
Jason

