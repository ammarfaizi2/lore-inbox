Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWJRQZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWJRQZc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWJRQZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:25:31 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:26614 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751485AbWJRQZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:25:30 -0400
Date: Wed, 18 Oct 2006 18:25:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [S390] cio: invalid device operational notification
Message-ID: <20061018162536.GA7158@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] cio: invalid device operational notification

Reset device operational notification flag when channel paths become
unavailable during path verification.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_fsm.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-10-18 17:12:37.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-10-18 17:12:51.000000000 +0200
@@ -578,9 +578,13 @@ ccw_device_verify_done(struct ccw_device
 		}
 		break;
 	case -ETIME:
+		/* Reset oper notify indication after verify error. */
+		cdev->private->flags.donotify = 0;
 		ccw_device_done(cdev, DEV_STATE_BOXED);
 		break;
 	default:
+		/* Reset oper notify indication after verify error. */
+		cdev->private->flags.donotify = 0;
 		PREPARE_WORK(&cdev->private->kick_work,
 			     ccw_device_nopath_notify, cdev);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
