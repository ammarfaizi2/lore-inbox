Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266686AbUHOOAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266686AbUHOOAj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 10:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUHOOAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 10:00:39 -0400
Received: from av9-2-sn4.m-sp.skanova.net ([81.228.10.107]:9159 "EHLO
	av9-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S266686AbUHOOAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 10:00:37 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Get blockdev size right in pktcdvd after switching discs
From: Peter Osterlund <petero2@telia.com>
Date: 15 Aug 2004 16:00:32 +0200
Message-ID: <m3r7q8sdq7.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you do "pktsetup 0 /dev/hdd", insert a CD and write some data to
it, remove the CD and insert a DVD, the /dev/hdd block device will not
have the correct size. This leads to bogus "attempt to access beyond
end of device" errors.

This patch fixes it.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/block/pktcdvd.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN drivers/block/pktcdvd.c~packet-capacity drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-capacity	2004-08-15 15:08:08.000000000 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-08-15 15:44:18.102726968 +0200
@@ -1971,6 +1971,8 @@ static int pkt_open_dev(struct pktcdvd_d
 	}
 
 	set_capacity(pd->disk, lba << 2);
+	set_capacity(pd->bdev->bd_disk, lba << 2);
+	bd_set_size(pd->bdev, (loff_t)lba << 11);
 
 	/*
 	 * The underlying block device needs to have its merge logic
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
