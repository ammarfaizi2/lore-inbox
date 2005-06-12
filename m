Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVFLWkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVFLWkL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 18:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVFLWkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 18:40:11 -0400
Received: from mail.dif.dk ([193.138.115.101]:10421 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261259AbVFLWkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 18:40:02 -0400
Date: Mon, 13 Jun 2005 00:45:18 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org,
       Markus Lidel <markus.lidel@shadowconnect.com>,
       Go Taniguchi <go@turbolinux.co.jp>
Subject: [PATCH] remove pointless explicit void pointer casts in calls to
 kfree (drivers/scsi/dpt_i2o.c) 
Message-ID: <Pine.LNX.4.62.0506130039110.16521@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please keep me on CC when replying)


Patch removes two pointless explicit casts to void* in calls to kfree() in 
drivers/scsi/dpt_i2o.c


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/scsi/dpt_i2o.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.12-rc6-mm1-orig/drivers/scsi/dpt_i2o.c	2005-06-12 15:58:48.000000000 +0200
+++ linux-2.6.12-rc6-mm1/drivers/scsi/dpt_i2o.c	2005-06-13 00:37:29.000000000 +0200
@@ -2711,10 +2711,10 @@ static s32 adpt_i2o_init_outbound_q(adpt
 	// If the command was successful, fill the fifo with our reply
 	// message packets
 	if(*status != 0x04 /*I2O_EXEC_OUTBOUND_INIT_COMPLETE*/) {
-		kfree((void*)status);
+		kfree(status);
 		return -2;
 	}
-	kfree((void*)status);
+	kfree(status);
 
 	if(pHba->reply_pool != NULL){
 		kfree(pHba->reply_pool);


