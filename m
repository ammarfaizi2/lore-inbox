Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVFUQeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVFUQeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVFUQcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:32:31 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:62445 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262171AbVFUQYp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:24:45 -0400
Date: Tue, 21 Jun 2005 18:24:43 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, horst.hummel@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 7/16] s390: fba dasd i/o errors.
Message-ID: <20050621162443.GG6053@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 7/16] s390: fba dasd i/o errors.

From: Horst Hummel <horst.hummel@de.ibm.com>

The FBA discipline does not use retries for failed requests. A request
fails after the first unsuccessful start attempt. There are some rare
conditions (e.g. CIO path recovery) in which the start of an i/o on
a fba device can fail. A tiny amount of retries is therefore
reasonable.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/block/dasd_fba.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_fba.c linux-2.6-patched/drivers/s390/block/dasd_fba.c
--- linux-2.6/drivers/s390/block/dasd_fba.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_fba.c	2005-06-21 17:36:49.000000000 +0200
@@ -4,7 +4,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.39 $
+ * $Revision: 1.40 $
  */
 
 #include <linux/config.h>
@@ -354,6 +354,8 @@ dasd_fba_build_cp(struct dasd_device * d
 	}
 	cqr->device = device;
 	cqr->expires = 5 * 60 * HZ;	/* 5 minutes */
+	cqr->retries = 32;
+	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
 	return cqr;
 }
