Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422673AbWJDSBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbWJDSBT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422674AbWJDSBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:01:18 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:56565 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422692AbWJDSAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:00:31 -0400
Date: Wed, 4 Oct 2006 20:00:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [S390] cio: add timeout handler for internal operations.
Message-ID: <20061004180033.GJ26756@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] cio: add timeout handler for internal operations.

Add timeout handler for common-I/O-layer-internal I/O operations.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_ops.c |    3 +++
 1 files changed, 3 insertions(+)

diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2006-10-04 19:53:47.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2006-10-04 19:53:53.000000000 +0200
@@ -312,7 +312,10 @@ __ccw_device_retry_loop(struct ccw_devic
 
 	sch = to_subchannel(cdev->dev.parent);
 	do {
+		ccw_device_set_timeout(cdev, 60 * HZ);
 		ret = cio_start (sch, ccw, lpm);
+		if (ret != 0)
+			ccw_device_set_timeout(cdev, 0);
 		if (ret == -EBUSY) {
 			/* Try again later. */
 			spin_unlock_irq(&sch->lock);
