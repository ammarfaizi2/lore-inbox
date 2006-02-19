Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWBSPvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWBSPvK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 10:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWBSPvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 10:51:10 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:24253 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750769AbWBSPvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 10:51:09 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] pktcdvd: Correctly set rq->cmd_len in pkt_generic_packet()
From: Peter Osterlund <petero2@telia.com>
Date: 19 Feb 2006 16:50:59 +0100
Message-ID: <m37j7rbb4s.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the code in pkt_generic_packet() worked by luck in the
past, but after commit 186d330e682210100c671355580a8592e4a21692
leaving rq->cmd_len uninitialized doesn't work any more.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index f783af7..5276d66 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -59,6 +59,7 @@
 #include <linux/mutex.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_ioctl.h>
+#include <scsi/scsi.h>
 
 #include <asm/uaccess.h>
 
@@ -381,6 +382,7 @@ static int pkt_generic_packet(struct pkt
 	memcpy(rq->cmd, cgc->cmd, CDROM_PACKET_SIZE);
 	if (sizeof(rq->cmd) > CDROM_PACKET_SIZE)
 		memset(rq->cmd + CDROM_PACKET_SIZE, 0, sizeof(rq->cmd) - CDROM_PACKET_SIZE);
+	rq->cmd_len = COMMAND_SIZE(rq->cmd[0]);
 
 	rq->ref_count++;
 	rq->flags |= REQ_NOMERGE;

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
