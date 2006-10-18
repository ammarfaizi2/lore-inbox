Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422650AbWJRQ1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbWJRQ1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422656AbWJRQ1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:27:11 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:1932 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422651AbWJRQ1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:27:03 -0400
Date: Wed, 18 Oct 2006 18:27:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, wein@de.ibm.com
Subject: [S390] dasd: clean up timer.
Message-ID: <20061018162709.GF7158@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Weinhuber <wein@de.ibm.com>

[S390] dasd: clean up timer.

Clean up dasd timer when when a dasd device is set offline.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c |    1 +
 1 files changed, 1 insertion(+)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-10-18 17:12:37.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-10-18 17:12:57.000000000 +0200
@@ -203,6 +203,7 @@ dasd_state_basic_to_known(struct dasd_de
 	rc = dasd_flush_ccw_queue(device, 1);
 	if (rc)
 		return rc;
+	dasd_clear_timer(device);
 
 	DBF_DEV_EVENT(DBF_EMERG, device, "%p debug area deleted", device);
 	if (device->debug_area != NULL) {
