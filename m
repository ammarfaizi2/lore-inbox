Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965257AbWIROOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbWIROOk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 10:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbWIROOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 10:14:40 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:35720 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S965257AbWIROOk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 10:14:40 -0400
Date: Mon, 18 Sep 2006 16:14:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [S390] cio: subchannels in no-path state.
Message-ID: <20060918141436.GA5612@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] cio: subchannels in no-path state.

Subchannel may incorrectly remain in state no-path after channel paths
have reappeared. Currently the scan for subchannels which are using a
channel path ends at the first occurrence if a full link address was
provided by the channel subsystem. The scan needs to continue over
all subchannels.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-09-18 14:11:04.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-09-18 14:11:59.000000000 +0200
@@ -378,6 +378,7 @@ __s390_process_res_acc(struct subchannel
 
 	if (chp_mask == 0) {
 		spin_unlock_irq(&sch->lock);
+		put_device(&sch->dev);
 		return 0;
 	}
 	old_lpm = sch->lpm;
@@ -392,7 +393,7 @@ __s390_process_res_acc(struct subchannel
 
 	spin_unlock_irq(&sch->lock);
 	put_device(&sch->dev);
-	return (res_data->fla_mask == 0xffff) ? -ENODEV : 0;
+	return 0;
 }
 
 
