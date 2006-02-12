Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWBLLsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWBLLsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 06:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWBLLsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 06:48:16 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:36575 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750989AbWBLLsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 06:48:15 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] pktcdvd: Don't spam the kernel log when nothing is wrong
From: Peter Osterlund <petero2@telia.com>
Date: 12 Feb 2006 12:48:04 +0100
Message-ID: <m3mzgw7q8b.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change some messages that don't indicate an error so that they are
only printed when debugging is enabled.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 18d5979..7879df0 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1549,7 +1549,7 @@ static int pkt_good_disc(struct pktcdvd_
 		case 0x12: /* DVD-RAM */
 			return 0;
 		default:
-			printk("pktcdvd: Wrong disc profile (%x)\n", pd->mmc3_profile);
+			VPRINTK("pktcdvd: Wrong disc profile (%x)\n", pd->mmc3_profile);
 			return 1;
 	}
 
@@ -1895,7 +1895,7 @@ static int pkt_open_write(struct pktcdvd
 	unsigned int write_speed, media_write_speed, read_speed;
 
 	if ((ret = pkt_probe_settings(pd))) {
-		DPRINTK("pktcdvd: %s failed probe\n", pd->name);
+		VPRINTK("pktcdvd: %s failed probe\n", pd->name);
 		return -EIO;
 	}
 
@@ -2441,7 +2441,7 @@ static int pkt_ioctl(struct inode *inode
 		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);
 
 	default:
-		printk("pktcdvd: Unknown ioctl for %s (%x)\n", pd->name, cmd);
+		VPRINTK("pktcdvd: Unknown ioctl for %s (%x)\n", pd->name, cmd);
 		return -ENOTTY;
 	}
 

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
