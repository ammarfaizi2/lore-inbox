Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262742AbRE3Lsp>; Wed, 30 May 2001 07:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262743AbRE3Lsg>; Wed, 30 May 2001 07:48:36 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:61386 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S262742AbRE3Lsa>; Wed, 30 May 2001 07:48:30 -0400
Date: Wed, 30 May 2001 12:47:18 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: ll_rw_blk.c and high memory
Message-ID: <Pine.LNX.4.21.0105301233390.7153-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens, all,

  In drivers/block/ll_rw_blk.c:blk_dev_init(), the high and low queued
sectors are calculated from the total number of free pages in all memory
zones.  Shouldn't this calculation be passed upon the number of pages upon
which I/O can be done directly (ie. without bounce pages)?

  On a box with gigabytes of memory, high_queued_sectors becomes larger
than the amount of memory upon which block I/O can be directly done - the
test in ll_rw_block() against high_queued_sectors is then never true.  The
throttling of submitting I/O happens much earlier in the stack - at
the allocation of a bounce page.  This doesn't seem right.

Mark

