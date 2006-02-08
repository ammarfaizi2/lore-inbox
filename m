Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbWBHMjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbWBHMjB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbWBHMjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:39:01 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:34322 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030404AbWBHMjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:39:00 -0500
Date: Wed, 8 Feb 2006 13:38:28 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Stefan Weinhuber <wein@de.ibm.com>,
       Horst Hummel <horst.hummel@de.ibm.com>, hch@lst.de
Subject: [patch 06/10] s390: cleanup of dasd eer module
Message-ID: <20060208123828.GG1656@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Weinhuber <wein@de.ibm.com>

This patch addresses some issues Christoph has with the dasd eer module:

- make variables static
- avoid mixed case in function names

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/block/dasd_eer.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_eer.c linux-2.6-patched/drivers/s390/block/dasd_eer.c
--- linux-2.6/drivers/s390/block/dasd_eer.c	2006-02-08 12:56:18.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_eer.c	2006-02-08 12:56:18.000000000 +0100
@@ -102,11 +102,11 @@ struct eerbuffer {
 	int residual;
 };
 
-LIST_HEAD(bufferlist);
+static LIST_HEAD(bufferlist);
 
 static spinlock_t bufferlock = SPIN_LOCK_UNLOCKED;
 
-DECLARE_WAIT_QUEUE_HEAD(dasd_eer_read_wait_queue);
+static DECLARE_WAIT_QUEUE_HEAD(dasd_eer_read_wait_queue);
 
 /*
  * Check if called ioctl is valid on this device type.
@@ -485,7 +485,7 @@ dasd_eer_probe(struct dasd_device *devic
  * dasd ccw queue so we can free the requests memory.
  */
 static void
-dasd_eer_dequeue_SNSS_request(struct dasd_device *device,
+dasd_eer_dequeue_snss_request(struct dasd_device *device,
 			      struct dasd_eer_private *eer)
 {
 	struct list_head *lst, *nxt;
@@ -533,7 +533,7 @@ static void
 dasd_eer_destroy(struct dasd_device *device, struct dasd_eer_private *eer)
 {
 	flush_workqueue(dasd_eer_workqueue);
-	dasd_eer_dequeue_SNSS_request(device, eer);
+	dasd_eer_dequeue_snss_request(device, eer);
 	dasd_kfree_request(eer->cqr, device);
 	kfree(eer);
 };
@@ -683,7 +683,7 @@ dasd_eer_write_standard_trigger(int trig
  * This function writes a DASD_EER_STATECHANGE trigger.
  */
 static void
-dasd_eer_write_SNSS_trigger(struct dasd_device *device,
+dasd_eer_write_snss_trigger(struct dasd_device *device,
 			    struct dasd_ccw_req *cqr)
 {
 	int data_size;
@@ -723,7 +723,7 @@ dasd_eer_write_SNSS_trigger(struct dasd_
  * callback function for use with SNSS request
  */
 static void
-dasd_eer_SNSS_cb(struct dasd_ccw_req *cqr, void *data)
+dasd_eer_snss_cb(struct dasd_ccw_req *cqr, void *data)
 {
         struct dasd_device *device;
 	struct dasd_eer_private *private;
@@ -731,7 +731,7 @@ dasd_eer_SNSS_cb(struct dasd_ccw_req *cq
 
         device = (struct dasd_device *)data;
 	private = (struct dasd_eer_private *)device->eer;
-	dasd_eer_write_SNSS_trigger(device, cqr);
+	dasd_eer_write_snss_trigger(device, cqr);
 	spin_lock_irqsave(&snsslock, irqflags);
 	if(!test_and_clear_bit(SNSS_REQUESTED, &private->flags)) {
 		clear_bit(CQR_IN_USE, &private->flags);
@@ -748,7 +748,7 @@ dasd_eer_SNSS_cb(struct dasd_ccw_req *cq
  * clean a used cqr before using it again
  */
 static void
-dasd_eer_clean_SNSS_request(struct dasd_ccw_req *cqr)
+dasd_eer_clean_snss_request(struct dasd_ccw_req *cqr)
 {
 	struct ccw1 *cpaddr = cqr->cpaddr;
 	void *data = cqr->data;
@@ -789,7 +789,7 @@ dasd_eer_sense_subsystem_status(void *da
 		return;
 	};
 	spin_unlock_irqrestore(&snsslock, irqflags);
-	dasd_eer_clean_SNSS_request(cqr);
+	dasd_eer_clean_snss_request(cqr);
 	cqr->device = device;
 	cqr->retries = 255;
 	cqr->expires = 10 * HZ;
@@ -802,7 +802,7 @@ dasd_eer_sense_subsystem_status(void *da
 
 	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
-	cqr->callback = dasd_eer_SNSS_cb;
+	cqr->callback = dasd_eer_snss_cb;
 	cqr->callback_data = (void *)device;
         dasd_add_request_head(cqr);
 
@@ -877,7 +877,7 @@ static int dasd_eer_notify(struct notifi
  * to transfer in a readbuffer, which is protected by the readbuffer_mutex.
  */
 static char readbuffer[PAGE_SIZE];
-DECLARE_MUTEX(readbuffer_mutex);
+static DECLARE_MUTEX(readbuffer_mutex);
 
 
 static int
