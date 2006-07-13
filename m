Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWGMMnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWGMMnr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWGMMnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:43:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6191 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751273AbWGMMnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:43:46 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] 0/15 IO scheduler improvements
Date: Thu, 13 Jul 2006 14:46:23 +0200
Message-Id: <11527947982769-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a continuation of the patches posted yesterday, I continued
to build on them. The patch series does:

- Move the hash backmerging into the elevator core.
- Move the rbtree handling into the elevator core.
- Abstract the FIFO handling into the elevator core.
- Kill the io scheduler private requests, that require allocation/free
  for each request passed through the system.

The result is a faster elevator core (and faster IO schedulers), with a
nice net reduction of kernel text and code as well.

If you have time, please give this patch series a test spin just to
verify that everything still works for you. Thanks!

 block/as-iosched.c       |  650 ++++++++++-------------------------------------
 block/cfq-iosched.c      |  498 +++++++++---------------------------
 block/deadline-iosched.c |  462 +++++----------------------------
 block/elevator.c         |  266 +++++++++++++++++--
 block/ll_rw_blk.c        |    9 
 include/linux/blkdev.h   |   29 +-
 include/linux/elevator.h |   32 ++
 include/linux/rbtree.h   |    2 
 lib/rbtree.c             |    6 
 9 files changed, 649 insertions(+), 1305 deletions(-)


--
Jens Axboe

