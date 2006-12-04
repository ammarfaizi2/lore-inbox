Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936943AbWLDOxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936943AbWLDOxm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936925AbWLDOxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:53:00 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:22139 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S936944AbWLDOwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:52:55 -0500
Date: Mon, 4 Dec 2006 15:52:51 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com
Subject: [S390] return 'count' for successful execution of dasd_eer_enable.
Message-ID: <20061204145251.GM32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[S390] return 'count' for successful execution of dasd_eer_enable.

Currently the return value of 'dasd_eer_enable' is returned - even if the 
function returned '0'. Now return 'count' for successful execution.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_devmap.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2006-12-04 14:50:30.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2006-12-04 14:50:44.000000000 +0100
@@ -877,12 +877,13 @@ dasd_eer_store(struct device *dev, struc
 	if (((endp + 1) < (buf + count)) || (val > 1))
 		return -EINVAL;
 
-	rc = count;
-	if (val)
+	if (val) {
 		rc = dasd_eer_enable(devmap->device);
-	else
+		if (rc)
+			return rc;
+	} else
 		dasd_eer_disable(devmap->device);
-	return rc;
+	return count;
 }
 
 static DEVICE_ATTR(eer_enabled, 0644, dasd_eer_show, dasd_eer_store);
