Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbTBFCZ6>; Wed, 5 Feb 2003 21:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTBFCZ6>; Wed, 5 Feb 2003 21:25:58 -0500
Received: from ns.xdr.com ([209.48.37.1]:14765 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id <S265567AbTBFCZ5>;
	Wed, 5 Feb 2003 21:25:57 -0500
Date: Wed, 5 Feb 2003 18:35:40 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200302060235.h162ZeP04153@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Block device invalidate cached blocks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I'm working on a block device driver for linux. 
>
>Linux caches the blocks read from my block device, which is fine. I've 
>mounted a read-only filesystem on the block device. But sometimes on 
>the back end the file system will change. Is there a way I can cause the 
>kernel to just flush all its cached blocks? Or even better invalidate 
>just the few blocks that have changed? 
>
>Thanks-- 
>Dave


After some hunting (kernel hackers guide proved fruitless, web searches
were the same, looked in fs/buffer.c and found
void invalidate_bdev(struct block_device *bdev, int destroy_dirty_buffers);

Found use of it in block_dev.c:

/* Kill _all_ buffers, dirty or not.. */
static void kill_bdev(struct block_device *bdev)
{
	invalidate_bdev(bdev, 1);
	truncate_inode_pages(bdev->bd_inode->i_mapping, 0);
}	

So hopefully I can just invalidate the block device when I need to.

-Dave
