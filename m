Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVGKQkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVGKQkD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVGKQhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:37:43 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:10750 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261982AbVGKQfZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:35:25 -0400
Date: Mon, 11 Jul 2005 18:35:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 5/12] s390: debug data for ifcc/ccc.
Message-ID: <20050711163524.GE10822@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 5/12] s390: debug data for ifcc/ccc.

From: Cornelia Huck <cohuck@de.ibm.com>

Fix debug data in case of an interface-control or channel-control
check: don't log the not yet accumulated interrupt-response-block,
but the one we just received.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/cio/device_status.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/device_status.c linux-2.6-patched/drivers/s390/cio/device_status.c
--- linux-2.6/drivers/s390/cio/device_status.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_status.c	2005-07-11 17:37:45.000000000 +0200
@@ -39,15 +39,14 @@ ccw_device_msg_control_check(struct ccw_
 		      " ... device %04X on subchannel %04X, dev_stat "
 		      ": %02X sch_stat : %02X\n",
 		      cdev->private->devno, cdev->private->irq,
-		      cdev->private->irb.scsw.dstat,
-		      cdev->private->irb.scsw.cstat);
+		      irb->scsw.dstat, irb->scsw.cstat);
 
 	if (irb->scsw.cc != 3) {
 		char dbf_text[15];
 
 		sprintf(dbf_text, "chk%x", cdev->private->irq);
 		CIO_TRACE_EVENT(0, dbf_text);
-		CIO_HEX_EVENT(0, &cdev->private->irb, sizeof (struct irb));
+		CIO_HEX_EVENT(0, irb, sizeof (struct irb));
 	}
 }
 
