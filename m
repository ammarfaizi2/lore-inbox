Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265190AbSJRQDP>; Fri, 18 Oct 2002 12:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265273AbSJRQDP>; Fri, 18 Oct 2002 12:03:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:44977 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265190AbSJRQDO>;
	Fri, 18 Oct 2002 12:03:14 -0400
Subject: [PATCH] 2.5.43 aacraid driver
From: Mark Haverkamp <markh@osdl.org>
To: torvalds@transmeta.com
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Oct 2002 09:10:01 -0700
Message-Id: <1034957401.11782.9.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change replaces the 2.5.42 patch I sent on Monday.


Fill devno[cid] from request instead of sc_request->sr_request since
sc_request is passed in as NULL now.

diff -Nru base_linux-2.5/drivers/scsi/aacraid/aachba.c linux-2.5/drivers/scsi/aacraid/aachba.c
--- base_linux-2.5/drivers/scsi/aacraid/aachba.c	Mon Oct  7 13:03:15 2002
+++ linux-2.5/drivers/scsi/aacraid/aachba.c	Thu Oct 17 16:16:20 2002
@@ -1060,7 +1060,8 @@
 			 */
 			 
 			spin_unlock_irq(scsicmd->host->host_lock);
-			fsa_dev_ptr->devno[cid] = DEVICE_NR(scsicmd->sc_request->sr_request->rq_dev);
+			fsa_dev_ptr->devno[cid] = 
+				DEVICE_NR(scsicmd->request->rq_dev);
 			ret = aac_read(scsicmd, cid);
 			spin_lock_irq(scsicmd->host->host_lock);
 			return ret;


