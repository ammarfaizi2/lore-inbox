Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWD0Uel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWD0Uel (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWD0UeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:34:09 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28679 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751441AbWD0Uds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:33:48 -0400
Date: Thu, 27 Apr 2006 22:33:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/md/raid6algos.c: fix a NULL dereference
Message-ID: <20060427203346.GP3570@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a NULL dereference spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/md/raid6algos.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.17-rc2-mm1-full/drivers/md/raid6algos.c.old	2006-04-27 20:38:18.000000000 +0200
+++ linux-2.6.17-rc2-mm1-full/drivers/md/raid6algos.c	2006-04-27 20:41:21.000000000 +0200
@@ -139,15 +139,14 @@ int __init raid6_select_algo(void)
 		}
 	}
 
-	if ( best )
+	if (best) {
 		printk("raid6: using algorithm %s (%ld MB/s)\n",
 		       best->name,
 		       (bestperf*HZ) >> (20-16+RAID6_TIME_JIFFIES_LG2));
-	else
+		raid6_call = *best;
+	} else
 		printk("raid6: Yikes!  No algorithm found!\n");
 
-	raid6_call = *best;
-
 	free_pages((unsigned long)syndromes, 1);
 
 	return best ? 0 : -EINVAL;

