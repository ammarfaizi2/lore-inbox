Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWFNOH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWFNOH4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWFNOH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:07:56 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:5806 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S964962AbWFNOHy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:07:54 -0400
Date: Wed, 14 Jun 2006 15:59:26 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [patch 5/24] s390: channel measurement fix.
Message-ID: <20060614135926.GF9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] channel measurement fix.

Specify correct sizeof() in chp_measurement_read() and return
correct amount of read data.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-06-14 14:29:37.000000000 +0200
@@ -918,12 +918,13 @@ chp_measurement_read(struct kobject *kob
 	chp = to_channelpath(container_of(kobj, struct device, kobj));
 	css = to_css(chp->dev.parent);
 
-	size = sizeof(struct cmg_chars);
+	size = sizeof(struct cmg_entry);
 
 	/* Only allow single reads. */
 	if (off || count < size)
 		return 0;
 	chp_measurement_copy_block((struct cmg_entry *)buf, css, chp->id);
+	count = size;
 	return count;
 }
 
