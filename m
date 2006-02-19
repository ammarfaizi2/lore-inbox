Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWBSP4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWBSP4i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 10:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWBSP4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 10:56:38 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:38625 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750747AbWBSP4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 10:56:38 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] pktcdvd: Remove useless printk statements
References: <m37j7rbb4s.fsf@telia.com> <m33bifbb0l.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 19 Feb 2006 16:56:28 +0100
In-Reply-To: <m33bifbb0l.fsf@telia.com>
Message-ID: <m3y8079wb7.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Writing the detected disc type in the kernel log is not useful during
normal use of the driver, so remove the printk statements.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 12ff6d8..dba5ce7 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1598,20 +1598,6 @@ static int pkt_probe_settings(struct pkt
 	if (!pkt_writable_disc(pd, &di))
 		return -ENXIO;
 
-	switch (pd->mmc3_profile) {
-		case 0x1a: /* DVD+RW */
-			printk("pktcdvd: inserted media is DVD+RW\n");
-			break;
-		case 0x13: /* DVD-RW */
-			printk("pktcdvd: inserted media is DVD-RW\n");
-			break;
-		case 0x12: /* DVD-RAM */
-			printk("pktcdvd: inserted media is DVD-RAM\n");
-			break;
-		default:
-			printk("pktcdvd: inserted media is CD-R%s\n", di.erasable ? "W" : "");
-			break;
-	}
 	pd->type = di.erasable ? PACKET_CDRW : PACKET_CDR;
 
 	track = 1; /* (di.last_track_msb << 8) | di.last_track_lsb; */

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
