Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272383AbRIKLjr>; Tue, 11 Sep 2001 07:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272375AbRIKLjh>; Tue, 11 Sep 2001 07:39:37 -0400
Received: from krynn.axis.se ([193.13.178.10]:36554 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S272342AbRIKLjY>;
	Tue, 11 Sep 2001 07:39:24 -0400
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB6B6B57@mailse01.axis.se>
From: Jonas Holmberg <jonas.holmberg@axis.com>
To: "'torvalds@transmeta.com'" <torvalds@transmeta.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: cramfs and page size
Date: Tue, 11 Sep 2001 13:39:05 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having trouble with cramfs in a 2.4.9 kernel with PAGE_CACHE_SIZE == 8192.
cramfs tries to read beyond the size of my block device.

I think I've found the problem: in the function cramfs_read in fs/cramfs/inode.c
the line

	devsize = blk_size[major][minor] >> 2;

seems to assume a block size of 4096 bytes. Shouldn't it be depending on
PAGE_CACHE_SIZE or the block size of the filesystem? The following works
for me:

	devsize = blk_size[major][minor] / (PAGE_CACHE_SIZE / 1024);

Best regards
/Jonas
